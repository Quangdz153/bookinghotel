/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author Admin
 */
public class UpdateRoom extends HttpServlet {

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
            String roomTypeID_raw = request.getParameter("updateroomtype");
            String roomID = request.getParameter("roomID");
            String updateimg1 = request.getParameter("updateimg1");
            String updateimg2 = request.getParameter("updateimg2");
            String updateimg3 = request.getParameter("updateimg3");
            String updateimg4 = request.getParameter("updateimg4");

//            out.println(updateimg1+"\n"+updateimg2+"\n"+updateimg3+"\n"+updateimg4+"\n" );
            int roomTypeID = 0;
            try {
                roomTypeID = Integer.parseInt(roomTypeID_raw);
            } catch (NumberFormatException e) {
                System.out.println(e);
            }

            List<Integer> listImageID = new DAO.RoomImageDAO().getFirstImageIDByRoomID(roomID);

            switch (listImageID.size()) {
                case 4 -> {
                    if (updateimg1 != null) {
                        new DAO.RoomImageDAO().updateRoomImage(listImageID.get(0), updateimg1, "Room Luxury");
                    }
                    if (updateimg2 != null) {
                        new DAO.RoomImageDAO().updateRoomImage(listImageID.get(1), updateimg2, "Room Luxury");
                    }
                    if (updateimg3 != null) {
                        new DAO.RoomImageDAO().updateRoomImage(listImageID.get(2), updateimg3, "Room Luxury");
                    }
                    if (updateimg4 != null) {
                        new DAO.RoomImageDAO().updateRoomImage(listImageID.get(3), updateimg4, "Room Luxury");
                    }
                }
                case 3 -> {
                    if (updateimg1 != null) {
                        new DAO.RoomImageDAO().updateRoomImage(listImageID.get(0), updateimg1, "Room Luxury");
                    }
                    if (updateimg2 != null) {
                        new DAO.RoomImageDAO().updateRoomImage(listImageID.get(1), updateimg2, "Room Luxury");
                    }
                    if (updateimg3 != null) {
                        new DAO.RoomImageDAO().updateRoomImage(listImageID.get(2), updateimg3, "Room Luxury");
                    }
                    if (updateimg4 != null) {
                        new DAO.RoomImageDAO().addNewImgRoom(roomID, updateimg4, "Room Luxury");
                    }
                }
                case 2 -> {
                    if (updateimg1 != null) {
                        new DAO.RoomImageDAO().updateRoomImage(listImageID.get(0), updateimg1, "Room Luxury");
                    }
                    if (updateimg2 != null) {
                        new DAO.RoomImageDAO().updateRoomImage(listImageID.get(1), updateimg2, "Room Luxury");
                    }
                    if (updateimg3 != null) {
                        new DAO.RoomImageDAO().addNewImgRoom(roomID, updateimg3, "Room Luxury");
                    }
                    if (updateimg4 != null) {
                        new DAO.RoomImageDAO().addNewImgRoom(roomID, updateimg4, "Room Luxury");
                    }
                }
                case 1 -> {
                    if (updateimg1 != null) {
                        new DAO.RoomImageDAO().updateRoomImage(listImageID.get(0), updateimg1, "Room Luxury");
                    }
                    if (updateimg2 != null) {
                        new DAO.RoomImageDAO().addNewImgRoom(roomID, updateimg2, "Room Luxury");
                    }
                    if (updateimg3 != null) {
                        new DAO.RoomImageDAO().addNewImgRoom(roomID, updateimg3, "Room Luxury");
                    }
                    if (updateimg4 != null) {
                        new DAO.RoomImageDAO().addNewImgRoom(roomID, updateimg4, "Room Luxury");
                    }
                }case 0 -> {
                    if (updateimg1 != null) {
                        new DAO.RoomImageDAO().addNewImgRoom(roomID, updateimg1, "Room Luxury");
                    }
                    if (updateimg2 != null) {
                        new DAO.RoomImageDAO().addNewImgRoom(roomID, updateimg2, "Room Luxury");
                    }
                    if (updateimg3 != null) {
                        new DAO.RoomImageDAO().addNewImgRoom(roomID, updateimg3, "Room Luxury");
                    }
                    if (updateimg4 != null) {
                        new DAO.RoomImageDAO().addNewImgRoom(roomID, updateimg4, "Room Luxury");
                    }
                }
                default -> {
                }
            }

            new DAO.RoomDAO().updateRoom(roomID, roomTypeID);
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
