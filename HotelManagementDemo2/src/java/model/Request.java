package model;

import java.util.Date;
import java.util.LinkedList;

public class Request {
    private int id, typeID, employeeID;
    private String status, reason, appliedDate;

    public Request(int id, int employeeID, int typeID, String status, String reason, String appliedDate) {
        this.id = id;
        this.employeeID = employeeID;
        this.typeID = typeID;
        this.status = status;
        this.reason = reason;
        this.appliedDate = appliedDate;
    }

    public int getId() {
        return id;
    }

    public int getTypeID() {
        return typeID;
    }

    public int getEmployeeID() {
        return employeeID;
    }

    public String getStatus() {
        return status;
    }

    public String getReason() {
        return reason;
    }

    public String getAppliedDate() {
        return appliedDate;
    }

}
