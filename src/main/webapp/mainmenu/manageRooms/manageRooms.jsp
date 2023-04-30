<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Manage rooms</title>
    <style >
        <%@include file="manageRooms.css" %>
    </style>
  <jsp:include page="../../inclue_header.html"></jsp:include>
  <jsp:include page="../../ajaxToastMessages.jsp"></jsp:include>
  <jsp:include page="../navbar.jsp"></jsp:include>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
<button class="add-button" data-bs-toggle="modal" data-bs-target="#add-room-modal">
    <i class="fas fa-plus"></i>
</button>

<div class="modal fade" id="add-room-modal" tabindex="-1" aria-labelledby="add-room-modal-label" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="add-room-modal-label">Add Room</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="mb-3">
                        <label for="room-name" class="form-label">Name</label>
                        <input type="text" class="form-control" id="room-name" required>
                    </div>
                    <div class="mb-3">
                        <label for="room-capacity" class="form-label">Capacity</label>
                        <input type="number" class="form-control" id="room-capacity" required>
                    </div>
                    <div class="mb-3">
                        <label for="room-building" class="form-label">Building</label>
                        <input type="text" class="form-control" id="room-building" required>
                    </div>
                    <div class="mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="room-has-projector">
                        <label class="form-check-label" for="room-has-projector">Has Projector</label>
                    </div>
                    <div class="mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="room-has-whiteboard">
                        <label class="form-check-label" for="room-has-whiteboard">Has Whiteboard</label>
                    </div>
                    <div class="mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="room-has-wifi">
                        <label class="form-check-label" for="room-has-wifi">Has WiFi</label>
                    </div>
                    <div class="mb-3">
                        <label for="room-image" class="form-label">Image</label>
                        <input type="file" class="form-control" id="room-image" accept="image/*">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary">Save</button>
            </div>
        </div>
    </div>
</div>

</body>
</html>