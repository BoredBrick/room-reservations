package reservations;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import javax.naming.NamingException;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet(name = "ReservationListById", value = "/ReservationListById")
public class ReservationListById extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ArrayList<Reservation> reservations = null;
        try {
            reservations = new ReservationController().getReservationsByUserId(Integer.parseInt(request.getParameter("user_id")));
        } catch (SQLException | NamingException e) {
            throw new RuntimeException(e);
        }

        Gson gson = new GsonBuilder().create();
        String json = gson.toJson(reservations);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }
}
