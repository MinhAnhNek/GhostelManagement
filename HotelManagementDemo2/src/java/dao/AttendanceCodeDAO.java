package dao;

import model.AttendanceCode;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.util.ArrayList;
import java.util.List;

public class AttendanceCodeDAO extends DBContext{
    public List<AttendanceCode> getAll(){
        String sql = "select * from attendanceCode";
        List<AttendanceCode> list = new ArrayList<>();
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet r = pre.executeQuery();
            while (r.next()) {
                list.add(new AttendanceCode(
                        r.getInt(1),
                        r.getString(2),
                        r.getTime(3),
                        r.getTime(4),
                        r.getDate(5)
                ));
            }
        } catch (SQLException e) {
            System.out.println("AttendanceCodeDAO getAll: " + e.getMessage());
        }
        return list;
    }

    public List<AttendanceCode> getByDate(String date){
        date = date.isEmpty() ? " cast(getdate() as date) " : "'%" + date + "%'";
        String sql = "select * from attendanceCode where date like " + date + " " +
                "order by id desc";
        List<AttendanceCode> list = new ArrayList<>();
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet r = pre.executeQuery();
            while (r.next()) {
                list.add(new AttendanceCode(
                        r.getInt(1),
                        r.getString(2),
                        r.getTime(3),
                        r.getTime(4),
                        r.getDate(5)
                ));
            }
        } catch (SQLException e) {
            System.out.println("AttendanceCodeDAO getByDate: " + e.getMessage());
        }
        return list;
    }

    public AttendanceCode getByTime(Time time){
        String sql = "select * from attendanceCode where " + time + " >= startTime and " + time + " <= endTime ";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet r = pre.executeQuery();
            if (r.next()) {
                return new AttendanceCode(
                        r.getInt(1),
                        r.getString(2),
                        r.getTime(3),
                        r.getTime(4),
                        r.getDate(5)
                );
            }
        } catch (SQLException e) {
            System.out.println("AttendanceCodeDAO getByTime: " + e.getMessage());
        }
        return null;
    }

    public AttendanceCode getLast() {
        String sql = "select top 1 * from attendanceCode order by id desc";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet r = pre.executeQuery();
            if (r.next()) {
                return new AttendanceCode(
                        r.getInt(1),
                        r.getString(2),
                        r.getTime(3),
                        r.getTime(4),
                        r.getDate(5)
                );
            }
        } catch (SQLException e) {
            System.out.println("AttendanceCodeDAO getByCode: " + e.getMessage());
        }
        return null;
    }

    public AttendanceCode getPredictingNext() {
        String sql = "select top 1 endTime, dateadd(hour, 1, endTime) " +
                "from attendanceCode " +
                "order by id desc";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet r = pre.executeQuery();
            if (r.next()) {
                return new AttendanceCode(
                        r.getTime(1),
                        r.getTime(2)
                );
            }
        } catch (SQLException e) {
            System.out.println("AttendanceCodeDAO getByCode: " + e.getMessage());
        }
        return null;
    }


    public AttendanceCode getByCode(String code){
        String sql = "select * from attendanceCode where code = '" + code + "'";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet r = pre.executeQuery();
            if (r.next()) {
                return new AttendanceCode(
                        r.getInt(1),
                        r.getString(2),
                        r.getTime(3),
                        r.getTime(4),
                        r.getDate(5)
                );
            }
        } catch (SQLException e) {
            System.out.println("AttendanceCodeDAO getByCode: " + e.getMessage());
        }
        return null;
    }

    public void addCode(String code, String startTime){
        String sql = "insert into attendanceCode(code,startTime) " +
                "values('" + code + "', '" + startTime + "')";
        System.out.println(sql);
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println("AttendanceCodeDAO addCode: " + e.getMessage());
        }
    }
}
