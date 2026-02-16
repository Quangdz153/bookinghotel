/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.BookingDAO;
import DAO.GuestDAO;
import DAO.RoomDAO;
import entity.Account;
import entity.Guest;
import entity.Room;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ASUS
 */
public class BookingGuestServlet extends HttpServlet {

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
            out.println("<title>Servlet BookingGuestServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BookingGuestServlet at " + request.getContextPath() + "</h1>");
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
        try {
            String firstName = request.getParameter("fname");
            String lastName = request.getParameter("lname");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String checkinStr = request.getParameter("checkinDate");
            String checkoutStr = request.getParameter("checkoutDate");
            String totalPriceStr = request.getParameter("totalPrice");
            String roomIDs = request.getParameter("roomIDs");

            RoomDAO r = new RoomDAO();
            GuestDAO dao1 = new GuestDAO();
            BookingDAO bookingDAO = new BookingDAO();
            List<Room> availableRoomList = r.getAllRoomAvailable();

            HttpSession session = request.getSession();
            Account acc = (Account) session.getAttribute("acc");

            Guest guestAccount = null;
            if (acc != null) {
                guestAccount = dao1.getGuestByAccountID(acc.getAccountID());
            } else {
                guestAccount = new Guest();
                guestAccount.setFirstName("");
                guestAccount.setLastName("");
                guestAccount.setPhone("");
                guestAccount.setEmail("");
            }

            session.setAttribute("acc", acc);
            request.setAttribute("guestAccount", guestAccount);

            if (checkinStr == null || checkinStr.isEmpty() || checkoutStr == null || checkoutStr.isEmpty()) {

                availableRoomList = r.getAllRoomAvailable();
                request.setAttribute("availableRoomList", availableRoomList);

                request.getRequestDispatcher("booking-dep.jsp").forward(request, response);
                return;
            }

            SimpleDateFormat spd = new SimpleDateFormat("yyyy-MM-dd");

            java.util.Date javaCheckinDate = spd.parse(checkinStr);
            java.util.Date javaCheckoutDate = spd.parse(checkoutStr);

            java.sql.Date checkinDate = new Date(javaCheckinDate.getTime());
            java.sql.Date checkoutDate = new Date(javaCheckoutDate.getTime());

            BigDecimal totalPrice = (totalPriceStr != null && !totalPriceStr.isEmpty()) ? new BigDecimal(totalPriceStr) : BigDecimal.ZERO;

            String[] selectedRooms = (roomIDs != null && !roomIDs.isEmpty()) ? roomIDs.split(", ") : new String[0];

            if (selectedRooms.length == 0) {
                request.setAttribute("errorMessage", "Please select at least one room.");

                availableRoomList = r.getAllRoomAvailable();
                request.setAttribute("availableRoomList", availableRoomList);

                forwardRequest(request, response);
                return;
            }

            if (!checkoutDate.after(checkinDate)) {
                request.setAttribute("errorMessage", "Check-out date must be later than check-in date.");
                availableRoomList = r.getAllRoomAvailable();
                request.setAttribute("availableRoomList", availableRoomList);

                forwardRequest(request, response);
                return;
            }

//            request.setAttribute("fname", firstName);
//            request.setAttribute("lname", lastName);
//            request.setAttribute("phone", phone);
//            request.setAttribute("email", email);
//            request.setAttribute("checkinDate", checkinDate);
//            request.setAttribute("checkoutDate", checkoutDate);
//            request.setAttribute("totalPrice", totalPrice);
            request.setAttribute("availableRoomList", availableRoomList);

            bookingDAO.createBookingIfGuestNotExist(firstName, lastName, phone, email,
                    selectedRooms, checkinDate, checkoutDate, totalPrice);

            request.setAttribute("successMessage", "Booking successful! Thank you for your reservation.");
            forwardRequest(request, response);
//            response.sendRedirect("bookingguest");
//            request.getRequestDispatcher("booking-dep.jsp").forward(request, response);
        } catch (ParseException e) {
            Logger.getLogger(BookingGuestServlet.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    private void forwardRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("booking-dep.jsp").forward(request, response);
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
        processRequest(request, response);
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
