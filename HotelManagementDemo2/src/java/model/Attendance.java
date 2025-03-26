package model;

import java.sql.Time;
import java.util.Date;

public class Attendance {
    private int attId, employeeID;
    private Date date;
    private Time checkInTime, checkOutTime;
    private String status;
    private float totalHours;

    public Attendance(int id, int employeeID, Date date, Time checkInTime, Time checkOutTime, String status, float totalHours) {
        this.attId = id;
        this.employeeID = employeeID;
        this.date = date;
        this.checkInTime = checkInTime;
        this.checkOutTime = checkOutTime;
        this.status = status;
        this.totalHours = totalHours;
    }

    public int getAttId() {
        return attId;
    }

    public void setAttId(int attId) {
        this.attId = attId;
    }

    public int getEmployeeID() {
        return employeeID;
    }

    public void setEmployeeID(int employeeID) {
        this.employeeID = employeeID;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Time getCheckInTime() {
        return checkInTime;
    }

    public void setCheckInTime(Time checkInTime) {
        this.checkInTime = checkInTime;
    }

    public Time getCheckOutTime() {
        return checkOutTime;
    }

    public void setCheckOutTime(Time checkOutTime) {
        this.checkOutTime = checkOutTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public float getTotalHours() {
        return totalHours;
    }

    public void setTotalHours(float totalHours) {
        this.totalHours = totalHours;
    }
}
