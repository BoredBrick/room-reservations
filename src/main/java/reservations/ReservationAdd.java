package reservations;

import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import javax.naming.NamingException;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet(name = "ReservationAdd", value = "/ReservationAdd")
public class ReservationAdd extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("user_id"));
        int roomId = Integer.parseInt(request.getParameter("room_id"));
        Date startTime = null;
        Date endTime = null;

        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        try {
            startTime = format.parse(request.getParameter("startTime"));
            endTime = format.parse(request.getParameter("endTime"));
        } catch (ParseException e) {
            e.printStackTrace();
        }

        Reservation reservation = new Reservation(userId, roomId, startTime, endTime);
        try {
            int id = new ReservationController().insertReservation(reservation);
            reservation.setReservationId(id);
            Gson gson = new Gson();
            String json = gson.toJson(reservation);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(json);
        } catch (SQLException | NamingException e) {
            throw new RuntimeException(e);
        }
    }
}
