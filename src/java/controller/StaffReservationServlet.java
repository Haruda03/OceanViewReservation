/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ReservationDAO;
import model.ReservationView;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/staff/reservations")
public class StaffReservationServlet extends HttpServlet {

    private final ReservationDAO reservationDAO = new ReservationDAO();

    /* ---------------- GET (LOAD PAGE) ---------------- */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null || action.equals("list")) {
            loadPendingRequests(request, response);
        }
    }

    /* ---------------- POST (APPROVE / REJECT) ---------------- */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Integer staffId = (session == null) ? null : (Integer) session.getAttribute("userId");

        if (staffId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("approve".equals(action)) {
                approveReservation(request, staffId);
            } else if ("reject".equals(action)) {
                rejectReservation(request, staffId);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/staff/reservations");
    }

    /* ---------------- LOAD PENDING LIST ---------------- */
    private void loadPendingRequests(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            reservationDAO.expireOldPending();

            List<ReservationView> list = reservationDAO.findActivePendingRequests();
            request.setAttribute("requests", list);

            request.getRequestDispatcher("/staff/pendingRequests.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/staff/pendingRequests.jsp")
                   .forward(request, response);
        }
    }

    /* ---------------- APPROVE ---------------- */
    private void approveReservation(HttpServletRequest request, int staffId) throws Exception {

        String no = request.getParameter("no");
        reservationDAO.approveReservation(no, staffId);
    }

    /* ---------------- REJECT ---------------- */
    private void rejectReservation(HttpServletRequest request, int staffId) throws Exception {

        String no = request.getParameter("no");
        String note = request.getParameter("note");

        reservationDAO.rejectReservation(no, staffId, note);
    }
}