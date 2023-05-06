package reservations;

import java.util.Date;

public class Reservation {
    private int reservationId;
    private int userId;
    private int roomId;
    private Date startTime;
    private Date endTime;

    public Reservation(int reservationId, int userId, int roomId, Date startTime, Date endTime) {
        this.reservationId = reservationId;
        this.userId = userId;
        this.roomId = roomId;
        this.startTime = startTime;
        this.endTime = endTime;
    }

    public Reservation(int userId, int roomId, Date startTime, Date endTime) {
        this.userId = userId;
        this.roomId = roomId;
        this.startTime = startTime;
        this.endTime = endTime;
    }

    public int getReservationId() {
        return reservationId;
    }

    public int getUserId() {
        return userId;
    }

    public int getRoomId() {
        return roomId;
    }

    public Date getStartTime() {
        return startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setReservationId(int reservationId) {
        this.reservationId = reservationId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }
}

