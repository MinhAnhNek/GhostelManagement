/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.admin.EmployeeManagement;

import java.io.IOException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;

import dao.EmployeeDAO;
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
public class SearchServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        LinkedList<String> filterTypes = FilterType.getEmployeeFilterTypes();
        Map<String, String> selected = new HashMap<>();
        String minSalary = request.getParameter("minSalary");
        if (minSalary != null && !minSalary.isEmpty()) {
            filterTypes.add("minSalary");
            filterTypes.add("maxSalary");
        }               //FilterType.getFilterTypeMap();
        for (String filterType : filterTypes) {
            selected.put(filterType, request.getParameter(filterType));
            session.setAttribute(filterType, request.getParameter(filterType));
        }

        EmployeeDAO employeeDAO = new EmployeeDAO();
        session.setAttribute("employees", employeeDAO.getEmployeeByType(selected));

        request.getRequestDispatcher("admin/home.jsp").forward(request, response);
//        response.sendRedirect("admin/home.jsp");
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
