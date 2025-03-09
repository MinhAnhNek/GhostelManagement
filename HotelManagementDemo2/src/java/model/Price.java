package model;

import java.util.Date;

public class Price {
    private int HotelID, RoomTypeID;
    private float price;
    private Date startDate, endDate;

    public Price(int hotelID, int roomTypeID, float price, Date startDate, Date endDate) {
        HotelID = hotelID;
        RoomTypeID = roomTypeID;
        this.price = price;
        this.startDate = startDate;
        this.endDate = endDate;
    }

    public int getHotelID() {
        return HotelID;
    }

    public int getRoomTypeID() {
        return RoomTypeID;
    }

    public float getPrice() {
        return price;
    }

    public Date getStartDate() {
        return startDate;
    }

    public Date getEndDate() {
        return endDate;
    }
}
