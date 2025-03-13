package dao;

import model.Hotel;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

public class HotelDAO extends DBContext {
    public List<Hotel> getAll() {
        String sql = "select * from Hotel";
        LinkedList<Hotel> list = new LinkedList<>();
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new Hotel(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4)
                ));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public int getHotelIDByName(String name) {
        String sql = "select HotelID from Hotel where Name like ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, "%" + name + "%");
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("HotelDAO: " + e);
        }
        return -1;
    }

}