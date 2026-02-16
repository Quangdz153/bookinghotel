/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;


/**
 *
 * @author Admin
 */
public class RoomType {

    private int typeID;
    private String name, description;
    private double pricePerNight;
    private int capacity;
    private String imageURL;
    private double area;
    private String amenities;

    public RoomType() {
    }

    public RoomType(int typeID, String name, String description, double pricePerNight, int capacity, String imageURL, double area, String amenities) {
        this.typeID = typeID;
        this.name = name;
        this.description = description;
        this.pricePerNight = pricePerNight;
        this.capacity = capacity;
        this.imageURL = imageURL;
        this.area = area;
        this.amenities = amenities;
    }

    public int getTypeID() {
        return typeID;
    }

    public void setTypeID(int typeID) {
        this.typeID = typeID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPricePerNight() {
        return pricePerNight;
    }

    public void setPricePerNight(double pricePerNight) {
        this.pricePerNight = pricePerNight;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    public double getArea() {
        return area;
    }

    public void setArea(double area) {
        this.area = area;
    }

    public String getAmenities() {
        return amenities;
    }

    public void setAmenities(String amenities) {
        this.amenities = amenities;
    }

    

}
