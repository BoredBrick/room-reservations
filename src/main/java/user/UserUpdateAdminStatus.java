package user;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import javax.naming.NamingException;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "UserUpdateAdminStatus", value = "/userUpdateAdminStatus")
public class UserUpdateAdminStatus extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        doPost(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            new UserController().updateAdminStatus(Integer.parseInt(request.getParameter("userId")));
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": true}");
        } catch (SQLException | NamingException | IOException e) {
            response.getWriter().write("{\"success\": true}");
            throw new RuntimeException(e);
        }
    }
}
