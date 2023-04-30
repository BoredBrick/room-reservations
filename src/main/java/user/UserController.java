package user;

import helper.DataManager;

import javax.naming.NamingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class UserController {

    public int insertUser(User user) throws SQLException, NamingException, ClassNotFoundException {
        String INSERT_USER = "INSERT INTO users (username, email, password, isAdmin) VALUES (?, ?, ?, ?)";
        Connection conn = DataManager.getConnection();
        PreparedStatement ps = conn.prepareStatement(INSERT_USER);
        ps.setString(1, user.getUsername());
        ps.setString(2, user.getEmail());
        ps.setString(3, user.getPassword());
        ps.setBoolean(4, user.isAdmin());
        return ps.executeUpdate();
    }

    public User getUser(String emailToCheck) throws SQLException, NamingException {
        String GET_USER = "SELECT * FROM users WHERE email = ?";
        Connection conn = DataManager.getConnection();
        PreparedStatement ps = conn.prepareStatement(GET_USER);
        ps.setString(1, emailToCheck);
        return getUser(ps);
    }

    public int updateUser(User user) throws SQLException, NamingException {
        String UPDATE_USER = "UPDATE users SET username = ?, password = ?, isAdmin = ? WHERE email = ?";
        Connection conn = DataManager.getConnection();
        PreparedStatement ps = conn.prepareStatement(UPDATE_USER);
        ps.setString(1, user.getUsername());
        ps.setString(2, user.getPassword());
        ps.setBoolean(3, user.isAdmin());
        ps.setString(4, user.getEmail());

        return ps.executeUpdate();
    }

    public int updateAdminStatus(int userId) throws SQLException, NamingException {
        User user = getUserById(userId);
        user.setAdmin(!user.isAdmin());
        return updateUser(user);
    }

    public User getUserById(int id) throws SQLException, NamingException {
        String GET_USER = "SELECT * FROM users WHERE id = ?";
        Connection conn = DataManager.getConnection();
        PreparedStatement ps = conn.prepareStatement(GET_USER);
        ps.setInt(1, id);
        return getUser(ps);
    }

    private User getUser(PreparedStatement ps) throws SQLException {
        ResultSet resultSet = ps.executeQuery();

        while (resultSet.next()) {
            int id = resultSet.getInt("id");
            String username = resultSet.getString("username");
            String email = resultSet.getString("email");
            String password = resultSet.getString("password");
            boolean isAdmin = resultSet.getBoolean("isAdmin");
            return new User(id, username, email, password, isAdmin);
        }
        return null;
    }

    public int deleteUserById(int id) throws SQLException, NamingException {
        String DELETE_USER = "DELETE FROM users WHERE id = ?";
        Connection conn = DataManager.getConnection();
        PreparedStatement ps = conn.prepareStatement(DELETE_USER);
        ps.setInt(1, id);
        return ps.executeUpdate();
    }

    public ArrayList<User> getAllUsers() throws SQLException, NamingException {
        String SELECT_USERS = "select * from users";
        ArrayList<User> users = new ArrayList<>();

        Connection conn = DataManager.getConnection();
        PreparedStatement ps = conn.prepareStatement(SELECT_USERS);
        ResultSet resultSet = ps.executeQuery();

        while (resultSet.next()) {
            int id = resultSet.getInt("id");
            String username = resultSet.getString("username");
            String email = resultSet.getString("email");
            boolean isAdmin = resultSet.getBoolean("isAdmin");
            User user = new User(id, username, email, isAdmin);
            users.add(user);
        }
        return users;
    }
}
