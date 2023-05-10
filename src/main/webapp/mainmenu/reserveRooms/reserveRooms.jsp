<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <style>
        <%@include file="reserveRooms.css" %>
    </style>
    <jsp:include page="../../inclue_header.html"></jsp:include>
    <jsp:include page="../../toastMessages.jsp"></jsp:include>
    <jsp:include page="../../ajaxToastMessages.jsp"></jsp:include>
    <jsp:include page="../navbar.jsp"></jsp:include>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
          integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <title>Reserve a room</title>
    <script src="reserveRooms.js"></script>
    <%
        String loggedInUsername = (String) session.getAttribute("loggedInUsername");
        if (loggedInUsername == null) {
            String redirectUrl = "../../index.jsp";
            response.sendRedirect(redirectUrl);
            return;
        }
    %>

</head>
<body>
<div id="room-cards-container" class="justify-content-center"></div>

<div class="modal fade" id="room-reservation-modal" tabindex="-1" aria-labelledby="room-reservation-modal-label" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="room-reservation-modal-label">Room Reservation</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="reserve-form">
                    <div class="mb-3">
                        <label for="reserve-datetime" class="form-label">Date and Time</label>
                        <input type="datetime-local" class="form-control" id="reserve-datetime" name="reserve-datetime" required>
                    </div>
                    <div class="mb-3">
                        <label for="reserve-duration" class="form-label">Duration</label>
                        <input type="number" class="form-control" id="reserve-duration" value="5" name="reserve-duration" min="5" max="120" step="5" required>
                        <label for="reserve-duration">minutes</label>
                    </div>
                    <input type="hidden" id="reserve-roomId" name="roomId" value="">
                    <button type="submit" class="btn btn-primary">Reserve</button>
                </form>
                <div id="current-reservations">
                    <h5>Current Reservations:</h5>
                    <ul id="reservation-list">
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>


</body>
</html>