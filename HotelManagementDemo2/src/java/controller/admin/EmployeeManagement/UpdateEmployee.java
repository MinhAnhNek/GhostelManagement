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

        String name = request.getParameter("name");
        String role = request.getParameter("role");
        String startDate = request.getParameter("startDate");
        String hotelName = request.getParameter("hotelName");
        String mail = request.getParameter("mail");
        String phoneNum = request.getParameter("phoneNum");
        String status = request.getParameter("status");
        String address = request.getParameter("address");
        String monthStr = request.getParameter("month");
        int month = monthStr == null ? 3 : Integer.parseInt(monthStr);
        EmployeeDAO eDAO = new EmployeeDAO();

        Employee newEmp = eDAO.getEmployeeById(Integer.parseInt(request.getParameter("id")));
        if (name != null && !name.isEmpty()) newEmp.setName(name);
        if (role != null && !role.isEmpty()) newEmp.setRole(role);
        if (startDate != null && !startDate.isEmpty()) newEmp.setStartDate(startDate);
        if (hotelName != null && !hotelName.isEmpty()) newEmp.setHotelName(hotelName);
        if (mail != null && !mail.isEmpty()) newEmp.setMail(mail);
        if (phoneNum != null && !phoneNum.isEmpty()) newEmp.setPhoneNum(phoneNum);
        if (status != null && !status.isEmpty()) newEmp.setStatus(status);
        if (address != null && !address.isEmpty()) newEmp.setAddress(address);
//                new Employee(Integer.parseInt(request.getParameter("id")), name, status, role, startDate,hotelName, mail, phoneNum, address, Float.parseFloat(request.getParameter("salary")));
        eDAO.update(newEmp, Float.parseFloat(request.getParameter("overtime_pay")), month);
        response.sendRedirect("admin?id=" + newEmp.getId());
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
