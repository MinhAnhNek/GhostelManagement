package dao;

import model.EmployeeRole;
import model.EmployeeStatus;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

public class EmployeeStatusDAO extends DBContext {
    public List<EmployeeStatus> getAll() {
        String sql = "select * from EmployeeStatus ";
        LinkedList<EmployeeStatus> list = new LinkedList<>();
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new EmployeeStatus(rs.getInt(1), rs.getString(2)));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public int getEmployeeStatusByName(String name) {
        String sql = "select StatusID from EmployeeStatus where StatusName = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, name);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("EmpStatusDAO: " + e);
        }
        return -1;
    }}
