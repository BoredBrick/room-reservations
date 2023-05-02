package room;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "RoomDelete", value = "/roomDelete")
public class RoomDelete extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        new RoomController().deleteRoomById(Integer.parseInt(request.getParameter("roomId")));
        response.setContentType("application/json");
        response.getWriter().write("{\"success\": true}");
    }
}
