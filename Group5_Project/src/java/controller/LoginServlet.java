/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.AccountDAO;
import DAO.GuestDAO;
import entity.Account;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author ASUS
 */
public class LoginServlet extends HttpServlet {

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
            out.println("<title>Servlet LoginServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginServlet at " + request.getContextPath() + "</h1>");
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
        String action = request.getParameter("action");

        if ("login".equals(action)) {
            login(request, response);
        } else if ("register".equals(action)) {
            register(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }

    public void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String user = request.getParameter("user");
        String pass = request.getParameter("pass");
        String remember = request.getParameter("remember");
        boolean isValid = true;

        String userErr = null;
        String passErr = null;

        AccountDAO d = new AccountDAO();
        HttpSession sesson = request.getSession();
        Account a = d.login(user, pass);
        
        Account userA = d.checkExitsAccount(user);

        sesson.setAttribute("user12", user);
        request.setAttribute("pass", pass);

        if (userA == null) {
            userErr = "User not exited!!";
            isValid = false;
        } else if (a == null) {
            passErr = "Wrong Password";
            isValid = false;
        }

        if (!isValid) {
            request.setAttribute("userErr", userErr);
            request.setAttribute("passErr", passErr);
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            sesson.setAttribute("acc", a);
            if ("on".equals(remember)) {
                Cookie cookie = new Cookie("user", user);
                cookie.setMaxAge(60 * 60 * 24 * 6);
                sesson.setMaxInactiveInterval(100);
                response.addCookie(cookie);
            } else {
                Cookie cookie = new Cookie("user", "");
                cookie.setMaxAge(0);
                response.addCookie(cookie);
            }
            response.sendRedirect("loadtohome");
        }
    }

   public void register(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    // 🔹 Lấy dữ liệu từ form
    String rname = request.getParameter("rname");
    String ruser = request.getParameter("ruser");
    String rpass = request.getParameter("rpass");
    String reppass = request.getParameter("reppass");
    String remail = request.getParameter("remail");
    String rphone = request.getParameter("rphone");
    String raddress = request.getParameter("raddress");
    String rcity = request.getParameter("rcity");
    String rcountry = request.getParameter("rcountry");
    String rdob = request.getParameter("rbirth"); // yyyy-MM-dd
    String recheck = request.getParameter("recheck");

    boolean isValid = true;
    String errUser = null, errPass = null, errEmail = null, errRecheck = null, errPhone = null;

    // 🔹 Giữ lại giá trị đã nhập
    request.setAttribute("rname", rname);
    request.setAttribute("ruser", ruser);
    request.setAttribute("rpass", rpass);
    request.setAttribute("reppass", reppass);
    request.setAttribute("remail", remail);
    request.setAttribute("rphone", rphone);
    request.setAttribute("raddress", raddress);
    request.setAttribute("rcity", rcity);
    request.setAttribute("rcountry", rcountry);
    request.setAttribute("rdob", rdob);

    AccountDAO d = new AccountDAO();
    GuestDAO g = new GuestDAO();

    // 🔹 Kiểm tra password khớp
    if (!rpass.equals(reppass)) {
        errPass = "Repeat password must match password";
        isValid = false;
    }

    // 🔹 Kiểm tra email tồn tại
    if (d.checkExistEmail(remail)) {
        errEmail = "This email is already associated with an account!";
        isValid = false;
    }

    // 🔹 Kiểm tra username tồn tại
    if (d.checkExitsAccount(ruser) != null) {
        errUser = "This username is already taken!";
        isValid = false;
    }

    // 🔹 Kiểm tra phone hợp lệ
    if (rphone == null || !rphone.matches("[0-9]{10,15}")) {
        errPhone = "Invalid phone number!";
        isValid = false;
    }

    // 🔹 Kiểm tra checkbox
    if (recheck == null) {
        errRecheck = "You must agree to the terms!";
        isValid = false;
    }

    // 🔹 Nếu có lỗi -> quay lại form
    if (!isValid) {
        request.setAttribute("errUser", errUser);
        request.setAttribute("errPass", errPass);
        request.setAttribute("errEmail", errEmail);
        request.setAttribute("errRecheck", errRecheck);
        request.setAttribute("errPhone", errPhone);
        request.getRequestDispatcher("register.jsp").forward(request, response);
        return;
    }

    // ✅ Bước 1: thêm Guest mới (thêm đủ thông tin)
    int guestID = g.insertGuest(rname, remail, rphone, raddress, rcity, rcountry, rdob);

    // ✅ Bước 2: thêm Account cho Guest đó
    d.insertAccount(ruser, rpass, "Guest", guestID);

    // ✅ Bước 3: chuyển hướng
    response.sendRedirect("login.jsp");
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
