/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import dal.DBContext;
import entity.Guest;
import entity.Staff;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ASUS
 */
public class GuestDAO extends DBContext {

    public List<Guest> getAllGuest() {
        List<Guest> list = new ArrayList<>();
        String sql = "SELECT * FROM Guest";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Guest(rs.getInt("guestID"),
                        rs.getString("firstName"),
                        rs.getString("lastName"),
                        rs.getDate("dateOfBirth"),
                        rs.getString("address"),
                        rs.getString("city"),
                        rs.getString("country"),
                        rs.getString("phone"),
                        rs.getString("email")));
            }
        } catch (SQLException ex) {
            Logger.getLogger(GuestDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public int insertGuest(String name, String email, String phone, String address, String city, String country, String dob) {
        int guestID = -1;
        String sql = "INSERT INTO Guest (FirstName, LastName, Email, Phone, Address, City, Country, DateOfBirth) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

            // 🔹 Nếu bạn chỉ có full name trong 1 biến 'name', tách thử first và last name
            String firstName = name;
            String lastName = "";
            if (name != null && name.contains(" ")) {
                int spaceIndex = name.lastIndexOf(" ");
                firstName = name.substring(0, spaceIndex);
                lastName = name.substring(spaceIndex + 1);
            }

            ps.setString(1, firstName);
            ps.setString(2, lastName);
            ps.setString(3, email);
            ps.setString(4, phone);
            ps.setString(5, address);
            ps.setString(6, city);
            ps.setString(7, country);
            ps.setString(8, dob);

            ps.executeUpdate();

            // 🔹 Lấy GuestID vừa được tạo
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    guestID = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return guestID;
    }

    public List<Guest> getAllGuestNotAccount() {
        List<Guest> list = new ArrayList<>();
        String sql = "SELECT * FROM Guest g\n"
                + "	LEFT JOIN Account a ON g.GuestID = a.GuestID\n"
                + "WHERE a.GuestID IS NULL;";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Guest(rs.getInt("guestID"),
                        rs.getString("firstName"),
                        rs.getString("lastName"),
                        rs.getDate("dateOfBirth"),
                        rs.getString("address"),
                        rs.getString("city"),
                        rs.getString("country"),
                        rs.getString("phone"),
                        rs.getString("email")));
            }
        } catch (SQLException ex) {
            Logger.getLogger(StaffDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public Guest getGuestByPhone(String phone, Integer guestID) {
        Guest sf = null;
        String sql = "SELECT * FROM Guest WHERE phone = ?";

        if (guestID != null && guestID > 0) {
            sql += " AND guestID != ?";
        }

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, phone);

            if (guestID != null && guestID > 0) {
                stm.setInt(2, guestID);
            }

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    sf = new Guest(
                            rs.getInt("guestID"),
                            rs.getString("firstName"),
                            rs.getString("lastName"),
                            rs.getDate("dateOfBirth"),
                            rs.getString("address"),
                            rs.getString("city"),
                            rs.getString("country"),
                            rs.getString("phone"),
                            rs.getString("email")
                    );
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(GuestDAO.class.getName()).log(Level.SEVERE, "Error fetching guest by phone", e);
        }
        return sf;
    }

    public Guest getGuestById(int guestID) {
        String sql = "SELECT * FROM Guest WHERE GuestID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, guestID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Guest(
                        rs.getInt("GuestID"),
                        rs.getString("FirstName"),
                        rs.getString("LastName"),
                        rs.getDate("DateOfBirth"),
                        rs.getString("Address"),
                        rs.getString("City"),
                        rs.getString("Country"),
                        rs.getString("Phone"),
                        rs.getString("Email")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void deleteGuest(int guestID) {
        String sql = "DELETE FROM Guest WHERE GuestID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, guestID);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Sinh GuestID tự động tăng
    public int generateNextGuestID() {
        String sql = "SELECT ISNULL(MAX(GuestID), 0) + 1 FROM Guest";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 1; // mặc định
    }

// Thêm guest từ staff
    public int insertGuestFromStaff(Staff s) {
        int newGuestID = generateNextGuestID();
        String sql = "INSERT INTO Guest (GuestID, FirstName, LastName, DateOfBirth, Address, City, Country, Phone, Email) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, newGuestID);
            ps.setString(2, s.getFirstName());
            ps.setString(3, s.getLastName());
            ps.setDate(4, s.getDateOfBirth());
            ps.setString(5, s.getAddress());
            ps.setString(6, s.getCity());
            ps.setString(7, s.getCountry());
            ps.setString(8, s.getPhone());
            ps.setString(9, s.getEmail());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return newGuestID;
    }

    public Guest getGuestByEmail(String email, Integer guestID) {
        Guest sf = null;

        String sql = "select * from Guest where Email = ?";

        if (guestID != null && guestID > 0) {
            sql += " AND guestID != ?";
        }

        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, email);
            if (guestID != null) {
                stm.setInt(2, guestID);
            }
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                sf = new Guest(rs.getInt("guestID"),
                        rs.getString("firstName"),
                        rs.getString("lastName"),
                        rs.getDate("dateOfBirth"),
                        rs.getString("address"),
                        rs.getString("city"),
                        rs.getString("country"),
                        rs.getString("phone"),
                        rs.getString("email"));
            }
        } catch (SQLException e) {
            Logger.getLogger(GuestDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return sf;
    }

    public Guest getGuestByAccountID(int aId) {
        Guest sf = new Guest();

        String sql = "select * from Account a	\n"
                + "	JOIN Guest g ON a.guestID = g.guestID WHERE a.AccountID = ?";

        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, aId);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                sf = new Guest(rs.getInt("guestID"),
                        rs.getString("firstName"),
                        rs.getString("lastName"),
                        rs.getDate("dateOfBirth"),
                        rs.getString("address"),
                        rs.getString("city"),
                        rs.getString("country"),
                        rs.getString("phone"),
                        rs.getString("email"));
            }
        } catch (SQLException e) {
            Logger.getLogger(GuestDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return sf;
    }

    public Integer getGuestIDByPhoneOrEmail(String phoneOrEmail) {
        String sql = "SELECT guestID FROM Guest WHERE phone = ? OR email = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, phoneOrEmail);
            stm.setString(2, phoneOrEmail);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("guestID");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public int createGuest(String firstName, String lastName, String phone, String email) {
        String sql = "INSERT INTO Guest (FirstName, LastName, Phone, Email) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement stm = connection.prepareStatement(sql, java.sql.Statement.RETURN_GENERATED_KEYS);
            stm.setString(1, firstName);
            stm.setString(2, lastName);
            stm.setString(3, phone);
            stm.setString(4, email);
            stm.executeUpdate();
            ResultSet rs = stm.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1); // Lấy GuestID vừa tạo
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return -1;
    }

    public int countSearchResults(String keyword) {
        String sql = "SELECT COUNT(*) FROM Guest WHERE FirstName LIKE ? OR LastName LIKE ? OR Phone LIKE ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            String searchParam = "%" + keyword + "%";
            stm.setString(1, searchParam);
            stm.setString(2, searchParam);
            stm.setString(3, searchParam);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1); // Trả về số lượng bản ghi tìm được
            }
        } catch (SQLException ex) {
            Logger.getLogger(GuestDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public int getTotalGuest() {
        String sql = "SELECT COUNT(*) FROM Guest";
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

    public List<Guest> sortGuest(String sortBy, boolean isDecreasing, int start) {
        List<Guest> list = new ArrayList<>();
        String sql = "SELECT * FROM Guest ";

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
            stm.setInt(1, (start - 1) * 5); // Vị trí bắt đầu
//            stm.setInt(2, total);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Guest(rs.getInt("guestID"),
                        rs.getString("firstName"),
                        rs.getString("lastName"),
                        rs.getDate("dateOfBirth"),
                        rs.getString("address"),
                        rs.getString("city"),
                        rs.getString("country"),
                        rs.getString("phone"),
                        rs.getString("email")));
            }
        } catch (SQLException ex) {
            Logger.getLogger(GuestDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Guest> searchGuest(String searchGuest, String sortBy, boolean isDecreasing, int start) {
        List<Guest> list = new ArrayList<>();
        if (searchGuest == null || searchGuest.isEmpty()) {
            return list;
        }

        String sql = "select * from Guest where FirstName LIKE ? \n"
                + "	OR LastName LIKE ? OR Phone LIKE ? ";

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
            stm.setInt(4, (start - 1) * 5);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Guest(rs.getInt("guestID"),
                        rs.getString("firstName"),
                        rs.getString("lastName"),
                        rs.getDate("dateOfBirth"),
                        rs.getString("address"),
                        rs.getString("city"),
                        rs.getString("country"),
                        rs.getString("phone"),
                        rs.getString("email")));
            }
        } catch (SQLException ex) {
            Logger.getLogger(GuestDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public void update(Guest gs) {
        String sql = "UPDATE Guest SET FirstName = ?, LastName = ?,\n"
                + "		DateOfBirth=?, Address=?,\n"
                + "		City = ?, Country = ?, Phone=?,\n"
                + "		Email=?\n"
                + "		WHERE guestID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, gs.getFirstName());
            stm.setString(2, gs.getLastName());
            stm.setDate(3, gs.getDateOfBirth());
            stm.setString(4, gs.getAddress());
            stm.setString(5, gs.getCity());
            stm.setString(6, gs.getCountry());
            stm.setString(7, gs.getPhone());
            stm.setString(8, gs.getEmail());
            stm.setInt(9, gs.getGuestID());

            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(GuestDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void addNewGuest(Guest gs) {
        String sql = "INSERT INTO Guest (FirstName, LastName, DateOfBirth, Address, City, Country, Phone, Email)\n"
                + "VALUES \n"
                + "(?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, gs.getFirstName());
            stm.setString(2, gs.getLastName());
            stm.setDate(3, gs.getDateOfBirth());
            stm.setString(4, gs.getAddress());
            stm.setString(5, gs.getCity());
            stm.setString(6, gs.getCountry());
            stm.setString(7, gs.getPhone());
            stm.setString(8, gs.getEmail());

            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(GuestDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void DeleteGuest(int id) {
        String sqlDeleteAccount = "DELETE FROM Account WHERE guestID = ? ";
        String sqlDeleteGuest = "DELETE FROM Guest WHERE guestID = ?";
        PreparedStatement stm = null;
        try {
            connection.setAutoCommit(false);

            stm = connection.prepareStatement(sqlDeleteAccount);
            stm.setInt(1, id);
            stm.executeUpdate();

            stm = connection.prepareStatement(sqlDeleteGuest);
            stm.setInt(1, id);
            stm.executeUpdate();

            connection.commit();
        } catch (SQLException ex) {
            try {
                connection.rollback();
            } catch (SQLException e) {
                Logger.getLogger(GuestDAO.class.getName()).log(Level.SEVERE, null, e);
            }
            Logger.getLogger(GuestDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (stm != null) {
                    connection.setAutoCommit(true);
                }
            } catch (SQLException e) {
                Logger.getLogger(GuestDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
    }

    public static void main(String[] args) {
        GuestDAO dao = new GuestDAO();
        List<Guest> list1 = dao.getAllGuest();
        List<Guest> listsort = dao.sortGuest("lastName", false, 1);
        List<Guest> search = dao.searchGuest("n", "lastName", false, 1);

        int count = dao.getTotalGuest();
        int c = dao.countSearchResults("n");
//        Staff s = dao.getStaffByAccountID("4");
//        Staff s1 = dao.getStaffById("S001");
//
//        System.out.println("Staff");
//        System.out.println(s1);

        for (Guest g : search) {
            System.out.println(g);
        }

        System.out.println(count);
        System.out.println(c);
    }
}
