/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.AccountDAO;
import DAO.StaffDAO;
import entity.Account;
import entity.Staff;
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
public class AccountStaff extends HttpServlet {

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
            out.println("<title>Servlet AccountStaff</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AccountStaff at " + request.getContextPath() + "</h1>");
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
        AccountDAO dao = new AccountDAO();
        StaffDAO dao1 = new StaffDAO();

        List<Account> listAccount = dao.getAllAccount();

        String sortby = request.getParameter("sortby");
        String orderSort = request.getParameter("orderSort");
        String index_raw = request.getParameter("index");

        String searchAccount = request.getParameter("searchAccount");

        String AccountID = request.getParameter("AccountID");
        String acID = request.getParameter("acID");
        
        int id = 0;
        
        try {
            id = Integer.parseInt(AccountID);
        } catch (NumberFormatException e) {
            System.out.println(e);
        }

        if (sortby == null || sortby.isEmpty() || sortby.equals("default")) {
            sortby = " AccountID ";
        }
        if (orderSort == null || orderSort.isEmpty() || orderSort.equals("default")) {
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

        List<Account> list = new ArrayList<>();
//        List<Staff> sortedList = null;

        if (searchAccount != null && !searchAccount.isEmpty()) {
            list = dao.searchAccount(searchAccount, sortby, isDescending, index);
            count = dao.countSearchResults(searchAccount);
            System.out.println("list: " + list);
            System.out.println("search count: " + count);
            System.out.println("Success: " + list.size() + "..." + searchAccount);
        } else {
            list = dao.sortAccount(sortby, isDescending, index);
            count = dao.getTotalAccount();
            System.out.println("listElse: " + list);
            System.out.println(count);
            System.out.println(false);
        }

//        count = dao.getTotalAccount();
//        list = dao.pagingAccount(index);
        int endPage = count / 5;
        if (count % 5 != 0) {
            endPage++;
        }

//        Staff staffs = dao.getStaffById(staffID);
        Staff staffAccount = dao1.getStaffByAccountID(id);
        List<Staff> liststaffNotAcc = dao1.getAllStaffNotAccount();

        request.setAttribute("AccountID", AccountID);
        request.setAttribute("searchAccount", searchAccount);

        request.setAttribute("listPageAcc", list);
        request.setAttribute("listAccount", listAccount);
        
        request.setAttribute("liststaffNotAcc", liststaffNotAcc);
        
        request.setAttribute("sortby", sortby);
        request.setAttribute("orderSort", orderSort);
        request.setAttribute("endPage", endPage);
        request.setAttribute("tag", index);
        request.setAttribute("count", count);
        request.setAttribute("acID", acID);

//        request.setAttribute("staffs", staffs);
        request.setAttribute("staffAccount", staffAccount);
        request.getRequestDispatcher("accountStaffCRUD.jsp").forward(request, response);
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
