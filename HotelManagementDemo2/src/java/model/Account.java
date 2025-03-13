package model;

public class Account {
    private String username;
    private String password;
    private int roleId;

    public Account() {}
    public Account(String username, String password) {
        this.username = username;
        this.password = password;
    }
    public Account(String username, String password, int roleId) {
        this.username = username;
        this.password = password;
        this.roleId = roleId;
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
