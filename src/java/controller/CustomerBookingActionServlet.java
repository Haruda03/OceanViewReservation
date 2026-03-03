/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ReservationDAO;
import dao.RoomDAO;
import dao.NotificationDAO;
import model.Room;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;

@WebServlet("/customer/booking-action")
public class CustomerBookingActionServlet extends HttpServlet {

    private final ReservationDAO reservationDAO = new ReservationDAO();
    private final RoomDAO roomDAO = new RoomDAO();
    private final NotificationDAO notificationDAO = new NotificationDAO();

    private boolean isCustomer(HttpSession session) {
        if (session == null)
            return false;
        String role = (String) session.getAttribute("role");
        return "CUSTOMER".equals(role);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        handleBooking(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        handleBooking(request, response);
    }

    private void handleBooking(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        HttpSession session = request.getSession(false);
        if (!isCustomer(session)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null)
            action = "book";

        String roomIdStr = request.getParameter("roomId");
        String checkInStr = request.getParameter("checkIn");
        String checkOutStr = request.getParameter("checkOut");
        String guestsStr = request.getParameter("guests");

        if (roomIdStr == null || checkInStr == null || checkOutStr == null || guestsStr == null) {
            redirectWithError(request, response, "Missing booking details. Please search again.");
            return;
        }

        int roomId;
        int guests;
        LocalDate checkIn;
        LocalDate checkOut;

        try {
            roomId = Integer.parseInt(roomIdStr);
            guests = Integer.parseInt(guestsStr);
        } catch (NumberFormatException ex) {
            redirectWithError(request, response, "Invalid room or guests value. Please try again.");
            return;
        }

        try {
            checkIn = LocalDate.parse(checkInStr);
            checkOut = LocalDate.parse(checkOutStr);
        } catch (DateTimeParseException ex) {
            redirectWithError(request, response, "Invalid dates. Please try again.");
            return;
        }

        LocalDate today = LocalDate.now();
        if (checkIn.isBefore(today) || !checkOut.isAfter(checkIn)) {
            redirectWithError(request, response, "Invalid date range. Please select valid dates.");
            return;
        }

        long nights = java.time.temporal.ChronoUnit.DAYS.between(checkIn, checkOut);
        if (nights > 30) {
            redirectWithError(request, response, "Maximum stay is 30 nights.");
            return;
        }

        if (guests < 1 || guests > 20) {
            redirectWithError(request, response, "Guests must be between 1 and 20.");
            return;
        }

        try {
            // Optional: verify room exists and capacity again
            Room room = findRoomById(roomId);
            if (room == null) {
                redirectWithError(request, response, "Selected room no longer exists.");
                return;
            }
            if (guests > room.getMaxGuests()) {
                redirectWithError(request, response, "Guests exceed room capacity. Please search again.");
                return;
            }

            // Check for conflicts right before creating booking/reservation
            if (reservationDAO.hasConflict(roomId, checkIn, checkOut)) {
                redirectWithError(request, response,
                        "This room is no longer available for those dates. Please search again.");
                return;
            }

            // Generate reservation number (example)
            String reservationNo = generateReservationNo(userId);

            if ("request".equalsIgnoreCase(action)) {
                // Reservation request with expiry, e.g. 60 minutes
                reservationDAO.createReservationRequest(
                        reservationNo, userId, roomId, checkIn, checkOut, guests, 60);

                String fullName = (String) session.getAttribute("fullName");
                notificationDAO.notifyStaff("New reservation request " + reservationNo + " from " + fullName);

                response.sendRedirect(request.getContextPath() + "/customer/my-reservations");
            } else {
                // Direct booking (CONFIRMED)
                reservationDAO.createDirectBooking(
                        reservationNo, userId, roomId, checkIn, checkOut, guests);

                String fullName = (String) session.getAttribute("fullName");
                notificationDAO.notifyStaff("New instant booking " + reservationNo + " created by " + fullName);

                response.sendRedirect(request.getContextPath() + "/customer/my-bookings");
            }

        } catch (Exception e) {
            e.printStackTrace();
            redirectWithError(request, response, "Failed to create booking: " + e.getMessage());
        }
    }

    // Simple example – replace with your own generator if you have one
    private String generateReservationNo(int userId) {
        long now = System.currentTimeMillis();
        return "OVR-" + userId + "-" + now;
    }

    private void redirectWithError(HttpServletRequest request, HttpServletResponse response, String message)
            throws IOException {
        String ctx = request.getContextPath();
        String encoded = message.replace(" ", "+");
        response.sendRedirect(ctx + "/customer/book?err=" + encoded);
    }

    // Simple lookup; if you already have a DAO method by id, use that instead
    private Room findRoomById(int roomId) throws Exception {
        // Example implementation: you may already have such a method
        for (Room r : roomDAO.findAllRooms()) {
            if (r.getRoomId() == roomId) {
                return r;
            }
        }
        return null;
    }
}