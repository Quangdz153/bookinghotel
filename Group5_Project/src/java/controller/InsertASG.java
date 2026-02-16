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
public class InsertASG extends HttpServlet {

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
            out.println("<title>Servlet InsertASG</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet InsertASG at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
        String insert = request.getParameter("insert");

        if ("insertStaff".equals(insert)) {
            insertSatff(request, response);
        } else if ("insertAccount".equals(insert)) {
            insertAccount(request, response);
        } else if ("insertGuest".equals(insert)) {
            insertGuest(request, response);
        } else if ("insertAccountGuest".equals(insert)) {
            insertAccountGuest(request, response);
        } else if ("insertBooking".equals(insert)) {
            insertBooking(request, response);
        }
    }

    private void insertBooking(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String firstName = request.getParameter("fname");
        String lastName = request.getParameter("lname");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");

        // Lấy danh sách RoomID từ form (dạng mảng)
        String roomIDs = request.getParameter("roomIDs");

        String[] selectedRooms = roomIDs.split(", ");

        Date checkinDate = Date.valueOf(request.getParameter("checkinDate"));
        Date checkoutDate = Date.valueOf(request.getParameter("checkoutDate"));
        BigDecimal totalPrice = new BigDecimal(request.getParameter("TotalPrice"));
        int status = 1; // Mặc định: Booking mới

        if (!checkoutDate.after(checkinDate)) {
            request.setAttribute("errorMessage", "Check-out date must be later than check-in date.");
            request.getRequestDispatcher("booking").forward(request, response);
            return;
        }

        if (selectedRooms.length == 0) {
            request.setAttribute("errorMessage", "Please select at least one room.");
            request.getRequestDispatcher("booking").forward(request, response);
            return;
        }

        BookingDAO bookingDAO = new BookingDAO();
        request.setAttribute("successMessage", "Creted booking successfully.");
        bookingDAO.createBookingIfGuestNotExist(firstName, lastName, phone, email,
                selectedRooms, checkinDate, checkoutDate, totalPrice);
        request.getRequestDispatcher("booking").forward(request, response);
    }

    private void insertAccountGuest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String guestID = request.getParameter("guestID");

        boolean valid = true;
        String userError = "";
        String staffIDError = "";

        AccountDAO dao = new AccountDAO();
        int id = 0;
        if (guestID != null && !guestID.isEmpty()) {
            try {
                id = Integer.parseInt(guestID);
            } catch (NumberFormatException e) {
                System.out.println(e);
            }
        }

        if (dao.checkExitsAccount(username) != null) {
            userError = "User exited";
            valid = false;
        }
//        else if (id < 0 || "Choose".equals(guestID)) {
//            staffIDError = "No guestID selected";
//            valid = false;
//        }

        if (valid) {
            dao.createAccountGuest(username, password, role, id);
        }

        request.setAttribute("userError", userError);
        request.setAttribute("staffIDError", staffIDError);

        request.setAttribute("username", username);
        request.setAttribute("password", password);
        request.setAttribute("role", role);
        request.setAttribute("guestID", guestID);

        request.getRequestDispatcher("accountguest").forward(request, response);
    }

    private void insertGuest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        String guestID = request.getParameter("guestID");
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String dob = request.getParameter("dob");
        String add = request.getParameter("add");
        String city = request.getParameter("city");
        String country = request.getParameter("country");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");

        boolean valid = true;
        String phoneError = "";
        String emailError = "";

        GuestDAO d = new GuestDAO();
        if (d.getGuestByPhone(phone, null) != null) {
            phoneError = "Phone Exited!!!";
            valid = false;
        } else if (d.getGuestByEmail(email, null) != null) {
            emailError = "Email Exited!!!";
            valid = false;
        }

//        int id = 0;
        try {
//            if (guestID != null && !guestID.isEmpty()) {
//                id = Integer.parseInt(guestID);
//            }

            SimpleDateFormat sjdate = new SimpleDateFormat("yyyy-MM-dd");

            java.util.Date javaDob = sjdate.parse(dob);

            java.sql.Date sqlDob = new Date(javaDob.getTime());

            if (valid) {
                Guest gs = new Guest(fname, lname, sqlDob, add, city, country, phone, email);
                new DAO.GuestDAO().addNewGuest(gs);
                System.out.println("add success");
            } else {
                System.out.println("add false");
                if (!valid) {
                    System.out.println(phoneError);
                }
            }
        } catch (NumberFormatException e) {
            System.out.println(e);
        } catch (ParseException ex) {
            Logger.getLogger(InsertASG.class.getName()).log(Level.SEVERE, null, ex);
        }

        request.setAttribute("fname", fname);
        request.setAttribute("lname", lname);
        request.setAttribute("dob", dob);
        request.setAttribute("add", add);
        request.setAttribute("city", city);
        request.setAttribute("country", country);
        request.setAttribute("phone", phone);
        request.setAttribute("email", email);
        request.setAttribute("phoneError", phoneError);
        request.setAttribute("emailError", emailError);

        request.getRequestDispatcher("guest").forward(request, response);
    }

    private void insertAccount(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String staffID = request.getParameter("staffID");

        boolean valid = true;
        String userError = "";
        String staffIDError = "";

        AccountDAO dao = new AccountDAO();

        if (dao.checkExitsAccount(username) != null) {
            userError = "User exited";
            valid = false;
        } else if (staffID == null || staffID.trim().isEmpty() || "Choose".equals(staffID)) {
            staffIDError = "No staffID selected";
            valid = false;
        }

        if (valid) {
            dao.createAccountStaff(username, password, role, staffID);
        }

        request.setAttribute("userError", userError);
        request.setAttribute("staffIDError", staffIDError);

        request.setAttribute("username", username);
        request.setAttribute("password", password);
        request.setAttribute("role", role);
        request.setAttribute("staffID", staffID);

        request.getRequestDispatcher("accountstaff").forward(request, response);
    }

    private void insertSatff(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String staffid = request.getParameter("staffid");
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

        boolean valid = true;
        String staffidError = "";
        String phoneError = "";
        String emailError = "";

        StaffDAO d = new StaffDAO();
        if (d.getStaffById(staffid) != null) {
            staffidError = "StaffID Exited!!!";
            valid = false;
        } else if (d.getStaffByPhone(phone, null) != null) {
            phoneError = "Phone Exited!!!";
            valid = false;
        } else if (d.getStaffByEmail(email, null) != null) {
            emailError = "Email Exited!!!";
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

            if (valid && staffid != null && !staffid.isEmpty()) {
                Staff sf = new Staff(staffid, fname, lname, position, salary, sqlDob, add, city, country, phone, email, sqlhiredate);
                new DAO.StaffDAO().addNewStaff(sf);
                System.out.println("add success");
                System.out.println(staffid);
                System.out.println(lname);
                System.out.println("getid: : " + d.getStaffById(staffid));
            } else {
                System.out.println("add false");
                System.out.println(staffid);
                if (!valid) {
                    System.out.println(phoneError);
                }
                System.out.println("getid false : " + d.getStaffById(staffid));
            }
        } catch (NumberFormatException e) {
            System.out.println(e);
        } catch (ParseException ex) {
            Logger.getLogger(InsertASG.class.getName()).log(Level.SEVERE, null, ex);
        }

        request.setAttribute("staffid", staffid);
        request.setAttribute("fname", fname);
        request.setAttribute("lname", lname);
        request.setAttribute("position", position);
        request.setAttribute("salary", salary);
        request.setAttribute("dob", dob);
        request.setAttribute("add", add);
        request.setAttribute("city", city);
        request.setAttribute("country", country);
        request.setAttribute("phone", phone);
        request.setAttribute("email", email);
        request.setAttribute("hiredate", hiredate);
        request.setAttribute("staffidError", staffidError);
        request.setAttribute("phoneError", phoneError);
        request.setAttribute("emailError", emailError);

        request.getRequestDispatcher("staff").forward(request, response);
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
