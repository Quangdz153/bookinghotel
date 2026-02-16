/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.BookingDAO;
import DAO.GuestDAO;
import DAO.PaymentDAO;
import entity.Account;
import entity.Booking;
import entity.Guest;
import entity.Payment;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author ASUS
 */
public class HistoryBookingGuest extends HttpServlet {

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
            out.println("<title>Servlet HistoryBookingGuest</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HistoryBookingGuest at " + request.getContextPath() + "</h1>");
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
        BookingDAO dao = new BookingDAO();
        GuestDAO dao1 = new GuestDAO();
        PaymentDAO dao2 = new PaymentDAO();

        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("acc");

        String AccountID = request.getParameter("AccountID");

        Guest guestAccount = null;
        if (acc != null) {
            guestAccount = dao1.getGuestByAccountID(acc.getAccountID());
        } else {
            guestAccount = new Guest();
        }

        List<Booking> bookingByGuestID = dao.getAllBookingbyGuestID(guestAccount.getGuestID());
        List<Payment> paymentByGuestID = dao2.getAllPaymentByGuestID(guestAccount.getGuestID());

        System.out.println(bookingByGuestID);
        session.setAttribute("acc", acc);
        request.setAttribute("guestBookingList", bookingByGuestID);
        request.setAttribute("guestPaymentList", paymentByGuestID);
        request.setAttribute("AccountID", AccountID);
        request.setAttribute("guestAccount", guestAccount);

        request.setAttribute("successMessage", "Pay successfully!");
        request.getRequestDispatcher("elements.jsp").forward(request, response);
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
        doGet(request, response);
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
