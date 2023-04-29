package user;

import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.springframework.security.crypto.bcrypt.BCrypt;

import javax.naming.NamingException;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "UserUpdatePassword", value = "/userUpdatePassword")
public class UserUpdatePassword extends HttpServlet {
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

        String passwordCurrent = request.getParameter("passwordCurrent");
        String passwordNew = request.getParameter("passwordNew");

        if (!BCrypt.checkpw(passwordCurrent, user.getPassword())) {
            request.getSession().setAttribute("error","Incorrect password.");
            return;
        }

        String encodedPassword = BCrypt.hashpw(passwordNew,BCrypt.gensalt());
        user.setPassword(encodedPassword);

        try {
            new UserController().updateUser(user);
            request.getSession().setAttribute("success","Password updated.");
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": true}");
        } catch (SQLException | NamingException | IOException e) {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false}");
            throw new RuntimeException(e);
        }
    }
}
