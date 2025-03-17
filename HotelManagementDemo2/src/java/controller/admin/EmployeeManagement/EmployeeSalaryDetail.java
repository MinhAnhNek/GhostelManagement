/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.admin.EmployeeManagement;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.EnumMap;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;

import dao.EmployeeDAO;
import dao.HotelDAO;
import dao.PayrollDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Employee;
import model.Hotel;
import model.Payroll;

/**
 *
 * @author ADMIN
 */
public class EmployeeSalaryDetail extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        PayrollDAO payrollDAO = new PayrollDAO();
        EmployeeDAO employeeDAO = new EmployeeDAO();
        HotelDAO hotelDAO = new HotelDAO();

        String hotelID = request.getParameter("hotelID");
        String month = request.getParameter("month") == null ? "" : request.getParameter("month");
        String year = request.getParameter("year") == null ? "" : request.getParameter("year");

        HttpSession session = request.getSession();
        session.setAttribute("hotels",hotelDAO.getAll());

        session.setAttribute("totalPaidSalary", payrollDAO.getTotalPaidSalary());
        session.setAttribute("totalPayrolls", payrollDAO.getByMonth(month, year));
        session.setAttribute("totalEmp", employeeDAO.getAll(""));
        session.setAttribute("pendingPayrolls", payrollDAO.getByStatus("pending"));

        if (hotelID == null) {
            hotelID = "";
        }
        HashMap<String, String> map = new HashMap<>();
        map.put("hotelID", hotelID);
        LinkedList<Payroll> payrolls = (LinkedList<Payroll>) payrollDAO.getByHotelAndMonth(hotelID, month);
        LinkedList<Payroll> payrolls2 = ( LinkedList<Payroll>) payrollDAO.getByYear(hotelID, year);

        session.setAttribute("hotelID", hotelID);
        session.setAttribute("payrolls", payrolls);
        session.setAttribute("payrolls2", payrolls2);
        request.setAttribute("month", month);
        request.setAttribute("year", year);
        request.getRequestDispatcher("admin/EmployeeSalaryDetail.jsp").forward(request, response);

    }



    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        String employeeID = request.getParameter("employeeID");
        String month = request.getParameter("month");
        String hotelID = (String) session.getAttribute("hotelID");
        PayrollDAO payrollDAO = new PayrollDAO();
        Payroll payroll = payrollDAO.getByEmpIDAndMonth(Integer.parseInt(employeeID), month).getFirst();

//        if ( request.getParameter("totalSalary") != null) payroll.setTotalSalary(Float.parseFloat( request.getParameter("totalSalary")));
        if(request.getParameter("totalWorkingDays") != null) payroll.setTotalWorkingDays(Integer.parseInt(request.getParameter("totalWorkingDays")));
        if (request.getParameter("overtimePay") != null) payroll.setOvertimePay(Float.parseFloat(request.getParameter("overtimePay")));
        if (request.getParameter("baseSalary") != null) payroll.setBaseSalary(Float.parseFloat(request.getParameter("baseSalary")));
        if (request.getParameter("totalHours") != null) payroll.setTotalHours(Float.parseFloat(request.getParameter("totalHours")));
        if (request.getParameter("overtimeHours") != null) payroll.setOvertimeHours(Float.parseFloat(request.getParameter("overtimeHours")));
        if (request.getParameter("status") != null) payroll.setStatus(request.getParameter("status"));

        payrollDAO.update(payroll);
        response.sendRedirect("EmployeeSalaryDetail?hotelID=" + hotelID + "&month=" + month);
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
