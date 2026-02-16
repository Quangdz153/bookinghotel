    /*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import dal.DBContext;
import entity.RoomImages;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
/**
 *
 * @author Admin
 */
public class RoomImageDAO extends DBContext{
    public List<RoomImages> getImageByRoomID(String roomID){
        List<RoomImages> list = new ArrayList<>();
        String sql = "select * from roomimages where roomid = ?";
        try{
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, roomID);
            ResultSet rs = pre.executeQuery();
            while(rs.next()){
                list.add(new RoomImages(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4)));
            }
        }catch(SQLException e){
            System.out.println(e.getMessage());
        }
        return list;
    }
    
    public boolean addNewImgRoom(String roomID , String url , String description){
        String sql = "insert into roomimages (roomid,imageurl,description) values (?,?,?)";
        try{
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, roomID);
            pre.setString(2, url);
            pre.setString(3, description);
            
            return pre.executeUpdate() > 0;
        }catch(SQLException e){
            System.out.println(e);
        }
        return false;
    }
    public boolean deleteByRoomID(String roomID){
        String sql = "delete from roomimages where roomid = ?";
        try{
            PreparedStatement pre =connection.prepareStatement(sql);
            pre.setString(1, roomID);
            
            return pre.executeUpdate() > 0;
        }catch(SQLException e){
            System.out.println(e);
        }
        return false;
    }
    public boolean updateRoomImage(int imageID, String newUrl, String newDescription){
    String sql = "update roomimages set imageurl = ?, description = ? where imageid = ?";
    try{
        PreparedStatement pre = connection.prepareStatement(sql);
        pre.setString(1, newUrl);
        pre.setString(2, newDescription);
        pre.setInt(3, imageID);

        return pre.executeUpdate() > 0;
    }catch(SQLException e){
        System.out.println(e);
    }
    return false;
}

public List<Integer> getFirstImageIDByRoomID(String roomID) {
    String sql = "select imageid from roomimages where roomid = ?";
    List<Integer> list = new ArrayList<>();
    try {
        PreparedStatement pre = connection.prepareStatement(sql);
        pre.setString(1, roomID);
        ResultSet rs = pre.executeQuery();
        while(rs.next()) {
            list.add(rs.getInt(1));
        }
    } catch(SQLException e) {
        System.out.println(e);
    }
    return list;
}

    public static void main(String[] args) {
        RoomImageDAO dao = new RoomImageDAO();
        System.out.println(dao.getImageByRoomID("R001").get(0).getDescription());
        
        System.out.println(new DAO.RoomImageDAO().addNewImgRoom("R005", 
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHdK0VG-bwilcn2BYbXPjhQPH96bIwXjOFEQ&s"
                        + ""
                , "Luxury room"));
        
        System.out.println(new DAO.RoomImageDAO().getFirstImageIDByRoomID("R002").get(0));
        for (int tmp : new DAO.RoomImageDAO().getFirstImageIDByRoomID("R002")) {
            System.out.println(tmp);
        }
        
        
    }
}
