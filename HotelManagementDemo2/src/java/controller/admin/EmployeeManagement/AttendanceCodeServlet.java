/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.admin.EmployeeManagement;

import java.io.IOException;
import java.sql.Time;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

import dao.AttendanceCodeDAO;
import dao.AttendanceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Attendance;

import static java.sql.Time.*;

/**
 *
 * @author ADMIN
 */
public class AttendanceCodeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
//        request.getRequestDispatcher("EmployeeAttendance").forward(request, response);
        response.sendRedirect("EmployeeAttendance");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        String attCode = request.getParameter("attCode");
        String startTime = request.getParameter("startTime");
//        System.out.println("Attendance Code: " + attCode);
//        System.out.println("Star Time: " + startTime);
        AttendanceCodeDAO attendanceCodeDAO = new AttendanceCodeDAO();
        boolean isExist = attendanceCodeDAO.getByCode(attCode) != null;
//        System.out.println("isExist: " + isExist);

        if (isExist) {
            session.setAttribute("code", attCode);
            session.setAttribute("startTime", startTime);
            session.setAttribute("codeError", "Attendance Code Already Exists!");
            response.sendRedirect("EmployeeAttendance");
            return;
        }
        if (attendanceCodeDAO.getLast() != null) {
            LocalTime time = LocalTime.parse(startTime, DateTimeFormatter.ofPattern("HH:mm:ss"));
            LocalTime prevTime = attendanceCodeDAO.getLast().getEndTime().toLocalTime();
//            System.out.println("Prev Time: " + prevTime);
//            System.out.println(time.isBefore(prevTime));
            if (time.isBefore(prevTime)) {
                session.setAttribute("code", attCode);
                session.setAttribute("startTime", startTime);
                session.setAttribute("codeError", "Start Time is after End Time of the previous attendance code!");
                response.sendRedirect("EmployeeAttendance");
                return;
            }
        }
        attendanceCodeDAO.addCode(attCode, startTime);
        session.setAttribute("codeSuccess", "Attendance Code Added!");

//        request.getRequestDispatcher("admin/EmployeeAttendance.jsp").forward(request, response);
        response.sendRedirect("EmployeeAttendance");
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
