/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.employee;

import java.io.IOException;
import java.io.PrintWriter;

import dao.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
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
        HttpSession session = request.getSession();

//        Account account = (Account) session.getAttribute("account");
        AccountDAO accountDAO = new AccountDAO();
        Account account = accountDAO.getAccount("emp@email.com");


        Employee emp = employeeDAO.getEmployeeByUsername(account.getUsername());
        session.setAttribute("emp", emp);

        AttendanceDAO attendanceDAO = new AttendanceDAO();
        session.setAttribute("attendance", attendanceDAO.getByEmployeeID(emp.getId(), " month(getdate()) "));
        session.setAttribute("monthlyPresentCount", attendanceDAO.countByEmployeeID(emp.getId(), "Present"));
        session.setAttribute("monthlyAbsentCount", attendanceDAO.countByEmployeeID(emp.getId(),  "Absent"));

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
