<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Manage rooms</title>
    <style>
        <%@include file="manageRooms.css" %>
    </style>
    <jsp:include page="../../inclue_header.html"></jsp:include>
    <jsp:include page="../../ajaxToastMessages.jsp"></jsp:include>
    <jsp:include page="../navbar.jsp"></jsp:include>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
          integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <script src="manageRooms.js"></script>
</head>
<body>


<div id="room-cards-container" class="justify-content-center"></div>


<div class="modal fade" id="edit-room-modal" tabindex="-1" aria-labelledby="edit-room-modal-label"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="edit-room-modal-label">Edit Room Details</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="edit-room-form">
                    <input type="hidden" id="edit-room-id" name="id">
                    <div class="mb-3">
                        <label for="edit-room-name" class="form-label">Name</label>
                        <input type="text" class="form-control" id="edit-room-name" name="name" required>
                    </div>
                    <div class="mb-3">
                        <label for="edit-room-capacity" class="form-label">Capacity</label>
                        <input type="number" class="form-control" id="edit-room-capacity" name="capacity" min="1"
                               value="1" required>
                    </div>
                    <div class="mb-3">
                        <label for="edit-room-building" class="form-label">Building</label>
                        <input type="text" class="form-control" id="edit-room-building" name="building" required>
                    </div>
                    <div class="mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="edit-room-has-projector"
                               name="has_projector">
                        <label class="form-check-label" for="edit-room-has-projector">Has Projector</label>
                    </div>
                    <div class="mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="edit-room-has-whiteboard"
                               name="has_whiteboard">
                        <label class="form-check-label" for="edit-room-has-whiteboard">Has Whiteboard</label>
                    </div>
                    <div class="mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="edit-room-has-wifi" name="has_wifi">
                        <label class="form-check-label" for="edit-room-has-wifi">Has WiFi</label>
                    </div>
                    <div class="mb-3">
                        <label for="edit-room-image" class="form-label">Image</label>
                        <input type="file" class="form-control" id="edit-room-image" accept="image/*" name="image">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <div class="row">
                    <div class="col">
                        <button type="button" class="btn btn-secondary w-100" data-bs-dismiss="modal">Cancel
                        </button>
                    </div>
                    <div class="col">
                        <button type="button" class="btn btn-outline-danger w-100" id="clear-edit-form-btn"
                                onclick="clearEditRoomForm()">Clear
                        </button>
                    </div>
                </div>
                <div class="row mt-2">
                    <div class="col">
                        <button type="submit" class="btn btn-primary w-100" data-dismiss="modal">Add Room
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

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
                <form id="add-room-form">
                    <div class="mb-3">
                        <label for="room-name" class="form-label">Name</label>
                        <input type="text" class="form-control" id="room-name" name="name" required>
                    </div>
                    <div class="mb-3">
                        <label for="room-capacity" class="form-label">Capacity</label>
                        <input type="number" class="form-control" id="room-capacity" name="capacity" min="1"
                               value="1"
                               required>
                    </div>
                    <div class="mb-3">
                        <label for="room-building" class="form-label">Building</label>
                        <input type="text" class="form-control" id="room-building" name="building" required>
                    </div>
                    <div class="mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="room-has-projector"
                               name="has_projector">
                        <label class="form-check-label" for="room-has-projector">Has Projector</label>
                    </div>
                    <div class="mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="room-has-whiteboard"
                               name="has_whiteboard">
                        <label class="form-check-label" for="room-has-whiteboard">Has Whiteboard</label>
                    </div>
                    <div class="mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="room-has-wifi" name="has_wifi">
                        <label class="form-check-label" for="room-has-wifi">Has WiFi</label>
                    </div>
                    <div class="mb-3">
                        <label for="room-image" class="form-label">Image</label>
                        <input type="file" class="form-control" id="room-image" accept="image/*" name="image">
                    </div>
                    <div class="modal-footer">
                        <div class="row">
                            <div class="col">
                                <button type="button" class="btn btn-secondary w-100" data-bs-dismiss="modal">Cancel
                                </button>
                            </div>
                            <div class="col">
                                <button type="button" class="btn btn-outline-danger w-100" id="clear-form-btn"
                                        onclick="clearAddRoomForm()">Clear
                                </button>
                            </div>
                        </div>
                        <div class="row mt-2">
                            <div class="col">
                                <button type="submit" class="btn btn-primary w-100" data-dismiss="modal">Add Room
                                </button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

</body>
</html>