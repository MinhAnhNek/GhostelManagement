/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.admin.EmployeeManagement;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Time;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Locale;

import dao.AttendanceCodeDAO;
import dao.AttendanceDAO;
import dao.EmployeeDAO;
import dao.HotelDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.AttendanceCode;

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
        AttendanceCodeDAO attendanceCodeDAO = new AttendanceCodeDAO();


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
        session.setAttribute("attCodeList", attendanceCodeDAO.getByDate(""));

        AttendanceCode thisCode;
//                = attendanceCodeDAO.getLast();
        if (attendanceCodeDAO.getLast() == null) {
            thisCode = new AttendanceCode(
                    Time.valueOf(LocalTime.parse("08:30", DateTimeFormatter.ofPattern("HH:mm"))),
                    Time.valueOf(LocalTime.parse("09:30", DateTimeFormatter.ofPattern("HH:mm")))
            );
        } else {
            thisCode = attendanceCodeDAO.getPredictingNext();
        }
        if (LocalTime.parse(String.valueOf(thisCode.getEndTime())).isAfter(LocalTime.parse("17:30", DateTimeFormatter.ofPattern("HH:mm")))) {
//            System.out.println("end of working time");
            session.setAttribute("endOfTime", "End of Working Time");
        }
        session.setAttribute("thisCode", thisCode);
//        session.setAttribute("attendanceCodes", attendanceCodeDAO.getAll());

        request.setAttribute("hotelID", hotelID);
        request.setAttribute("status", status);

        request.getRequestDispatcher("admin/EmployeeAttendance.jsp").forward(request, response);
    } 


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();

        String checkInTime = request.getParameter("checkInTime");
//        System.out.println(checkInTime);
        String checkOutTime = request.getParameter("checkOutTime");
//        System.out.println(checkOutTime);
        String employeeID = request.getParameter("employeeID");
        AttendanceDAO attendanceDAO = new AttendanceDAO();
        LocalTime inTime = LocalTime.parse(checkInTime, DateTimeFormatter.ofPattern("HH:mm:ss"));
        LocalTime outTime = LocalTime.parse(checkOutTime, DateTimeFormatter.ofPattern("HH:mm"));
//        System.out.println(inTime.isAfter(outTime));

        if (inTime.isAfter(outTime)) {
            session.setAttribute("checkOutTimeError", "Check Out Time must be after Check In Time");
            session.setAttribute("empID", employeeID);
            response.sendRedirect("EmployeeAttendance");
            return;
        }
        String status = "";
        if (inTime.isBefore(LocalTime.parse("09:00", DateTimeFormatter.ofPattern("HH:mm")))) {
            status = "Present";
        } else {
            status = "Late";
        }
        attendanceDAO.update(employeeID, checkInTime, checkOutTime, status);
        session.setAttribute("added", "Successfully Added Attendance Code");

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
