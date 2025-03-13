package dao;

import model.Account;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

public class AccountDAO extends DBContext {
    public List<Account> getAll() {
        LinkedList<Account> list = new LinkedList<>();
        String sql = "select * from Account";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new Account(
                        rs.getString(1),
                        rs.getString(2)
                ));
            }
        } catch (SQLException e) {
            System.out.println("AccountDAO.getAll(): " + e.getMessage());
        }
        return list;
    }

    public Account getAccount(String user) {
        String sql = "select * from Account where username like '%" + user + "%'";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                return new Account(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getInt(3)
                );
            }
        } catch (SQLException e) {
            System.out.println("AccountDAO getAccount(username):" + e.getMessage());
        }
        return null;
    }

    public boolean checkLogin(String username, String password) {
        String sql = "select * from Account where username like '%" + username + "%' and password like '%" + password + "%'";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, username);
            pre.setString(2, password);
            ResultSet rs = pre.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }



    public void updateAccount(Account account) {
        String sql = "update Account " +
                "set password = " + account.getPassword() +
                " where username = '" + account.getUsername() + "'";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println("AccountDAO updateAccount: " + e.getMessage());
        }
    }
}
