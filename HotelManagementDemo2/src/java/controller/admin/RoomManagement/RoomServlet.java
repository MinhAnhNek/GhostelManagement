/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.admin.RoomManagement;

import java.io.IOException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;

import dao.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;
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
        RoomStatusDAO roomStatusDAO = new RoomStatusDAO();
        HotelDAO hotelDAO = new HotelDAO();

        HttpSession session = request.getSession();
        session.setAttribute("hotels", hotelDAO.getAll());
        session.setAttribute("roomTypes", roomTypeDAO.getAll());
        session.setAttribute("roomStatus", roomStatusDAO.getAll());

        LinkedList<String> filterTypes = FilterType.getRoomFilterTypes();
        Map<String, String> selected = new HashMap<String, String>();
        String minPrice = request.getParameter("minPrice");
        if (minPrice != null && !minPrice.isEmpty()) {
            filterTypes.add("minPrice");
            filterTypes.add("maxPrice");
        }               //FilterType.getFilterTypeMap();
        for (String filterType : filterTypes) {
            selected.put(filterType, request.getParameter(filterType));
            request.setAttribute(filterType, request.getParameter(filterType));
        }
        String sortType = request.getParameter("sortType");
        LinkedList<Room> list = (LinkedList<Room>) roomDAO.getRoomsByTypes(selected, sortType == null ? "" : sortType);

//        response.sendRedirect("admin/home.jsp");
        request.setAttribute("sortType", sortType);
        session.setAttribute("rooms", list);

//        response.sendRedirect("admin/RoomManagement.jsp");
        request.getRequestDispatcher("admin/RoomManagement.jsp").forward(request, response);
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
