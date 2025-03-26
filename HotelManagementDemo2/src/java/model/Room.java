package model;

public class Room {
    private int RoomID, RoomCapacity;
    private String RoomNumber, HotelName, RoomType, Description, RoomStatus;
    float Price;

    public String getRoomStatus() {
        return RoomStatus;
    }

    public float getPrice() {
        return Price;
    }

    public Room(int roomID, String hotelName, String roomNumber, String roomType, int roomCapacity, String description, float price, String roomStatus) {
        RoomID = roomID;
        RoomCapacity = roomCapacity;
        RoomNumber = roomNumber;
        HotelName = hotelName;
        RoomType = roomType;
        Description = description;
        Price = price;
        RoomStatus = roomStatus;
    }

    public Room(String hotelName, String roomNumber, String roomType) {
        HotelName = hotelName;
        RoomNumber = roomNumber;
        RoomType = roomType;
    }

    public int getRoomID() {
        return RoomID;
    }

    public int getCapacity() {
        return RoomCapacity;
    }

    public String getRoomNumber() {
        return RoomNumber;
    }

    public String getHotelName() {
        return HotelName;
    }

    public String getRoomType() {
        return RoomType;
    }

    public String getDescription() {
        return Description;
    }

    public void setRoomID(int roomID) {
        RoomID = roomID;
    }

    public void setCapacity(int roomCapacity) {
        RoomCapacity = roomCapacity;
    }

    public void setRoomNumber(String roomNumber) {
        RoomNumber = roomNumber;
    }

    public void setHotelName(String hotelName) {
        HotelName = hotelName;
    }

    public void setRoomType(String roomType) {
        RoomType = roomType;
    }

    public void setDescription(String description) {
        Description = description;
    }

    public void setRoomStatus(String roomStatus) {
        RoomStatus = roomStatus;
    }

    public void setPrice(float price) {
        Price = price;
    }
}
