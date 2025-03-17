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

    public List<Payroll> getByYear(String hotelID, String year) {
        if (year.isEmpty()) year = "year(getdate())";
        String sql = "select p.EmployeeID, salary_year, sum(total_working_days), sum(total_hours), sum(overtime_hours), sum(base_salary), sum(overtime_pay), sum(total_salary) " +
                "from payroll p left join Employee e on e.EmployeeID = p.EmployeeID " +
                "where e.HotelID like '%" + hotelID + "%' and salary_year like " + year +
                "group by p.EmployeeID, salary_year ";
        List<Payroll> list = new LinkedList<>();
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new Payroll(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getFloat(4),
                        rs.getFloat(5),
                        rs.getFloat(6),
                        rs.getFloat(7),
                        rs.getFloat(8),
                        "Pending"
//                        rs.getString(9)
                ));
            }
        } catch (SQLException e) {
            System.out.println("PayrollDAO getByYear: " + e.getMessage());
        }
        return list;
    }

    public List<Payroll> getByHotelAndMonth(String id, String month) {
        List<Payroll> list = new LinkedList<>();
        String sql = "select * from Payroll p " +
                "left join Employee e on e.EmployeeID = p.EmployeeID " +
                "where e.HotelID like '%" + id + "%' and salary_month like '%" + month + "%' " +
                "order by salary_year desc, salary_month desc ";
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
            System.out.println("PayrollDAO getByEmpIDAndMonth: " + e.getMessage());
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


    public double getTotalPaidSalary() {
        String sql = "select sum(total_salary) from Payroll";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) return rs.getDouble(1);
        } catch (SQLException e) {
            System.out.println("PayrollDAO getTotalPaidSalary: " + e.getMessage());
        }
        return -1;
    }

    public List<Payroll> getByStatus(String status) {
        String sql = "select * from Payroll where status like '" + status + "'";
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
            System.out.println("PayrollDAO getByStatus(): " + e.getMessage());
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
    public void updateSalary(int employeeID, float base_salary, float overtime_pay, int month) {
        String sql = "update payroll set base_salary = ?, overtime_pay = ? where EmployeeID = ? and salary_month like '" + month + "'";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setFloat(1, base_salary);
            pre.setFloat(2, overtime_pay);
            pre.setInt(3, employeeID);
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println("PayrollDAO updateSalary: " + e.getMessage());
        }

    }

    public void update(Payroll p) {
        String sql = "update payroll " +
                "set base_salary = ?, overtime_pay = ?, total_working_days = ?, total_hours = ?, overtime_hours = ?, status = ? " +
                "where employeeID = ? and salary_month like ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setFloat(1, p.getBaseSalary());
            pre.setFloat(2, p.getOvertimePay());
            pre.setInt(3, p.getTotalWorkingDays());
            pre.setFloat(4, p.getTotalHours());
            pre.setFloat(5, p.getOvertimeHours());
            pre.setString(6, p.getStatus());
            pre.setInt(7, p.getEmployeeID());
            pre.setInt(8, p.getSalaryMonth());
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println("PayrollDAO update: " + e.getMessage());
        }
    }
}
