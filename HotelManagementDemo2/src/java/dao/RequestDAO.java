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
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8)

                ));
            }
        } catch (SQLException e) {
            System.out.println("RequestDAO.getRequests(): " + e.getMessage());
        }
        return list;
    }

    public String convertToColumnName(String name) {
        return switch (name) {
            case "HotelID", "Name" -> "e." + name;
            default -> "r." + name;
        };
    }

    public List<Request> getRequestsByFilter(Map<String, String> selected) {
        StringBuilder sql = new StringBuilder(
                "select * from Request r left join Employee e on r.EmployeeID = e.EmployeeID " +
                "where "
        );
        Boolean appended = false;
        for (Map.Entry<String, String> entry : selected.entrySet()) {
            if (entry.getValue() != null && !entry.getValue().isEmpty() ) {
                System.out.println(entry.getKey() + " = " + entry.getValue());
                sql.append(convertToColumnName(entry.getKey())).append(" like '%").append(entry.getValue()).append("%'");
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
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8)

                ));
            }
        } catch (SQLException e) {
            System.out.println("RequestDAO getRequestsByFilter: " + e.getMessage());
        }
        return list;
    }

    public List<Request> getRequestsByType(String typeName, String value) {
        String sql = "select * from Request where " + typeName + " like '" + value +"' order by applied_at desc";
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
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8)
                ));
            }
        } catch (SQLException e) {
            System.out.println("RequestDAO getRequestsByType: " + e.getMessage());
        }
        return list;
    }

    public List<Integer> getRequestDistributionBy(String groupByType, String additionalTable, String condition) {
        String sql = "select count(r.RequestID), " + groupByType +" " +
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




    // =================================    ADD REQUEST  =================================
    public void add(int employeeID, int requestTypeID, String reason) {
        String sql = "insert into Request(EmployeeID, RequestTypeID, reason) values " +
                "(" + employeeID + ", " + requestTypeID + ", '" + reason + "')";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println("RequestDAO add: " + e.getMessage());
        }
    }






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
