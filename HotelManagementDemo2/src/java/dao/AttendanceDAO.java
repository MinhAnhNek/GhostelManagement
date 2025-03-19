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

    public List<Attendance> getByEmployeeID(int empId, String month) {
        month = month.isEmpty() ? "'%%'" : month;
        String sql = "select * from attendance where EmployeeID = ? and month(date) like " + month + " order by date desc";
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

    public List<Attendance> getByDateAndStatus(String date, String status) {
        String sql;
        if (date.isEmpty()) sql = "select * from attendance " +
                "where date like CAST( GETDATE() AS Date ) " +
                "and status like '%" + status + "%'";
        else sql = "select * from attendance " +
                "where date like " + "'%" + date + "%'" +
                "and status like '%" + status + "%'";
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
            System.out.println("AttendanceDAO getByDateAndStatus(): " + e.getMessage());
        }
        return list;
    }

    public int countByDateAndStatus(String date, String status) {
        String sql;
        if (date.isEmpty()) sql = "select count(*) from attendance " +
                "where date like CAST( GETDATE() AS Date ) " +
                "and status like '%" + status + "%'";
        else sql = "select count(*) from attendance " +
                "where date like " + "'%" + date + "%'" +
                "and status like '%" + status + "%'";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.out.println("AttendanceDAO countByDateAndStatus(): " + e.getMessage());
        }
        return -1;
    }

    public int countByEmployeeID(int empId, String status) {
        status = status.isEmpty() ? "'%%'" : status;
        String sql = "select count(status) total, EmployeeID from attendance " +
                "where status = '" + status + "' " +
                "group by EmployeeID having EmployeeID = " + empId;
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.out.println("AttendanceDAO countByDateAndStatus(): " + e.getMessage());
        }
        return -1;
    }

}
