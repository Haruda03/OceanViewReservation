/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.UserDAO;
import model.User;
import util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/admin/create-user")
public class AdminCreateUserServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Double-check role server-side (extra security)
        HttpSession session = request.getSession(false);
        String sessionRole = (session == null) ? null : (String) session.getAttribute("role");
        if (!"ADMIN".equals(sessionRole)) {
            response.sendRedirect(request.getContextPath() + "/403.jsp");
            return;
        }

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String role = request.getParameter("role"); // STAFF or ADMIN

        try {
            // Validation
            if (fullName == null || fullName.trim().length() < 3) {
                request.setAttribute("error", "Full name must be at least 3 characters.");
                request.getRequestDispatcher("/admin/createUser.jsp").forward(request, response);
                return;
            }
            if (email == null || !email.matches("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$")) {
                request.setAttribute("error", "Invalid email format.");
                request.getRequestDispatcher("/admin/createUser.jsp").forward(request, response);
                return;
            }
            if (password == null || password.length() < 6) {
                request.setAttribute("error", "Password must be at least 6 characters.");
                request.getRequestDispatcher("/admin/createUser.jsp").forward(request, response);
                return;
            }
            if (!"STAFF".equals(role) && !"ADMIN".equals(role)) {
                request.setAttribute("error", "Invalid role selected.");
                request.getRequestDispatcher("/admin/createUser.jsp").forward(request, response);
                return;
            }
            String normalizedEmail = email.trim().toLowerCase();

            if (phone != null && !phone.trim().isEmpty()) {
                if (!phone.matches("^[0-9+]{9,15}$")) {
                    request.setAttribute("error", "Phone number must be 9–15 digits (can include +).");
                    request.getRequestDispatcher("/admin/createUser.jsp").forward(request, response);
                    return;
                }
            }

            // Duplicate email check
            if (userDAO.emailExists(normalizedEmail)) {
                request.setAttribute("error", "Email already exists.");
                request.getRequestDispatcher("/admin/createUser.jsp").forward(request, response);
                return;
            }

            // Create user
            User u = new User();
            u.setFullName(fullName.trim());
            u.setEmail(normalizedEmail);
            u.setPhone((phone == null) ? null : phone.trim());
            u.setPasswordHash(PasswordUtil.createStoredPassword(password));
            u.setRole(role);

            userDAO.createUser(u);

            request.setAttribute("msg", "User created successfully as " + role + ".");
            request.getRequestDispatcher("/admin/createUser.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to create user: " + e.getMessage());
            request.getRequestDispatcher("/admin/createUser.jsp").forward(request, response);
        }
    }
}