/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.admin.EmployeeManagement;

import java.io.IOException;
import java.io.PrintWriter;

import dao.RequestDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author ADMIN
 */
public class UpdateRequest extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
//        HttpSession session = request.getSession();
        RequestDAO requestDAO = new RequestDAO();
        String requestID = request.getParameter("requestID");
        String status = request.getParameter("status");
        String to = request.getParameter("to");
        System.out.println(to);
        if (requestID != null && !requestID.isEmpty() && status != null && !status.isEmpty()) {
            requestDAO.updateStatus(Integer.parseInt(requestID), status);
        }
        if (to != null && !to.isEmpty()) {
            response.sendRedirect("EmployeeRequest");
        } else {
            response.sendRedirect("admin");
        }


    }

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
