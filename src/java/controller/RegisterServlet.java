/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.UserDAO;
import model.User;
import util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");

        try {
            // --- Basic validation (server-side) ---
            if (fullName == null || fullName.trim().length() < 3) {
                request.setAttribute("error", "Full name must be at least 3 characters.");
                request.getRequestDispatcher("/register.jsp").forward(request, response);
                return;
            }

            if (email == null || !email.matches("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$")) {
                request.setAttribute("error", "Invalid email format.");
                request.getRequestDispatcher("/register.jsp").forward(request, response);
                return;
            }

            if (password == null || password.length() < 6) {
                request.setAttribute("error", "Password must be at least 6 characters.");
                request.getRequestDispatcher("/register.jsp").forward(request, response);
                return;
            }

            String normalizedEmail = email.trim().toLowerCase();

            // optional phone validation (if provided)
            if (phone != null && !phone.trim().isEmpty()) {
                if (!phone.matches("^[0-9+]{9,15}$")) {
                    request.setAttribute("error", "Phone number must be 9–15 digits (can include +).");
                    request.getRequestDispatcher("/register.jsp").forward(request, response);
                    return;
                }
            }

            // --- Check duplicate email ---
            if (userDAO.emailExists(normalizedEmail)) {
                request.setAttribute("error", "Email already registered. Please login.");
                request.getRequestDispatcher("/register.jsp").forward(request, response);
                return;
            }

            // --- Create user ---
            User u = new User();
            u.setFullName(fullName.trim());
            u.setEmail(normalizedEmail);
            u.setPhone((phone == null) ? null : phone.trim());
            u.setPasswordHash(PasswordUtil.createStoredPassword(password));
            u.setRole("CUSTOMER"); // public registration always CUSTOMER (secure)

            userDAO.createUser(u);

            // --- Success: go to login page ---
            request.setAttribute("msg", "Account created successfully! Please login.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);

        } catch (Exception e) {
            // Log for debugging (NetBeans Output)
            e.printStackTrace();

            request.setAttribute("error", "Registration failed: " + e.getMessage());
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}