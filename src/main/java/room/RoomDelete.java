package room;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import javax.naming.NamingException;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "RoomDelete", value = "/roomDelete")
public class RoomDelete extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Room room;
        try {
            room = new RoomController().getRoomById(Integer.parseInt(request.getParameter("roomId")));
        } catch (SQLException | NamingException e) {
            throw new RuntimeException(e);
        }

        if (!room.getImagePath().isEmpty()) {
            String uploadPath = getServletContext().getRealPath("") + File.separator + RoomAdd.UPLOAD_DIRECTORY;
            File imageFile = new File(uploadPath + File.separator + room.getImagePath());
            if (imageFile.exists()) {
                imageFile.delete();
            }
        }
        new RoomController().deleteRoomById(Integer.parseInt(request.getParameter("roomId")));
        response.setContentType("application/json");
        response.getWriter().write("{\"success\": true}");
    }
}
