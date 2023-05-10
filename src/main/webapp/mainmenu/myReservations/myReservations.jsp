<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <jsp:include page="../../inclue_header.html"></jsp:include>
    <jsp:include page="../../ajaxToastMessages.jsp"></jsp:include>
    <jsp:include page="../navbar.jsp"></jsp:include>
    <style>
        <%@include file="myReservations.css" %>
    </style>
    <script src="myReservations.js"></script>
    <title>My reservations</title>
</head>
<%
    String loggedInUsername = (String) session.getAttribute("loggedInUsername");
    if (loggedInUsername == null) {
        String redirectUrl = "../../index.jsp";
        response.sendRedirect(redirectUrl);
        return;
    }
%>
<body>
<div class="container mt-4">
    <h1 class="mb-4">My Reservations</h1>
    <div id="reservations"></div>
</div>


</body>
</html>