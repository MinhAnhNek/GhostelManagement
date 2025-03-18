package model;

import java.util.LinkedList;
import java.util.List;

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

    public Employee(String name, String role, String hotelName, String mail, String phoneNum, String address, float salary) {
        this.name = name;
        this.role = role;
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

    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public void setHotelName(String hotelName) {
        this.hotelName = hotelName;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public void setPhoneNum(String phoneNum) {
        this.phoneNum = phoneNum;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public void setSalary(float salary) {
        this.salary = salary;
    }

    public static List<Employee> getPage(int pageNo, LinkedList<Employee> empList, int empDisplayedPerPage) {
        LinkedList<Employee> page = new LinkedList<>();
        int max = pageNo * empDisplayedPerPage;
        for (int i = (pageNo-1)*empDisplayedPerPage; i < max && i < empList.size(); i++) {
            page.add(empList.get(i));
        }
        return page;
    }
}
