package controller.admin.RoomManagement;

import java.io.IOException;

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
        response.sendRedirect("/RoomManagement");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String type = request.getParameter("type");
        if (type.equals("room")) {
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
        } else if (type.equals("roomType")) {
            String name = request.getParameter("roomTypeName");
            String cap = request.getParameter("roomTypeCap");
            String[] selectedHotel = request.getParameterValues("selectedHotels");
            String[] p = request.getParameterValues("price");
            String description = request.getParameter("description");

        }

        request.setAttribute("type", type);
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
