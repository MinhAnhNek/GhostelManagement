package dao;

import model.Payroll;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

public class PayrollDAO extends DBContext {
    public List<Payroll> getByMonth(String month, String year) {
        if (month.isEmpty()) month = " month(getdate()) ";
        if (year.isEmpty()) year = " year(getdate()) ";
        String sql = "select * from Payroll " +
                "where salary_month like " + month +
                " and salary_year like " + year +
                " order by total_salary desc ";

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
                        rs.getFloat(10),
                        rs.getString(11)
                ));
            }
        } catch (SQLException e) {
            System.out.println("PayrollDAO getAll: " + e.getMessage());
        }
        return list;
    }

    public List<Payroll> getByEmpIDAndMonth(int id, String month) {
        List<Payroll> list = new LinkedList<>();
        String sql = "select * from Payroll " +
                "where EmployeeID = ? and salary_month like '%" + month + "%' " +
                "order by salary_year desc, salary_month desc ";
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
                        rs.getFloat(10),
                        rs.getString(11)
                ));
            }
        } catch (SQLException e) {
            System.out.println("PayrollDAO getByEmpIDAndMonth: " + e.getMessage());
        }
        return list;
    }



    // =========================    ADD NEW PAYROLL   ============================
    public void add(int employeeID, float base_salary, float overtime_pay) {
        String sql = "insert into Payroll (EmployeeID, base_salary, overtime_pay) values (?, ?, ?)";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, employeeID);
            pre.setFloat(2, base_salary);
            pre.setFloat(3, overtime_pay);
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println("PayrollDAO add: " + e.getMessage());
        }

    }



    // =========================    UPDATE PAYROLL   ============================

    public void updateSalary(int employeeID, float salary, float overtime_pay) {
        String sql = "update payroll set base_salary = ?, overtime_pay = ? where employeeID = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setFloat(1, salary);
            pre.setFloat(2, overtime_pay);
            pre.setInt(3, employeeID);
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println("PayrollDAO updateSalary: " + e.getMessage());
        }
    }
}
