$(document).ready(function () {
    function generateRoomCard(room) {
        const card = $('<div class="col-md-4 mb-4 room-card"></div>');
        const cardInner = $('<div class="card h-100"></div>');
        const imagePath = room.imagePath !== "" ? `/uploads/${room.imagePath}` : 'https://via.placeholder.com/400x400.png?text=No+Image';
        const img = $('<img class="card-img-top" alt="Room Image">').attr('src', imagePath);
        const title = $('<h5 class="card-title"></h5>').text(room.name);
        const capacity = $('<p class="card-text"></p>').html(`<i class="fas fa-user"></i> ${room.capacity} ${room.capacity === 1 ? 'person' : 'people'}`);
        const building = $('<p class="card-text"></p>').html(`<i class="fas fa-building"></i> ${room.building}`);
        const features = $('<p class="card-text"></p>').html(`<i class="fas fa-wifi"></i> <span class="wifi-availability">${room.hasWifi ? 'Yes' : 'No'}</span> <i class="fa-solid fa-video"></i> <span class="projector-availability">${room.hasProjector ? 'Yes' : 'No'}</span> <i class="fa-solid fa-chalkboard-user"></i> <span class="whiteboard-availability">${room.hasWhiteboard ? 'Yes' : 'No'}</span>`);
        const reserveBtn = $(`<button type="button" data-roomid="${room.id}"  class="btn btn-success reserve-btn">RESERVE</button>`);
        reserveBtn.data('room', JSON.stringify(room));

        cardInner.append(
            $('<div class="position-relative overflow-hidden"></div>').append(img),
            $('<div class="card-body"></div>').append(title, capacity, building, features),
            $('<div class="card-footer"></div>').append(reserveBtn),
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


    $(document).on('click', '.reserve-btn', function() {
        var roomId = $(this).data('roomid');
        $('#room-reservation-modal').modal('show');
        $('#room-reservation-modal-title').html('Reservations for Room ' + roomId);

        $.ajax({
            url: '/ReservationListByRoomId',
            type: 'POST',
            data: { roomId: roomId },
            success: function(reservations) {
                var reservationsList = '';
                for (var i = 0; i < reservations.length; i++) {
                    reservationsList += '<li>' + reservations[i].start_time + ' - ' + reservations[i].end_time + ' on ' + reservations[i].date + '</li>';
                }
                $('#reservations-list').html(reservationsList);
            },
            error: function(xhr, status, error) {
                console.log('Error:', error);
            }
        });

        console.log("HALOOO")
        $('#reservation-date').attr('min', getCurrentDate());
        $('#reservation-date').val(getCurrentDate());

        $('#reservation-start-time, #reservation-end-time').datetimepicker({
            format: 'LT'
        });
    });

    $('#room-reservation-form').submit(function(event) {
        event.preventDefault();
        var formData = new FormData(this);
        $.ajax({
            url: '/reservationAdd',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function(response) {
                console.log('Reservation added successfully');
                $('#room-reservation-modal').modal('hide');
            },
            error: function(xhr, status, error) {
                console.log('Error:', error);
            }
        });
    });

});

function getCurrentDate() {
    var today = new Date();
    var month = today.getMonth() + 1;
    var day = today.getDate();
    var year = today.getFullYear();
    if (month < 10) month = '0' + month;
    if (day < 10) day = '0' + day;
    return year + '-' + month + '-' + day;
}
