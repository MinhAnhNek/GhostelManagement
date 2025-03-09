package dao;

import model.RoomStatus;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

public class RoomStatusDAO extends DBContext {
    public List<RoomStatus> getAll() {
        List<RoomStatus> list = new LinkedList<>();
        String sql = "select * from RoomStatus";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new RoomStatus(
                        rs.getInt(1),
                        rs.getString(2)
                ));
            }
        } catch (SQLException e) {
            System.out.println("RoomStatusDAO getAll: " + e.getMessage());
        }
        return list;
    }

    public RoomStatus getByStatusName(String statusName) {
        String sql = "select * from RoomStatus where statusName = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, statusName);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                return new RoomStatus(
                        rs.getInt(1),
                        rs.getString(2)
                );
            }
        } catch (SQLException e) {
            System.out.println("RoomStatusDAO getByStatusName: " + e.getMessage());
        }
        return null;
    }
}
