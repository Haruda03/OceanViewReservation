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
import model.ReservationDetail;

@WebServlet("/customer/reservation-details")
public class CustomerReservationDetailsServlet extends HttpServlet {

    private final ReservationDAO reservationDAO = new ReservationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Integer userId = (session == null) ? null : (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String no = request.getParameter("no");
        if (no == null || no.trim().isEmpty()) {
            request.setAttribute("error", "Reservation number is required.");
            request.getRequestDispatcher("/customer/reservationDetails.jsp").forward(request, response);
            return;
        }

        try {
            // Expire old pending before showing details
            reservationDAO.expireOldPending();

            ReservationDetail detail = reservationDAO.findDetailForCustomer(no.trim(), userId);

            if (detail == null) {
                request.setAttribute("error", "Reservation not found (or you do not have access).");
            } else {
                request.setAttribute("detail", detail);
            }

            request.getRequestDispatcher("/customer/reservationDetails.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to load reservation details: " + e.getMessage());
            request.getRequestDispatcher("/customer/reservationDetails.jsp").forward(request, response);
        }
    }
}