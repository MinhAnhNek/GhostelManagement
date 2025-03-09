package dao;

import model.Room;
import model.RoomStatus;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

public class RoomDAO extends DBContext {
    public List<Room> getAll() {
        String sql = "select r.RoomID, h.Name, r.RoomNumber, rt.RoomTypeName, rt.Capacity, rt.Description, p.Price, rs.StatusName " +
                "from Room r " +
                "left join RoomType rt on r.roomTypeID = rt.roomTypeID " +
                "left join Hotel h on r.HotelID = h.HotelID " +
                "left join Price p on r.HotelID = p.HotelID and r.RoomTypeID = p.RoomTypeID " +
                "left join RoomStatus rs on r.StatusID = rs.StatusID";
        List<Room> list = new LinkedList<>();
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new Room(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getInt(5),
                        rs.getString(6),
                        rs.getFloat(7),
                        rs.getString(8)
                ));
            }
        } catch (SQLException e) {
            System.out.println("RoomDAO getAll(): " + e.getMessage());
        }
        return list;
    }

    public Room getByID(int id) {
        String sql = "select r.RoomID, h.Name, r.RoomNumber, rt.RoomTypeName, rt.Capacity, rt.Description, p.Price, rs.StatusName " +
                "from Room r " +
                "left join RoomType rt on r.roomTypeID = rt.roomTypeID " +
                "left join Hotel h on r.HotelID = h.HotelID " +
                "left join Price p on r.HotelID = p.HotelID and r.RoomTypeID = p.RoomTypeID " +
                "left join RoomStatus rs on r.StatusID = rs.StatusID " +
                "where r.RoomID = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, id);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                return new Room(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getInt(5),
                        rs.getString(6),
                        rs.getFloat(7),
                        rs.getString(8)
                );
            }
        } catch (SQLException e) {
            System.out.println("RoomDAO getByID(): " + e.getMessage());
        }
        return null;
    }

    public Room getByHotelNameAndRoomNumber(String hotelName, String roomNumber) {
        String sql = "select r.RoomID, h.Name, r.RoomNumber, rt.RoomTypeName, rt.Capacity, rt.Description, p.Price, rs.StatusName " +
                "from Room r " +
                "left join RoomType rt on r.roomTypeID = rt.roomTypeID " +
                "left join Hotel h on r.HotelID = h.HotelID " +
                "left join Price p on r.HotelID = p.HotelID and r.RoomTypeID = p.RoomTypeID " +
                "left join RoomStatus rs on r.StatusID = rs.StatusID " +
                "where h.Name = ? and r.RoomNumber = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, hotelName);
            pre.setString(2, roomNumber);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                return new Room(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getInt(5),
                        rs.getString(6),
                        rs.getFloat(7),
                        rs.getString(8)
                );
            }
        } catch (SQLException e) {
            System.out.println("RoomDAO getByID(): " + e.getMessage());
        }
        return null;
    }


    // ===============================      ADD NEW ROOM    ===============================

    public void add(Room room) {
        String sql = "insert into Room(HotelID, RoomNumber, RoomTypeID) " +
                "values(?,?,?)";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            HotelDAO hotelDAO = new HotelDAO();
            RoomTypeDAO roomTypeDAO = new RoomTypeDAO();
            pre.setInt(1, hotelDAO.getHotelIDByName(room.getHotelName()));
            pre.setString(2,room.getRoomNumber());
            pre.setInt(3, roomTypeDAO.getRoomTypeIDByName(room.getRoomType()));
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println("RoomDAO add(): " + e.getMessage());
        }
    }

    // ===============================      UPDATE ROOM    ===============================

    public boolean update(String id, String roomTypeName, String roomStatus) {
        String sql = "update Room " +
                "set RoomTypeID = ?, StatusID = ? " +
                "where RoomID = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            RoomTypeDAO roomTypeDAO = new RoomTypeDAO();
            RoomStatusDAO roomStatusDAO = new RoomStatusDAO();
            pre.setInt(1, roomTypeDAO.getRoomTypeIDByName(roomTypeName));
            pre.setInt(2, roomStatusDAO.getByStatusName(roomStatus).getStatusID());
            pre.setString(3, id);
            pre.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("RoomDAO update(): " + e.getMessage());
        }
        return false;
    }

}
