/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import dal.DBContext;
import entity.Guest;
import entity.Staff;
import java.math.BigDecimal;
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
public class StaffDAO extends DBContext {

    public List<Staff> getAllStaff() {
        List<Staff> list = new ArrayList<>();
        String sql = "SELECT * FROM Staff";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Staff(rs.getString("staffID"),
                        rs.getString("firstName"),
                        rs.getString("lastName"),
                        rs.getString("position"),
                        rs.getDouble("salary"),
                        rs.getDate("dateOfBirth"),
                        rs.getString("address"),
                        rs.getString("city"),
                        rs.getString("country"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getDate("hireDate")));
            }
        } catch (SQLException ex) {
            Logger.getLogger(StaffDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Staff> getAllStaffNotAccount() {
        List<Staff> list = new ArrayList<>();
        String sql = "SELECT * FROM Staff s\n"
                + "	LEFT JOIN Account a ON s.StaffID = a.StaffID\n"
                + "WHERE a.StaffID IS NULL;";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Staff(rs.getString("staffID"),
                        rs.getString("firstName"),
                        rs.getString("lastName"),
                        rs.getString("position"),
                        rs.getDouble("salary"),
                        rs.getDate("dateOfBirth"),
                        rs.getString("address"),
                        rs.getString("city"),
                        rs.getString("country"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getDate("hireDate")));
            }
        } catch (SQLException ex) {
            Logger.getLogger(StaffDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Staff> pagingStaff(int x) {
        List<Staff> list = new ArrayList<>();
        String sql = "select * from Staff order by StaffID OFFSET ? ROWS FETCH NEXT 5 ROWS ONLY";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, (x - 1) * 5);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Staff(rs.getString("staffID"),
                        rs.getString("firstName"),
                        rs.getString("lastName"),
                        rs.getString("position"),
                        rs.getDouble("salary"),
                        rs.getDate("dateOfBirth"),
                        rs.getString("address"),
                        rs.getString("city"),
                        rs.getString("country"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getDate("hireDate")));
            }
        } catch (SQLException ex) {
            Logger.getLogger(StaffDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public String insertStaffFromGuest(Guest g) {
        String newStaffID = generateNextStaffID(); // ví dụ S001, S002
        String sql = "INSERT INTO Staff (StaffID, FirstName, LastName, DateOfBirth, Address, City, Country, Phone, Email, Position, Salary) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, newStaffID);
            ps.setString(2, g.getFirstName());
            ps.setString(3, g.getLastName());
            ps.setDate(4, g.getDateOfBirth());
            ps.setString(5, g.getAddress());
            ps.setString(6, g.getCity());
            ps.setString(7, g.getCountry());
            ps.setString(8, g.getPhone());
            ps.setString(9, g.getEmail());
            ps.setString(10, "Staff"); // mặc định
            ps.setBigDecimal(11, new BigDecimal("0.00")); // salary mặc định
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return newStaffID;
    }

    public void deleteStaffById(int staffID) throws SQLException {
        String sql = "DELETE FROM Staff WHERE StaffID = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, staffID);
        ps.executeUpdate();
    }

    public String generateNextStaffID() {
        String sql = "SELECT MAX(StaffID) AS maxID FROM Staff";
        String nextID = "S001"; // mặc định nếu bảng đang trống

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                String maxID = rs.getString("maxID");
                if (maxID != null) {
                    // Cắt bỏ chữ 'S' ở đầu và ép phần số thành int
                    int num = Integer.parseInt(maxID.substring(1));
                    num++; // tăng lên 1
                    // Ghép lại dạng S001, S002, ...
                    nextID = String.format("S%03d", num);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return nextID;
    }

    public Staff getStaffById(String staffID) {
        String sql = "SELECT * FROM Staff WHERE StaffID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, staffID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Staff(
                        rs.getString("StaffID"),
                        rs.getString("FirstName"),
                        rs.getString("LastName"),
                        rs.getString("Position"),
                        rs.getDouble("Salary"),
                        rs.getDate("DateOfBirth"),
                        rs.getString("Address"),
                        rs.getString("City"),
                        rs.getString("Country"),
                        rs.getString("Phone"),
                        rs.getString("Email"),
                        rs.getDate("HireDate")
                );

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void deleteStaff(String staffID) {
        String sql = "DELETE FROM Staff WHERE StaffID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, staffID);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Staff getStaffByPhone(String phone, String staffID) {
        Staff sf = null;

        String sql = "select * from Staff where phone = ?";

        if (staffID != null && !staffID.isEmpty()) {
            sql += " AND StaffID != ?";
        }
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, phone);
            if (staffID != null && !staffID.isEmpty()) {
                stm.setString(2, staffID);
            }
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                sf = new Staff(rs.getString("staffID"),
                        rs.getString("firstName"),
                        rs.getString("lastName"),
                        rs.getString("position"),
                        rs.getDouble("salary"),
                        rs.getDate("dateOfBirth"),
                        rs.getString("address"),
                        rs.getString("city"),
                        rs.getString("country"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getDate("hireDate"));
            }
        } catch (SQLException e) {
            Logger.getLogger(StaffDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return sf;
    }

    public Staff getStaffByEmail(String email, String staffID) {
        Staff sf = null;

        String sql = "select * from Staff where Email = ?";

        if (staffID != null && !staffID.isEmpty()) {
            sql += " AND StaffID != ?";
        }

        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, email);
            if (staffID != null && !staffID.isEmpty()) {
                stm.setString(2, staffID);
            }
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                sf = new Staff(rs.getString("staffID"),
                        rs.getString("firstName"),
                        rs.getString("lastName"),
                        rs.getString("position"),
                        rs.getDouble("salary"),
                        rs.getDate("dateOfBirth"),
                        rs.getString("address"),
                        rs.getString("city"),
                        rs.getString("country"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getDate("hireDate"));
            }
        } catch (SQLException e) {
            Logger.getLogger(StaffDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return sf;
    }

    public Staff getStaffByAccountID(int aId) {
        Staff sf = new Staff();

        String sql = "select * from Account a	\n"
                + "	JOIN Staff s ON a.staffID = s.staffID WHERE a.AccountID = ?";

        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, aId);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                sf = new Staff(rs.getString("staffID"),
                        rs.getString("firstName"),
                        rs.getString("lastName"),
                        rs.getString("position"),
                        rs.getDouble("salary"),
                        rs.getDate("dateOfBirth"),
                        rs.getString("address"),
                        rs.getString("city"),
                        rs.getString("country"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getDate("hireDate"));
            }
        } catch (SQLException e) {
            Logger.getLogger(StaffDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return sf;
    }

    public void update(Staff sf) {
        String sql = "UPDATE Staff SET FirstName = ?, LastName = ?,\n"
                + "		Position = ?, Salary = ?, DateOfBirth=?, Address=?,\n"
                + "		City = ?, Country = ?, Phone=?,\n"
                + "		Email=?, HireDate=?\n"
                + "		WHERE StaffID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, sf.getFirstName());
            stm.setString(2, sf.getLastName());
            stm.setString(3, sf.getPosition());
            stm.setDouble(4, sf.getSalary());
            stm.setDate(5, sf.getDateOfBirth());
            stm.setString(6, sf.getAddress());
            stm.setString(7, sf.getCity());
            stm.setString(8, sf.getCountry());
            stm.setString(9, sf.getPhone());
            stm.setString(10, sf.getEmail());
            stm.setDate(11, sf.getHireDate());
            stm.setString(12, sf.getStaffID());

            stm.executeUpdate();
        } catch (SQLException ex) {
            System.out.println(ex);
        }
    }

    public void addNewStaff(Staff st) {
        String sql = "INSERT INTO Staff (StaffID, FirstName, LastName, Position, Salary, DateOfBirth, Address, City, Country, Phone, Email, HireDate)\n"
                + "VALUES \n"
                + "(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, st.getStaffID());
            stm.setString(2, st.getFirstName());
            stm.setString(3, st.getLastName());
            stm.setString(4, st.getPosition());
            stm.setDouble(5, st.getSalary());
            stm.setDate(6, st.getDateOfBirth());
            stm.setString(7, st.getAddress());
            stm.setString(8, st.getCity());
            stm.setString(9, st.getCountry());
            stm.setString(10, st.getPhone());
            stm.setString(11, st.getEmail());
            stm.setDate(12, st.getHireDate());

            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(StaffDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void DeleteStaff(String id) {
        String sqlDeleteAccount = "DELETE FROM Account WHERE StaffID = ? ";
        String sqlDeleteStaff = "DELETE FROM Staff WHERE StaffID = ?";
        PreparedStatement stm = null;
        try {
            connection.setAutoCommit(false);

            stm = connection.prepareStatement(sqlDeleteAccount);
            stm.setString(1, id);
            stm.executeUpdate();

            stm = connection.prepareStatement(sqlDeleteStaff);
            stm.setString(1, id);
            stm.executeUpdate();

            connection.commit();
        } catch (SQLException ex) {
            try {
                connection.rollback();
            } catch (SQLException e) {
                Logger.getLogger(StaffDAO.class.getName()).log(Level.SEVERE, null, e);
            }
            Logger.getLogger(StaffDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (stm != null) {
                    connection.setAutoCommit(true);
                }
            } catch (SQLException e) {
                Logger.getLogger(StaffDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
    }

    public int countSearchResults(String keyword) {
        String sql = "SELECT COUNT(*) FROM Staff WHERE FirstName LIKE ? OR LastName LIKE ? OR Phone LIKE ?";
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
            Logger.getLogger(StaffDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public int getTotalSatff() {
        String sql = "SELECT COUNT(*) FROM Staff";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(StaffDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public List<Staff> sortStaff(String sortBy, boolean isDecreasing, int start) {
        List<Staff> list = new ArrayList<>();
        String sql = "SELECT * FROM Staff ";

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
            sql += " ORDER BY staffID"; // Tránh lỗi nếu `sortBy` null
        }

        sql += " OFFSET ? ROWS FETCH NEXT 5 ROWS ONLY";

        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, (start - 1) * 5); // Vị trí bắt đầu
//            stm.setInt(2, total);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Staff(rs.getString("staffID"),
                        rs.getString("firstName"),
                        rs.getString("lastName"),
                        rs.getString("position"),
                        rs.getDouble("salary"),
                        rs.getDate("dateOfBirth"),
                        rs.getString("address"),
                        rs.getString("city"),
                        rs.getString("country"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getDate("hireDate")));
            }
        } catch (SQLException ex) {
            Logger.getLogger(StaffDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Staff> searchStaff(String searchStaff, String sortBy, boolean isDecreasing, int start) {
        List<Staff> list = new ArrayList<>();
        if (searchStaff == null || searchStaff.isEmpty()) {
            return list;
        }

        String sql = "select * from Staff where FirstName LIKE ? \n"
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
            sql += " ORDER BY staffID"; // Tránh lỗi nếu `sortBy` null
        }

        sql += " OFFSET ? ROWS FETCH NEXT 5 ROWS ONLY";

        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, "%" + searchStaff + "%");
            stm.setString(2, "%" + searchStaff + "%");
            stm.setString(3, "%" + searchStaff + "%");
            stm.setInt(4, (start - 1) * 5);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Staff(rs.getString("staffID"),
                        rs.getString("firstName"),
                        rs.getString("lastName"),
                        rs.getString("position"),
                        rs.getDouble("salary"),
                        rs.getDate("dateOfBirth"),
                        rs.getString("address"),
                        rs.getString("city"),
                        rs.getString("country"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getDate("hireDate")));
            }
        } catch (SQLException ex) {
            Logger.getLogger(StaffDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public static void main(String[] args) {
        StaffDAO dao = new StaffDAO();
        List<Staff> list1 = dao.getAllStaff();
        List<Staff> list2 = dao.pagingStaff(2);
        List<Staff> listsort = dao.sortStaff("lastName", false, 1);
        List<Staff> search = dao.searchStaff("n", "lastName", false, 1);

        int count = dao.getTotalSatff();
        int c = dao.countSearchResults("n");
//        Staff s = dao.getStaffByAccountID("4");
//        Staff s1 = dao.getStaffById("S001");
//
//        System.out.println("Staff");
//        System.out.println(s1);

        for (Staff st : search) {
            System.out.println(st);
        }

        System.out.println(count);
        System.out.println(c);
    }
}
