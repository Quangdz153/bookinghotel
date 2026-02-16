/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.BookingDAO;
import DAO.PaymentDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;

/**
 *
 * @author ASUS
 */
public class PaymentServlet extends HttpServlet {

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
            out.println("<title>Servlet PaymentServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PaymentServlet at " + request.getContextPath() + "</h1>");
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

        String bookingID_raw = request.getParameter("paymentID");
        String paymentMethod = request.getParameter("paymentMethod");
        String amount_raw = request.getParameter("amount");
        String statusbook = request.getParameter("statusbook");

        PaymentDAO dao = new PaymentDAO();

        int bookingID = 0;

        try {
            bookingID = Integer.parseInt(bookingID_raw);
        } catch (NumberFormatException e) {
            System.out.println(e);
        }

        BigDecimal totalPrice = (amount_raw != null && !amount_raw.isEmpty()) ? new BigDecimal(amount_raw) : BigDecimal.ZERO;

        BookingDAO dao1 = new BookingDAO();

        int newStatus = 0;
        String roomStatus = "";

//        boolean paymentSuccess = dao.addPayment(bookingID, totalPrice, paymentMethod);
        boolean paymentSuccess = dao.insertPayment(bookingID, paymentMethod);

//        Booking b = dao1.getPaymentByBookingID(bookingID);
//        request.setAttribute("bs", b);
        if (paymentSuccess) {
            newStatus = 3;
            roomStatus = "Occupied";
        }
        if("cancel-5".equals(statusbook)){
            newStatus = 5;
            roomStatus = "Available";
            request.setAttribute("successMessage", "Cancel booking successFully ");
        }

//        if (newStatus != 0 && !roomStatus.isEmpty()) {
        boolean bookingUpdate = dao1.updateBookingStatus(bookingID, newStatus);
        boolean roomUpdate = dao1.updateRoomStatus(bookingID, roomStatus);

        if (bookingUpdate && roomUpdate) {
            request.getSession().setAttribute("successMessage", "Pay successfully!");
            response.sendRedirect("historybookingguest");
//            request.getRequestDispatcher("historybookingguest").forward(request, response);
        } 
//        }

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
