package dao;

import model.Employee;
import model.Room;
import model.RoomStatus;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

public class RoomDAO extends DBContext {
    public List<Room> getAll(String sortType) {
        String sql = "select r.RoomID, h.Name, r.RoomNumber, rt.RoomTypeName, r.Capacity, rt.Description, p.Price, rs.RoomStatusName " +
                "from Room r " +
                "left join RoomType rt on r.roomTypeID = rt.roomTypeID " +
                "left join Hotel h on r.HotelID = h.HotelID " +
                "left join Price p on r.HotelID = p.HotelID and r.RoomTypeID = p.RoomTypeID " +
                "left join RoomStatus rs on r.RoomStatusID = rs.RoomStatusID";
        List<Room> list = new LinkedList<>();
        if (!sortType.isEmpty()) {
            sql += " order by " + convertTypeToColumnName(sortType) + " ";
        }
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

    public List<Room> getRoomsByTypes(Map<String, String> selected, String sortType) {
        StringBuilder sql = new StringBuilder(
                "select r.RoomID, h.Name, r.RoomNumber, rt.RoomTypeName, r.Capacity, rt.Description, p.Price, rs.RoomStatusName " +
                        "from Room r " +
                        "left join RoomType rt on r.roomTypeID = rt.roomTypeID " +
                        "left join Hotel h on r.HotelID = h.HotelID " +
                        "left join Price p on r.HotelID = p.HotelID and r.RoomTypeID = p.RoomTypeID " +
                        "left join RoomStatus rs on r.RoomStatusID = rs.RoomStatusID " +
                        "where "
        );
        boolean hasSalary = false;
        boolean appended = false;
        for (Map.Entry<String, String> entry : selected.entrySet()) {
            System.out.println(entry.getKey() + " = " + entry.getValue());
            if (entry.getValue() != null && !entry.getValue().isEmpty() ) {
                if (entry.getKey().equals("minPrice")) {
                    sql.append(" p.Price >= ").append(entry.getValue());
                    hasSalary = true;
                } else if (entry.getKey().equals("maxPrice")) {
                    sql.append("p.Price <= ").append(entry.getValue());
                } else {
                    sql.append(convertTypeToColumnName(entry.getKey())).append(" like '%").append(entry.getValue()).append("%'");
                }
                sql.append(" and ");
                appended = true;
            }
        }
        if (!appended) {
            return getAll(sortType);
        }
        String sql2 = sql.substring(0, sql.length() - 4);
        if (!sortType.isEmpty()) {
            sql2 += " order by " + convertTypeToColumnName(sortType) + " ";
        }
        LinkedList<Room> list = new LinkedList<>();
        try {
            PreparedStatement pre = connection.prepareStatement(sql2);
            System.out.println(sql2);
            for (Map.Entry<String, String> entry : selected.entrySet()) {
                if (entry.getValue() != null && !entry.getValue().isEmpty() ) {
                    System.out.println(entry.getValue() + " " + entry.getKey() + " ");
                    if (!hasSalary && entry.getKey().equals("minPrice")) {
                        break;
                    }
                }
            }
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
            System.out.println("RoomDAO getRoomsByTypes: " + e.getMessage());
        }
        return list;
    }

    private String convertTypeToColumnName(String key) {
        return switch (key) {
            case "price desc", "price", "minPrice", "maxPrice" -> "p." + key;
            case "description" -> "rt." + key;
            default -> "r." + key;
        };
    }

    public Room getByID(int id) {
        String sql = "select r.RoomID, h.Name, r.RoomNumber, rt.RoomTypeName, r.Capacity, rt.Description, p.Price, rs.RoomStatusName " +
                "from Room r " +
                "left join RoomType rt on r.roomTypeID = rt.roomTypeID " +
                "left join Hotel h on r.HotelID = h.HotelID " +
                "left join Price p on r.HotelID = p.HotelID and r.RoomTypeID = p.RoomTypeID " +
                "left join RoomStatus rs on r.RoomStatusID = rs.RoomStatusID " +
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
        String sql = "select r.RoomID, h.Name, r.RoomNumber, rt.RoomTypeName, r.Capacity, rt.Description, p.Price, rs.RoomStatusName " +
                "from Room r " +
                "left join RoomType rt on r.roomTypeID = rt.roomTypeID " +
                "left join Hotel h on r.HotelID = h.HotelID " +
                "left join Price p on r.HotelID = p.HotelID and r.RoomTypeID = p.RoomTypeID " +
                "left join RoomStatus rs on r.RoomStatusID = rs.RoomStatusID " +
                "where h.Name = ? and r.RoomNumber = ? ";
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

    public boolean update(String roomID, String roomTypeID, String roomStatusID, String capacity) {
        String sql = "update Room " +
                "set RoomTypeID = ?, RoomStatusID = ?, Capacity = ? " +
                "where RoomID like '%" + roomID + "%'";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            RoomTypeDAO roomTypeDAO = new RoomTypeDAO();
            RoomStatusDAO roomStatusDAO = new RoomStatusDAO();
            pre.setInt(1, Integer.parseInt(roomTypeID));
            pre.setInt(2, Integer.parseInt(roomStatusID));
            pre.setInt(3, Integer.parseInt(capacity));
            pre.setInt(4, Integer.parseInt(roomID));

            pre.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("RoomDAO update(): " + e.getMessage());
        }
        return false;
    }

}
