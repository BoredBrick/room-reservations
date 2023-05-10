<%@ page import="user.User" %>
<%@ page import="user.UserController" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="javax.naming.NamingException" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Manage users</title>
    <style>
        <%@include file="manageUsers.css" %>
    </style>
    <jsp:include page="../inclue_header.html"></jsp:include>
    <jsp:include page="../ajaxToastMessages.jsp"></jsp:include>
    <jsp:include page="navbar.jsp"></jsp:include>
    <script src="manageUsers.js"></script>
</head>
<body>
<%
    String loggedInUsername = (String) session.getAttribute("loggedInUsername");
    if (loggedInUsername == null) {
        String redirectUrl = "../../index.jsp";
        response.sendRedirect(redirectUrl);
        return;
    }


    ArrayList<User> users = null;
    try {
        users = new UserController().getAllUsers();
    } catch (SQLException | NamingException e) {
        throw new RuntimeException(e);
    }

%>
<div class="container-fluid container-padding">
    <h1 class="text-center mt-5 mb-4">Registered users</h1>
    <div class="card">
        <div class="card-header">
            Users
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table">
                    <thead>
                    <tr>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Is admin</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for (User user : users) {
                        if (user.getEmail().equals(request.getSession().getAttribute("loggedInEmail"))) {
                            continue;
                        }
                    %>
                    <tr>
                        <td><%= user.getUsername() %>
                        </td>
                        <td><%= user.getEmail() %>
                        </td>
                        <td>
                            <button type="button"
                                    class="btn btn-sm admin-toggle <%= user.isAdmin() ? "btn-success" : "btn-secondary" %> update-admin-status"
                                    data-userid="<%= user.getId() %>">
                                <%= user.isAdmin() ? "Yes" : "No" %>
                            </button>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>


</body>
</html>