/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.RoomDAO;
import model.Room;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

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
            List<Room> rooms = roomDAO.findAllRooms();
            request.setAttribute("rooms", rooms);

            // show messages from redirect
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

        String roomIdStr = request.getParameter("roomId");
        String rateStr = request.getParameter("rate");
        String status = request.getParameter("status"); // ACTIVE / INACTIVE

        try {
            if (roomIdStr == null || rateStr == null || status == null) {
                response.sendRedirect(request.getContextPath() + "/staff/rooms?err=Missing+fields");
                return;
            }

            int roomId = Integer.parseInt(roomIdStr.trim());

            BigDecimal rate;
            try {
                rate = new BigDecimal(rateStr.trim());
            } catch (NumberFormatException ex) {
                response.sendRedirect(request.getContextPath() + "/staff/rooms?err=Invalid+rate+value");
                return;
            }

            if (rate.compareTo(BigDecimal.ZERO) <= 0) {
                response.sendRedirect(request.getContextPath() + "/staff/rooms?err=Rate+must+be+greater+than+0");
                return;
            }

            if (!("ACTIVE".equals(status) || "INACTIVE".equals(status))) {
                response.sendRedirect(request.getContextPath() + "/staff/rooms?err=Invalid+status");
                return;
            }

            roomDAO.updateRoom(roomId, rate, status);

            response.sendRedirect(request.getContextPath() + "/staff/rooms?msg=Room+updated+successfully");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/staff/rooms?err=Update+failed");
        }
    }
}