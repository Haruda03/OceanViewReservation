/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ReservationDAO;
import dao.RoomDAO;
import model.Room;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.List;
import java.util.concurrent.ThreadLocalRandom;

@WebServlet("/customer/book")
public class CustomerBookingServlet extends HttpServlet {

    private final RoomDAO roomDAO = new RoomDAO();
    private final ReservationDAO reservationDAO = new ReservationDAO();

    private static final int REQUEST_EXPIRE_MINUTES = 30;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            reservationDAO.expireOldPending();
            List<Room> rooms = roomDAO.findActiveRooms();
            request.setAttribute("rooms", rooms);
            request.getRequestDispatcher("/customer/bookRoom.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to load rooms: " + e.getMessage());
            request.getRequestDispatcher("/customer/bookRoom.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Integer userId = (session == null) ? null : (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            reservationDAO.expireOldPending();
            request.setAttribute("rooms", roomDAO.findActiveRooms());

            String requestType = request.getParameter("requestType");
            if (requestType == null) requestType = "BOOKING"; // default

            int roomId = Integer.parseInt(request.getParameter("roomId"));
            int guests = Integer.parseInt(request.getParameter("guests"));

            LocalDate checkIn;
            LocalDate checkOut;
            try {
                checkIn = LocalDate.parse(request.getParameter("checkIn"));
                checkOut = LocalDate.parse(request.getParameter("checkOut"));
            } catch (DateTimeParseException ex) {
                request.setAttribute("error", "Invalid date format.");
                request.getRequestDispatcher("/customer/bookRoom.jsp").forward(request, response);
                return;
            }

            if (!checkOut.isAfter(checkIn)) {
                request.setAttribute("error", "Check-out date must be after check-in date.");
                request.getRequestDispatcher("/customer/bookRoom.jsp").forward(request, response);
                return;
            }

            if (guests < 1 || guests > 10) {
                request.setAttribute("error", "Guests must be between 1 and 10.");
                request.getRequestDispatcher("/customer/bookRoom.jsp").forward(request, response);
                return;
            }

            if (reservationDAO.hasConflict(roomId, checkIn, checkOut)) {
                request.setAttribute("error",
                    "Room not available for selected dates (confirmed booking or active reservation request).");
                request.getRequestDispatcher("/customer/bookRoom.jsp").forward(request, response);
                return;
            }

            String reservationNo = generateReservationNo();

            if ("BOOKING".equals(requestType)) {
                reservationDAO.createDirectBooking(reservationNo, userId, roomId, checkIn, checkOut, guests);
                request.setAttribute("msg", "Booking confirmed instantly! Booking No: " + reservationNo);

            } else if ("RESERVATION".equals(requestType)) {
                reservationDAO.createReservationRequest(reservationNo, userId, roomId, checkIn, checkOut, guests, REQUEST_EXPIRE_MINUTES);
                request.setAttribute("msg",
                    "Reservation request submitted! Reservation No: " + reservationNo +
                    ". Staff will approve within " + REQUEST_EXPIRE_MINUTES + " minutes.");

            } else {
                request.setAttribute("error", "Invalid request type.");
            }

            request.getRequestDispatcher("/customer/bookRoom.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Booking failed: " + e.getMessage());
            request.getRequestDispatcher("/customer/bookRoom.jsp").forward(request, response);
        }
    }

    private String generateReservationNo() {
        String datePart = LocalDate.now().toString().replace("-", "");
        int rand = ThreadLocalRandom.current().nextInt(1000, 9999);
        return "OVR-" + datePart + "-" + rand;
    }
}