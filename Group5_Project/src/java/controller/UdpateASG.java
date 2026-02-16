/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.AccountDAO;
import DAO.BookingDAO;
import DAO.GuestDAO;
import DAO.StaffDAO;
import entity.Guest;
import entity.Staff;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ASUS
 */
public class UdpateASG extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UdpateASG</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UdpateASG at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        String user = request.getParameter("user");
//        String pass = request.getParameter("pass");
//
//        AccountDAO d = new AccountDAO();
//        HttpSession sesson = request.getSession();
//        Account a = d.login(user, pass);
//
//        sesson.setAttribute("acc", a);
//        response.sendRedirect("staffCRUD.jsp");

        doPost(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String update = request.getParameter("update");

        if ("updateStaff".equals(update)) {
            updateStaff(request, response);
        } else if ("updateAccount".equals(update)) {
            updateAccountStaff(request, response);
        } else if ("updateGuest".equals(update)) {
            updateGuest(request, response);
        } else if ("updateAccountGuest".equals(update)) {
            updateAccountGuest(request, response);
        } else if ("updateBooking".equals(update)) {
            updateBooking(request, response);
        }
    }

    private void updateBooking(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fname = request.getParameter("fnameud");
        String lname = request.getParameter("lnameud");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");

        int bookingID = Integer.parseInt(request.getParameter("bookingID"));
        String roomID = request.getParameter("bookingIDud");
        Date checkinDate = Date.valueOf(request.getParameter("checkinDate"));
        Date checkoutDate = Date.valueOf(request.getParameter("checkoutDate"));
        BigDecimal totalPrice = new BigDecimal(request.getParameter("TotalPrice"));

        boolean valid = true;
        String checkoutError = "";

        BookingDAO dao = new BookingDAO();

        if (checkoutDate.before(checkinDate) || checkoutDate.equals(checkinDate)) {
            checkoutError = "Checkout date must be after check-in date!";
            valid = false;
        }
        request.setAttribute("checkoutError", checkoutError);

//        if (valid) {
        boolean isUpdated = dao.updateBooking(bookingID, roomID, checkinDate, checkoutDate, totalPrice, fname, lname, phone, email);
        if (isUpdated) {
            request.getRequestDispatcher("booking").forward(request, response);
        } else {
            System.out.println("Update: " + isUpdated);
        }
//        }
    }

    private void updateAccountGuest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String AccountID_raw = request.getParameter("AccountID");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String GuestID_raw = request.getParameter("GuestID");

        boolean valid = true;
        String userError = "";

        int AccountID = 0;
        int GuestID = 0;

        AccountDAO accDao = new AccountDAO();
        GuestDAO guestDao = new GuestDAO();
        StaffDAO staffDao = new StaffDAO();

        try {
            AccountID = Integer.parseInt(AccountID_raw);
            GuestID = Integer.parseInt(GuestID_raw);

            // Kiểm tra username trùng
            if (accDao.checkExitsAccountUd(username, AccountID) != null) {
                userError = "User existed!";
                valid = false;
            }

            if (valid) {
                // Nếu đổi sang Staff thì chuyển dữ liệu
                if (role.equals("Staff")) {
                    // 1️⃣ Lấy dữ liệu guest cũ
                    Guest g = guestDao.getGuestById(GuestID);

                    // 2️⃣ Thêm mới staff (copy thông tin từ guest)
                    String newStaffID = staffDao.insertStaffFromGuest(g);

                    // 3️⃣ Cập nhật account
                    accDao.updateAccountToStaff(AccountID, username, password, "Staff", newStaffID);

                    // 4️⃣ Xóa guest cũ
                    guestDao.deleteGuest(GuestID);
                } else {
                    // Nếu vẫn là Guest thì chỉ update bình thường
                    accDao.updateAccountGuest(AccountID, username, password, role);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("userUdError", userError);
        request.getRequestDispatcher("accountguest").forward(request, response);
    }

    public void updateGuest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String guestID = request.getParameter("guestIDud");
        String fname = request.getParameter("fnameud");
        String lname = request.getParameter("lnameud");
        String dob = request.getParameter("dobud");
        String add = request.getParameter("addud");
        String city = request.getParameter("cityud");
        String country = request.getParameter("countryud");
        String phone = request.getParameter("phoneud");
        String email = request.getParameter("emailud");

        boolean valid = true;
        String phoneudError = "";
        String emailudError = "";

        GuestDAO d = new GuestDAO();

        int id = 0;
        try {
            if (guestID != null && !guestID.isEmpty()) {
                id = Integer.parseInt(guestID);
            }
            if (d.getGuestByPhone(phone, id) != null) {
                phoneudError = "Phone Exited!!!";
                valid = false;
            } else if (d.getGuestByEmail(email, id) != null) {
                emailudError = "Email Exited!!!";
                valid = false;
            }

            SimpleDateFormat sjdate = new SimpleDateFormat("yyyy-MM-dd");

            java.util.Date javaDob = sjdate.parse(dob);

            java.sql.Date sqlDob = new Date(javaDob.getTime());

            if (valid && guestID != null && !guestID.isEmpty()) {
                Guest gs = new Guest(id, fname, lname, sqlDob, add, city, country, phone, email);
                new DAO.GuestDAO().update(gs);
            }
        } catch (NumberFormatException e) {
            System.out.println(e);
        } catch (ParseException ex) {
            Logger.getLogger(UdpateASG.class.getName()).log(Level.SEVERE, null, ex);
        }

        request.setAttribute("phoneudError", phoneudError);
        request.setAttribute("emailudError", emailudError);
        request.getRequestDispatcher("guest").forward(request, response);
    }

    private void updateAccountStaff(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String AccountID_raw = request.getParameter("AccountID");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String StaffID = request.getParameter("StaffID"); // 🔹 StaffID là String

        boolean valid = true;
        String userError = "";
        int AccountID = 0;

        AccountDAO accDao = new AccountDAO();
        GuestDAO guestDao = new GuestDAO();
        StaffDAO staffDao = new StaffDAO();

        try {
            AccountID = Integer.parseInt(AccountID_raw);

            // Kiểm tra username trùng
            if (accDao.checkExitsAccountUd(username, AccountID) != null) {
                userError = "Username already exists!";
                valid = false;
            }

            if (valid) {
                // Nếu đổi sang Guest thì chuyển dữ liệu
                if (role.equals("Guest")) {
                    // 1️⃣ Lấy dữ liệu staff cũ
                    Staff s = staffDao.getStaffById(StaffID);

                    // 2️⃣ Tạo mới Guest (copy dữ liệu staff)
                    int newGuestID = guestDao.insertGuestFromStaff(s);

                    // 3️⃣ Cập nhật Account sang Guest
                    accDao.updateAccountToGuest(AccountID, username, password, "Guest", newGuestID);

                    // 4️⃣ Xóa staff cũ
                    staffDao.deleteStaff(StaffID);
                } else {
                    // Nếu vẫn là Staff thì chỉ update thông tin account
                    accDao.updateAccountStaff(AccountID, username, password, role);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("userUdError", userError);
        request.getRequestDispatcher("accountstaff").forward(request, response);
    }

    private void updateStaff(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String staffID = request.getParameter("staffID");
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String position = request.getParameter("position");
        String salary_raw = request.getParameter("salary");
        String dob = request.getParameter("dob");
        String add = request.getParameter("add");
        String city = request.getParameter("city");
        String country = request.getParameter("country");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String hiredate = request.getParameter("hiredate");

        String index = request.getParameter("index");

        boolean valid = true;
        String phoneudError = "";
        String emailudError = "";

        StaffDAO d = new StaffDAO();
        if (d.getStaffByPhone(phone, staffID) != null) {
            phoneudError = "Phone Exited!!!";
            valid = false;
        } else if (d.getStaffByEmail(email, staffID) != null) {
            emailudError = "Email Exited!!!";
            valid = false;
        }

        double salary = 0;
        try {
            salary = Double.parseDouble(salary_raw);

            SimpleDateFormat sjdate = new SimpleDateFormat("yyyy-MM-dd");

            java.util.Date javaDob = sjdate.parse(dob);
            java.util.Date javahiredate = sjdate.parse(hiredate);

            java.sql.Date sqlDob = new Date(javaDob.getTime());
            java.sql.Date sqlhiredate = new Date(javahiredate.getTime());

            if (valid && staffID != null && !staffID.isEmpty()) {
                Staff sf = new Staff(staffID, fname, lname, position, salary, sqlDob, add, city, country, phone, email, sqlhiredate);
                new DAO.StaffDAO().update(sf);
            }
        } catch (NumberFormatException e) {
            System.out.println(e);
        } catch (ParseException ex) {
            Logger.getLogger(UdpateASG.class.getName()).log(Level.SEVERE, null, ex);
        }

//        Staff list = new DAO.StaffDAO().getStaffById(staffID);
//        
//        String indexPage = request.getParameter("index");
//        if (indexPage == null) {
//            indexPage = "1";
//        }
//        int index = 0;
//        try {
//            index = Integer.parseInt(indexPage);
//        } catch (NumberFormatException e) {
//            System.out.println(e);
//        }
//        
//        List<Staff> listPage = new DAO.StaffDAO().pagingStaff(index);
//
//        request.setAttribute("staffID", staffID);
//        request.setAttribute("list", list);
//        request.setAttribute("listPage", listPage);
        request.setAttribute("phoneudError", phoneudError);
        request.setAttribute("emailudError", emailudError);
        request.getRequestDispatcher("staff?index=" + (index != null ? index : "1")).forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
