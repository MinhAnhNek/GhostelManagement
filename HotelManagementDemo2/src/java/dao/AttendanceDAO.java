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
        String sql = "select * from attendance where EmployeeID = " + empId + " and month(date) like " + month + " order by date desc";
//        System.out.println(sql);
        List<Attendance> list = new LinkedList<>();
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
//            pre.setInt(1, empId);
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

    public List<Attendance> getByDateAndStatus(String date, String status, String hotelID) {
        String sql;
        if (date.isEmpty()) sql = "select * from attendance a left join Employee e on e.EmployeeID = a.EmployeeID " +
                "where date like CAST( GETDATE() AS Date ) " +
                "and status like '%" + status + "%' and e.hotelID like '%" + hotelID + "%'";
        else sql = "select * from attendance " +
                "where date like " + "'%" + date + "%'" +
                "and status like '%" + status + "%'";
//        System.out.println(sql);
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
//        System.out.println(sql);
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.out.println("AttendanceDAO countByDateAndStatus(): " + e.getMessage());
        }
        return 0;
    }



    public void update(String empID, String checkInTime, String checkOutTime, String status) {
        if (checkInTime.isEmpty()) {
            checkInTime = " cast (getdate() as time) ";
            status = status.isEmpty() ? "'%%'" : status;
        } else {
            checkInTime = "'" + checkInTime + "'";
        }
        String total_hours = "";
        if (!checkOutTime.isEmpty()) {
            total_hours = ", total_hours = datediff (hour, '" + checkInTime + "', '" + checkOutTime + "')";
            checkOutTime =  "', CheckOutTime = '" + checkOutTime + "'";
        }
        String sql = "update attendance set CheckInTime = " + checkInTime + checkOutTime + total_hours + ", status = '" + status + "' " +
                "where EmployeeID = " + empID + " and date = cast (getdate() as date)";
//        System.out.println(sql);
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println("AttendanceDAO update(): " + e.getMessage());
        }
    }

    public void autoAddAttendance() {
        String sql = "EXEC dbo.InsertDailyAttendance;";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println("AttendanceDAO autoAddAttendance(): " + e.getMessage());
        }
    }
}
