package room;

import com.google.gson.GsonBuilder;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import javax.naming.NamingException;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import com.google.gson.Gson;

@WebServlet(name = "RoomList", value = "/roomList")
public class RoomList extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ArrayList<Room> rooms = null;
        try {
            rooms = new RoomController().getAllRooms();
        } catch (SQLException | NamingException e) {
            throw new RuntimeException(e);
        }

        Gson gson = new GsonBuilder().create();
        String json = gson.toJson(rooms);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }
}
