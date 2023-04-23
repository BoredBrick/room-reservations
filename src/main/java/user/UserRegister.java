package user;

import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.springframework.security.crypto.bcrypt.BCrypt;

import javax.naming.NamingException;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "UserRegisterServlet", value = "/userRegister")
public class UserRegister extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        User user = new User(
                request.getParameter("username"),
                request.getParameter("email"),
                request.getParameter("password"));

        User existingUser;
        try {
            existingUser = new UserController().getUser(user.getEmail());
        } catch (SQLException | NamingException e) {
            throw new RuntimeException(e);
        }

        if (existingUser != null) {
            request.getSession().setAttribute("registered",false);
            response.sendRedirect("/register/register.jsp");
        }

        String encodedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
        user.setPassword(encodedPassword);

        try {
            new UserController().insertUser(user);
            request.getSession().setAttribute("registered",true);
        } catch (SQLException | NamingException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        response.sendRedirect("/index.jsp");
    }
}

