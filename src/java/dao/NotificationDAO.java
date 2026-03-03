package dao;

import model.Notification;
import util.DBConnectionManager;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NotificationDAO {

    public NotificationDAO() {
        ensureTableExists();
    }

    private void ensureTableExists() {
        String sql = "CREATE TABLE IF NOT EXISTS notifications (" +
                "notif_id INT AUTO_INCREMENT PRIMARY KEY, " +
                "user_id INT NULL, " +
                "message VARCHAR(255) NOT NULL, " +
                "is_read BOOLEAN DEFAULT FALSE, " +
                "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP" +
                ")";
        try (Connection c = DBConnectionManager.getInstance().getConnection();
                Statement stmt = c.createStatement()) {
            stmt.execute(sql);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void notifyUser(Integer userId, String message) throws SQLException {
        String sql = "INSERT INTO notifications (user_id, message) VALUES (?, ?)";
        try (Connection c = DBConnectionManager.getInstance().getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {
            if (userId == null) {
                ps.setNull(1, Types.INTEGER);
            } else {
                ps.setInt(1, userId);
            }
            ps.setString(2, message);
            ps.executeUpdate();
        }
    }

    public void notifyStaff(String message) throws SQLException {
        notifyUser(null, message); // null user_id means global staff notification
    }

    public int getUnreadCount(Integer userId) throws SQLException {
        String sql;
        if (userId == null) {
            sql = "SELECT COUNT(*) FROM notifications WHERE user_id IS NULL AND is_read=FALSE";
        } else {
            sql = "SELECT COUNT(*) FROM notifications WHERE user_id=? AND is_read=FALSE";
        }
        try (Connection c = DBConnectionManager.getInstance().getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {
            if (userId != null) {
                ps.setInt(1, userId);
            }
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next())
                    return rs.getInt(1);
            }
        }
        return 0;
    }

    public List<Notification> getRecentNotifications(Integer userId, int limit) throws SQLException {
        String sql;
        if (userId == null) {
            sql = "SELECT * FROM notifications WHERE user_id IS NULL ORDER BY created_at DESC LIMIT ?";
        } else {
            sql = "SELECT * FROM notifications WHERE user_id=? ORDER BY created_at DESC LIMIT ?";
        }
        List<Notification> list = new ArrayList<>();
        try (Connection c = DBConnectionManager.getInstance().getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {
            if (userId == null) {
                ps.setInt(1, limit);
            } else {
                ps.setInt(1, userId);
                ps.setInt(2, limit);
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Notification n = new Notification();
                    n.setNotifId(rs.getInt("notif_id"));
                    n.setUserId(rs.getObject("user_id") != null ? rs.getInt("user_id") : null);
                    n.setMessage(rs.getString("message"));
                    n.setRead(rs.getBoolean("is_read"));
                    n.setCreatedAt(rs.getTimestamp("created_at"));
                    list.add(n);
                }
            }
        }
        return list;
    }

    public void markAsRead(int notifId) throws SQLException {
        String sql = "UPDATE notifications SET is_read=TRUE WHERE notif_id=?";
        try (Connection c = DBConnectionManager.getInstance().getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, notifId);
            ps.executeUpdate();
        }
    }

    public void markAllAsRead(Integer userId) throws SQLException {
        String sql;
        if (userId == null) {
            sql = "UPDATE notifications SET is_read=TRUE WHERE user_id IS NULL";
        } else {
            sql = "UPDATE notifications SET is_read=TRUE WHERE user_id=?";
        }
        try (Connection c = DBConnectionManager.getInstance().getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {
            if (userId != null) {
                ps.setInt(1, userId);
            }
            ps.executeUpdate();
        }
    }
}
