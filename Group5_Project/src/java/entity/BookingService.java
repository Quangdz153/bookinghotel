/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author minhq
 */
import java.util.*;
import java.sql.Date;
public class BookingService {
    private int bookingServiceID;
    private int bookingID;
    private Integer serviceID;   // có thể null khi đặt combo
    private Integer comboID;
    private int quantity;
    private double pricePerUnit;  //giá áp dụng tại thời điểm đặt
    private double subTotal;  // tổng tiền (quantity * pricePerUnit)
    private Date serviceDate;
    
    private Booking booking;
    private Service service;
    private ServiceCombo servicecombo;

    public BookingService() {
    }

    public BookingService(int bookingServiceID, int bookingID, Integer serviceID, Integer comboID, int quantity, double pricePerUnit, double subTotal,Date serviceDate){
        this.bookingServiceID = bookingServiceID;
        this.bookingID = bookingID;
        this.serviceID = serviceID;
        this.comboID = comboID;
        this.quantity = quantity;
        this.pricePerUnit = pricePerUnit;
        this.subTotal = subTotal;
        this.serviceDate=serviceDate;
    }

    public int getBookingServiceID() {
        return bookingServiceID;
    }

    public void setBookingServiceID(int bookingServiceID) {
        this.bookingServiceID = bookingServiceID;
    }

    public int getBookingID() {
        return bookingID;
    }

    public void setBookingID(int bookingID) {
        this.bookingID = bookingID;
    }

    public Integer getServiceID() {
        return serviceID;
    }

    public void setServiceID(Integer serviceID) {
        this.serviceID = serviceID;
    }

    public Integer getComboID() {
        return comboID;
    }

    public void setComboID(Integer comboID) {
        this.comboID = comboID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPricePerUnit() {
        return pricePerUnit;
    }

    public void setPricePerUnit(double pricePerUnit) {
        this.pricePerUnit = pricePerUnit;
    }

    public double getSubTotal() {
        return subTotal;
    }

    public void setSubTotal(double subTotal) {
        this.subTotal = subTotal;
    }

    public Date getServiceDate() {
        return serviceDate;
    }

    public void setServiceDate(Date serviceDate) {
        this.serviceDate = serviceDate;
    }

    public Booking getBooking() {
        return booking;
    }

    public void setBooking(Booking booking) {
        this.booking = booking;
    }

    public Service getService() {
        return service;
    }

    public void setService(Service service) {
        this.service = service;
    }

    public ServiceCombo getServicecombo() {
        return servicecombo;
    }

    public void setServicecombo(ServiceCombo servicecombo) {
        this.servicecombo = servicecombo;
    }
    
    
}
