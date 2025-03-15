package dao;

import model.Payroll;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

public class PayrollDAO extends DBContext {
    public List<Payroll> getAll() {
        String sql = "select * from Payroll";
        List<Payroll> list = new LinkedList<>();
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new Payroll(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getInt(4),
                        rs.getInt(5),
                        rs.getFloat(6),
                        rs.getFloat(7),
                        rs.getFloat(8),
                        rs.getFloat(9),
                        rs.getFloat(10)
                ));
            }
        } catch (SQLException e) {
            System.out.println("PayrollDAO getAll: " + e.getMessage());
        }
        return list;
    }

    public List<Payroll> getByEmpIDAndMonth(int id, String month) {
        List<Payroll> list = new LinkedList<>();
        String sql = "select * from Payroll where EmployeeID = ? and salary_month like '%" + month + "%'";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, id);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new Payroll(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getInt(4),
                        rs.getInt(5),
                        rs.getFloat(6),
                        rs.getFloat(7),
                        rs.getFloat(8),
                        rs.getFloat(9),
                        rs.getFloat(10)
                ));
            }
        } catch (SQLException e) {
            System.out.println("PayrollDAO getByEmpIDAndMonth: " + e.getMessage());
        }
        return list;
    }

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
