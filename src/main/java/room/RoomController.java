package room;

import helper.DataManager;

import javax.naming.NamingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class RoomController {

    public int insertRoom(Room room) throws SQLException, NamingException {
        String INSERT_ROOM = "INSERT INTO rooms (name, capacity, building," +
                " hasProjector, hasWhiteboard, hasWifi, imagePath) VALUES (?, ?, ?, ?, ?, ?, ?)";
        Connection conn = DataManager.getConnection();
        PreparedStatement ps = conn.prepareStatement(INSERT_ROOM, PreparedStatement.RETURN_GENERATED_KEYS);
        ps.setString(1, room.getName());
        ps.setInt(2, room.getCapacity());
        ps.setString(3, room.getBuilding());
        ps.setBoolean(4, room.hasProjector());
        ps.setBoolean(5, room.hasWhiteboard());
        ps.setBoolean(6, room.hasWifi());
        ps.setString(7, room.getImagePath());
        ps.executeUpdate();
        ResultSet resultSet = ps.getGeneratedKeys();
        int generatedId = 0;
        if (resultSet.next()) {
            generatedId = resultSet.getInt(1);
        }
        return generatedId;
    }

    public int updateRoom(Room room) throws SQLException, NamingException {
        String UPDATE_ROOM = "UPDATE rooms SET name = ?, capacity = ?, building = ?," +
                " hasProjector = ?, hasWhiteboard = ?, hasWifi = ?, imagePath = ? WHERE id = ?";
        Connection conn = DataManager.getConnection();
        PreparedStatement ps = conn.prepareStatement(UPDATE_ROOM);
        ps.setString(1, room.getName());
        ps.setInt(2, room.getCapacity());
        ps.setString(3, room.getBuilding());
        ps.setBoolean(4, room.hasProjector());
        ps.setBoolean(5, room.hasWhiteboard());
        ps.setBoolean(6, room.hasWifi());
        ps.setString(7, room.getImagePath());
        ps.setInt(8, room.getId());
        return ps.executeUpdate();
    }

    public Room getRoomById(int id) throws SQLException, NamingException {
        String GET_ROOM = "SELECT * FROM rooms WHERE id = ?";
        Connection conn = DataManager.getConnection();
        PreparedStatement ps = conn.prepareStatement(GET_ROOM);
        ps.setInt(1, id);
        return getRoom(ps);
    }

    public int deleteRoomById(int id) {
        String DELETE_ROOM = "DELETE FROM rooms WHERE id = ?";
        try {
            Connection conn = DataManager.getConnection();
            PreparedStatement ps = conn.prepareStatement(DELETE_ROOM);
            ps.setInt(1, id);
            return ps.executeUpdate();
        } catch (SQLException | NamingException e) {
            throw new RuntimeException(e);
        }
    }

    private Room getRoom(PreparedStatement ps) throws SQLException {
        ResultSet resultSet = ps.executeQuery();

        while (resultSet.next()) {
            int id = resultSet.getInt("id");
            String name = resultSet.getString("name");
            int capacity = resultSet.getInt("capacity");
            String building = resultSet.getString("building");
            boolean hasProjector = resultSet.getBoolean("hasProjector");
            boolean hasWhiteboard = resultSet.getBoolean("hasWhiteboard");
            boolean hasWifi = resultSet.getBoolean("hasWifi");
            String imagePath = resultSet.getString("imagePath");
            return new Room(id, name, capacity, building, hasProjector, hasWhiteboard, hasWifi, imagePath);
        }
        return null;
    }

    public ArrayList<Room> getAllRooms() throws SQLException, NamingException {
        String SELECT_ROOMS = "SELECT * FROM rooms";
        ArrayList<Room> rooms = new ArrayList<>();

        Connection conn = DataManager.getConnection();
        PreparedStatement ps = conn.prepareStatement(SELECT_ROOMS);
        ResultSet resultSet = ps.executeQuery();

        while (resultSet.next()) {
            int id = resultSet.getInt("id");
            String name = resultSet.getString("name");
            int capacity = resultSet.getInt("capacity");
            String building = resultSet.getString("building");
            boolean hasProjector = resultSet.getBoolean("hasProjector");
            boolean hasWhiteboard = resultSet.getBoolean("hasWhiteboard");
            boolean hasWifi = resultSet.getBoolean("hasWifi");
            String imagePath = resultSet.getString("imagePath");
            Room room = new Room(id, name, capacity, building, hasProjector, hasWhiteboard, hasWifi, imagePath);
            rooms.add(room);
        }
        return rooms;
    }

}
