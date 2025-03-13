package model;

public class EmployeeRole {
    private int roleId;
    private String roleName;

    public EmployeeRole(int roleId, String roleName) {
        this.roleId = roleId;
        this.roleName = roleName;
    }

    public int getRoleId() {
        return roleId;
    }

    public String getRoleName() {
        return roleName;
    }
}
