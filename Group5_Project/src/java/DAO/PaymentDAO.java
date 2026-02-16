/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import entity.Payment;
import dal.DBContext;
import java.math.BigDecimal;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;

/**
 *
 * @author viet7
 */
public class PaymentDAO extends DBContext {

    public List<Payment> getAllPayment() {
        List<Payment> paymentList = new ArrayList<>();
        String sql = "select * from Payment";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                paymentList.add(new Payment(rs.getInt("paymentID"), rs.getInt("bookingID"), rs.getBigDecimal("amount"), rs.getDate("paymentDate"), rs.getString("PaymentMethod"), rs.getInt("guestID")));
            }
        } catch (SQLException e) {
            Logger.getLogger(PaymentDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return paymentList;
    }

    public List<Payment> getAllPaymentByGuestID(int guestID) {
        List<Payment> paymentList = new ArrayList<>();
        String sql = "select * from payment\n"
                + "join booking on booking.BookingID= Payment.BookingID\n"
                + "where booking.GuestID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, guestID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                paymentList.add(new Payment(rs.getInt("paymentID"), rs.getInt("bookingID"), rs.getBigDecimal("amount"), rs.getDate("paymentDate"), rs.getString("PaymentMethod"), rs.getInt("guestID")));
            }
        } catch (SQLException e) {
            Logger.getLogger(PaymentDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return paymentList;
    }

    public boolean addPayment(int bookingID, BigDecimal amount, String paymentMethod) {
        String sql = "INSERT INTO Payment (bookingID, amount, paymentMethod) VALUES ( ?, ?, ?)";

        try {
//            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd");
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, bookingID);
            stm.setBigDecimal(2, amount);
            stm.setString(3, paymentMethod);
            int rowsAffected = stm.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, e);
            return false;
        }
    }

    public boolean insertPayment(int bookingID, String paymentMethod) {
        String sql = "INSERT INTO Payment (BookingID, Amount, PaymentMethod) "
                + "SELECT BookingID, TotalPrice, ? FROM Booking WHERE BookingID = ?";
        try  {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, paymentMethod);
            stm.setInt(2, bookingID);
            int rowsInserted = stm.executeUpdate();
            return rowsInserted > 0; // Trả về true nếu thêm thành công
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updatePayment(int paymentID, String bookingID, BigDecimal amount, String paymentDate, String paymentMethod) {
        String sql = "UPDATE Payment\n"
                + "SET BookingID = ?, amount = ?, paymentDate = ?, paymentMethod =?\n"
                + "WHERE PaymentID = ?;";

        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, bookingID);
            stm.setBigDecimal(2, amount);
            stm.setString(3, paymentDate);;
            stm.setString(4, paymentMethod);
            stm.setInt(5, paymentID);
            int rowsAffected = stm.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            Logger.getLogger(PaymentDAO.class.getName()).log(Level.SEVERE, null, e);
            return false;
        }
    }

    public boolean deletePayment(String paymentid) {
        String sql = "delete from Payment where PaymentID = ?\n";

        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, paymentid);
            int rowsAffected = stm.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            Logger.getLogger(PaymentDAO.class.getName()).log(Level.SEVERE, null, e);
            return false;
        }
    }

    public List<Payment> getPaymentsPaginated(int offset, int pageSize) {
        List<Payment> payments = new ArrayList<>();
        String sql = "SELECT *\n"
                + "FROM Payment\n"
                + "ORDER BY PaymentID\n"
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, offset);
            ps.setInt(2, pageSize);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                payments.add(new Payment(rs.getInt("paymentID"), rs.getInt("bookingID"), rs.getBigDecimal("amount"), rs.getDate("paymentDate"), rs.getString("paymentMethod")));
            }
        } catch (SQLException e) {
            Logger.getLogger(PaymentDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return payments;
    }

    public int getTotalPaymentCount() {
        int totalCount = 0;
        String sql = "SELECT COUNT(*) FROM payment";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                totalCount = rs.getInt(1);
            }
        } catch (SQLException e) {
            Logger.getLogger(PaymentDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return totalCount;
    }

    public static void main(String[] args) {
        PaymentDAO a = new PaymentDAO();
        Payment b = new Payment();
        b.setBookingID(7);
        BigDecimal amount = new BigDecimal(500);
        b.setAmount(amount);
        b.setPaymentMethod("Online Payment");
//        a.addPayment(b);
        List<Payment> listins = a.getAllPaymentByGuestID(1);

        for (Payment ins : listins) {
            System.out.println(ins);
        }
        System.out.println("Booking List Size: " + (listins == null ? "NULL" : listins.size()));
    }
}
