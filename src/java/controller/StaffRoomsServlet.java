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
import java.math.BigDecimal;

@WebServlet("/staff/rooms")
public class StaffRoomsServlet extends HttpServlet {

    private final RoomDAO roomDAO = new RoomDAO();

    private boolean isStaffOrAdmin(HttpSession session) {
        if (session == null) return false;
        String role = (String) session.getAttribute("role");
        return "STAFF".equals(role) || "ADMIN".equals(role);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (!isStaffOrAdmin(session)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            request.setAttribute("rooms", roomDAO.findAllRooms());

            String msg = request.getParameter("msg");
            String err = request.getParameter("err");
            if (msg != null) request.setAttribute("msg", msg);
            if (err != null) request.setAttribute("error", err);

            request.getRequestDispatcher("/staff/rooms.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to load rooms: " + e.getMessage());
            request.getRequestDispatcher("/staff/rooms.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (!isStaffOrAdmin(session)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) action = "update";

        try {
            if ("update".equals(action)) {

                int roomId = Integer.parseInt(request.getParameter("roomId"));
                BigDecimal rate = new BigDecimal(request.getParameter("rate"));
                String status = request.getParameter("status");

                if (rate.compareTo(BigDecimal.ZERO) <= 0)
                    throw new IllegalArgumentException("Rate must be > 0");

                if (!("ACTIVE".equals(status) || "INACTIVE".equals(status)))
                    throw new IllegalArgumentException("Invalid status");

                roomDAO.updateRoom(roomId, rate, status);
                response.sendRedirect(request.getContextPath() + "/staff/rooms?msg=Room+updated+successfully");
                return;
            }

            if ("add".equals(action)) {

                String roomType = request.getParameter("roomType");
                BigDecimal rate = new BigDecimal(request.getParameter("rate"));
                int maxGuests = Integer.parseInt(request.getParameter("maxGuests"));
                String status = request.getParameter("status");

                if (roomType == null || roomType.trim().isEmpty())
                    throw new IllegalArgumentException("Room type required");
                if (rate.compareTo(BigDecimal.ZERO) <= 0)
                    throw new IllegalArgumentException("Rate must be > 0");
                if (maxGuests < 1 || maxGuests > 20)
                    throw new IllegalArgumentException("Max guests must be between 1 and 20");
                if (!("ACTIVE".equals(status) || "INACTIVE".equals(status)))
                    throw new IllegalArgumentException("Invalid status");

                roomDAO.addRoom(roomType.trim(), rate, maxGuests, status);
                response.sendRedirect(request.getContextPath() + "/staff/rooms?msg=New+room+added");
                return;
            }

            if ("delete".equals(action)) {

                int roomId = Integer.parseInt(request.getParameter("roomId"));

                if (roomDAO.hasActiveBooking(roomId)) {
                    response.sendRedirect(request.getContextPath() + "/staff/rooms?err=Cannot+delete:+Room+has+CONFIRMED+booking");
                    return;
                }

                roomDAO.deleteRoom(roomId);
                response.sendRedirect(request.getContextPath() + "/staff/rooms?msg=Room+deleted");
                return;
            }

            response.sendRedirect(request.getContextPath() + "/staff/rooms?err=Invalid+action");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/staff/rooms?err=" + encode(e.getMessage()));
        }
    }

    private String encode(String s) {
        if (s == null) return "Error";
        return s.replace(" ", "+");
    }
}