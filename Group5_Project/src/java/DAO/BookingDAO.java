/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import entity.Booking;
import dal.DBContext;
import entity.Guest;
import entity.Payment;
import entity.Room;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author viet7
 */
public class BookingDAO extends DBContext {

    public List<Booking> getAllBooking() {
        List<Booking> bookingList = new ArrayList<>();
        String sql = "select * from Booking";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                bookingList.add(new Booking(rs.getInt("BookingID"),
                        rs.getInt("GuestID"),
                        rs.getString("RoomID"),
                        rs.getDate("CheckinDate"),
                        rs.getDate("CheckoutDate"),
                        rs.getBigDecimal("TotalPrice"),
                        rs.getInt("Status")));
            }
        } catch (SQLException e) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return bookingList;
    }

    public Booking getBookingByGuestID(int id) {
        String sql = "select * from Booking where GuestID = ?";
        Booking b = new Booking();
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                b = new Booking(rs.getInt("BookingID"), rs.getInt("GuestID"),
                        rs.getString("RoomID"), rs.getDate("CheckinDate"),
                        rs.getDate("CheckoutDate"), rs.getBigDecimal("TotalPrice"), rs.getInt("Status"));
            }
        } catch (SQLException e) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return b;
    }

    public Room getRoomByBookingID(int id) {
        String sql = "SELECT r.RoomID, rt.PricePerNight \n"
                + "   FROM Booking b\n"
                + "   JOIN Room r ON b.RoomID = r.RoomID \n"
                + "   JOIN RoomType rt ON r.TypeID = rt.TypeID \n"
                + "   WHERE b.BookingID = ?";
        Room room = null;
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                room = new Room();
                room.setRoomID(rs.getString("RoomID"));
                room.setPrice(rs.getBigDecimal("PricePerNight"));
            }
        } catch (SQLException e) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return room;
    }

    public List<Room> getAllRoomAvailable() {
        List<Room> roomList = new ArrayList<>();
        String sql = "SELECT r.RoomID, rt.PricePerNight from Room r\n"
                + "	join RoomType rt on r.TypeID = rt.TypeID\n"
                + "	where r.status = 'available'";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Room room = new Room();
                room.setRoomID(rs.getString("RoomID"));
                room.setPrice(rs.getBigDecimal("PricePerNight"));  // Lấy giá từ roomtype
                roomList.add(room);
            }
        } catch (SQLException e) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return roomList;
    }

    public boolean addBooking(int guestID, String roomID, Date checkinDate, Date checkoutDate, BigDecimal totalPrice) {
        String insertSql = "INSERT INTO Booking (GuestID, RoomID, CheckinDate, CheckoutDate, TotalPrice, Status) VALUES (?, ?, ?, ?, ?, 2)";
        String updateRoomSql = "UPDATE Room SET Status = 'Reserved' WHERE RoomID = ?";

        try (PreparedStatement insertStm = connection.prepareStatement(insertSql)) {
            insertStm.setInt(1, guestID);
            insertStm.setString(2, roomID);
            insertStm.setDate(3, checkinDate);
            insertStm.setDate(4, checkoutDate);
            insertStm.setBigDecimal(5, totalPrice);

            int rowsAffected = insertStm.executeUpdate();

            if (rowsAffected > 0) {
                // Nếu booking thành công, cập nhật trạng thái phòng thành "Reserved"
                try (PreparedStatement updateRoomStm = connection.prepareStatement(updateRoomSql)) {
                    updateRoomStm.setString(1, roomID);
                    updateRoomStm.executeUpdate();
                }
                return true;
            }
        } catch (SQLException e) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, "Error adding booking for RoomID: " + roomID, e);
        }
        return false;
    }

    public void createBookingIfGuestNotExist(String firstName, String lastName, String phone, String email,
            String[] roomIDs, Date checkinDate, Date checkoutDate,
            BigDecimal totalPrice) {

        GuestDAO dao = new GuestDAO();
        // 1. Kiểm tra nếu ngày không hợp lệ
        if (checkinDate.after(checkoutDate)) {
            System.err.println("❌ Error: Check-in date must be before check-out date!");
            return;
        }

        // 2. Lấy GuestID theo Phone hoặc Email
        Integer guestID = dao.getGuestIDByPhoneOrEmail(phone);

        // 3. Nếu Guest không tồn tại, tạo mới và lấy GuestID
        if (guestID == null) {
            guestID = dao.createGuest(firstName, lastName, phone, email);
            if (guestID == -1) {
                System.err.println("❌ Error: Failed to create guest!");
                return; // Dừng hàm ngay lập tức
            }
        }

        // 4. Chia tổng giá tiền cho từng phòng nếu totalPrice là tổng tất cả phòng
        BigDecimal pricePerRoom = totalPrice.divide(new BigDecimal(roomIDs.length), RoundingMode.HALF_UP);

        // 5. Tạo booking cho từng phòng
        for (String roomID : roomIDs) {
            addBooking(guestID, roomID, checkinDate, checkoutDate, pricePerRoom);
        }
    }

    public List<Booking> getAllBookingbyGuestID(int guestID) {
        List<Booking> bookingList = new ArrayList<>();
        String sql = "select * from Booking b \n"
                + "	JOIN Guest g ON b.GuestID = g.GuestID "
                + "     LEFT JOIN Payment p on b.BookingID = p.BookingID\n"
                + " where g.guestID=?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, guestID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int bookingID = rs.getInt("BookingID");

                String RoomID = rs.getString("RoomID");

                Date CheckinDate = rs.getDate("CheckinDate");
                Date CheckoutDate = rs.getDate("CheckoutDate");

                int Status = rs.getInt("Status");
                BigDecimal TotalPrice = rs.getBigDecimal("TotalPrice");

                int GuestID = rs.getInt("GuestID");
                String fname = rs.getString("firstName");
                String lname = rs.getString("lastName");
                Date dob = rs.getDate("dateOfBirth");
                String address = rs.getString("address");
                String city = rs.getString("city");
                String country = rs.getString("country");
                String phone = rs.getString("Phone");
                String email = rs.getString("Email");

                int paymentID = rs.getInt("paymentID");
                BigDecimal amount = rs.getBigDecimal("amount");
                Date paymentDate = rs.getDate("paymentDate");
                String paymentMethod = rs.getString("paymentMethod");

                Payment payment = new Payment(paymentID, bookingID, amount, paymentDate, paymentMethod);

                Guest staff = new Guest(GuestID, fname, lname, dob, address, city, country, phone, email);
//                Booking book = new Booking(bookingID, GuestID, RoomID, CheckinDate, CheckoutDate, TotalPrice, Status, staff);
                Booking book = new Booking(bookingID, GuestID, RoomID, CheckinDate, CheckoutDate, TotalPrice, Status, staff, payment);
                bookingList.add(book);
            }
        } catch (SQLException e) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return bookingList;
    }

    public List<Booking> getAllPayment() {
        List<Booking> paymentList = new ArrayList<>();
        String sql = "select * from Payment p	\n"
                + "	JOIN Booking b on b.BookingID = p.BookingID\n"
                + "	JOIN Guest g ON g.GuestID = b.GuestID";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int bookingID = rs.getInt("BookingID");

                String RoomID = rs.getString("RoomID");

                Date CheckinDate = rs.getDate("CheckinDate");
                Date CheckoutDate = rs.getDate("CheckoutDate");

                int Status = rs.getInt("Status");
                BigDecimal TotalPrice = rs.getBigDecimal("TotalPrice");

                int GuestID = rs.getInt("GuestID");
                String fname = rs.getString("firstName");
                String lname = rs.getString("lastName");
                Date dob = rs.getDate("dateOfBirth");
                String address = rs.getString("address");
                String city = rs.getString("city");
                String country = rs.getString("country");
                String phone = rs.getString("Phone");
                String email = rs.getString("Email");

                int paymentID = rs.getInt("paymentID");
                BigDecimal amount = rs.getBigDecimal("amount");
                Date paymentDate = rs.getDate("paymentDate");
                String paymentMethod = rs.getString("paymentMethod");

                Payment payment = new Payment(paymentID, bookingID, amount, paymentDate, paymentMethod);

                Guest staff = new Guest(GuestID, fname, lname, dob, address, city, country, phone, email);
                Booking book = new Booking(bookingID, GuestID, RoomID, CheckinDate, CheckoutDate, TotalPrice, Status, staff, payment);
                paymentList.add(book);
            }
        } catch (SQLException e) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return paymentList;
    }

    public Booking getPaymentByBookingID(int bookingID) {
        String sql = "select * from payment\n"
                + " join booking on booking.BookingID = Payment.BookingID\n"
                + " where booking.bookingID = ?";
        Booking booking = null;
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, bookingID);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                int paymentID = rs.getInt("paymentID");
                BigDecimal amount = rs.getBigDecimal("amount");
                Date paymentDate = rs.getDate("paymentDate");
                String paymentMethod = rs.getString("paymentMethod");

//                int bookingID = rs.getInt("bookingID");
                BigDecimal totalPrice = rs.getBigDecimal("totalPrice");

                Payment payment = new Payment(paymentID, bookingID, amount, paymentDate, paymentMethod);

                booking = new Booking(bookingID, totalPrice, payment);
            }
        } catch (SQLException e) {
            Logger.getLogger(PaymentDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return booking;
    }

//    public boolean updateBooking(int bookingID, int guestID, String roomID, Date checkinDate, Date checkoutDate, BigDecimal totalPrice) {
//        String sql = "UPDATE Booking\n"
//                + "SET GuestID = ?, RoomID = ?, CheckinDate = ?, CheckoutDate =?, TotalPrice = ? \n"
//                + "WHERE BookingID = ?;";
//
//        try {
//            PreparedStatement stm = connection.prepareStatement(sql);
//            stm.setInt(1, guestID);
//            stm.setString(2, roomID);
//            stm.setDate(3, checkinDate);
//            stm.setDate(4, checkoutDate);
//            stm.setBigDecimal(5, totalPrice);
//            stm.setInt(6, bookingID);
//            int rowsAffected = stm.executeUpdate();
//            return rowsAffected > 0;
//        } catch (SQLException e) {
//            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, e);
//            return false;
//        }
//    }
    public boolean updateBooking(int bookingID, String roomID, Date checkinDate, Date checkoutDate, BigDecimal totalPrice,
            String firstName, String lastName, String phone, String email) {
        String sqlGuestID = "Select GuestID From Booking WHERE BookingID = ?";
        String sqlUpdateGuest = "Update Guest SET FirstName = ?, LastName = ?, phone = ?, email = ? WHERE GuestID = ?";
        String sqlUpdateBooking = "Update Booking SET roomID = ?, checkinDate = ?, checkoutDate = ?, totalPrice = ? WHERE bookingID = ?";

        try {
            connection.setAutoCommit(false);

            int guestID = -1;

            PreparedStatement guestST = connection.prepareStatement(sqlGuestID);
            guestST.setInt(1, bookingID);
            ResultSet rsGuest = guestST.executeQuery();
            if (rsGuest.next()) {
                guestID = rsGuest.getInt("GuestID");
            } else {
                return false;
            }
            PreparedStatement updateGuestStmt = connection.prepareStatement(sqlUpdateGuest);
            updateGuestStmt.setString(1, firstName);
            updateGuestStmt.setString(2, lastName);
            updateGuestStmt.setString(3, phone);
            updateGuestStmt.setString(4, email);
            updateGuestStmt.setInt(5, guestID);
            updateGuestStmt.executeUpdate();

            PreparedStatement updateBookingStmt = connection.prepareStatement(sqlUpdateBooking);
            updateBookingStmt.setString(1, roomID);
            updateBookingStmt.setDate(2, checkinDate);
            updateBookingStmt.setDate(3, checkoutDate);
            updateBookingStmt.setBigDecimal(4, totalPrice);
            updateBookingStmt.setInt(5, bookingID);
            int rowsAffected = updateBookingStmt.executeUpdate();

            connection.commit();
            return rowsAffected > 0;
        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException ex) {
                Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, e);
            return false;
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public void deleteBooking(int bookingid) {
        String sql = "delete from Payment where BookingID = ?\n"
                + "delete from Booking where BookingID = ?";

        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, bookingid);
            stm.setInt(2, bookingid);
            stm.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public boolean updateBookingStatus(int bookingID, int newStatus) {
        String sql = "UPDATE Booking SET Status = ? WHERE BookingID = ?";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, newStatus);
            stm.setInt(2, bookingID);
            return stm.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateRoomStatus(int bookingID, String newStatus) {
        String sql = "UPDATE Room SET Status = ? WHERE RoomID = (SELECT RoomID FROM Booking WHERE BookingID = ?)";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, newStatus);
            stm.setInt(2, bookingID);
            return stm.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Booking> getBookingsPaginated(int offset, int pageSize) {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT *\n"
                + "FROM booking\n"
                + "ORDER BY BookingID\n"
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, offset);
            ps.setInt(2, pageSize);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                bookings.add(new Booking(rs.getInt("BookingID"),
                        rs.getInt("GuestID"), rs.getString("RoomID"),
                        rs.getDate("CheckinDate"), rs.getDate("CheckoutDate"),
                        rs.getBigDecimal("TotalPrice"), rs.getInt("Status")));
            }
        } catch (SQLException e) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return bookings;
    }

    public int countSearchResults(String keyword) {
        String sql = "SELECT COUNT(*) FROM Booking b \n"
                + "	JOIN Guest g ON b.GuestID = g.GuestID\n"
                + "	JOIN Room r ON r.RoomID = b.RoomID\n"
                + " WHERE g.FirstName LIKE ? OR g.LastName LIKE ? \n"
                + "	OR g.Phone LIKE ? OR r.RoomID LIKE ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            String searchParam = "%" + keyword + "%";
            stm.setString(1, searchParam);
            stm.setString(2, searchParam);
            stm.setString(3, searchParam);
            stm.setString(4, searchParam);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1); // Trả về số lượng bản ghi tìm được
            }
        } catch (SQLException ex) {
            Logger.getLogger(GuestDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public int getTotalBooking() {
        String sql = "SELECT COUNT(*) FROM Booking b \n"
                + "	JOIN Guest g ON b.GuestID = g.GuestID\n"
                + "	JOIN Room r ON r.RoomID = b.RoomID";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(GuestDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public List<Booking> sortBooking(String sortBy, boolean isDecreasing, int start) {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT * FROM Booking b \n"
                + "	JOIN Guest g ON b.GuestID = g.GuestID\n"
                + "	JOIN Room r ON r.RoomID = b.RoomID";

        if (sortBy != null) {
            if (sortBy.equals("lastName")) {
                sql += " ORDER BY RIGHT(g.lastName, CHARINDEX(' ', REVERSE(g.lastName) + ' ') - 1)";
            } else {
                sql += " ORDER BY " + sortBy;
            }
            if (isDecreasing) {
                sql += " DESC";
            }
        } else {
            sql += " ORDER BY b.BookingID"; // Tránh lỗi nếu `sortBy` null
        }

        sql += " OFFSET ? ROWS FETCH NEXT 5 ROWS ONLY";

        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, (start - 1) * 5); // Vị trí bắt đầu
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int bookingID = rs.getInt("BookingID");

                String RoomID = rs.getString("RoomID");

                Date CheckinDate = rs.getDate("CheckinDate");
                Date CheckoutDate = rs.getDate("CheckoutDate");

                int Status = rs.getInt("Status");
                BigDecimal TotalPrice = rs.getBigDecimal("TotalPrice");

                int GuestID = rs.getInt("GuestID");
                String fname = rs.getString("firstName");
                String lname = rs.getString("lastName");
                Date dob = rs.getDate("dateOfBirth");
                String address = rs.getString("address");
                String city = rs.getString("city");
                String country = rs.getString("country");
                String phone = rs.getString("Phone");
                String email = rs.getString("Email");

                Guest staff = new Guest(GuestID, fname, lname, dob, address, city, country, phone, email);
                Booking book = new Booking(bookingID, GuestID, RoomID, CheckinDate, CheckoutDate, TotalPrice, Status, staff);
                list.add(book);
            }
        } catch (SQLException ex) {
            Logger.getLogger(GuestDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Booking> searchBooking(String searchGuest, String sortBy, boolean isDecreasing, int start) {
        List<Booking> list = new ArrayList<>();
        if (searchGuest == null || searchGuest.isEmpty()) {
            return list;
        }

        String sql = "SELECT * FROM Booking b \n"
                + "	JOIN Guest g ON b.GuestID = g.GuestID\n"
                + "	JOIN Room r ON r.RoomID = b.RoomID where g.FirstName LIKE ? \n"
                + "	OR g.LastName LIKE ? OR g.Phone LIKE ? OR r.RoomID LIKE ? ";

        if (sortBy != null) {
            if (sortBy.equals("lastName")) {
                sql += " ORDER BY RIGHT(lastName, CHARINDEX(' ', REVERSE(lastName) + ' ') - 1)";
            } else {
                sql += " ORDER BY " + sortBy;
            }
            if (isDecreasing) {
                sql += " DESC";
            }
        } else {
            sql += " ORDER BY guestID"; // Tránh lỗi nếu `sortBy` null
        }

        sql += " OFFSET ? ROWS FETCH NEXT 5 ROWS ONLY";

        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, "%" + searchGuest + "%");
            stm.setString(2, "%" + searchGuest + "%");
            stm.setString(3, "%" + searchGuest + "%");
            stm.setString(4, "%" + searchGuest + "%");
            stm.setInt(5, (start - 1) * 5);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int bookingID = rs.getInt("BookingID");

                String RoomID = rs.getString("RoomID");

                Date CheckinDate = rs.getDate("CheckinDate");
                Date CheckoutDate = rs.getDate("CheckoutDate");

                int Status = rs.getInt("Status");
                BigDecimal TotalPrice = rs.getBigDecimal("TotalPrice");

                int GuestID = rs.getInt("GuestID");
                String fname = rs.getString("firstName");
                String lname = rs.getString("lastName");
                Date dob = rs.getDate("dateOfBirth");
                String address = rs.getString("address");
                String city = rs.getString("city");
                String country = rs.getString("country");
                String phone = rs.getString("Phone");
                String email = rs.getString("Email");

                Guest staff = new Guest(GuestID, fname, lname, dob, address, city, country, phone, email);
                Booking book = new Booking(bookingID, GuestID, RoomID, CheckinDate, CheckoutDate, TotalPrice, Status, staff);
                list.add(book);
            }
        } catch (SQLException ex) {
            Logger.getLogger(GuestDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

//    // Hàm lấy kết nối database
//    private Connection getConnection() throws SQLException {
//        // Đảm bảo bạn đã cấu hình đúng database URL, user, password tại đây
//        return DriverManager.getConnection("jdbc:mysql://localhost:3306/your_database", "root", "password");
//    }
    public static void main(String[] args) {
        BookingDAO a = new BookingDAO();
        List<Booking> listins = new DAO.BookingDAO().getBookingsPaginated(0, 10);
        List<Room> listR = new DAO.BookingDAO().getAllRoomAvailable();

        List<Booking> listb = new DAO.BookingDAO().getAllBookingbyGuestID(1);

        List<Booking> list1 = new DAO.BookingDAO().sortBooking("lastName", true, 1);
        List<Booking> list2 = new DAO.BookingDAO().searchBooking("d", "lastName", true, 1);

        Booking b = a.getPaymentByBookingID(3);
        System.out.println(b);

//        Room room = a.getRoomByBookingID(115);
//        System.out.println(room);
//        for (Booking ins : listb) {
//            System.out.println(ins);
//        }
//        System.out.println(a.getTotalBooking());
//        System.out.println("Booking List Size: " + (listins == null ? "NULL" : listins.size()));
    }
}
