package model;

import java.util.Date;
import java.util.LinkedList;
import java.util.List;

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

    public static List<Request> getPage(int pageNo, List<Request> requestList, int pageSize) {
        LinkedList<Request> page = new LinkedList<Request>();
        int max = pageNo * pageSize;
        for (int i = max - pageSize; i < max && i < requestList.size(); i++) {
            page.add(requestList.get(i));
        }
        return page;
    }
}
