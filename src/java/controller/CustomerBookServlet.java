/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.RoomDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;

@WebServlet("/customer/book")
public class CustomerBookServlet extends HttpServlet {

    private final RoomDAO roomDAO = new RoomDAO();

    private boolean isCustomer(HttpSession session) {
        if (session == null) return false;
        String role = (String) session.getAttribute("role");
        return "CUSTOMER".equals(role);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (!isCustomer(session)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        request.getRequestDispatcher("/customer/bookRoom.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (!isCustomer(session)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String checkInStr = request.getParameter("checkIn");
        String checkOutStr = request.getParameter("checkOut");
        String guestsStr = request.getParameter("guests");

        if (checkInStr == null || checkOutStr == null || guestsStr == null
                || checkInStr.isEmpty() || checkOutStr.isEmpty() || guestsStr.isEmpty()) {
            request.setAttribute("error", "Please fill Check-in, Check-out, and Guests.");
            request.getRequestDispatcher("/customer/bookRoom.jsp").forward(request, response);
            return;
        }

        LocalDate checkIn;
        LocalDate checkOut;
        int guests;

        try {
            checkIn = LocalDate.parse(checkInStr);
            checkOut = LocalDate.parse(checkOutStr);
        } catch (DateTimeParseException ex) {
            request.setAttribute("error", "Invalid date format. Please use the date picker.");
            request.getRequestDispatcher("/customer/bookRoom.jsp").forward(request, response);
            return;
        }

        try {
            guests = Integer.parseInt(guestsStr);
        } catch (NumberFormatException ex) {
            request.setAttribute("error", "Guests must be a valid number.");
            request.getRequestDispatcher("/customer/bookRoom.jsp").forward(request, response);
            return;
        }

        LocalDate today = LocalDate.now();

        if (checkIn.isBefore(today)) {
            request.setAttribute("error", "Check-in date cannot be in the past.");
            request.getRequestDispatcher("/customer/bookRoom.jsp").forward(request, response);
            return;
        }
        if (!checkOut.isAfter(checkIn)) {
            request.setAttribute("error", "Check-out must be after check-in.");
            request.getRequestDispatcher("/customer/bookRoom.jsp").forward(request, response);
            return;
        }

        long nights = java.time.temporal.ChronoUnit.DAYS.between(checkIn, checkOut);
        if (nights > 30) {
            request.setAttribute("error", "Maximum stay is 30 nights.");
            request.getRequestDispatcher("/customer/bookRoom.jsp").forward(request, response);
            return;
        }

        if (guests < 1 || guests > 20) {
            request.setAttribute("error", "Guests must be between 1 and 20.");
            request.getRequestDispatcher("/customer/bookRoom.jsp").forward(request, response);
            return;
        }

        try {
            request.setAttribute("checkIn", checkIn);
            request.setAttribute("checkOut", checkOut);
            request.setAttribute("guests", guests);

            request.setAttribute("rooms", roomDAO.findAvailableRooms(checkIn, checkOut, guests));
            request.getRequestDispatcher("/customer/bookRoom.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to load rooms: " + e.getMessage());
            request.getRequestDispatcher("/customer/bookRoom.jsp").forward(request, response);
        }
    }
}