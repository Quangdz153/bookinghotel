/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import entity.Room;
import dal.DBContext;
import entity.RoomImages;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;

/**
 *
 * @author viet7
 */
public class RoomDAO extends DBContext {

    public List<Room> getAllRoom() {
        List<Room> roomList = new ArrayList<>();
        String sql = "select * from Room";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                roomList.add(new Room(rs.getString("RoomID"), rs.getString("HotelID"), rs.getInt("TypeID"), rs.getString("Status")));
            }
        } catch (SQLException e) {
            Logger.getLogger(RoomDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return roomList;
    }

    public List<Room> getAllRoomAvailable() {
        List<Room> roomList = new ArrayList<>();
        String sql = "SELECT room.RoomID, RoomType.PricePerNight from Room\n"
                + "join RoomType on Room.TypeID = RoomType.TypeID\n"
                + "where status = 'available'";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Room room = new Room();
                room.setRoomID(rs.getString("RoomID"));
                    room.setPrice(rs.getBigDecimal("PricePerNight"));  // Lấy giá từ roomtype
                roomList.add(room);            }
        } catch (SQLException e) {
            Logger.getLogger(RoomDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return roomList;
    }
    
    public List<Room> getRoomByTime(String checkInTime, String checkOutTime) {
        List<Room> list = new ArrayList<>();
        String sql = "SELECT r1.* FROM Room r1 "
                + "JOIN RoomType rt ON rt.TypeID = r1.TypeID "
                + "WHERE NOT EXISTS ( "
                + "    SELECT 1 FROM Booking b "
                + "    WHERE b.RoomID = r1.RoomID ";

        // 1️⃣ Trường hợp có cả `checkInTime` và `checkOutTime`
        if (checkInTime != null && checkOutTime != null) {
            sql += " AND (b.CheckinDate < ? AND b.CheckoutDate > ?) ";
        } // 2️⃣ Trường hợp chỉ có `checkInTime` (khách chưa biết ngày trả phòng)
        else if (checkInTime != null) {
            sql += " AND b.CheckoutDate > ? ";
        } // 3️⃣ Trường hợp chỉ có `checkOutTime` (khách muốn tìm phòng trống trước ngày này)
        else if (checkOutTime != null) {
            sql += " AND b.CheckinDate < ? ";
        }

        sql += ")"; // Kết thúc `NOT EXISTS`

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            // Gán giá trị cho điều kiện
            if (checkInTime != null && checkOutTime != null) {
                st.setString(1, checkOutTime);
                st.setString(2, checkInTime);
            } else if (checkInTime != null) {
                st.setString(1, checkInTime);
            } else if (checkOutTime != null) {
                st.setString(1, checkOutTime);
            }

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Room(rs.getString(1), rs.getString(2),
                        rs.getInt(3), rs.getString(4))); // Điều chỉnh theo bảng Room
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;
    }

    private List<RoomImages> getImgByRoomID(String roomID) {
        List<RoomImages> list = new ArrayList<>();
        String sql = "select * from RoomImages where roomID = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, roomID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new RoomImages(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4)));
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    
    public boolean deleteByRoomID(String roomid) {
        String sql = "delete from room where roomid = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, roomid);
            return pre.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public boolean addNewRoom(Room room) {
        String sql = "insert into room values (?,?,?,?)";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, room.getRoomID());
            pre.setString(2, room.getHotelID());
            pre.setInt(3, room.getTypeID());
            pre.setString(4, room.getStatus());

            return pre.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public boolean updateRoom(String roomID, int typeID) {
        String sql = "UPDATE Room\n"
                + "SET TypeID = ?\n"
                + "WHERE RoomID = ?";

        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, typeID);
            pre.setString(2, roomID);

            return pre.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return false;
    }

    public int getRoomCount() {
        String sql = "SELECT COUNT(*) FROM room";
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

    public List<Room> getListByPage(int offset, int numRoom) {
        List<Room> list = new ArrayList<>();
        String sql = "select * from Room\n"
                + "order by RoomID \n "
                + "offset ? rows fetch next ? rows only ";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, offset);
            pre.setInt(2, numRoom);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new Room(rs.getString(1), "H001", rs.getInt(3),
                         rs.getString(4)));
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        return list;
    }

    public static void main(String[] args) {
        RoomDAO a = new RoomDAO();
        List<Room> listins = new DAO.RoomDAO().getAllRoomAvailable();
        for (Room ins : listins) {
            System.out.println(ins);
        }
        System.out.println("Room List Size: " + (listins == null ? "NULL" : listins.size()));
    }
}
