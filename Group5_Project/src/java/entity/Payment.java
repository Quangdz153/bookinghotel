/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.math.BigDecimal;
import java.util.Date;

/**
 *
 * @author viet7
 */
public class Payment {
    private int paymentID;
    private int bookingID;
    private BigDecimal amount;
    private Date paymentDate;
    private String paymentMethod; 
    private int guestID;

    public Payment() {
    }

    public Payment(int paymentID, int bookingID, BigDecimal amount, Date paymentDate, String paymentMethod) {
        this.paymentID = paymentID;
        this.bookingID = bookingID;
        this.amount = amount;
        this.paymentDate = paymentDate;
        this.paymentMethod = paymentMethod;
    }
    

    public Payment(int paymentID, int bookingID, BigDecimal amount, Date paymentDate, String paymentMethod, int guestID) {
        this.paymentID = paymentID;
        this.bookingID = bookingID;
        this.amount = amount;
        this.paymentDate = paymentDate;
        this.paymentMethod = paymentMethod;
        this.guestID = guestID;
    }

    public Payment(int bookingID, BigDecimal amount, Date paymentDate, String paymentMethod) {
        this.bookingID = bookingID;
        this.amount = amount;
        this.paymentDate = paymentDate;
        this.paymentMethod = paymentMethod;
    }



    public int getPaymentID() {
        return paymentID;
    }

    public void setPaymentID(int paymentID) {
        this.paymentID = paymentID;
    }

    public int getBookingID() {
        return bookingID;
    }

    public void setBookingID(int bookingID) {
        this.bookingID = bookingID;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public Date getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Date paymentDate) {
        this.paymentDate = paymentDate;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    @Override
    public String toString() {
        return "Payment{" + "paymentID=" + paymentID + ", bookingID=" + bookingID + ", amount=" + amount + ", paymentDate=" + paymentDate + ", PaymentMethod=" + paymentMethod + '}';
    }
}
