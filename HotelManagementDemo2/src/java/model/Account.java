package model;

public class Account {
    private String username;
    private String password;
    private String phoneNum;
    private int roleId;
    private int statusID;

    public Account(String username, String password, int roleId, String phoneNum, int statusID) {
        this.phoneNum = phoneNum;
        this.username = username;
        this.password = password;
        this.roleId = roleId;
        this.statusID = statusID;
    }

    public String getPhoneNum() {
        return phoneNum;
    }

    public void setPhoneNum(String phoneNum) {
        this.phoneNum = phoneNum;
    }

    public Account() {}
    public Account(String username, String password) {
        this.username = username;
        this.password = password;
    }

    public Account(String username, String password, String phoneNum) {
        this.username = username;
        this.password = password;
        this.phoneNum = phoneNum;
    }

    public int getStatusID() {
        return statusID;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public int getRoleId() {
        return roleId;
    }
}
