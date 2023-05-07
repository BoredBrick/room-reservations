package room;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "RoomGet", value = "/RoomGet")
public class RoomGet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

            int roomId = Integer.parseInt(request.getParameter("id"));

            try {
                Room room = new RoomController().getRoomById(roomId);
                Gson gson = new GsonBuilder().create();
                String json = gson.toJson(room);
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(json);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
    }
}
