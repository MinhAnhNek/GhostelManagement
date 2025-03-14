/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.admin.EmployeeManagement;

import java.io.IOException;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;

import dao.EmployeeDAO;
import dao.EmployeeRoleDAO;
import dao.EmployeeStatusDAO;
import dao.HotelDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Employee;
import model.FilterType;

/**
 *
 * @author ADMIN
 */
public class EmployeeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        EmployeeRoleDAO erDAO = new EmployeeRoleDAO();
        EmployeeStatusDAO esDAO = new EmployeeStatusDAO();
        HotelDAO hotelDAO = new HotelDAO();
        HttpSession session = request.getSession();
        session.setAttribute("roles", erDAO.getAll());
        session.setAttribute("employeeStatuses", esDAO.getAll());
        session.setAttribute("hotels", hotelDAO.getAll());

        EmployeeDAO employeeDAO = new EmployeeDAO();
        session.setAttribute("employees", employeeDAO.getAll(""));
//        }
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
