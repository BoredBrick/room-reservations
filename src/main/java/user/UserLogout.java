package user;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "UserLogout", value = "/userLogOut")
public class UserLogout extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.getSession().removeAttribute("loggedInEmail");
        request.getSession().removeAttribute("loggedInUsername");
        request.getSession().removeAttribute("loggedInIsAdmin");
        request.getSession().setAttribute("success","You've been logged out.");
        response.sendRedirect("/index.jsp");
    }
}
