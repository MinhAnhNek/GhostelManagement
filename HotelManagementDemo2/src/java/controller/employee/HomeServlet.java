/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.employee;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

import dao.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.AttendanceCode;
import model.Employee;

/**
 *
 * @author ADMIN
 */
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        EmployeeDAO employeeDAO = new EmployeeDAO();
        AttendanceDAO attendanceDAO = new AttendanceDAO();
        HttpSession session = request.getSession();

        attendanceDAO.autoAddAttendance();
        Account account = (Account) session.getAttribute("account");
        AccountDAO accountDAO = new AccountDAO();
//        Account account = accountDAO.getAccount("Username","emp@email.com");

        Employee emp = employeeDAO.getEmployeeByUsername(account.getUsername());
        session.setAttribute("emp", emp);

        session.setAttribute("attendances", attendanceDAO.getByEmployeeID(emp.getId(), " month(getdate()) "));
        session.setAttribute("monthlyPresentCount", attendanceDAO.countByEmployeeID(emp.getId(), "Present"));
        session.setAttribute("monthlyAbsentCount", attendanceDAO.countByEmployeeID(emp.getId(),  "Absent"));
        session.setAttribute("monthlyLateCount", attendanceDAO.countByEmployeeID(emp.getId(),  "Late"));
        session.setAttribute("monthlyDayOff", attendanceDAO.countByEmployeeID(emp.getId(),  "Day Off"));

        PayrollDAO payrollDAO = new PayrollDAO();
        session.setAttribute("payroll", payrollDAO.getByEmpIDAndMonth(emp.getId(), " month(getdate()) "));

        RequestDAO requestDAO = new RequestDAO();
        session.setAttribute("requests", requestDAO.getRequestsByType("EmployeeID", String.valueOf(emp.getId())));

        RequestTypeDAO requestTypeDAO = new RequestTypeDAO();
        session.setAttribute("requestTypes", requestTypeDAO.getAll());

        ScheduleDAO scheduleDAO = new ScheduleDAO();
        session.setAttribute("schedule", scheduleDAO.getByEmployeeID(emp.getId()));

        request.getRequestDispatcher("employee/home.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        AttendanceCodeDAO attendanceCodeDAO = new AttendanceCodeDAO();
        String attCode = request.getParameter("attCode");
        AttendanceCode ac = attendanceCodeDAO.getByTime("", attCode);
        if (ac == null) {
            System.out.println("invalid code");
            session.setAttribute("attCode", attCode);
            session.setAttribute("wrongCode", "This code is invalid");
        } else {
            session.setAttribute("successAttend", "Successfully attended");
            AttendanceDAO attendanceDAO = new AttendanceDAO();
            Employee emp = (Employee) session.getAttribute("emp");

            LocalTime now = LocalTime.now();
            String status = "Late";
            if (now.isBefore(LocalTime.parse("09:00", DateTimeFormatter.ofPattern("HH:mm")))) {
                status = "Present";
            }
            attendanceDAO.update(String.valueOf(emp.getId()), "", "", status);
            System.out.println("successfully attended");
        }
        response.sendRedirect("employee");
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
