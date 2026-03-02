/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.SupportTicketDAO;
import model.SupportTicket;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/staff/support")
public class StaffSupportServlet extends HttpServlet {

    private final SupportTicketDAO dao = new SupportTicketDAO();

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
            List<SupportTicket> tickets = dao.findAllTickets();
            request.setAttribute("tickets", tickets);
            request.getRequestDispatcher("/staff/supportTickets.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to load tickets: " + e.getMessage());
            request.getRequestDispatcher("/staff/supportTickets.jsp").forward(request, response);
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

        String ticketIdStr = request.getParameter("ticketId");
        String status = request.getParameter("status");

        if (ticketIdStr == null || status == null) {
            response.sendRedirect(request.getContextPath() + "/staff/support");
            return;
        }

        // whitelist statuses
        if (!("OPEN".equals(status) || "IN_PROGRESS".equals(status) || "CLOSED".equals(status))) {
            response.sendRedirect(request.getContextPath() + "/staff/support");
            return;
        }

        try {
            int ticketId = Integer.parseInt(ticketIdStr);
            dao.updateTicketStatus(ticketId, status);
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/staff/support");
    }
}