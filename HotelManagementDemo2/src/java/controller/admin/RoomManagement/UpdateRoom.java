/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.admin.RoomManagement;

import java.io.IOException;

import dao.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Room;

/**
 *
 * @author ADMIN
 */
public class UpdateRoom extends HttpServlet {
   

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        RoomDAO roomDAO = new RoomDAO();
        PriceDAO priceDAO = new PriceDAO();
        HotelDAO hotelDAO = new HotelDAO();
        RoomTypeDAO roomTypeDAO = new RoomTypeDAO();
        RoomStatusDAO roomStatusDAO = new RoomStatusDAO();

        String roomID = request.getParameter("roomID");
        Room room =  roomDAO.getByID(Integer.parseInt(roomID));

        String roomType = request.getParameter("roomType");
        if (roomType != null) {
            int hotelID = hotelDAO.getHotelIDByName(room.getHotelName());
            int roomTypeID = roomTypeDAO.getRoomTypeIDByName(roomType);
            room.setRoomType(roomType);
            room.setDescription(roomTypeDAO.getById(roomTypeID).getDescription());
            room.setPrice(priceDAO.get(hotelID, roomTypeID).getPrice());
        }
        session.setAttribute("room", room);
        session.setAttribute("roomStatuses", roomStatusDAO.getAll());
//        response.sendRedirect("admin/UpdateRoom.jsp");
        request.getRequestDispatcher("admin/UpdateRoom.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String roomID = request.getParameter("roomID");
        String roomTypeID = request.getParameter("roomTypeID");
        String roomStatusID = request.getParameter("roomStatusID");

        RoomDAO roomDAO = new RoomDAO();

        HttpSession session = request.getSession();
        session.setAttribute("updated", roomDAO.update(roomID, roomTypeID, roomStatusID));

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
