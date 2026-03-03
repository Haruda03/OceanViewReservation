/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import util.DBConnectionManager;

import java.sql.*;
import java.math.BigDecimal;
import java.time.LocalDate;

public class InvoiceDAO {

    public boolean invoiceExists(String reservationNo) throws SQLException {
        String sql = "SELECT 1 FROM invoices WHERE reservation_no=? LIMIT 1";
        try (Connection c = DBConnectionManager.getInstance().getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, reservationNo);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    public void createInvoice(
            String reservationNo, int userId,
            String roomType, LocalDate checkIn, LocalDate checkOut, int nights,
            BigDecimal baseRate, String strategyUsed,
            BigDecimal subtotal, BigDecimal discount, BigDecimal total
    ) throws SQLException {

        String sql =
            "INSERT INTO invoices(reservation_no,user_id,room_type,check_in,check_out,nights,base_rate,strategy_used,subtotal,discount,total) " +
            "VALUES (?,?,?,?,?,?,?,?,?,?,?)";

        try (Connection c = DBConnectionManager.getInstance().getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setString(1, reservationNo);
            ps.setInt(2, userId);
            ps.setString(3, roomType);
            ps.setDate(4, Date.valueOf(checkIn));
            ps.setDate(5, Date.valueOf(checkOut));
            ps.setInt(6, nights);
            ps.setBigDecimal(7, baseRate);
            ps.setString(8, strategyUsed);
            ps.setBigDecimal(9, subtotal);
            ps.setBigDecimal(10, discount);
            ps.setBigDecimal(11, total);

            ps.executeUpdate();
        }
    }

    // Customer can open invoice only if belongs to them
    public ResultSet findInvoiceForCustomer(Connection c, String reservationNo, int userId) throws SQLException {
        String sql = "SELECT * FROM invoices WHERE reservation_no=? AND user_id=? LIMIT 1";
        PreparedStatement ps = c.prepareStatement(sql);
        ps.setString(1, reservationNo);
        ps.setInt(2, userId);
        return ps.executeQuery();
    }
}