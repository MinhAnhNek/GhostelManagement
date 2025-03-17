package model;

import java.util.LinkedList;

public class FilterType {

    public static LinkedList<String> getEmployeeFilterTypes() {
        LinkedList<String> list = new LinkedList<>();
//        list.add(new FilterType("all", "Search All"));
        list.add("employeeID");
        list.add("name");
        list.add("roleID");
        list.add("hotelID");
        list.add("mail");
        list.add("phoneNum");
        list.add("statusID");
        return list;
    }

    public static LinkedList<String> getRoomFilterTypes() {
        LinkedList<String> list = new LinkedList<>();
        list.add("hotelID");
        list.add("roomTypeID");
        list.add("roomStatusID");
        list.add("roomNumber");
        list.add("capacity");
        return list;
    }

    public static LinkedList<String> getRequestFilterTypes() {
        LinkedList<String> list = new LinkedList<>();
        list.add("RequestID");
        list.add("EmployeeID");
        list.add("RequestTypeID");
        list.add("status");
        list.add("reason");
        return list;
    }
}
