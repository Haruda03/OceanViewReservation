/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.UserDAO;
import model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.AuthService;



@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private final AuthService authService = new AuthService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            if (email == null || password == null) {
                request.setAttribute("error", "Email and password are required.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            User u = authService.login(email.trim().toLowerCase(), password);

            if (u == null) {
                request.setAttribute("error", "Invalid email or password.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            HttpSession session = request.getSession(true);
            session.setAttribute("userId", u.getUserId());
            session.setAttribute("fullName", u.getFullName());
            session.setAttribute("role", u.getRole());

            // Role-based redirect (ADMIN / STAFF / CUSTOMER)
String role = u.getRole();

if ("ADMIN".equals(role)) {
    response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
} else if ("STAFF".equals(role)) {
    response.sendRedirect(request.getContextPath() + "/staff/dashboard.jsp");
} else {
    response.sendRedirect(request.getContextPath() + "/customer/dashboard.jsp");
}

        } catch (Exception e) {
            request.setAttribute("error", "Login failed: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}