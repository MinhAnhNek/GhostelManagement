package dao;

import model.RequestType;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

public class RequestTypeDAO extends DBContext {
    public List<RequestType> getAll() {
        String sql = "select * from RequestType";
        LinkedList<RequestType> list = new LinkedList<RequestType>();
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new RequestType(
                        rs.getInt(1),
                        rs.getString(2)
                ));
            }
        } catch (SQLException e) {
            System.out.println("RequestTypeDAO.getAll(): " + e.getMessage());
        }
        return list;
    }
}
