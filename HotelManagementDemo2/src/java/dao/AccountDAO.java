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

    public Account getAccount(String loginMethod, String loginValue) {
        String sql = "select * from Account where " + loginMethod + " like '" + loginValue + "'";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                return new Account(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getString(4),
                        rs.getInt(5)
                );
            }
        } catch (SQLException e) {
            System.out.println("AccountDAO getAccount(username):" + e.getMessage());
        }
        return null;
    }

    public boolean checkLogin(String loginMethod, String loginValue, String password) {
        String sql = "select * from Account " +
                "where password = ? and " + loginMethod + " = ? " ;
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, password);
            pre.setString(2, loginValue);
            ResultSet rs = pre.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.out.println("AccountDAO checkLogin: " + e.getMessage());
        }
        return false;
    }

    public void add(Account a) {
        String sql = "insert into Account(Username, Password, RoleID, phoneNum) values('" + a.getUsername() + "', '" + a.getPassword() + "' ," + a.getRoleId() + ", " + a.getPhoneNum() + " )";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println("AccountDAO.add(): " + e.getMessage());
        }
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

    public void updateAccountStatus(String username, int status) {
        String sql = "update Account set StatusID = " + status + " where username = '" + username + "'";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println("AccountDAO updateAccountStatus: " + e.getMessage());
        }
    }
}
