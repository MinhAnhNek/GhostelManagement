package model;

public class Payroll {
    private int payrollID, employeeID, salaryMonth, salaryYear, totalWorkingDays;
    private float totalHours, overtimeHours, baseSalary, totalSalary, overtimePay;
    private String status;
    public Payroll() {}

    public Payroll(int payrollID, int employeeID, int salaryMonth, int salaryYear, int totalWorkingDays, float totalHours, float overtimeHours, float baseSalary, float overtimePay, float totalSalary, String status) {
        this.payrollID = payrollID;
        this.employeeID = employeeID;
        this.salaryMonth = salaryMonth;
        this.salaryYear = salaryYear;
        this.totalWorkingDays = totalWorkingDays;
        this.totalHours = totalHours;
        this.overtimeHours = overtimeHours;
        this.baseSalary = baseSalary;
        this.overtimePay = overtimePay;
        this.totalSalary = totalSalary;
        this.status = status;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public float getOvertimePay() {
        return overtimePay;
    }

    public void setOvertimePay(float overtimePay) {
        this.overtimePay = overtimePay;
    }

    public int getPayrollID() {
        return payrollID;
    }

    public void setPayrollID(int payrollID) {
        this.payrollID = payrollID;
    }

    public int getEmployeeID() {
        return employeeID;
    }

    public void setEmployeeID(int employeeID) {
        this.employeeID = employeeID;
    }

    public int getSalaryMonth() {
        return salaryMonth;
    }

    public void setSalaryMonth(int salaryMonth) {
        this.salaryMonth = salaryMonth;
    }

    public int getSalaryYear() {
        return salaryYear;
    }

    public void setSalaryYear(int salaryYear) {
        this.salaryYear = salaryYear;
    }

    public int getTotalWorkingDays() {
        return totalWorkingDays;
    }

    public void setTotalWorkingDays(int totalWorkingDays) {
        this.totalWorkingDays = totalWorkingDays;
    }

    public float getTotalHours() {
        return totalHours;
    }

    public void setTotalHours(float totalHours) {
        this.totalHours = totalHours;
    }

    public float getOvertimeHours() {
        return overtimeHours;
    }

    public void setOvertimeHours(float overtimeHours) {
        this.overtimeHours = overtimeHours;
    }

    public float getBaseSalary() {
        return baseSalary;
    }

    public void setBaseSalary(float baseSalary) {
        this.baseSalary = baseSalary;
    }

    public float getTotalSalary() {
        return totalSalary;
    }

    public void setTotalSalary(float totalSalary) {
        this.totalSalary = totalSalary;
    }
}
