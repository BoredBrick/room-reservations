function getReservations() {
    $.ajax({
        url: "/ReservationListById",
        type: "GET",
        success: function (data) {
            displayReservations(data);
        },
        error: function (xhr) {
            console.error(xhr.responseText);
        },
    });
}


function displayReservations(data) {
    var roomCache = {};

    var table = $("<table>").addClass("table");

    var header = $("<thead>");
    var headerRow = $("<tr>");
    headerRow.append($("<th>").text("Room"));
    headerRow.append($("<th>").text("Start Time"));
    headerRow.append($("<th>").text("End Time"));
    headerRow.append($("<th>").text("Actions"));
    header.append(headerRow);
    table.append(header);

    var tbody = $("<tbody>");
    data.sort(function(a, b) {
        return moment(a.startTime).valueOf() - moment(b.startTime).valueOf();
    }).forEach(function (reservation) {
        var roomId = reservation.roomId;

        var roomData = roomCache[roomId];
        if (!roomData) {
            $.get("/RoomGet", {id: roomId}, function (room) {
                // Store the room data in cache
                roomCache[roomId] = room;
                updateTableRow(reservation, room);
            });
        } else {
            updateTableRow(reservation, roomData);
        }

        function updateTableRow(reservation, roomData) {
            var row = $("<tr>");
            row.append($("<td>").text(roomData.name + " (" + roomData.building + ")"));
            row.append($("<td>").text(moment(reservation.startTime).format("DD.MM.YYYY HH:mm")));
            row.append($("<td>").text(moment(reservation.endTime).format("HH:mm")));

            var deleteBtn = $("<button>").addClass("btn btn-danger");
            deleteBtn.text("Delete");
            deleteBtn.data("reservation-id", reservation.reservationId);
            deleteBtn.click(function () {
                deleteReservation($(this).data("reservation-id"));
            });

            row.append($("<td>").append(deleteBtn));

            tbody.append(row);
        }
    });

    table.append(tbody);
    $("#reservations").empty().append(table);
}

function deleteReservation(reservationId) {
    if (!confirm('Are you sure you want to delete this reservation?')) {
        return
    }
    console.log(reservationId)
    $.ajax({
        url: "/ReservationDelete",
        type: "POST",
        data: { reservationId: reservationId },
        success: function () {
            getReservations();
        },
        error: function (xhr, status, error) {
            console.error(xhr.responseText);
        },
    });
}

$(document).ready(function () {
    getReservations();
});