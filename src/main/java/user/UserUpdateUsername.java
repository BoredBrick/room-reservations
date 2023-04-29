package user;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.springframework.security.crypto.bcrypt.BCrypt;

import javax.naming.NamingException;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "UserUpdateUsername", value = "/userUpdateUsername")
public class UserUpdateUsername extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        doPost(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        User user;
        try {
            user = new UserController().getUser((String)request.getSession().getAttribute("loggedInEmail"));
        } catch (SQLException | NamingException e) {
            throw new RuntimeException(e);
        }

        user.setUsername(request.getParameter("username"));

        try {
            new UserController().updateUser(user);
            request.getSession().setAttribute("loggedInUsername",user.getUsername());
            request.getSession().setAttribute("success","Username updated.");
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": true}");
        } catch (SQLException | NamingException e) {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false}");
            throw new RuntimeException(e);
        }
    }
}
