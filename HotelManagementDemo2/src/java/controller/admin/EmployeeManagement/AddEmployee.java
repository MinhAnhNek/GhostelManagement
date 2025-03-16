/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.admin.EmployeeManagement;

import java.io.IOException;

import dao.EmployeeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Employee;

/**
 *
 * @author ADMIN
 */
public class AddEmployee extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String name = request.getParameter("name");
        String role = request.getParameter("role");
        String hotelName = request.getParameter("hotelName");
        String mail = request.getParameter("mail");
        String phoneNum = request.getParameter("phoneNum");
        String address = request.getParameter("address");
        Employee newEmp = new Employee(name, role, hotelName, mail, phoneNum, address, Float.parseFloat(request.getParameter("salary")));
        EmployeeDAO eDAO = new EmployeeDAO();
        eDAO.addNew(newEmp, Float.parseFloat(request.getParameter("overtime_pay")));
        response.sendRedirect("admin");
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
