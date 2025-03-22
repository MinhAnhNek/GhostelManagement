/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.admin.EmployeeManagement;

import java.io.IOException;
import java.io.PrintWriter;

import dao.AttendanceDAO;
import dao.EmployeeDAO;
import dao.HotelDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author ADMIN
 */
public class EmployeeAttendance extends HttpServlet {
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        AttendanceDAO attendanceDAO = new AttendanceDAO();
        EmployeeDAO employeeDAO = new EmployeeDAO();
        HotelDAO hotelDAO = new HotelDAO();

        session.setAttribute("hotels", hotelDAO.getAll());
        session.setAttribute("employees", employeeDAO.getAll(""));
        session.setAttribute("attendances", attendanceDAO.getAll());

        request.getRequestDispatcher("admin/EmployeeAttendance.jsp").forward(request, response);
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
