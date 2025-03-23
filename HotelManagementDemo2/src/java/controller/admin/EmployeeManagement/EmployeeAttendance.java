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


        String hotelID = request.getParameter("hotelID");
        hotelID = hotelID == null ? "" : hotelID;
        String status = request.getParameter("status");
        status = status == null ? "" : status;
        session.setAttribute("hotels", hotelDAO.getAll());
        session.setAttribute("totalEmp", employeeDAO.getAll(""));
        session.setAttribute("hotelAttendance", attendanceDAO.getByDateAndStatus("", "", hotelID));
        session.setAttribute("attendances", attendanceDAO.getByDateAndStatus("", status, hotelID));
        session.setAttribute("lates", attendanceDAO.getByDateAndStatus("", "late", hotelID));
        session.setAttribute("presents", attendanceDAO.getByDateAndStatus("", "present", hotelID));
        session.setAttribute("absents", attendanceDAO.getByDateAndStatus("", "absent", hotelID));
        session.setAttribute("dayoffs", attendanceDAO.getByDateAndStatus("", "Day Off", hotelID));

        request.setAttribute("hotelID", hotelID);
        request.setAttribute("status", status);

        request.getRequestDispatcher("admin/EmployeeAttendance.jsp").forward(request, response);
    } 


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

        String checkInTime = request.getParameter("checkInTime");
        System.out.println(checkInTime);
        String checkOutTime = request.getParameter("checkOutTime");
        System.out.println(checkOutTime);
        AttendanceDAO attendanceDAO = new AttendanceDAO();

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
