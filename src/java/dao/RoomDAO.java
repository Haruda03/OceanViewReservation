/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.math.BigDecimal;
import model.Room;
import util.DBConnectionManager;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class RoomDAO {

    // Customer: Find available ACTIVE rooms by date + guests
    public List<Room> findAvailableRooms(LocalDate checkIn, LocalDate checkOut, int guests) throws SQLException {

        String sql =
            "SELECT rm.room_id, rm.room_type, rm.rate, rm.max_guests, rm.status " +
            "FROM rooms rm " +
            "WHERE rm.status='ACTIVE' " +
            "AND rm.max_guests >= ? " +
            "AND rm.room_id NOT IN ( " +
            "   SELECT r.room_id FROM reservations r " +
            "   WHERE ( " +
            "       r.status='CONFIRMED' " +
            "       OR (r.request_type='RESERVATION' AND r.status='PENDING' AND r.expires_at IS NOT NULL AND r.expires_at > NOW()) " +
            "   ) " +
            "   AND r.check_in < ? AND r.check_out > ? " +
            ") " +
            "ORDER BY rm.rate ASC";

        List<Room> list = new ArrayList<>();

        try (Connection c = DBConnectionManager.getInstance().getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, guests);
            ps.setDate(2, Date.valueOf(checkOut)); // overlap: existing.check_in < new.check_out
            ps.setDate(3, Date.valueOf(checkIn));  // overlap: existing.check_out > new.check_in

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Room r = new Room();
                    r.setRoomId(rs.getInt("room_id"));
                    r.setRoomType(rs.getString("room_type"));
                    r.setRate(rs.getBigDecimal("rate"));
                    r.setMaxGuests(rs.getInt("max_guests"));
                    r.setStatus(rs.getString("status"));
                    list.add(r);
                }
            }
        }
        return list;
    }

    // Staff / customer: list ACTIVE rooms without date filter
    public List<Room> findActiveRooms() throws SQLException {
        String sql =
                "SELECT room_id, room_type, rate, max_guests, status " +
                "FROM rooms " +
                "WHERE status = 'ACTIVE' " +
                "ORDER BY rate ASC";

        List<Room> list = new ArrayList<>();

        try (Connection c = DBConnectionManager.getInstance().getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Room r = new Room();
                r.setRoomId(rs.getInt("room_id"));
                r.setRoomType(rs.getString("room_type"));
                r.setRate(rs.getBigDecimal("rate"));
                r.setMaxGuests(rs.getInt("max_guests"));
                r.setStatus(rs.getString("status"));
                list.add(r);
            }
        }
        return list;
    }

    public void addRoom(String roomType, BigDecimal rate, int maxGuests, String status) throws SQLException {
        String sql =
                "INSERT INTO rooms(room_type, rate, max_guests, status) " +
                "VALUES (?,?,?,?)";

        try (Connection c = DBConnectionManager.getInstance().getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setString(1, roomType);
            ps.setBigDecimal(2, rate);
            ps.setInt(3, maxGuests);
            ps.setString(4, status);
            ps.executeUpdate();
        }
    }

    // Check if a room has any non-expired active booking/reservation
    public boolean hasActiveBooking(int roomId) throws SQLException {
        String sql =
                "SELECT 1 FROM reservations " +
                "WHERE room_id=? " +
                "AND (" +
                "   status='CONFIRMED' " +
                "   OR (request_type='RESERVATION' AND status='PENDING' AND expires_at IS NOT NULL AND expires_at > NOW())" +
                ") " +
                "LIMIT 1";

        try (Connection c = DBConnectionManager.getInstance().getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, roomId);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    public void deleteRoom(int roomId) throws SQLException {
        String sql = "DELETE FROM rooms WHERE room_id=?";

        try (Connection c = DBConnectionManager.getInstance().getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, roomId);
            ps.executeUpdate();
        }
    }

    public void updateRoom(int roomId, BigDecimal rate, String status) throws SQLException {
        String sql =
                "UPDATE rooms SET rate=?, status=? " +
                "WHERE room_id=?";

        try (Connection c = DBConnectionManager.getInstance().getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setBigDecimal(1, rate);
            ps.setString(2, status);
            ps.setInt(3, roomId);
            ps.executeUpdate();
        }
    }

    public List<Room> findAllRooms() throws SQLException {
        String sql =
                "SELECT room_id, room_type, rate, max_guests, status " +
                "FROM rooms " +
                "ORDER BY room_id ASC";

        List<Room> list = new ArrayList<>();

        try (Connection c = DBConnectionManager.getInstance().getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Room r = new Room();
                r.setRoomId(rs.getInt("room_id"));
                r.setRoomType(rs.getString("room_type"));
                r.setRate(rs.getBigDecimal("rate"));
                r.setMaxGuests(rs.getInt("max_guests"));
                r.setStatus(rs.getString("status"));
                list.add(r);
            }
        }
        return list;
    }
}