/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.admin.RoomManagement;

import java.io.IOException;
import java.io.PrintWriter;

import dao.PriceDAO;
import dao.RoomDAO;
import dao.RoomStatusDAO;
import dao.RoomTypeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.RoomStatus;

/**
 *
 * @author ADMIN
 */
public class RoomServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        RoomDAO roomDAO = new RoomDAO();
        RoomTypeDAO roomTypeDAO = new RoomTypeDAO();
        PriceDAO priceDAO = new PriceDAO();



        HttpSession session = request.getSession();
        session.setAttribute("rooms", roomDAO.getAll());
        session.setAttribute("roomTypes", roomTypeDAO.getAll());
        session.setAttribute("prices", priceDAO.getAll());

        response.sendRedirect("admin/RoomManagement.jsp");
    } 


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
