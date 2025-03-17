/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.admin.EmployeeManagement;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;

import dao.EmployeeDAO;
import dao.HotelDAO;
import dao.RequestDAO;
import dao.RequestTypeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.FilterType;

/**
 *
 * @author ADMIN
 */
public class EmployeeRequest extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

        HttpSession session = request.getSession();
        HotelDAO hotelDAO = new HotelDAO();
        RequestDAO requestDAO = new RequestDAO();
        RequestTypeDAO requestTypeDAO = new RequestTypeDAO();
        EmployeeDAO employeeDAO = new EmployeeDAO();

        session.setAttribute("hotels", hotelDAO.getAll());
        session.setAttribute("requestTypes", requestTypeDAO.getAll());

        Map<String, String> filter = new HashMap<String, String>();
        LinkedList<String> filterTypes = FilterType.getRequestFilterTypes();
        for (String filterType : filterTypes) {
            filter.put(filterType, request.getParameter(filterType));
        }

        LinkedList<String> requestStatus = new LinkedList<>();
        requestStatus.add("Approved");
        requestStatus.add("Rejected");
        requestStatus.add("Pending");
        session.setAttribute("requestStatuses", requestStatus);

        session.setAttribute("requests", requestDAO.getRequestsByFilter(filter));
        session.setAttribute("employees", employeeDAO.getAll(""));

        request.getRequestDispatcher("admin/EmployeeRequests.jsp").forward(request, response);
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
