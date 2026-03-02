/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ReservationDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

@WebServlet("/staff/reports")
public class StaffReportsServlet extends HttpServlet {

    private final ReservationDAO dao = new ReservationDAO();

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
            // date range
            LocalDate to = LocalDate.now().plusDays(1); // exclusive
            LocalDate from = LocalDate.now().minusDays(30);

            String fromStr = request.getParameter("from");
            String toStr = request.getParameter("to");

            if (fromStr != null && !fromStr.trim().isEmpty()) from = LocalDate.parse(fromStr.trim());
            if (toStr != null && !toStr.trim().isEmpty()) to = LocalDate.parse(toStr.trim()).plusDays(1); // exclusive

            // keep system clean (expire pending requests)
            dao.expireOldPending();

            Map<String, Integer> statusCounts = dao.reportStatusCounts();
            java.math.BigDecimal revenue = dao.reportRevenue(from, to);
            List<Map<String, Object>> topRooms = dao.reportTopRoomTypes(from, to, 5);
            List<Map<String, Object>> daily = dao.reportDailyRevenue(from, to);

            request.setAttribute("from", from);
            request.setAttribute("toInclusive", to.minusDays(1)); // show inclusive to user
            request.setAttribute("statusCounts", statusCounts);
            request.setAttribute("revenue", revenue);
            request.setAttribute("topRooms", topRooms);
            request.setAttribute("dailyRevenue", daily);

            request.getRequestDispatcher("/staff/reports.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to load reports: " + e.getMessage());
            request.getRequestDispatcher("/staff/reports.jsp").forward(request, response);
        }
    }
}