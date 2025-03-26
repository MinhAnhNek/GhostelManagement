package dao;

import model.Schedule;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ScheduleDAO extends DBContext {
    public Schedule getByEmployeeID(int employeeID) {
        String sql = "select * from work_schedule where EmployeeID = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, employeeID);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                return new Schedule(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getTime(3),
                        rs.getTime(4),
                        rs.getString(5).split(", ")
                );
            }
        } catch (SQLException e) {
            System.out.println("ScheduleDAO.getByEmployeeID: " + e.getMessage());
        }
        return null;
    }
}
