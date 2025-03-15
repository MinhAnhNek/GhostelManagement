package dao;

import java.sql.PreparedStatement;
import java.sql.SQLException;

public class PayrollDAO extends DBContext {
    public void updateSalary(int employeeID, float salary) {
        String sql = "update payroll set base_salary = ? where employeeID = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setFloat(1, salary);
            pre.setInt(2, employeeID);
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println("PayrollDAO updateSalary: " + e.getMessage());
        }
    }
}
