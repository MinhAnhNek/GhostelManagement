package model;

public class EmployeeStatus {
    private int id;
    private String name;

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public EmployeeStatus(int id, String name) {
        this.id = id;
        this.name = name;
    }
}
