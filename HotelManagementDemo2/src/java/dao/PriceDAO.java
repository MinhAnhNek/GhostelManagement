package dao;

import model.Price;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PriceDAO extends DBContext {
    public List<Price> getAll() {
        String sql = "select * from Price";
        List<Price> list = new ArrayList<Price>();
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new Price(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getFloat(3),
                        rs.getDate(4),
                        rs.getDate(5)
                ));
            }
        } catch (SQLException e) {
            System.out.println("PriceDAO getAll(): " + e.getMessage());
        }
        return list;
    }

    public Price get(int hotelID, int roomTypeID) {
        String sql = "select * from Price where HotelID = ? and RoomTypeID = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, hotelID);
            pre.setInt(2, roomTypeID);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                return new Price(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getFloat(3),
                        rs.getDate(4),
                        rs.getDate(5)
                );
            }

        } catch (SQLException e) {
            System.out.println("PriceDAO getByID(): " + e.getMessage());
        }
        return null;
    }


    // ==================================   ADD NEW PRICE TYPE ======================================

    public void add(Price price) {
        String sql = "insert into Price(HotelID, RoomTypeID, Price, StartDate, EndDate) values(?,?,?,?,?)";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, price.getHotelID());
            pre.setInt(2, price.getRoomTypeID());
            pre.setFloat(3, price.getPrice());
            pre.setString(4, String.valueOf(price.getStartDate()));
            pre.setString(5, String.valueOf(price.getEndDate()));
            pre.execute();
            System.out.println("PriceDAO add price: " + price);
        } catch (SQLException e) {
            System.out.println("RoomTypeDAO add(): " + e.getMessage());
        }
    }
}
