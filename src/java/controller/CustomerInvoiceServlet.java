/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.InvoiceDAO;
import util.DBConnectionManager;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;

@WebServlet("/customer/invoice")
public class CustomerInvoiceServlet extends HttpServlet {

    private final InvoiceDAO invoiceDAO = new InvoiceDAO();

    private boolean isCustomer(HttpSession s) {
        if (s == null)
            return false;
        Integer userId = (Integer) s.getAttribute("userId");
        String role = (String) s.getAttribute("role");
        return userId != null && "CUSTOMER".equals(role);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession s = req.getSession(false);
        if (!isCustomer(s)) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        int userId = (Integer) s.getAttribute("userId");
        String no = req.getParameter("no");
        if (no == null || no.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/customer/my-bookings?err=Missing+reservation+no");
            return;
        }

        try (Connection c = DBConnectionManager.getInstance().getConnection()) {
            ResultSet rs = invoiceDAO.findInvoiceForCustomer(c, no.trim(), userId);
            if (!rs.next()) {
                // Generate Invoice Automatically
                dao.ReservationDAO rDao = new dao.ReservationDAO();
                model.BillData data = rDao.findBillDataByReservationNo(no.trim());
                if (data == null || data.getUserId() != userId) {
                    resp.sendRedirect(req.getContextPath() + "/customer/my-bookings?err=Invoice+not+available+yet");
                    return;
                }

                billing.BillingStrategy strategy = new billing.NormalRateStrategy();
                model.BillResult result = strategy.calculate(data);

                invoiceDAO.createInvoice(
                        data.getReservationNo(), userId, data.getRoomType(), data.getCheckIn(), data.getCheckOut(),
                        (int) data.getTotalNights(), data.getRate(), result.getStrategyName(),
                        result.getSubtotal(), result.getDiscountAmount(), result.getTotal());

                // Fetch the newly created invoice to render it
                rs = invoiceDAO.findInvoiceForCustomer(c, no.trim(), userId);
                if (!rs.next()) {
                    resp.sendRedirect(req.getContextPath() + "/customer/my-bookings?err=Invoice+generation+failed");
                    return;
                }
            }

            // put invoice fields to request
            req.setAttribute("inv_reservation_no", rs.getString("reservation_no"));
            req.setAttribute("inv_room_type", rs.getString("room_type"));
            req.setAttribute("inv_check_in", rs.getDate("check_in"));
            req.setAttribute("inv_check_out", rs.getDate("check_out"));
            req.setAttribute("inv_nights", rs.getInt("nights"));
            req.setAttribute("inv_rate", rs.getBigDecimal("base_rate"));
            req.setAttribute("inv_strategy", rs.getString("strategy_used"));
            req.setAttribute("inv_subtotal", rs.getBigDecimal("subtotal"));
            req.setAttribute("inv_discount", rs.getBigDecimal("discount"));
            req.setAttribute("inv_total", rs.getBigDecimal("total"));
            req.setAttribute("inv_created", rs.getTimestamp("created_at"));

            req.getRequestDispatcher("/customer/invoice.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/customer/my-bookings?err=Invoice+load+failed");
        }
    }
}