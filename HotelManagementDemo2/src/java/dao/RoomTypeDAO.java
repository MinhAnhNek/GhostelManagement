package dao;

import model.RoomType;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RoomTypeDAO extends DBContext {
    public List<RoomType> getAll() {
        String sql = "select * from RoomType";
        List<RoomType> list = new ArrayList<RoomType>();
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new RoomType(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3)
                ));
            }
        } catch (SQLException e) {
            System.out.println("RoomTypeDAO getAll(): " + e.getMessage());
        }
        return list;
    }

    public RoomType getById(int id) {
        String sql = "select * from RoomType where RoomTypeID = ? ";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            System.out.println(sql + id);
            pre.setInt(1, id);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                return new RoomType(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3)
                );
            }
        } catch (SQLException e) {
            System.out.println("RoomTypeDAO getById(): " + e.getMessage());
        }
        return null;
    }

    public int getRoomTypeIDByName(String roomType) {
        String sql = "select RoomTypeID from RoomType where RoomTypeName like ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, "'%" + roomType + "%'");
            ResultSet rs = pre.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.out.println("RoomTypeDAO getRoomTypeByID(): " + e.getMessage());
        }
        return -1;
    }



    // ==================================   ADD NEW ROOM TYPE ======================================

    public void add(RoomType roomType) {
        String sql = "insert into RoomType(RoomTypeName, Description) values(?,?)";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, roomType.getName());
            pre.setString(2, roomType.getDescription());
            pre.execute();
        } catch (SQLException e) {
            System.out.println("RoomTypeDAO add(): " + e.getMessage());
        }
    }
}
