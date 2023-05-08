package user;

import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.springframework.security.crypto.bcrypt.BCrypt;

import javax.naming.NamingException;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "UserLogin", value = "/userLogin")
public class UserLogin extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        doPost(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        User user;
        try {
            user = new UserController().getUser(request.getParameter("email"));
        } catch (SQLException | NamingException e) {
            throw new RuntimeException(e);
        }

        if (user == null) {
            request.getSession().setAttribute("error","Incorrect email.");
            response.sendRedirect("/index.jsp");
            return;
        }

        String loginPassword = request.getParameter("password");
        if (!BCrypt.checkpw(loginPassword, user.getPassword())) {
            request.getSession().setAttribute("error","Incorrect password.");
            response.sendRedirect("/index.jsp");
            return;
        }

        request.getSession().setAttribute("loggedInId", user.getId());
        request.getSession().setAttribute("loggedInIsAdmin", user.isAdmin());
        request.getSession().setAttribute("loggedInEmail", user.getEmail());
        request.getSession().setAttribute("loggedInUsername", user.getUsername());
        request.getSession().setAttribute("success","Welcome, " + user.getUsername());

        response.sendRedirect("../webapp/mainmenu/reserveRooms/reserveRooms.jsp");
    }
}
