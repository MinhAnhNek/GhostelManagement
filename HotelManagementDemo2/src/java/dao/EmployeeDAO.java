package dao;

import model.Employee;
import model.Payroll;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

public class EmployeeDAO extends DBContext {

    // ===============================      READ FROM DATABASE     ===============================
    // Read information of Employees from database

    public List<Employee> getAll(String sortType) {
        LinkedList<Employee> list = new LinkedList<>();
        String sql ="select e.EmployeeID, e.Name, es.StatusName, er.RoleName, e.StartDate, h.Name, e.Mail, e.PhoneNum, e.Address, p.base_salary " +
                "from Employee e " +
                "left join EmployeeRole er on e.RoleID = er.RoleID " +
                "left join Hotel h on e.HotelID = h.HotelID " +
                "left join EmployeeStatus es on e.StatusID = es.StatusID " +
                "left join payroll p on e.EmployeeID = p.EmployeeID " +
                "where month(getDate()) = p.salary_month ";
        if (!sortType.isEmpty()) {
            sql += " order by " + convertTypeToColumnName(sortType) + " ";
            System.out.println(sql);
        }
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new Employee(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getFloat(10)
                ));
            }
        } catch (SQLException e) {
            System.out.println("EmployeeDAO getAll: " + e.getMessage());
        }
        return list;
    }

    public Employee getEmployeeById(int id) {
        String sql ="select e.EmployeeID, e.Name, es.StatusName, er.RoleName, e.StartDate, h.Name, e.Mail, e.PhoneNum, e.Address, p.base_salary " +
                "from Employee e " +
                "left join EmployeeRole er on e.RoleID = er.RoleID " +
                "left join Hotel h on e.HotelID = h.HotelID " +
                "left join EmployeeStatus es on e.StatusID = es.StatusID " +
                "left join payroll p on e.EmployeeID = p.EmployeeID " +
                "where month(getDate()) = p.salary_month " +
                "and e.EmployeeID = ?";

        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, id);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                return new Employee(
//                        rs.getInt("EmployeeID"),
//                        rs.getString("Name"),
//                        rs.getString("StatusName"),
//                        rs.getString("RoleName"),
//                        rs.getString("StartDate"),
//                        rs.getString("Name"),
//                        rs.getString("Mail"),
//                        rs.getString("PhoneNum"),
//                        rs.getString("Address"),
//                        rs.getFloat("Salary")
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getFloat(10)
                );
            }
        } catch (SQLException e) {
            System.out.println("EmployeeDAO getEmployeeById: " + e.getMessage());
        }
        return null;
    }

    public Employee getEmployeeByUsername(String username) {
        StringBuilder sql = new StringBuilder(
                "select e.EmployeeID, e.Name, es.StatusName, er.RoleName, e.StartDate, h.Name, e.Mail, e.PhoneNum, e.Address, p.base_salary " +
                "from Employee e " +
                "left join EmployeeRole er on e.RoleID = er.RoleID " +
                "left join Hotel h on e.HotelID = h.HotelID " +
                "left join EmployeeStatus es on e.StatusID = es.StatusID " +
                "left join payroll p on e.EmployeeID = p.EmployeeID " +
                "where month(getDate()) = p.salary_month " +
                "and e.Mail like '%" + username + "%'"
        );
        try {
            PreparedStatement pre = connection.prepareStatement(String.valueOf(sql));
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                return new Employee(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getFloat(10)
                );
            }
        } catch (SQLException e) {
            System.out.println("EmployeeDAO getEmployeeByUsername: " + e.getMessage());
        }
        return null;
    }

    public String convertTypeToColumnName(String type) {
//        if (type.equals("minSalary") || type.equals("maxSalary")) {
//            return "e.salary";
//        }
//        return "e." + type;
        return switch (type) {
            case "minSalary", "maxSalary" -> "p.base_salary";
            default -> "e." + type;
        };
    }

    public List<Employee> getEmployeesByTypes(Map<String, String> selected, String sortType) {
        StringBuilder sql = new StringBuilder(
                "select e.EmployeeID, e.Name, es.StatusName, er.RoleName, e.StartDate, h.Name, e.Mail, e.PhoneNum, e.Address, p.base_salary " +
                        "from Employee e " +
                        "left join EmployeeRole er on e.RoleID = er.RoleID " +
                        "left join Hotel h on e.HotelID = h.HotelID " +
                        "left join EmployeeStatus es on e.StatusID = es.StatusID " +
                        "left join payroll p on e.EmployeeID = p.EmployeeID " +
                        "where month(getDate()) = p.salary_month " +
                        "and ");
        boolean hasSalary = false;
        boolean appended = false;
        for (Map.Entry<String, String> entry : selected.entrySet()) {
            if (entry.getValue() != null && !entry.getValue().isEmpty() ) {
                System.out.println(entry.getKey() + " = " + entry.getValue());
                if (entry.getKey().equals("minSalary")) {
                    sql.append(convertTypeToColumnName(entry.getKey())).append(" >= ").append(entry.getValue());
                    hasSalary = true;
                } else if (entry.getKey().equals("maxSalary")) {
                    sql.append(convertTypeToColumnName(entry.getKey())).append(" <= ").append(entry.getValue());
                } else {
                    sql.append(convertTypeToColumnName(entry.getKey())).append(" like '").append(entry.getValue()).append("'");
                }
                sql.append(" and ");
                appended = true;
                System.out.println(appended);
            }
        }
        if (!appended) {
            return getAll(sortType);
        }
        String sql2 = sql.substring(0, sql.length() - 4);
        if (!sortType.isEmpty()) {
            sql2 += " order by " + convertTypeToColumnName(sortType);
        }
        LinkedList<Employee> list = new LinkedList<>();
        try {
            PreparedStatement pre = connection.prepareStatement(sql2);
            System.out.println(sql2);
            for (Map.Entry<String, String> entry : selected.entrySet()) {
                if (entry.getValue() != null && !entry.getValue().isEmpty() ) {
                    System.out.println(entry.getValue() + " " + entry.getKey() + " ");
                    if (!hasSalary && entry.getKey().equals("minSalary")) {
                        break;
                    }
                }
            }
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new Employee(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getFloat(10)
                ));
            }
        } catch (SQLException e) {
            System.out.println("EmployeeDAO getEmployeesByTypes: " + e.getMessage());
        }
        return list;
    }

    public int countEmployeesByStatus(String status) {
        String sql = "select count(*) from Employee e left join EmployeeStatus es on e.StatusID = es.StatusID" +
                " where es.statusName like '" + status + "'";

        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("EmployeeDAO countEmployeesByStatus: " + e.getMessage());
        }
        return -1;
    }


    // ===============================      ADD NEW EMPLOYEE    ===============================

    public void addNew(Employee e, float overtime_pay) {
        String sql = "insert into Employee(Name, RoleID, StartDate, HotelID, Mail, PhoneNum, StatusID, Address) " +
                "values (?, ?, cast (getDate() as date), ?, ?, ?, 1, ?);";
        try {
            EmployeeRoleDAO erDAO = new EmployeeRoleDAO();
            HotelDAO hotelDAO = new HotelDAO();
            EmployeeStatusDAO esDAO = new EmployeeStatusDAO();
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, e.getName());
            pre.setInt(2, erDAO.getEmployeeRoleIDByName(e.getRole()));
//            System.out.println(e.getRole() + " " + erDAO.getEmployeeRoleIDByName(e.getRole()));
//            pre.setFloat(3, e.getSalary());
//            pre.setString(3, e.getStartDate());
            pre.setInt(3, hotelDAO.getHotelIDByName(e.getHotelName()));
            pre.setString(4, e.getMail());
            pre.setString(5, e.getPhoneNum());
//            pre.setInt(6, esDAO.getEmployeeStatusByName(e.getStatus()));
            pre.setString(6, e.getAddress());
            pre.executeUpdate();

            PayrollDAO pDAO = new PayrollDAO();
            pDAO.add(e.getId(), e.getSalary(), overtime_pay);
        } catch (SQLException ex) {
            System.out.println("EmployeeDAO addNew(): " + ex.getMessage());
        }
    }



    // ===============================      UPDATE EMPLOYEE INFORMATION     ===============================

    public void update(Employee e, float overtime_pay, int month) {
        String sql = "update Employee " +
                "set Name = ?, RoleID = ?, StartDate = ?, HotelID = ?, Mail = ?, PhoneNum = ?, StatusID = ?, Address = ? " +
                "where EmployeeID = ? ";
        try {
            EmployeeRoleDAO erDAO = new EmployeeRoleDAO();
            HotelDAO hotelDAO = new HotelDAO();
            EmployeeStatusDAO esDAO = new EmployeeStatusDAO();
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, e.getName());
            pre.setInt(2, erDAO.getEmployeeRoleIDByName(e.getRole()));
//            System.out.println(e.getRole() + " " + erDAO.getEmployeeRoleIDByName(e.getRole()));
//            pre.setFloat(3, e.getSalary());
            pre.setString(3, e.getStartDate());
            pre.setInt(4, hotelDAO.getHotelIDByName(e.getHotelName()));
            pre.setString(5, e.getMail());
            pre.setString(6, e.getPhoneNum());
            pre.setInt(7, esDAO.getEmployeeStatusByName(e.getStatus()));
            pre.setString(8, e.getAddress());
            pre.setInt(9, e.getId());
            pre.executeUpdate();
            PayrollDAO pDAO = new PayrollDAO();
            pDAO.updateSalary(e.getId(), e.getSalary(), overtime_pay, month);
        } catch (SQLException ex) {
            System.out.println("EmployeeDAO update(): " + ex.getMessage());
        }
    }
}
