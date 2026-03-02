/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ReservationDAO;
import dao.SupportTicketDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/staff/dashboard")
public class StaffDashboardServlet extends HttpServlet {

    private final ReservationDAO reservationDAO = new ReservationDAO();
    private final SupportTicketDAO supportDAO = new SupportTicketDAO();

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
            // keep system clean (expire old reservation requests)
            reservationDAO.expireOldPending();

            int pendingRequests = reservationDAO.countActivePendingReservationRequests();
            int openTickets = supportDAO.countTicketsByStatus("OPEN");
            int inProgressTickets = supportDAO.countTicketsByStatus("IN_PROGRESS");

            request.setAttribute("pendingRequestsCount", pendingRequests);
            request.setAttribute("openTicketsCount", openTickets);
            request.setAttribute("inProgressTicketsCount", inProgressTickets);

            request.getRequestDispatcher("/staff/dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            // still show dashboard even if counts fail
            request.setAttribute("pendingRequestsCount", 0);
            request.setAttribute("openTicketsCount", 0);
            request.setAttribute("inProgressTicketsCount", 0);
            request.setAttribute("error", "Dashboard counters failed: " + e.getMessage());

            request.getRequestDispatcher("/staff/dashboard.jsp").forward(request, response);
        }
    }
}