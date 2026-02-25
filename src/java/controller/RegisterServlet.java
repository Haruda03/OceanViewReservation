/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import util.PasswordUtil;


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
            if (fullName == null || fullName.trim().length() < 3) {
                request.setAttribute("error", "Full name must be at least 3 characters.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }
            if (email == null || !email.matches("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$")) {
                request.setAttribute("error", "Invalid email format.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }
            if (password == null || password.length() < 6) {
                request.setAttribute("error", "Password must be at least 6 characters.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            if (userDAO.emailExists(email)) {
                request.setAttribute("error", "Email already registered. Please login.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            User u = new User();
            u.setFullName(fullName.trim());
            u.setEmail(email.trim().toLowerCase());
            u.setPhone(phone);
            u.setPasswordHash(PasswordUtil.createStoredPassword(password));
            u.setRole("CUSTOMER"); // default

            userDAO.createUser(u);

            request.setAttribute("msg", "Account created successfully! Please login.");
            request.getRequestDispatcher("register.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "Registration failed: " + e.getMessage());
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}