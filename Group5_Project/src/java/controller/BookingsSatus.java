/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.BookingDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author ASUS
 */
public class BookingsSatus extends HttpServlet {

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
            out.println("<title>Servlet BookingsSatus</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BookingsSatus at " + request.getContextPath() + "</h1>");
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
        String statusbook = request.getParameter("statusbook");
        int bookingID = Integer.parseInt(request.getParameter("bookingID"));

        BookingDAO dao = new BookingDAO();

        int newStatus = 0;
        String roomStatus = "";

        if ("reserved-2".equals(statusbook)) {
            newStatus = 3;
            roomStatus = "Occupied";
            request.setAttribute("successMessage", "Check-In successfully!");
        } else if ("occupied-3".equals(statusbook)) {
            newStatus = 4;
            roomStatus = "Cleaning";
            request.setAttribute("successMessage", "Check-Out successfully!");
        } else if ("cleaning-4".equals(statusbook)) {
            newStatus = 1;
            roomStatus = "Available";
            request.setAttribute("successMessage", "Cleaning complete! Room available");
        } else if("cancel-5".equals(statusbook)){
            newStatus = 5;
            roomStatus = "Available";
            request.setAttribute("successMessage", "Cancel booking successFully ");
        }

        boolean bookingUpdate = dao.updateBookingStatus(bookingID, newStatus);
        boolean roomUpdate = dao.updateRoomStatus(bookingID, roomStatus);

        if (bookingUpdate && roomUpdate) {
            request.getRequestDispatcher("booking").forward(request, response);
        } else {
            System.out.println("error update");
        }
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
