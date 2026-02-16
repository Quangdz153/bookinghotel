/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import DAO.GuestDAO;
import entity.Guest;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ASUS
 */
public class GuestServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet GuestServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet GuestServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        GuestDAO dao = new GuestDAO();

        List<Guest> listGuest = dao.getAllGuest();

        String sortby = request.getParameter("sortby");
        String orderSort = request.getParameter("orderSort");
        String index_raw = request.getParameter("index");

        String searchGuest = request.getParameter("searchGuest");

        String guestID = request.getParameter("guestID");
//        String acID = request.getParameter("acID");

        if (sortby == null || sortby.equals("default")) {
            sortby = "guestID";
        }
        if (orderSort == null || orderSort.equals("default")) {
            orderSort = "asc";
        }

        boolean isDescending = "desc".equals(orderSort);
        int count;

        int index = 1;
        if (index_raw != null) {
            try {
                index = Integer.parseInt(index_raw);
            } catch (NumberFormatException e) {
                System.out.println(e);
            }
        }

        List<Guest> list = new ArrayList<>();

        if (searchGuest != null && !searchGuest.isEmpty()) {
            list = dao.searchGuest(searchGuest, sortby, isDescending, index);
            count = dao.countSearchResults(searchGuest);
            System.out.println("search count: " + count);
            System.out.println("Success: " + list.size() + "..." + searchGuest);
        } else {
//            list = dao.getAllStaff();
            list = dao.sortGuest(sortby, isDescending, index);
            count = dao.getTotalGuest();
            System.out.println(count);
            System.out.println(false);
        }

        int endPage = count / 5;
        if (count % 5 != 0) {
            endPage++;
        }

//        Staff staffs = dao.getStaffById(staffID);
//        Guest staffAccount = dao.getStaffByAccountID(acID);

        request.setAttribute("guestID", guestID);
        request.setAttribute("searchGuest", searchGuest);

        request.setAttribute("listGuestSS", list);
        request.setAttribute("listGuest", listGuest);
        request.setAttribute("sortby", sortby);
        request.setAttribute("orderSort", orderSort);
        request.setAttribute("endPage", endPage);
        request.setAttribute("tag", index);
        request.setAttribute("count", count);

        request.getRequestDispatcher("guestCRUD.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
