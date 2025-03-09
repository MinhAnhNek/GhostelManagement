package model;

public class RoomStatus {
    public int StatusID;
    public String StatusName;

    public int getStatusID() {
        return StatusID;
    }

    public String getStatusName() {
        return StatusName;
    }

    public RoomStatus(int statusID, String statusName) {
        StatusID = statusID;
        StatusName = statusName;
    }
}
