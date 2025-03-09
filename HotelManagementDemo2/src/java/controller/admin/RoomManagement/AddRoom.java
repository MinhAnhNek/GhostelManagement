/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.admin.RoomManagement;

import java.io.IOException;
import java.io.PrintWriter;

import dao.RoomDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Room;

/**
 *
 * @author ADMIN
 */
public class AddRoom extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String hotelName = request.getParameter("hotelName");
        String RoomType = request.getParameter("roomType");
        String roomNumber = request.getParameter("roomNumber");

        RoomDAO roomDAO = new RoomDAO();
        if (roomDAO.getByHotelNameAndRoomNumber(hotelName, roomNumber) == null) {
            Room room = new Room(hotelName, roomNumber, RoomType);
            roomDAO.add(room);
        } else {
            request.setAttribute("error", "Room" + roomNumber + " in " + hotelName + " already exists!");
        }

        response.sendRedirect("RoomManagement");
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
