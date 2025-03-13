package dao;

import model.EmployeeRole;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

public class EmployeeRoleDAO extends DBContext {
    public List<EmployeeRole> getAll() {
        String sql = "select * from EmployeeRole ";
        LinkedList<EmployeeRole> list = new LinkedList<>();
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new EmployeeRole(rs.getInt(1), rs.getString(2)));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public int getEmployeeRoleIDByName(String name) {
        String sql = "select RoleID from EmployeeRole where RoleName like ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, "%" + name + "%");
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                return rs.getInt("RoleID");
            }
        } catch (SQLException e) {
            System.out.println("EmployeeRoleDAO: " + e);
        }
        return -1;
    }
}
