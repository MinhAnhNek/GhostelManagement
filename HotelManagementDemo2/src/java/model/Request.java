package model;

import java.util.Date;
import java.util.LinkedList;
import java.util.List;

public class Request {
    private int id, typeID, employeeID;
    private String status, reason, appliedDate;
    private String repliedDate, feedback;

    public Request(int id, int employeeID, int typeID, String status, String reason, String appliedDate, String repliedDate, String feedback) {
        this.id = id;
        this.typeID = typeID;
        this.employeeID = employeeID;
        this.status = status;
        this.reason = reason;
        this.appliedDate = appliedDate;
        this.repliedDate = repliedDate;
        this.feedback = feedback;
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

    public String getRepliedDate() {
        return repliedDate;
    }

    public String getFeedback() {
        return feedback;
    }

    public static List<Request> getPage(int pageNo, List<Request> requestList, int pageSize) {
        LinkedList<Request> page = new LinkedList<>();
        int max = pageNo * pageSize;
        for (int i = (pageNo-1) * pageSize; i < max && i < requestList.size(); i++) {
            page.add(requestList.get(i));
        }
        return page;
    }
}
