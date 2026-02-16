/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Room;
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
 * @author Admin
 */
public class SearchToHome extends HttpServlet {

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
            String getInTime = request.getParameter("checkInDate");
            String getOutTime = request.getParameter("checkOutDate");
            String numAdult_raw = request.getParameter("Adult");
            
            

            request.setAttribute("roomType", new DAO.RoomTypeDAO().getListType());
            request.setAttribute("getInTime", getInTime);
            request.setAttribute("getOutTime", getOutTime);
            List<Room> listRoom = new ArrayList<>();
            try {

//                int numChild = Integer.parseInt(numChild_raw);
//                int numAdult = Integer.parseInt(numAdult_raw);
                if (getInTime == null && getOutTime == null) {
                    listRoom = new DAO.RoomDAO().getAllRoom();  
                } else {
                    listRoom = new DAO.RoomDAO().getRoomByTime(getInTime, getOutTime);
                }

                request.setAttribute("listRoom", listRoom);
                request.setAttribute("lasttype", new DAO.RoomTypeDAO().getLastTypeID());

            } catch (NumberFormatException e) {
                System.out.println(e);
            }
            request.getRequestDispatcher("accomodation.jsp").forward(request, response);
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
