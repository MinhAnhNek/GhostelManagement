package model;

import java.sql.Time;

public class Schedule {
    private int id;
    private int employeeId;
    private Time shiftStart;
    private Time shiftEnd;
    private String[] workDays;

    public Schedule(int id, int employeeId, Time shiftStart, Time shiftEnd, String[] workDays) {
        this.id = id;
        this.employeeId = employeeId;
        this.shiftStart = shiftStart;
        this.shiftEnd = shiftEnd;
        this.workDays = workDays;
    }

    public int getId() {
        return id;
    }

    public int getEmployeeId() {
        return employeeId;
    }

    public Time getShiftStart() {
        return shiftStart;
    }

    public Time getShiftEnd() {
        return shiftEnd;
    }

    public String[] getWorkDays() {
        return workDays;
    }
}
