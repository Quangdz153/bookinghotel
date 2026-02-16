package entity;

import java.math.BigDecimal;
import java.sql.Date;

public class Booking {

    private int bookingID;
    private int guestID;
    private String roomID;
    private Date checkinDate;
    private Date checkoutDate;
    private BigDecimal totalPrice;
    private int status;
    private Guest guest;
    private Payment payment;

    public Booking() {
    }

    public Booking(int bookingID, int guestID, String roomID, Date checkinDate, Date checkoutDate, BigDecimal totalPrice, int status) {
        this.bookingID = bookingID;
        this.guestID = guestID;
        this.roomID = roomID;
        this.checkinDate = checkinDate;
        this.checkoutDate = checkoutDate;
        this.totalPrice = totalPrice;
        this.status = status;
    }

    public Booking(int guestID, String roomID, Date checkinDate, Date checkoutDate, BigDecimal totalPrice, int status) {
        this.guestID = guestID;
        this.roomID = roomID;
        this.checkinDate = checkinDate;
        this.checkoutDate = checkoutDate;
        this.totalPrice = totalPrice;
        this.status = status;
    }

    public Booking(int bookingID, int guestID, String roomID, Date checkinDate, Date checkoutDate, BigDecimal totalPrice, int status, Guest guest) {
        this.bookingID = bookingID;
        this.guestID = guestID;
        this.roomID = roomID;
        this.checkinDate = checkinDate;
        this.checkoutDate = checkoutDate;
        this.totalPrice = totalPrice;
        this.status = status;
        this.guest = guest;
    }
    
    public Booking(int bookingID, int guestID, String roomID, Date checkinDate, Date checkoutDate, BigDecimal totalPrice, int status, Guest guest, Payment payment) {
        this.bookingID = bookingID;
        this.guestID = guestID;
        this.roomID = roomID;
        this.checkinDate = checkinDate;
        this.checkoutDate = checkoutDate;
        this.totalPrice = totalPrice;
        this.status = status;
        this.guest = guest;
        this.payment = payment;
    }

    public Booking(int bookingID, BigDecimal totalPrice, Payment payment) {
        this.bookingID = bookingID;
        this.totalPrice = totalPrice;
        this.payment = payment;
    }

    // Getters và Setters
    public int getBookingID() {
        return bookingID;
    }

    public void setBookingID(int bookingID) {
        this.bookingID = bookingID;
    }

    public int getGuestID() {
        return guestID;
    }

    public void setGuestID(int guestID) {
        this.guestID = guestID;
    }

    public String getRoomID() {
        return roomID;
    }

    public void setRoomID(String roomID) {
        this.roomID = roomID;
    }

    public Date getCheckinDate() {
        return checkinDate;
    }

    public void setCheckinDate(Date checkinDate) {
        this.checkinDate = checkinDate;
    }

    public Date getCheckoutDate() {
        return checkoutDate;
    }

    public void setCheckoutDate(Date checkoutDate) {
        this.checkoutDate = checkoutDate;
    }

    public BigDecimal getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String takeStatus() {
        if (status == 1) {
            return "Pending";
        } else if (status == 2) {
            return "Confirmed";
        } else if (status == 3) {
            return "Cheched-in";
        } else if (status == 4) {
            return "Cheched-out";
        } else if (status == 5) {
            return "Cancelled";
        } else if (status == 6) {
            return "No-show";
        } else {
            return "Refunded";
        }
    }

    public Guest getGuest() {
        return guest;
    }

    public void setGuest(Guest guest) {
        this.guest = guest;
    }

    public Payment getPayment() {
        return payment;
    }

    public void setPayment(Payment payment) {
        this.payment = payment;
    }

    // Override toString() để debug dễ dàng hơn
    @Override
    public String toString() {
        return "Booking{" + "bookingID=" + bookingID + ", guestID=" + guestID + ", roomID=" + roomID + ", checkinDate=" + checkinDate + ", checkoutDate=" + checkoutDate + ", totalPrice=" + totalPrice + ", status=" + status + ", guest=" + guest + ", payment=" + payment + '}';
    }

}
