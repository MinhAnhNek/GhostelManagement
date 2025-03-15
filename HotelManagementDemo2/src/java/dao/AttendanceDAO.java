package dao;

import model.Attendance;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

public class AttendanceDAO extends DBContext {
    public List<Attendance> getAll() {
        String sql = "select * from attendance";
        List<Attendance> list = new LinkedList<>();
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new Attendance(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getDate(3),
                        rs.getTime(4),
                        rs.getTime(5),
                        rs.getString(6),
                        rs.getFloat(7)
                ));
            }
        } catch (SQLException e) {
            System.out.println("AttendanceDAO.getAll(): " + e.getMessage());
        }
        return list;
    }

    public List<Attendance> getByEmployeeID(int empId) {
        String sql = "select * from attendance where EmployeeID = ? order by date desc";
        List<Attendance> list = new LinkedList<>();
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, empId);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new Attendance(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getDate(3),
                        rs.getTime(4),
                        rs.getTime(5),
                        rs.getString(6),
                        rs.getFloat(7)
                ));
            }
        } catch (SQLException e) {
            System.out.println("AttendanceDAO.getAll(): " + e.getMessage());
        }
        return list;
    }
}
