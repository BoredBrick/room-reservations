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
    <jsp:include page="../../ajaxToastMessages.jsp"></jsp:include>
    <jsp:include page="../navbar.jsp"></jsp:include>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
          integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <title>Reserve a room</title>
    <script src="reserveRooms.js"></script>

</head>
<body>
<div id="room-cards-container" class="justify-content-center"></div>

<div class="modal fade" id="reservation-modal" tabindex="-1" aria-labelledby="reservation-modal-label"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="reservation-modal-label">Make a reservation</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <ul id="reservation-list"></ul>
                <form id="reservation-form">
                    <div class="mb-3">
                        <label for="reservation-date" class="form-label">Date</label>
                        <input type="date" class="form-control" id="reservation-date" name="date" required>
                    </div>
                    <div class="mb-3">
                        <label for="from-time" class="form-label">From</label>
                        <input type="time" class="form-control" id="from-time" name="from_time" required>
                    </div>
                    <div class="mb-3">
                        <label for="to-time" class="form-label">To</label>
                        <input type="time" class="form-control" id="to-time" name="to_time" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Make Reservation</button>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>