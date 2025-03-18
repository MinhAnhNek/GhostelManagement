package dao;

import model.Request;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

public class RequestDAO extends DBContext {
    public List<Request> getAll() {
        String sql = "select * from Request order by applied_at desc";
        LinkedList<Request> list = new LinkedList<>();
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new Request(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6)
                ));
            }
        } catch (SQLException e) {
            System.out.println("RequestDAO.getRequests(): " + e.getMessage());
        }
        return list;
    }

    public List<Request> getRequestsByFilter(Map<String, String> selected) {
        StringBuilder sql = new StringBuilder(
                "select * from Request " +
                "where "
        );
        Boolean appended = false;
        for (Map.Entry<String, String> entry : selected.entrySet()) {
            if (entry.getValue() != null && !entry.getValue().isEmpty() ) {
                System.out.println(entry.getKey() + " = " + entry.getValue());
                sql.append(entry.getKey()).append(" like '").append(entry.getValue()).append("'");
                sql.append(" and ");
                appended = true;
            }
        }
        if (!appended) {
            return getAll();
        }
        String sql2 = sql.substring(0, sql.length() - 4) + " order by applied_at desc";
//        if (!sortType.isEmpty()) {
//            sql2 += " order by " + convertTypeToColumnName(sortType);
//        }
        LinkedList<Request> list = new LinkedList<>();
        try {
            PreparedStatement pre = connection.prepareStatement(sql2);
            System.out.println(sql2);
            for (Map.Entry<String, String> entry : selected.entrySet()) {
                if (entry.getValue() != null && !entry.getValue().isEmpty() ) {
                    System.out.println(entry.getValue() + " " + entry.getKey() + " ");
                }
            }
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new Request(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6)
                ));
            }
        } catch (SQLException e) {
            System.out.println("RequestDAO getRequestsByFilter: " + e.getMessage());
        }
        return list;
    }

    public List<Request> getByStatus(String status) {
        String sql = "select * from Request where status like '" + status +"' order by applied_at desc";
        LinkedList<Request> list = new LinkedList<>();
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new Request(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6)
                ));
            }
        } catch (SQLException e) {
            System.out.println("RequestDAO getByStatus: " + e.getMessage());
        }
        return list;
    }

    public List<Integer> getRequestDistributionBy(String groupByType, String additionalTable, String condition) {
        String sql = "select count(r.RequestID) " +
                "from Request r " + additionalTable + " " +
                "group by " + groupByType + " " +
                condition;
//        System.out.println(sql);
        LinkedList<Integer> list = new LinkedList<>();
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(
                        rs.getInt(1)
                );
            }
        } catch (SQLException e) {
            System.out.println("RequestDAO getRequestDistributionBy: " + e.getMessage());
        }
        return list;
    }

//    public List<Integer> getRequestDistributionByHotel() {
//        String sql = "select count(r.RequestID) from Request r " +
//                "left join Employee e on r.EmployeeID = e.EmployeeID " +
//                "group by e.HotelID ";
//        LinkedList<Integer> list = new LinkedList<>();
//        try {
//            PreparedStatement pre = connection.prepareStatement(sql);
//            ResultSet rs = pre.executeQuery();
//            while (rs.next()) {
//                list.add(
//                        rs.getInt(1)
//                );
//            }
//        } catch (SQLException e) {
//            System.out.println("RequestDAO getRequestDistributionByHotel: " + e.getMessage());
//        }
//        return list;
//    }


    // =================================    UPDATE REQUEST  =================================
    public void updateStatus(int id, String status) {
        String sql = "update Request set Status = ? where RequestID = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, status);
            pre.setInt(2, id);
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println("RequestDAO updateStatus: " + e.getMessage());
        }
    }

}
