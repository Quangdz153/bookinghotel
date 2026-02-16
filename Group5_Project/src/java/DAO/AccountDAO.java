/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import dal.DBContext;
import entity.Account;
import entity.Guest;
import entity.Staff;
import java.beans.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ASUS
 */
public class AccountDAO extends DBContext {

    public Account login(String user, String pass) {
        String sql = "select * from Account WHERE Username = ? AND [Password] = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, user);
            stm.setString(2, pass);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                return new Account(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getDate(5));
            }
        } catch (SQLException e) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, e);
        }

        return null;
    }

    public Account checkExitsAccount(String user) {
        String sql = "select * from Account WHERE Username = ?";

        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, user);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                return new Account(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getDate(5));
            }
        } catch (SQLException e) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return null;
    }

    public Account checkExitsAccountUd(String user, int accountID) {
        String sql = "select * from Account WHERE Username = ? ";

        if (accountID != -1) {
            sql += " AND accountID != ?";
        }
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, user);
            if (accountID != -1) {
                stm.setInt(2, accountID);
            }
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                return new Account(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getDate(5));
            }
        } catch (SQLException e) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return null;
    }

    public Account checkPass(String pass) {
        String sql = "select * from Account WHERE [Password] = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, pass);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                return new Account(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getDate(5));
            }
        } catch (SQLException e) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, e);
        }

        return null;
    }

    public boolean checkExistEmail(String email) {
        String sql = "select email from staff where email = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, email);
            ResultSet rs = stm.executeQuery();

            return rs.next();
        } catch (SQLException e) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    public void register(String user, String pass) {
        String sql = "INSERT INTO Account (Username, Password, Role, CreatedAt)\n"
                + "VALUES \n"
                + "(?, ?, 'Guest', GETDATE())";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, user);
            stm.setString(2, pass);
            stm.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public void registerGuest(String username, String password, String email, String phone) {
        try {
            // 1. Thêm Guest
            String sqlGuest = "INSERT INTO Guest (FirstName, LastName, Email, Phone) VALUES (?, ?, ?, ?)";
            PreparedStatement stmGuest = connection.prepareStatement(sqlGuest, PreparedStatement.RETURN_GENERATED_KEYS);
            stmGuest.setString(1, username);
            stmGuest.setString(2, "");
            stmGuest.setString(3, email);
            stmGuest.setString(4, phone);
            stmGuest.executeUpdate();

            // Lấy GuestID
            int guestID = -1;
            try (ResultSet rs = stmGuest.getGeneratedKeys()) {
                if (rs.next()) {
                    guestID = rs.getInt(1);
                }
            }

            stmGuest.close(); // Đóng để giải phóng khóa

            // 2. Thêm Account
            if (guestID != -1) {
                String sqlAcc = "INSERT INTO Account (Username, Password, Role, CreatedAt, GuestID, StaffID) "
                        + "VALUES (?, ?, 'Guest', GETDATE(), ?, NULL)";
                PreparedStatement stmAcc = connection.prepareStatement(sqlAcc);
                stmAcc.setString(1, username);
                stmAcc.setString(2, password);
                stmAcc.setInt(3, guestID);
                stmAcc.executeUpdate();
                stmAcc.close();
            } else {
                System.out.println("❌ Không lấy được GuestID!");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void insertAccount(String username, String password, String role, int guestID) {
        String sql = "INSERT INTO Account (Username, Password, Role, CreatedAt, GuestID, StaffID) VALUES (?, ?, ?, GETDATE(), ?, NULL)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, role);
            ps.setInt(4, guestID);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void createAccountStaff(String user, String pass, String role, String StaffID) {
        String sql = "INSERT INTO Account (Username, Password, Role, StaffID, GuestID)\n"
                + "VALUES \n"
                + "(?, ?, ?, ?, Null)";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, user);
            stm.setString(2, pass);
            stm.setString(3, role);
            stm.setString(4, StaffID);
            stm.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public void updateAccountToStaff(int accountID, String username, String password, String role, String staffID) {
        String sql = "UPDATE Account SET Username=?, Password=?, Role=?, StaffID=?, GuestID=NULL WHERE AccountID=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, role);
            ps.setString(4, staffID);
            ps.setInt(5, accountID);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void updateAccountRoleToGuest(int accountID, String username, String password, int guestID) throws SQLException {
    String sql = "UPDATE Account SET Username = ?, [Password] = ?, GuestID = ?, StaffID = NULL, Role = 'Guest' WHERE AccountID = ?";
    PreparedStatement ps = connection.prepareStatement(sql);
    ps.setString(1, username);
    ps.setString(2, password);
    ps.setInt(3, guestID);
    ps.setInt(4, accountID);
    ps.executeUpdate();
}
    
    
// Cập nhật account khi đổi sang Guest
public void updateAccountToGuest(int accountID, String username, String password, String role, int guestID) {
    String sql = "UPDATE Account SET Username=?, Password=?, Role=?, GuestID=?, StaffID=NULL WHERE AccountID=?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, username);
        ps.setString(2, password);
        ps.setString(3, role);
        ps.setInt(4, guestID);
        ps.setInt(5, accountID);
        ps.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}

// Update account thông thường (khi không đổi role)
public void updateAccountStaff(int accountID, String username, String password, String role) {
    String sql = "UPDATE Account SET Username=?, Password=?, Role=? WHERE AccountID=?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, username);
        ps.setString(2, password);
        ps.setString(3, role);
        ps.setInt(4, accountID);
        ps.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}


    public void updateAccount(int accountID, String user, String pass, String role, String staffID) {
        String sql = "Update Account SET Username = ?, Password = ?, "
                + " Role = ?, StaffID = ?, GuestID = ? WHERE AccountID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, user);
            st.setString(2, pass);
            st.setString(3, role);

            if (role.equals("Admin") || role.equals("Guest")) {
                st.setNull(4, java.sql.Types.VARCHAR);
                st.setNull(5, java.sql.Types.INTEGER);
            } else if (role.equals("Staff")) {
                st.setNull(5, java.sql.Types.INTEGER);
                if (staffID != null && !staffID.isEmpty()) {
                    st.setString(4, staffID);
                } else {
                    st.setNull(4, java.sql.Types.VARCHAR);
                }
            }
            st.setInt(6, accountID);

            st.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public void deleteAccountStaff(int id) {
        String sql = "DELETE FROM Account WHERE AccountID = ? ";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public List<Account> getAllAccount() {
        List<Account> list = new ArrayList<>();
        String sql = "Select a.AccountID, a.Username, a.[Password], s.*, a.[Role], a.CreatedAt \n"
                + "from Account a LEFT JOIN Staff s ON a.StaffID = s.StaffID WHERE a.Role = 'Staff' ";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int accountID = rs.getInt("AccountID");
                String username = rs.getString("Username");
                String password = rs.getString("Password");
                String role = rs.getString("Role");
                Date createdAt = rs.getDate("CreatedAt");

                String StaffID = rs.getString("StaffID");
                String phone = rs.getString("Phone");
                String email = rs.getString("Email");

                Staff staff = new Staff(StaffID, phone, email);

                Account acc = new Account(accountID, username, password, role, createdAt, staff);
                list.add(acc);
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public int countSearchResults(String keyword) {
        String sql = "SELECT COUNT(*) FROM Account a LEFT JOIN Staff s ON a.StaffID = s.StaffID WHERE a.Role = 'Staff' AND Username LIKE ? ";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            String searchParam = "%" + keyword + "%";
            stm.setString(1, searchParam);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1); // Trả về số lượng bản ghi tìm được
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public int getTotalAccount() {
        String sql = "SELECT COUNT(*) FROM Account a LEFT JOIN Staff s ON a.StaffID = s.StaffID WHERE a.Role = 'Staff' ";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public List<Account> pagingAccount(int x) {
        List<Account> list = new ArrayList<>();
        String sql = "Select a.AccountID, a.Username, a.[Password], s.*, a.[Role], a.CreatedAt \n"
                + " from Account a LEFT JOIN Staff s ON a.StaffID = s.StaffID WHERE a.Role = 'Staff' "
                + " order by a.AccountID OFFSET ? ROWS FETCH NEXT 5 ROWS ONLY";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, (x - 1) * 5);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int accountID = rs.getInt("AccountID");
                String username = rs.getString("Username");
                String password = rs.getString("Password");
                String role = rs.getString("Role");
                Date createdAt = rs.getDate("CreatedAt");

                String StaffID = rs.getString("StaffID");
                String phone = rs.getString("Phone");
                String email = rs.getString("Email");

                Staff staff = new Staff(StaffID, phone, email);

                Account acc = new Account(accountID, username, password, role, createdAt, staff);
                list.add(acc);
            }
        } catch (SQLException ex) {
            Logger.getLogger(StaffDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Account> sortAccount(String sortBy, boolean isDecreasing, int start) {
        List<Account> list = new ArrayList<>();
        String sql = "Select a.AccountID, a.Username, a.[Password], s.*, a.[Role], a.CreatedAt \n"
                + "from Account a LEFT JOIN Staff s ON a.StaffID = s.StaffID WHERE a.Role = 'Staff' ";

        if (sortBy != null && !sortBy.isEmpty()) {
            if (sortBy.equals("Username")) {
                sql += " ORDER BY Username ";
            } else if (sortBy.equals("CreatedAt")) {
                sql += " ORDER BY DAY(CreatedAt) ";
            } else {
                sql += " ORDER BY " + sortBy;
            }
            if (isDecreasing) {
                sql += " DESC";
            }
        } else {
            sql += " ORDER BY a.AccountID "; // Tránh lỗi nếu `sortBy` null
        }

        sql += " OFFSET ? ROWS FETCH NEXT 5 ROWS ONLY";

        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, (start - 1) * 5); // Vị trí bắt đầu
//            stm.setInt(2, total);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int accountID = rs.getInt("AccountID");
                String username = rs.getString("Username");
                String password = rs.getString("Password");
                String role = rs.getString("Role");
                Date createdAt = rs.getDate("CreatedAt");

                String StaffID = rs.getString("StaffID");
                String fname = rs.getString("firstName");
                String lname = rs.getString("lastName");
                String pos = rs.getString("position");
                double sal = rs.getDouble("salary");
                Date dob = rs.getDate("dateOfBirth");
                String address = rs.getString("address");
                String city = rs.getString("city");
                String country = rs.getString("country");
                String phone = rs.getString("Phone");
                String email = rs.getString("Email");
                Date hireDate = rs.getDate("hireDate");

//                Staff staff = new Staff(StaffID, phone, email);
                Staff staff = new Staff(StaffID, fname, lname, pos, sal, dob, address, city, country, phone, email, hireDate);

                Account acc = new Account(accountID, username, password, role, createdAt, staff);
                list.add(acc);
            }
        } catch (SQLException ex) {
            Logger.getLogger(StaffDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Account> searchAccount(String searchAccount, String sortBy, boolean isDecreasing, int start) {
        List<Account> list = new ArrayList<>();
        if (searchAccount == null || searchAccount.isEmpty()) {
            return list;
        }

        String sql = "Select a.AccountID, a.Username, a.[Password], s.*, a.[Role], a.CreatedAt \n"
                + "from Account a LEFT JOIN Staff s ON a.StaffID = s.StaffID WHERE a.Role = 'Staff' AND Username LIKE ? ";

        if (sortBy != null) {
            if (sortBy.equals("Username")) {
                sql += " ORDER BY a.Username ";
            } else if (sortBy.equals("CreatedAt")) {
                sql += " ORDER BY DAY(CreatedAt) ";
            } else {
                sql += " ORDER BY " + sortBy;
            }
            if (isDecreasing) {
                sql += " DESC";
            }
        } else {
            sql += " ORDER BY a.AccountID "; // Tránh lỗi nếu `sortBy` null
        }

        sql += " OFFSET ? ROWS FETCH NEXT 5 ROWS ONLY";

        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, "%" + searchAccount + "%");
            stm.setInt(2, (start - 1) * 5);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int accountID = rs.getInt("AccountID");
                String username = rs.getString("Username");
                String password = rs.getString("Password");
                String role = rs.getString("Role");
                Date createdAt = rs.getDate("CreatedAt");

                String StaffID = rs.getString("StaffID");
                String fname = rs.getString("firstName");
                String lname = rs.getString("lastName");
                String pos = rs.getString("position");
                double sal = rs.getDouble("salary");
                Date dob = rs.getDate("dateOfBirth");
                String address = rs.getString("address");
                String city = rs.getString("city");
                String country = rs.getString("country");
                String phone = rs.getString("Phone");
                String email = rs.getString("Email");
                Date hireDate = rs.getDate("hireDate");

                Staff staff = new Staff(StaffID, fname, lname, pos, sal, dob, address, city, country, phone, email, hireDate);

                Account acc = new Account(accountID, username, password, role, createdAt, staff);
                list.add(acc);
            }
        } catch (SQLException ex) {
            Logger.getLogger(StaffDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    //Account guest
    public List<Account> getAllAccountGuest() {
        List<Account> list = new ArrayList<>();
        String sql = """
        SELECT a.AccountID, a.Username, a.[Password], 
               g.GuestID, g.Phone, g.Email,
               a.[Role], a.CreatedAt
        FROM Account a
        LEFT JOIN Guest g ON a.GuestID = g.GuestID
        WHERE a.Role = 'Guest'
    """;

        try (PreparedStatement stm = connection.prepareStatement(sql); ResultSet rs = stm.executeQuery()) {

            while (rs.next()) {
                int accountID = rs.getInt("AccountID");
                String username = rs.getString("Username");
                String password = rs.getString("Password");
                String role = rs.getString("Role");
                Date createdAt = rs.getDate("CreatedAt");

                int guestID = rs.getInt("GuestID");
                String phone = rs.getString("Phone");
                String email = rs.getString("Email");

                Guest guest = new Guest(guestID, phone, email);
                Account acc = new Account(accountID, username, password, role, createdAt, guest);
                list.add(acc);
            }

        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public int countSearchResultsGuest(String keyword) {
        String sql = "SELECT COUNT(*) FROM Account a LEFT JOIN Guest g ON a.GuestID = g.GuestID WHERE a.Role = 'Guest' AND Username LIKE ? ";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            String searchParam = "%" + keyword + "%";
            stm.setString(1, searchParam);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1); // Trả về số lượng bản ghi tìm được
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public int getTotalAccountGuest() {
        String sql = "SELECT COUNT(*) FROM Account a LEFT JOIN Guest g ON a.GuestID = g.GuestID WHERE a.Role = 'Guest' ";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public List<Account> sortAccountGuest(String sortBy, boolean isDecreasing, int start) {
        List<Account> list = new ArrayList<>();
        String sql = "Select a.AccountID, a.Username, a.[Password], g.*, a.[Role], a.CreatedAt \n"
                + "from Account a LEFT JOIN Guest g ON a.GuestID = g.GuestID WHERE a.Role = 'Guest' ";

        if (sortBy != null && !sortBy.isEmpty()) {
            if (sortBy.equals("Username")) {
                sql += " ORDER BY Username ";
            } else if (sortBy.equals("CreatedAt")) {
                sql += " ORDER BY DAY(CreatedAt) ";
            } else {
                sql += " ORDER BY " + sortBy;
            }
            if (isDecreasing) {
                sql += " DESC";
            }
        } else {
            sql += " ORDER BY a.AccountID "; // Tránh lỗi nếu `sortBy` null
        }

        sql += " OFFSET ? ROWS FETCH NEXT 5 ROWS ONLY";

        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, (start - 1) * 5); // Vị trí bắt đầu
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int accountID = rs.getInt("AccountID");
                String username = rs.getString("Username");
                String password = rs.getString("Password");
                String role = rs.getString("Role");
                Date createdAt = rs.getDate("CreatedAt");

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

                Account acc = new Account(accountID, username, password, role, createdAt, staff);
                list.add(acc);
            }
        } catch (SQLException ex) {
            Logger.getLogger(StaffDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Account> searchAccountGuest(String searchAccount, String sortBy, boolean isDecreasing, int start) {
        List<Account> list = new ArrayList<>();
        if (searchAccount == null || searchAccount.isEmpty()) {
            return list;
        }

        String sql = "Select a.AccountID, a.Username, a.[Password], g.*, a.[Role], a.CreatedAt \n"
                + "from Account a LEFT JOIN Guest g ON a.GuestID = g.GuestID WHERE a.Role = 'Guest' AND Username LIKE ? ";

        if (sortBy != null) {
            if (sortBy.equals("Username")) {
                sql += " ORDER BY a.Username ";
            } else if (sortBy.equals("CreatedAt")) {
                sql += " ORDER BY DAY(CreatedAt) ";
            } else {
                sql += " ORDER BY " + sortBy;
            }
            if (isDecreasing) {
                sql += " DESC";
            }
        } else {
            sql += " ORDER BY a.AccountID "; // Tránh lỗi nếu `sortBy` null
        }

        sql += " OFFSET ? ROWS FETCH NEXT 5 ROWS ONLY";

        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, "%" + searchAccount + "%");
            stm.setInt(2, (start - 1) * 5);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int accountID = rs.getInt("AccountID");
                String username = rs.getString("Username");
                String password = rs.getString("Password");
                String role = rs.getString("Role");
                Date createdAt = rs.getDate("CreatedAt");

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

                Account acc = new Account(accountID, username, password, role, createdAt, staff);
                list.add(acc);
            }
        } catch (SQLException ex) {
            Logger.getLogger(StaffDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public void createAccountGuest(String user, String pass, String role, Integer GuestID) {
        String sql = "INSERT INTO Account (Username, Password, Role, StaffID, GuestID)\n"
                + "VALUES \n"
                + "(?, ?, ?, Null, ?)";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, user);
            stm.setString(2, pass);
            stm.setString(3, role);
            if (GuestID != null && GuestID > 0) {
                stm.setInt(4, GuestID);
            } else {
                stm.setNull(4, java.sql.Types.INTEGER);
            }
            stm.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public void updateAccountGuest(int accountID, String user, String pass, String role) {
        String sql = "Update Account SET Username = ?, Password = ?, "
                + " Role = ? WHERE AccountID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, user);
            st.setString(2, pass);
            st.setString(3, role);
            st.setInt(4, accountID);

            st.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public void deleteAccountGuest(int id) {
        String sql = "DELETE FROM Account WHERE AccountID = ? ";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public static void main(String[] args) {
        AccountDAO dao = new AccountDAO();
        List<Account> list = dao.getAllAccount();

        List<Account> listsort = dao.sortAccount("", false, 1);
        List<Account> search = dao.searchAccount("us", null, false, 3);
        List<Account> page = dao.pagingAccount(1);

        int a1 = dao.getTotalAccount();
        System.out.println(a1);

        int b = dao.countSearchResults("st");
        System.out.println(b);

        for (Account a : listsort) {
            System.out.println(a);
        }
    }
}
