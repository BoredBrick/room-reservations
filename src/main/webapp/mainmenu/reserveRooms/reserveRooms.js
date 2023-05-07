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

    $(document).on('click', '.reserve-btn', function () {
        var roomId = $(this).data('roomid');
        $('#room-reservation-modal').modal('show');
        document.getElementById('reserve-roomId').value = roomId;
        setDefaultDateTime();
        var reservationsData = [];
        $.ajax({
            type: 'GET',
            url: '/ReservationListByRoomId',
            data: {roomId: roomId},
            success: function (reservations) {
                reservationsData = reservations
                reservations.sort(function (a, b) {
                    return new Date(a.startTime) - new Date(b.startTime);
                });
                var reservationList = $('#reservation-list');
                reservationList.empty();
                for (var i = 0; i < reservations.length; i++) {
                    var reservation = reservations[i];

                    var endTime = new Date(reservation.endTime);
                    var startTimeString = moment(reservation.startTime).format("DD.MM.YYYY HH:mm")
                    var endTimeString = moment(reservation.endTime).format("HH:mm")
                    var listItem = $('<li></li>').text(startTimeString + ' - ' + endTimeString);
                    reservationList.append(listItem);
                }

                $('#reserve-form').validate({
                    rules: {
                        'reserve-datetime': {
                            required: true,
                            datetimeFuture: true,
                            reservationCollision: {
                                reservations: reservationsData
                            }
                        },
                        'reserve-duration': {
                            required: true,
                            digits: true,
                            range: [5, 120],
                            reservationCollision: {
                                reservations: reservationsData
                            }
                        }
                    },
                    messages: {
                        'reserve-datetime': {
                            required: 'Please select a date and time',
                            datetimeFuture: 'Please select a future date and time',
                            reservationCollision: 'This time slot is already reserved'
                        },
                        'reserve-duration': {
                            required: 'Please enter the duration of your reservation',
                            digits: 'Please enter a valid duration in minutes',
                            range: 'Please enter a duration between 5 and 120 minutes',
                            reservationCollision: 'This reservation would overlap with an existing reservation'
                        }
                    }
                });

            },
            error: function (xhr, textStatus, errorThrown) {
                console.log(errorThrown);
            }
        });

        $.validator.addMethod('datetimeFuture', function (value, element) {
            var selectedDateTime = new Date(value);
            var currentDateTime = new Date();
            return this.optional(element) || selectedDateTime > currentDateTime;
        }, 'Your reservation date and time must be in the future');

        $.validator.addMethod('reservationCollision', function (value, element, options) {
            var selectedDateTime = new Date(value);
            var duration = parseInt($('#reserve-duration').val(), 10);
            var reservations = options.reservations
            for (var i = 0; i < reservations.length; i++) {
                var reservation = reservations[i];
                var startTime = new Date(reservation.startTime);
                var endTime = new Date(reservation.endTime);
                var selectedDateTimeEnd = new Date(selectedDateTime.getTime() + duration * 60000);
                if ((selectedDateTime >= startTime && selectedDateTime <= endTime) || (selectedDateTimeEnd >= startTime && selectedDateTimeEnd <= endTime)) {
                    return false;
                }
            }
            return true;
        });
    });

    $('#reserve-form').submit(function (event) {
        if (!$("#reserve-form").valid()) {
            return false;
        }
        event.preventDefault();
        var form = $(this);
        var formData = form.serialize();
        $.ajax({
            type: 'POST',
            url: '/ReservationAdd',
            data: formData,
            success: function () {
                $('#room-reservation-modal').modal('hide');
                showModal('success', 'Reservation successfully added!')
                form.trigger('reset');
            },
            error: function (xhr, textStatus, errorThrown) {
                console.log(errorThrown);
            }
        });
    });
});

function setDefaultDateTime() {
    var now = new Date();
    var year = now.getFullYear();
    var month = now.getMonth() + 1;
    var day = now.getDate();
    var hour = now.getHours();
    var minute = now.getMinutes();

    var datetimeString = year + '-' + pad(month, 2) + '-' + pad(day, 2) + 'T' + pad(hour, 2) + ':' + pad(minute, 2);
    document.getElementById('reserve-datetime').value = datetimeString;

    var maxDate = new Date(new Date().getTime() + 7 * 24 * 60 * 60 * 1000);
    document.getElementById('reserve-datetime').setAttribute('min', new Date().toISOString().slice(0, -8))
    document.getElementById('reserve-datetime').setAttribute('max', maxDate.toISOString().slice(0, -8))

}

function pad(num, size) {
    var s = num + "";
    while (s.length < size) s = "0" + s;
    return s;
}