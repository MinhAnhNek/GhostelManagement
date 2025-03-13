package dao;

import model.Employee;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

public class EmployeeDAO extends DBContext {

    // ===============================      READ FROM DATABASE     ===============================
    // Read information of Employees from database

    public List<Employee> getAll() {
        LinkedList<Employee> list = new LinkedList<>();
        String sql ="select e.EmployeeID, e.Name, es.StatusName, er.RoleName, e.StartDate, h.Name, e.Mail, e.PhoneNum, e.Address, e.Salary " +
                "from Employee e " +
                "left join EmployeeRole er on e.RoleID = er.RoleID " +
                "left join Hotel h on e.HotelID = h.HotelID " +
                "left join EmployeeStatus es on e.StatusID = es.StatusID";
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
        String sql = "select e.EmployeeID, e.Name, es.StatusName, er.RoleName, e.StartDate, h.Name, e.Mail, e.PhoneNum, e.Address, e.Salary " +
                "from Employee e " +
                "left join EmployeeRole er on e.RoleID = er.RoleID " +
                "left join Hotel h on e.HotelID = h.HotelID " +
                "left join EmployeeStatus es on e.StatusID = es.StatusID " +
                "where e.EmployeeID = ?";

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

    public String convertTypeToColumnName(String type) {
        if (type.equals("minSalary") || type.equals("maxSalary")) {
            return "e.salary";
        }
        return "e." + type;
    }

    public List<Employee> getEmployeeByType(Map<String, String> selected) {
        StringBuilder sql = new StringBuilder(
                "select e.EmployeeID, " +
                "e.Name, " +
                "es.StatusName, " +
                "er.RoleName, " +
                "e.StartDate, " +
                "h.Name, " +
                "e.Mail, " +
                "e.PhoneNum, " +
                "e.Address, " +
                "e.Salary " +
                "from Employee e " +
                "left join EmployeeRole er on e.RoleID = er.RoleID " +
                "left join Hotel h on e.HotelID = h.HotelID " +
                "left join EmployeeStatus es on e.StatusID = es.StatusID " +
                "where ");
        boolean hasSalary = false;
        boolean appended = false;
        for (Map.Entry<String, String> entry : selected.entrySet()) {
            if (entry.getValue() != null && !entry.getValue().isEmpty() ) {
                System.out.println(entry.getKey() + " = " + entry.getValue());
                if (entry.getKey().equals("minSalary")) {
                    sql.append(" e.Salary >= ").append(entry.getValue());
                    hasSalary = true;
                } else if (entry.getKey().equals("maxSalary")) {
                    sql.append("e.Salary <= ").append(entry.getValue());
                } else {
                    sql.append(convertTypeToColumnName(entry.getKey())).append(" like '%").append(entry.getValue()).append("%'");
                }
                sql.append(" and ");
                appended = true;
                System.out.println(appended);
            }
        }
        if (!appended) {
            return getAll();
        }
        String sql2 = sql.substring(0, sql.length() - 4);
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
            System.out.println("EmployeeDAO getEmployeeByType: " + e.getMessage());
        }
        return list;
    }


    // ===============================      ADD NEW EMPLOYEE    ===============================

    public void addNew(Employee e) {
        String sql = "insert into Employee(Name, RoleID, Salary, StartDate, HotelID, Mail, PhoneNum, StatusID, Address) " +
                "values (?, ?, ?, ?, ?, ?, ?, ?, ?);";
        try {
            EmployeeRoleDAO erDAO = new EmployeeRoleDAO();
            HotelDAO hotelDAO = new HotelDAO();
            EmployeeStatusDAO esDAO = new EmployeeStatusDAO();
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, e.getName());
            pre.setInt(2, erDAO.getEmployeeRoleIDByName(e.getRole()));
//            System.out.println(e.getRole() + " " + erDAO.getEmployeeRoleIDByName(e.getRole()));
            pre.setFloat(3, e.getSalary());
            pre.setString(4, e.getStartDate());
            pre.setInt(5, hotelDAO.getHotelIDByName(e.getHotelName()));
            pre.setString(6, e.getMail());
            pre.setString(7, e.getPhoneNum());
            pre.setInt(8, esDAO.getEmployeeStatusByName(e.getStatus()));
            pre.setString(9, e.getAddress());
            pre.executeUpdate();
        } catch (SQLException ex) {
            System.out.println("EmployeeDAO addNew(): " + ex.getMessage());
        }
    }



    // ===============================      UPDATE EMPLOYEE INFORMATION     ===============================

    public void update(Employee e) {
        String sql = "update Employee " +
                "set Name = ?, RoleID = ?, Salary = ?, StartDate = ?, HotelID = ?, Mail = ?, PhoneNum = ?, StatusID = ?, Address = ? " +
                "where EmployeeID = ?";
        try {
            EmployeeRoleDAO erDAO = new EmployeeRoleDAO();
            HotelDAO hotelDAO = new HotelDAO();
            EmployeeStatusDAO esDAO = new EmployeeStatusDAO();
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, e.getName());
            pre.setInt(2, erDAO.getEmployeeRoleIDByName(e.getRole()));
//            System.out.println(e.getRole() + " " + erDAO.getEmployeeRoleIDByName(e.getRole()));
            pre.setFloat(3, e.getSalary());
            pre.setString(4, e.getStartDate());
            pre.setInt(5, hotelDAO.getHotelIDByName(e.getHotelName()));
            pre.setString(6, e.getMail());
            pre.setString(7, e.getPhoneNum());
            pre.setInt(8, esDAO.getEmployeeStatusByName(e.getStatus()));
            System.out.println(e.getStatus() + " " + esDAO.getEmployeeStatusByName(e.getStatus()));
            pre.setString(9, e.getAddress());
            pre.setInt(10, e.getId());
            pre.executeUpdate();
        } catch (SQLException ex) {
            System.out.println("EmployeeDAO update(): " + ex.getMessage());
        }
    }
}
