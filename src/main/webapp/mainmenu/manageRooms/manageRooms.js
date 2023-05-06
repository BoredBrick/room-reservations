$(document).ready(function () {
    function generateRoomCard(room) {
        const card = $('<div class="col-md-6 mb-4"></div>');
        const cardInner = $('<div class="card h-100"></div>');
        const imagePath = room.imagePath !== "" ? `/uploads/${room.imagePath}` : 'https://via.placeholder.com/400x400.png?text=No+Image';
        const img = $('<img class="card-img-top" alt="Room Image">').attr('src', imagePath);
        const title = $('<h5 class="card-title"></h5>').text(room.name);
        const capacity = $('<p class="card-text"></p>').html(`<i class="fas fa-user"></i> ${room.capacity} ${room.capacity === 1 ? 'person' : 'people'}`);
        const building = $('<p class="card-text"></p>').html(`<i class="fas fa-building"></i> ${room.building}`);
        const features = $('<p class="card-text"></p>').html(`<i class="fas fa-wifi"></i> <span class="wifi-availability">${room.hasWifi ? 'Yes' : 'No'}</span> <i class="fa-solid fa-video"></i> <span class="projector-availability">${room.hasProjector ? 'Yes' : 'No'}</span> <i class="fa-solid fa-chalkboard-user"></i> <span class="whiteboard-availability">${room.hasWhiteboard ? 'Yes' : 'No'}</span>`);
        const editBtn = $(`<button type="button" data-roomid="${room.id}" data-bs-toggle="modal" data-bs-target="#edit-room-modal" class="btn btn-primary edit-btn">Edit</button>`);
        editBtn.data('room', JSON.stringify(room));
        const deleteBtn = $(`<button type="button" data-roomid="${room.id}" class="btn btn-danger delete-btn">Delete</button>`);

        cardInner.append(
            $('<div class="position-relative overflow-hidden"></div>').append(img),
            $('<div class="card-body"></div>').append(title, capacity, building, features),
            $('<div class="card-footer"></div>').append(editBtn, deleteBtn),
            $(`<span data-roomid="${room.id}"></span>`).hide()
        );
        card.append(cardInner);

        return card;
    }

    function generateRoomCards(rooms) {
        var row = $('<div class="row" id="cards-row"</div>');
        for (var i = 0; i < rooms.length; i++) {
            var card = generateRoomCard(rooms[i]);
            row.append(card);
        }
        return row;
    }

    $.ajax({
        url: '/roomList',
        dataType: 'json',
        success: function (data) {
            var roomCards = generateRoomCards(data);
            $('#room-cards-container').empty().append(roomCards);
        },
        error: function (xhr, status, error) {
            console.log('Error:', error);
        }
    });

    $('#add-room-form').submit(function (event) {
        event.preventDefault();
        var formData = new FormData(this);
        $.ajax({
            url: '/roomAdd',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function (response) {
                var newRoom = response;
                var newCard = generateRoomCard(newRoom);
                $('#cards-row').append(newCard);
                $('#add-room-modal').modal('hide');
            },
            error: function (xhr, status, error) {
                console.log('Error:', error);
            }
        });
    });

    $("#add-room-form").validate({
        rules: {
            name: {
                required: true,
                minlength: 3,
                maxlength: 30
            },
            capacity: {
                required: true,
                min: 1,
                max: 99
            },
            building: {
                required: true,
                minlength: 1,
                maxlength: 30
            }
        },
        messages: {
            name: {
                required: "Please enter a room name",
                minlength: "Name must be at least 3 characters long",
                maxlength: "Name cannot be longer than 30 characters"
            },
            capacity: {
                required: "Please enter a room capacity",
                min: "Capacity must be at least 1",
                max: "Capacity cannot be more than 99"
            },
            building: {
                required: "Please enter a building name",
                minlength: "Building name must be at least 1 character long",
                maxlength: "Building name cannot be longer than 30 characters"
            }
        }
    });

    $(document).on('click', '.delete-btn', function () {
        if (!confirm('Are you sure you want to delete this room?')) {
            return
        }
        var roomId = $(this).data('roomid');
        $.ajax({
            url: "/roomDelete",
            type: 'POST',
            data: {roomId: roomId},
            success: function (response) {
                $(`button[data-roomid="${roomId}"]`).closest('.col-md-6').remove();
            },
            error: function (xhr, status, error) {
                console.log('Error:', error);
            }
        });
    });

    $(document).on('click', '.edit-btn', function () {
        const room = JSON.parse($(this).data('room'));
        $('#edit-room-modal [name="id"]').val(room.id);
        $('#edit-room-modal [name="name"]').val(room.name);
        $('#edit-room-modal [name="capacity"]').val(room.capacity);
        $('#edit-room-modal [name="building"]').val(room.building);
        $('#edit-room-modal [name="hasWifi"]').prop('checked', room.hasWifi);
        $('#edit-room-modal [name="hasProjector"]').prop('checked', room.hasProjector);
        $('#edit-room-modal [name="hasWhiteboard"]').prop('checked', room.hasWhiteboard);
        $('#edit-room-modal [name="room-id"]').val(room.id);
    });

    $('#edit-room-form').submit(function (event) {
        event.preventDefault();
        var formData = new FormData(this);
        var roomId = $('#edit-room-form [name="id"]').val();
            $.ajax({
            url: "/roomUpdate",
            type: 'POST',
            processData: false,
            contentType: false,
            data: formData,
            success: function (response) {
                const card = $(`button[data-roomid="${roomId}"]`).closest('.col-md-6');
                const updatedRoom = response;
                card.find('.card-title').text(updatedRoom.name);
                card.find('.card-text.capacity').html(`<i class="fas fa-user"></i> ${updatedRoom.capacity} ${updatedRoom.capacity === 1 ? 'person' : 'people'}`);
                card.find('.card-text.building').html(`<i class="fas fa-building"></i> ${updatedRoom.building}`);
                card.find('.card-text.features .wifi-availability').text(updatedRoom.hasWifi ? 'Yes' : 'No');
                card.find('.card-text.features .projector-availability').text(updatedRoom.hasProjector ? 'Yes' : 'No');
                card.find('.card-text.features .whiteboard-availability').text(updatedRoom.hasWhiteboard ? 'Yes' : 'No');
                const imagePath = updatedRoom.imagePath !== "" ? `/uploads/${updatedRoom.imagePath}` : 'https://via.placeholder.com/400x400.png?text=No+Image';
                card.find('.card-img-top').attr('src', imagePath);
                $('#edit-room-modal').modal('hide');
            },
            error: function (xhr, status, error) {
                console.log('Error:', error);
            }
        });
    });
});

function clearAddRoomForm() {
    document.getElementById("add-room-form").reset();
}

function clearEditRoomForm() {
    document.getElementById("edit-room-form").reset();
}


