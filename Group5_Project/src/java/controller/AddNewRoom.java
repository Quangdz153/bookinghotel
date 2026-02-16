/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Room;
import entity.RoomImages;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
public class AddNewRoom extends HttpServlet {

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
            String roomID = request.getParameter("addroomid");
            String roomType_raw = request.getParameter("addroomtype");
            String status = request.getParameter("selectstatus");
            String img1 = request.getParameter("img1");
            String img2 = request.getParameter("img2");
            String img3 = request.getParameter("img3");
            String img4 = request.getParameter("img4");
            String description = request.getParameter("description");

            int roomType = 0;
            try {
                roomType = Integer.parseInt(roomType_raw);
            } catch (NumberFormatException e) {
                System.out.println(e);
            }
            boolean check = new DAO.RoomDAO().addNewRoom(new Room(roomID, "H001", roomType, status));
            if (img1 != null) {
                new DAO.RoomImageDAO().addNewImgRoom(roomID, img1, description);
            }
            if (img2 != null) {
                new DAO.RoomImageDAO().addNewImgRoom(roomID, img2, description);
            }
            if (img3 != null) {
                new DAO.RoomImageDAO().addNewImgRoom(roomID, img3, description);
            }
            if (img4 != null) {
                new DAO.RoomImageDAO().addNewImgRoom(roomID, img4, description);
            }

            if (check && img1 == null && img2 == null && img3 == null && img4 == null) {
                new DAO.RoomImageDAO().addNewImgRoom(roomID, new DAO.RoomTypeDAO().getRoomTypeByTypeID(roomType).getImageURL(), description);

            }
            response.sendRedirect("searchtohome");
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
