$(document).ready(function () {
    function generateRoomCard(room) {
        var card = $('<div class="card col-sm-6 col-lg-4"></div>');
        var img = $('<img src="/uploads/' + room.imagePath + '" class="card-img-top" alt="Room Image">');
        var cardBody = $('<div class="card-body"></div>');
        var title = $('<h5 class="card-title">' + room.name + '</h5>');
        var capacity = $('<p class="card-text">Capacity: ' + room.capacity + '</p>');
        var building = $('<p class="card-text">Building: ' + room.building + '</p>');
        var features = $('<p class="card-text">Features: ' + (room.hasProjector ? 'Projector' : '') + ' ' + (room.hasWhiteboard ? 'Whiteboard' : '') + ' ' + (room.hasWifi ? 'WiFi' : '') + '</p>');
        var editBtn = $('<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#edit-room-modal" data-id="' + room.id + '">Edit</button>');
        var deleteBtn = $('<button type="button" class="btn btn-danger" data-id="' + room.id + '">Delete</button>');
        cardBody.append(title, capacity, building, features, editBtn, deleteBtn);
        card.append(img, cardBody);
        return card;
    }

    // Function to generate all room cards
    function generateRoomCards(rooms) {
        console.log(rooms)
        var row = $('<div class="row"></div>');
        for (var i = 0; i < rooms.length; i++) {
            var card = generateRoomCard(rooms[i]);
            row.append(card);
        }
        return row;
    }

    // Load all rooms on page load
    $.ajax({
        url: '/roomList',
        dataType: 'json',
        success: function(data) {
            var roomCards = generateRoomCards(data);
            $('#room-cards-container').empty().append(roomCards);
        },
        error: function(xhr, status, error) {
            console.log('Error:', error);
        }
    });

    // Handle room form submission
    $('#add-room-form').submit(function(event) {
        event.preventDefault();
        var formData = new FormData(this);
        $.ajax({
            url: '/roomAdd',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function(response) {
                console.log(response);
                var newRoom = response.room;
                var newCard = generateRoomCard(newRoom);
                $('#room-cards-container').append(newCard);
            },
            error: function(xhr, status, error) {
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
});