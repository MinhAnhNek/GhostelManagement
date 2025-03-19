package model;

public class Account {
    private String username;
    private String password;
    private int roleId;
    private int statusID;

    public Account(String username, String password, int roleId, int statusID) {
        this.username = username;
        this.password = password;
        this.roleId = roleId;
        this.statusID = statusID;
    }


    public Account() {}
    public Account(String username, String password) {
        this.username = username;
        this.password = password;
    }
//    public Account(String username, String password, int roleId) {
//        this.username = username;
//        this.password = password;
//        this.roleId = roleId;
//    }

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
