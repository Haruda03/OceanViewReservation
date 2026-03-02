/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import billing.BillingStrategy;
import billing.DiscountStrategy;
import billing.NormalRateStrategy;
import billing.WeekendRateStrategy;
import dao.ReservationDAO;
import model.BillData;
import model.BillResult;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/customer/bill")
public class CustomerBillServlet extends HttpServlet {

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
            request.setAttribute("error", "Booking number is required.");
            request.getRequestDispatcher("/customer/bill.jsp").forward(request, response);
            return;
        }

        try {
            reservationDAO.expireOldPending();

            BillData data = reservationDAO.findConfirmedBillDataForCustomer(no.trim(), userId);
            if (data == null) {
                request.setAttribute("error",
                        "Bill not available. Only CONFIRMED bookings/reservations can generate a bill.");
                request.getRequestDispatcher("/customer/bill.jsp").forward(request, response);
                return;
            }

            BillingStrategy strategy = chooseStrategy(request);
            BillResult result = strategy.calculate(data);

            request.setAttribute("billData", data);
            request.setAttribute("billResult", result);

            request.getRequestDispatcher("/customer/bill.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to generate bill: " + e.getMessage());
            request.getRequestDispatcher("/customer/bill.jsp").forward(request, response);
        }
    }

    private BillingStrategy chooseStrategy(HttpServletRequest request) {
        // URL examples:
        // /customer/bill?no=OVR-...&pricing=normal
        // /customer/bill?no=OVR-...&pricing=weekend
        // /customer/bill?no=OVR-...&pricing=discount&discount=10

        String pricing = request.getParameter("pricing");
        if (pricing == null) pricing = "normal";

        switch (pricing.toLowerCase()) {
            case "weekend":
                return new WeekendRateStrategy(new BigDecimal("1.20")); // 20% extra on weekend nights
            case "discount":
                String dp = request.getParameter("discount");
                BigDecimal percent;
                try {
                    // default 10% if missing or invalid
                    if (dp == null || dp.trim().isEmpty()) {
                        percent = new BigDecimal("10");
                    } else {
                        percent = new BigDecimal(dp.trim());
                    }
                } catch (NumberFormatException ex) {
                    percent = new BigDecimal("10");
                }

                // Clamp to 0–90% for safety
                if (percent.compareTo(BigDecimal.ZERO) < 0) {
                    percent = BigDecimal.ZERO;
                } else if (percent.compareTo(new BigDecimal("90")) > 0) {
                    percent = new BigDecimal("90");
                }

                return new DiscountStrategy(percent);
            default:
                return new NormalRateStrategy();
        }
    }
}