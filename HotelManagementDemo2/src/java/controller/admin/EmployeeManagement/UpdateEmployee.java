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
public class UpdateEmployee extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String name = request.getParameter("name");
        String role = request.getParameter("role");
        String startDate = request.getParameter("startDate");
        String hotelName = request.getParameter("hotelName");
        String mail = request.getParameter("mail");
        String phoneNum = request.getParameter("phoneNum");
        String status = request.getParameter("status");
        String address = request.getParameter("address");
        Employee newEmp = new Employee(Integer.parseInt(request.getParameter("id")), name, status, role, startDate,hotelName, mail, phoneNum, address, Float.parseFloat(request.getParameter("salary")));
        EmployeeDAO eDAO = new EmployeeDAO();
        eDAO.update(newEmp);
        response.sendRedirect("admin");
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
