/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.SupportTicket;
import util.DBConnectionManager;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SupportTicketDAO {

    public void createTicket(int userId, String subject, String message) throws SQLException {
        String sql = "INSERT INTO support_tickets(user_id, subject, message) VALUES (?,?,?)";

        try (Connection c = DBConnectionManager.getInstance().getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setString(2, subject);
            ps.setString(3, message);
            ps.executeUpdate();
        }
    }

    public List<SupportTicket> findTicketsByUser(int userId) throws SQLException {
        String sql = "SELECT ticket_id, user_id, subject, message, status, created_at " +
                     "FROM support_tickets WHERE user_id=? ORDER BY created_at DESC";

        List<SupportTicket> list = new ArrayList<>();

        try (Connection c = DBConnectionManager.getInstance().getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    SupportTicket t = new SupportTicket();
                    t.setTicketId(rs.getInt("ticket_id"));
                    t.setUserId(rs.getInt("user_id"));
                    t.setSubject(rs.getString("subject"));
                    t.setMessage(rs.getString("message"));
                    t.setStatus(rs.getString("status"));
                    t.setCreatedAt(rs.getTimestamp("created_at"));
                    list.add(t);
                }
            }
        }
        return list;
    }
    
   public List<SupportTicket> findAllTickets() throws SQLException {

    String sql =
        "SELECT s.ticket_id, s.user_id, s.subject, s.message, s.status, s.created_at, " +
        "       u.full_name, u.email " +
        "FROM support_tickets s " +
        "JOIN users u ON u.user_id = s.user_id " +
        "ORDER BY s.created_at DESC";

    List<SupportTicket> list = new ArrayList<>();

    try (Connection c = DBConnectionManager.getInstance().getConnection();
         PreparedStatement ps = c.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            SupportTicket t = new SupportTicket();

            t.setTicketId(rs.getInt("ticket_id"));
            t.setUserId(rs.getInt("user_id"));
            t.setSubject(rs.getString("subject"));
            t.setMessage(rs.getString("message"));
            t.setStatus(rs.getString("status"));
            t.setCreatedAt(rs.getTimestamp("created_at"));

            // NEW
            t.setCustomerName(rs.getString("full_name"));
            t.setCustomerEmail(rs.getString("email"));

            list.add(t);
        }
    }

    return list;
}
public void updateTicketStatus(int ticketId, String status) throws SQLException {
    String sql = "UPDATE support_tickets SET status=? WHERE ticket_id=?";

    try (Connection c = DBConnectionManager.getInstance().getConnection();
         PreparedStatement ps = c.prepareStatement(sql)) {

        ps.setString(1, status);
        ps.setInt(2, ticketId);
        ps.executeUpdate();
    }
}
public int countTicketsByStatus(String status) throws SQLException {
    String sql = "SELECT COUNT(*) FROM support_tickets WHERE status=?";

    try (Connection c = DBConnectionManager.getInstance().getConnection();
         PreparedStatement ps = c.prepareStatement(sql)) {

        ps.setString(1, status);

        try (ResultSet rs = ps.executeQuery()) {
            rs.next();
            return rs.getInt(1);
        }
    }
}
}