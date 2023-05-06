package reservations;

import helper.DataManager;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.naming.NamingException;

public class ReservationController {
    private static final String INSERT_RESERVATION = "INSERT INTO room_reservations (user_id, room_id, start_time, end_time) VALUES (?, ?, ?, ?)";
    private static final String DELETE_RESERVATION = "DELETE FROM room_reservations WHERE reservation_id = ?";
    private static final String GET_ALL_RESERVATIONS = "SELECT * FROM room_reservations";
    private static final String GET_RESERVATIONS_BY_USER_ID = "SELECT * FROM room_reservations WHERE user_id = ?";

    public int insertReservation(Reservation reservation) throws SQLException, NamingException {
        Connection conn = DataManager.getConnection();
        PreparedStatement ps = conn.prepareStatement(INSERT_RESERVATION, PreparedStatement.RETURN_GENERATED_KEYS);
        ps.setInt(1, reservation.getUserId());
        ps.setInt(2, reservation.getRoomId());
        ps.setTimestamp(3, new Timestamp(reservation.getStartTime().getTime()));
        ps.setTimestamp(4, new Timestamp(reservation.getEndTime().getTime()));
        ps.executeUpdate();
        ResultSet resultSet = ps.getGeneratedKeys();
        int generatedId = 0;
        if (resultSet.next()) {
            generatedId = resultSet.getInt(1);
        }
        return generatedId;
    }

    public void deleteReservation(int reservationId) throws SQLException, NamingException {
        Connection conn = DataManager.getConnection();
        PreparedStatement ps = conn.prepareStatement(DELETE_RESERVATION);
        ps.setInt(1, reservationId);
        ps.executeUpdate();
    }

    public ArrayList<Reservation> getAllReservations() throws SQLException, NamingException {
        Connection conn = DataManager.getConnection();
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(GET_ALL_RESERVATIONS);
        ArrayList<Reservation> reservations = new ArrayList<>();
        while (rs.next()) {
            int reservationId = rs.getInt("reservation_id");
            int userId = rs.getInt("user_id");
            int roomId = rs.getInt("room_id");
            Date startTime = new Date(rs.getTimestamp("start_time").getTime());
            Date endTime = new Date(rs.getTimestamp("end_time").getTime());
            Reservation reservation = new Reservation(reservationId, userId, roomId, startTime, endTime);
            reservations.add(reservation);
        }
        return reservations;
    }

    public ArrayList<Reservation> getReservationsByUserId(int userId) throws SQLException, NamingException {
        Connection conn = DataManager.getConnection();
        PreparedStatement ps = conn.prepareStatement(GET_RESERVATIONS_BY_USER_ID);
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();
        ArrayList<Reservation> reservations = new ArrayList<>();
        while (rs.next()) {
            int reservationId = rs.getInt("reservation_id");
            int roomId = rs.getInt("room_id");
            Date startTime = new Date(rs.getTimestamp("start_time").getTime());
            Date endTime = new Date(rs.getTimestamp("end_time").getTime());
            Reservation reservation = new Reservation(reservationId, userId, roomId, startTime, endTime);
            reservations.add(reservation);
        }
        return reservations;
    }
}
