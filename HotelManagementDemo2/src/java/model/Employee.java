package model;

import java.util.LinkedList;

public class Employee {
    private int id;
    private String name, status, role, startDate, hotelName, mail, phoneNum, address;
    private float salary;

    public Employee() {}

    public Employee(int id,
                    String name,
                    String status,
                    String role,
                    String startDate,
                    String hotelName,
                    String mail,
                    String phoneNum,
                    String address,
                    float salary) {
        this.id = id;
        this.name = name;
        this.status = status;
        this.role = role;
        this.startDate = startDate;
        this.hotelName = hotelName;
        this.mail = mail;
        this.phoneNum = phoneNum;
        this.address = address;
        this.salary = salary;
    }

    public Employee(String name, String status, String role, String startDate, String hotelName, String mail, String phoneNum, String address, float salary) {
        this.name = name;
        this.status = status;
        this.role = role;
        this.startDate = startDate;
        this.hotelName = hotelName;
        this.mail = mail;
        this.phoneNum = phoneNum;
        this.address = address;
        this.salary = salary;
    }

    public int getId() {
        return id;
    }
    public String getName() {
        return name;
    }

    public String getStatus() {
        return status;
    }

    public String getRole() {
        return role;
    }

    public String getStartDate() {
        return startDate;
    }

    public String getHotelName() {
        return hotelName;
    }

    public String getMail() {
        return mail;
    }

    public String getPhoneNum() {
        return phoneNum;
    }

    public String getAddress() {
        return address;
    }

    public float getSalary() {
        return salary;
    }


    public static LinkedList<Employee> getPage(int pageNo, LinkedList<Employee> list) {
        LinkedList<Employee> page = new LinkedList<>();
        int max = pageNo * 6;
        for (int i = (pageNo-1)*6; i < max && i < list.size(); i++) {
            page.add(list.get(i));
        }
        return page;
    }
}
