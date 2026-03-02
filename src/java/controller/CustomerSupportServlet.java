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

@WebServlet("/customer/support")
public class CustomerSupportServlet extends HttpServlet {

    private final SupportTicketDAO dao = new SupportTicketDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Integer userId = (session == null) ? null : (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            List<SupportTicket> tickets = dao.findTicketsByUser(userId);
            request.setAttribute("tickets", tickets);
            request.getRequestDispatcher("/customer/helpSupport.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to load support page: " + e.getMessage());
            request.getRequestDispatcher("/customer/helpSupport.jsp").forward(request, response);
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

        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        if (subject == null || subject.trim().isEmpty() || message == null || message.trim().isEmpty()) {
            request.setAttribute("error", "Subject and message are required.");
            doGet(request, response);
            return;
        }

        try {
            dao.createTicket(userId, subject.trim(), message.trim());
            request.setAttribute("msg", "Support request submitted successfully. Our team will respond soon.");
            doGet(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to submit ticket: " + e.getMessage());
            doGet(request, response);
        }
    }
}