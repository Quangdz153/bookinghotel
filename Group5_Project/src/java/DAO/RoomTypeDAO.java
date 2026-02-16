/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import dal.DBContext;
import entity.RoomType;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class RoomTypeDAO extends DBContext {

    public List<RoomType> getListType() {
        List<RoomType> list = new ArrayList<>();
        String sql = "select * from roomtype";
        try {

            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new RoomType(rs.getInt(1), rs.getString(2),
                        rs.getString(3), rs.getDouble(4), rs.getInt(5), rs.getString(6),
                        rs.getDouble(7), rs.getString(8)));
            }

        } catch (SQLException ex) {
            Logger.getLogger(RoomTypeDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public RoomType getRoomTypeByRoomID(String roomID) {
        String sql = "select * from RoomType rt\n"
                + "join Room r on r.TypeID = rt.TypeID\n"
                + "where r.RoomID = ?";
        try {

            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, roomID);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new RoomType(rs.getInt(1), rs.getString(2),
                        rs.getString(3), rs.getDouble(4), rs.getInt(5), rs.getString(6),
                        rs.getDouble(7), rs.getString(8));
            }

        } catch (SQLException ex) {
            Logger.getLogger(RoomTypeDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public RoomType getRoomTypeByTypeID(int typeID) {
        String sql = "select * from roomtype where typeid = ?";
        try {

            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, typeID);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new RoomType(rs.getInt(1), rs.getString(2),
                        rs.getString(3), rs.getDouble(4), rs.getInt(5), rs.getString(6),
                        rs.getDouble(7), rs.getString(8));
            }

        } catch (SQLException ex) {
            Logger.getLogger(RoomTypeDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public boolean addNewRoomType(String name, String description, double price, int capacity, String image, double area, String amentities) {
        String sql = "insert into roomtype (name , description, pricepernight, capacity , imageURL , area , amenities)"
                + "values (?,?,?,?,?,?,?)";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, name);
            pre.setString(2, description);
            pre.setDouble(3, price);
            pre.setInt(4, capacity);
            pre.setString(5, image);
            pre.setDouble(6, area);
            pre.setString(7, amentities);

            return pre.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public int getLastTypeID() {
        String sql = "select top 1 TypeID  from RoomType\n"
                + "order by TypeID desc";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public boolean deleteByTypeID(int typeID) {
        String sql = "delete from RoomType where typeid = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, typeID);
            return pre.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public boolean deleteAllTypeID(int typeID) {
        String sql = "delete from RoomType ";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            return pre.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public boolean updateTypeID(RoomType type) {
        String sql = "UPDATE roomtype SET name=?, "
                + "description=?, pricePerNight=?, "
                + "imageURL=?, capacity=?, area=?, "
                + "amenities=? "
                + "WHERE typeID=?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, type.getName());
            pre.setString(2, type.getDescription());
            pre.setDouble(3, type.getPricePerNight());
            pre.setString(4, type.getImageURL());
            pre.setInt(5, type.getCapacity());
            pre.setDouble(6, type.getArea());
            pre.setString(7, type.getAmenities());
            pre.setInt(8, type.getTypeID());

            return pre.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public List<RoomType> getListRoomTypePage(int offset, int numRoom) {
        List<RoomType> list = new ArrayList<>();
        String sql = "select * from RoomType\n"
                + "order by typeid \n "
                + "offset ? rows fetch next ? rows only ";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, offset);
            pre.setInt(2, numRoom);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new RoomType(rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getDouble(4), rs.getInt(5), rs.getString(6),
                        rs.getDouble(7), rs.getString(8)));
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        return list;
    }
    public int getRoomTypeCount() {
        String sql = "SELECT COUNT(*) FROM roomtype";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                return rs.getInt(1); 
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
        return 0;  
    }

    public static void main(String[] args) {
        RoomTypeDAO dao = new RoomTypeDAO();
        RoomType a = dao.getRoomTypeByRoomID("R001");
        System.out.println(a.getCapacity());

        System.out.println(new DAO.RoomTypeDAO().deleteByTypeID(10));
        
        for (RoomType tmp : new DAO.RoomTypeDAO().getListRoomTypePage(0, 5)) {
            System.out.println(tmp.getTypeID());
        }
    }
}
