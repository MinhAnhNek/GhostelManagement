package model;

public class Hotel {
    private int hotelId;
    private String name;
    private String address;
    private int rating;

    public Hotel(int hotelId, String name, String address, int rating) {
        this.hotelId = hotelId;
        this.name = name;
        this.address = address;
        this.rating = rating;
    }

    public int getHotelId() {
        return hotelId;
    }

    public String getName() {
        return name;
    }

    public String getAddress() {
        return address;
    }

    public int getRating() {
        return rating;
    }
}
