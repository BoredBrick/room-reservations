package room;

import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import javax.naming.NamingException;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.UUID;
@MultipartConfig

@WebServlet(name = "RoomUpdate", value = "/roomUpdate")
public class RoomUpdate extends HttpServlet {
    private static final String UPLOAD_DIRECTORY = "uploads";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        int capacity = Integer.parseInt(request.getParameter("capacity"));
        String building = request.getParameter("building");
        boolean hasProjector = request.getParameter("has_projector") != null;
        boolean hasWhiteboard = request.getParameter("has_whiteboard") != null;
        boolean hasWifi = request.getParameter("has_wifi") != null;

        Part filePart = request.getPart("image");
        String fileName = "";
        if (!filePart.getSubmittedFileName().equals("")) {
            fileName = UUID.randomUUID().toString() + "_" + Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadPath = request.getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            Path filePath = Paths.get(uploadPath + File.separator + fileName);
            try (InputStream fileContent = filePart.getInputStream()) {
                Files.copy(fileContent, filePath);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        Room room = new Room(id, name, capacity, building, hasProjector, hasWhiteboard, hasWifi, fileName);
        try {
            new RoomController().updateRoom(room);
            room.setId(id);
            Gson gson = new Gson();
            String json = gson.toJson(room);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(json);
        } catch (SQLException | NamingException e) {
            throw new RuntimeException(e);
        }
    }
}
