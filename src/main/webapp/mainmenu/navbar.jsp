<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>

</head>
<%
  String loggedInUsername = (String) session.getAttribute("loggedInUsername");
  Boolean isAdmin = (Boolean) session.getAttribute("loggedInIsAdmin");
  if (isAdmin == null) {
    isAdmin = false;
  }
  if (loggedInUsername == null) {
    response.sendRedirect("../index.jsp");
  }
%>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
  <div class="container-fluid">
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link" href="/mainmenu/reserveRooms/reserveRooms.jsp">Reserve a Room</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/mainmenu/myReservations/myReservations.jsp">My Reservations</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/mainmenu/manageRooms/manageRooms.jsp">Manage rooms</a>
        </li>
      </ul>
      <ul class="navbar-nav ms-auto">
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle text-truncate" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            <%= request.getSession().getAttribute("loggedInUsername") %>
          </a>
          <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownMenuLink">
            <li><a class="dropdown-item" href="/mainmenu/userProfile.jsp">Profile</a></li>
            <% if (isAdmin) { %>
              <li><a class="dropdown-item" href="/mainmenu/manageUsers.jsp">Manage users</a></li>
            <% } %>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="/userLogOut">Log Out</a></li>
          </ul>
        </li>
      </ul>
    </div>
  </div>
</nav>
</body>
</html>
