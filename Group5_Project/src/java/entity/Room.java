/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.math.BigDecimal;

/**
 *
 * @author viet7
 */
public class Room {
    private String roomID;
    private String HotelID;
    private int typeID;
    private String status;
    private BigDecimal price;
    
    public Room() {
    }

    public Room(String roomID, String HotelID, int typeID, String status) {
        this.roomID = roomID;
        this.HotelID = HotelID;
        this.typeID = typeID;
        this.status = status;
    }
    
    public Room(String roomID, BigDecimal price) {
        this.roomID = roomID;
        this.price = price;
    }

    public String getRoomID() {
        return roomID;
    }

    public void setRoomID(String roomID) {
        this.roomID = roomID;
    }

    public String getHotelID() {
        return HotelID;
    }

    public void setHotelID(String HotelID) {
        this.HotelID = HotelID;
    }

    public int getTypeID() {
        return typeID;
    }

    public void setTypeID(int typeID) {
        this.typeID = typeID;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    @Override
    public String toString() {
        return "Room{" + "roomID=" + roomID + ", HotelID=" + HotelID + ", typeID=" + typeID + ", status=" + status + ", price=" + price + '}';
    }


    
}
