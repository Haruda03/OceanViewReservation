/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ReservationDAO;
import dao.NotificationDAO;
import model.ReservationView;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/staff/reservations-manage")
public class StaffReservationsServlet extends HttpServlet {

    private final ReservationDAO reservationDAO = new ReservationDAO();
    private final NotificationDAO notificationDAO = new NotificationDAO();

    private boolean isStaffOrAdmin(HttpSession session) {
        if (session == null)
            return false;
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
            reservationDAO.expireOldPending();

            String status = request.getParameter("status"); // CONFIRMED, PENDING, etc. or null
            String type = request.getParameter("type"); // BOOKING, RESERVATION or null

            if (status != null && status.trim().isEmpty())
                status = null;
            if (type != null && type.trim().isEmpty())
                type = null;

            List<ReservationView> list = reservationDAO.staffFindAll(status, type);
            request.setAttribute("list", list);

            request.getRequestDispatcher("/staff/reservationsManage.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to load reservations: " + e.getMessage());
            request.getRequestDispatcher("/staff/reservationsManage.jsp").forward(request, response);
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

        Integer staffId = (Integer) session.getAttribute("userId");

        String action = request.getParameter("action");
        String no = request.getParameter("no");

        try {
            if ("complete".equals(action)) {
                reservationDAO.staffUpdateStatus(no, "COMPLETED", staffId);
                Integer customerId = reservationDAO.getUserIdByReservationNo(no);
                if (customerId != null) {
                    notificationDAO.notifyUser(customerId, "Your stay for reservation/booking " + no
                            + " has been COMPLETED (Checked Out). Thank you for staying with us!");
                }
            } else if ("cancel".equals(action)) {
                reservationDAO.staffUpdateStatus(no, "CANCELLED", staffId);
                Integer customerId = reservationDAO.getUserIdByReservationNo(no);
                if (customerId != null) {
                    notificationDAO.notifyUser(customerId,
                            "Your reservation/booking " + no + " has been CANCELLED by the staff.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/staff/reservations-manage");
    }

}