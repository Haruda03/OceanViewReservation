/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.BillData;
import model.ReservationDetail;
import model.ReservationView;
import util.DBConnectionManager;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {

    /*
     * ---------------------- EXPIRY (RESERVATION requests only)
     * ----------------------
     */

    public int expireOldPending() throws SQLException {
        String sql = "UPDATE reservations SET status='EXPIRED' " +
                "WHERE request_type='RESERVATION' AND status='PENDING' " +
                "AND expires_at IS NOT NULL AND expires_at <= NOW()";

        try (Connection c = DBConnectionManager.getInstance().getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {
            return ps.executeUpdate();
        }
    }

    /*
     * ---------------------- AVAILABILITY / CONFLICT CHECK ----------------------
     */

    // Blocks:
    // 1) Any CONFIRMED booking/reservation
    // 2) Any active RESERVATION request (PENDING and not expired)
    // Overlap rule: existing.check_in < new.check_out AND existing.check_out >
    // new.check_in
    public boolean hasConflict(int roomId, LocalDate checkIn, LocalDate checkOut) throws SQLException {
        String sql = "SELECT 1 FROM reservations " +
                "WHERE room_id=? " +
                "AND (" +
                "   status='CONFIRMED' " +
                "   OR (request_type='RESERVATION' AND status='PENDING' AND expires_at IS NOT NULL AND expires_at > NOW())"
                +
                ") " +
                "AND check_in < ? AND check_out > ? " +
                "LIMIT 1";

        try (Connection c = DBConnectionManager.getInstance().getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, roomId);
            ps.setDate(2, Date.valueOf(checkOut));
            ps.setDate(3, Date.valueOf(checkIn));

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    /* ---------------------- CREATE: DIRECT BOOKING ---------------------- */

    public void createDirectBooking(String reservationNo, int userId, int roomId,
            LocalDate checkIn, LocalDate checkOut, int guests) throws SQLException {

        String sql = "INSERT INTO reservations(reservation_no, user_id, room_id, check_in, check_out, guests, status, request_type) "
                +
                "VALUES (?,?,?,?,?,?,'CONFIRMED','BOOKING')";

        try (Connection c = DBConnectionManager.getInstance().getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setString(1, reservationNo);
            ps.setInt(2, userId);
            ps.setInt(3, roomId);
            ps.setDate(4, Date.valueOf(checkIn));
            ps.setDate(5, Date.valueOf(checkOut));
            ps.setInt(6, guests);

            ps.executeUpdate();
        }
    }

    /*
     * ---------------------- CREATE: RESERVATION REQUEST (PENDING + expires)
     * ----------------------
     */

    public void createReservationRequest(String reservationNo, int userId, int roomId,
            LocalDate checkIn, LocalDate checkOut, int guests,
            int expireMinutes) throws SQLException {

        String sql = "INSERT INTO reservations(reservation_no, user_id, room_id, check_in, check_out, guests, status, expires_at, request_type) "
                +
                "VALUES (?,?,?,?,?,?,'PENDING', DATE_ADD(NOW(), INTERVAL ? MINUTE), 'RESERVATION')";

        try (Connection c = DBConnectionManager.getInstance().getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setString(1, reservationNo);
            ps.setInt(2, userId);
            ps.setInt(3, roomId);
            ps.setDate(4, Date.valueOf(checkIn));
            ps.setDate(5, Date.valueOf(checkOut));
            ps.setInt(6, guests);
            ps.setInt(7, expireMinutes);

            ps.executeUpdate();
        }
    }

    public Integer getUserIdByReservationNo(String reservationNo) throws SQLException {
        String sql = "SELECT user_id FROM reservations WHERE reservation_no=? LIMIT 1";
        try (Connection c = DBConnectionManager.getInstance().getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, reservationNo);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next())
                    return rs.getInt("user_id");
                return null;
            }
        }
    }

    /* ---------------------- CUSTOMER LISTS (SPLIT) ---------------------- */

    // Direct bookings only (request_type = BOOKING)
    public List<ReservationView> findBookingsByUser(int userId) throws SQLException {

        String sql = "SELECT r.reservation_no, r.check_in, r.check_out, r.guests, r.status, r.request_type, r.expires_at, "
                +
                "       rm.room_type, rm.rate " +
                "FROM reservations r " +
                "JOIN rooms rm ON rm.room_id = r.room_id " +
                "WHERE r.user_id=? AND r.request_type='BOOKING' " +
                "ORDER BY r.created_at DESC";

        List<ReservationView> list = new ArrayList<>();

        try (Connection c = DBConnectionManager.getInstance().getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ReservationView v = mapReservationView(rs);
                    list.add(v);
                }
            }
        }
        return list;
    }

    // Reservation requests only (request_type = RESERVATION)
    public List<ReservationView> findReservationRequestsByUser(int userId) throws SQLException {

        String sql = "SELECT r.reservation_no, r.check_in, r.check_out, r.guests, r.status, r.request_type, r.expires_at, "
                +
                "       rm.room_type, rm.rate " +
                "FROM reservations r " +
                "JOIN rooms rm ON rm.room_id = r.room_id " +
                "WHERE r.user_id=? AND r.request_type='RESERVATION' " +
                "ORDER BY r.created_at DESC";

        List<ReservationView> list = new ArrayList<>();

        try (Connection c = DBConnectionManager.getInstance().getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ReservationView v = mapReservationView(rs);
                    list.add(v);
                }
            }
        }
        return list;
    }

    private ReservationView mapReservationView(ResultSet rs) throws SQLException {
        ReservationView v = new ReservationView();
        v.setReservationNo(rs.getString("reservation_no"));
        v.setCheckIn(rs.getDate("check_in").toLocalDate());
        v.setCheckOut(rs.getDate("check_out").toLocalDate());
        v.setGuests(rs.getInt("guests"));
        v.setStatus(rs.getString("status"));
        v.setRequestType(rs.getString("request_type"));
        v.setRoomType(rs.getString("room_type"));
        v.setRate(rs.getBigDecimal("rate"));
        v.setExpiresAt(rs.getTimestamp("expires_at"));
        return v;
    }

    /*
     * ---------------------- STAFF: ACTIVE PENDING REQUESTS (RESERVATION only)
     * ----------------------
     */

    public List<ReservationView> findActivePendingRequests() throws SQLException {

        String sql = "SELECT r.reservation_no, r.check_in, r.check_out, r.guests, r.status, r.request_type, r.expires_at, "
                +
                "       rm.room_type, rm.rate " +
                "FROM reservations r " +
                "JOIN rooms rm ON rm.room_id = r.room_id " +
                "WHERE r.request_type='RESERVATION' AND r.status='PENDING' " +
                "AND r.expires_at IS NOT NULL AND r.expires_at > NOW() " +
                "ORDER BY r.requested_at ASC";

        List<ReservationView> list = new ArrayList<>();

        try (Connection c = DBConnectionManager.getInstance().getConnection();
                PreparedStatement ps = c.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapReservationView(rs));
            }
        }
        return list;
    }

    /*
     * ---------------------- STAFF ACTIONS: APPROVE / REJECT (RESERVATION only)
     * ----------------------
     */

    public void approveReservation(String reservationNo, int staffUserId) throws SQLException {
        String sql = "UPDATE reservations SET status='CONFIRMED', approved_by=?, approved_at=NOW() " +
                "WHERE reservation_no=? AND request_type='RESERVATION' AND status='PENDING'";

        try (Connection c = DBConnectionManager.getInstance().getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, staffUserId);
            ps.setString(2, reservationNo);
            ps.executeUpdate();
        }
    }

    public void rejectReservation(String reservationNo, int staffUserId, String note) throws SQLException {
        String sql = "UPDATE reservations SET status='REJECTED', approved_by=?, approved_at=NOW(), decision_note=? " +
                "WHERE reservation_no=? AND request_type='RESERVATION' AND status='PENDING'";

        try (Connection c = DBConnectionManager.getInstance().getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, staffUserId);
            ps.setString(2, note);
            ps.setString(3, reservationNo);
            ps.executeUpdate();
        }
    }

    /* ---------------------- CUSTOMER DETAILS (SECURE) ---------------------- */

    public ReservationDetail findDetailForCustomer(String reservationNo, int userId) throws SQLException {

        String sql = "SELECT r.reservation_no, r.check_in, r.check_out, r.guests, r.status, r.request_type, " +
                "       r.requested_at, r.expires_at, r.decision_note, r.approved_at, " +
                "       rm.room_type, rm.rate, " +
                "       u.full_name AS customer_name, u.email AS customer_email, " +
                "       au.full_name AS approved_by_name " +
                "FROM reservations r " +
                "JOIN rooms rm ON rm.room_id = r.room_id " +
                "JOIN users u ON u.user_id = r.user_id " +
                "LEFT JOIN users au ON au.user_id = r.approved_by " +
                "WHERE r.reservation_no=? AND r.user_id=? " +
                "LIMIT 1";

        try (Connection c = DBConnectionManager.getInstance().getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setString(1, reservationNo);
            ps.setInt(2, userId);

            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next())
                    return null;

                ReservationDetail d = new ReservationDetail();
                d.setReservationNo(rs.getString("reservation_no"));
                d.setCheckIn(rs.getDate("check_in").toLocalDate());
                d.setCheckOut(rs.getDate("check_out").toLocalDate());
                d.setGuests(rs.getInt("guests"));
                d.setStatus(rs.getString("status"));
                d.setRequestType(rs.getString("request_type"));

                d.setRequestedAt(rs.getTimestamp("requested_at"));
                d.setExpiresAt(rs.getTimestamp("expires_at"));
                d.setDecisionNote(rs.getString("decision_note"));
                d.setApprovedAt(rs.getTimestamp("approved_at"));
                d.setApprovedByName(rs.getString("approved_by_name"));

                d.setRoomType(rs.getString("room_type"));
                d.setRate(rs.getBigDecimal("rate"));
                d.setFullName(rs.getString("customer_name"));
                d.setEmail(rs.getString("customer_email"));

                return d;
            }
        }
    }

    /*
     * ---------------------- BILLING: CONFIRMED ONLY (for Strategy Pattern)
     * ----------------------
     */

    public BillData findConfirmedBillDataForCustomer(String reservationNo, int userId) throws SQLException {

        String sql = "SELECT r.reservation_no, r.check_in, r.check_out, rm.room_type, rm.rate " +
                "FROM reservations r " +
                "JOIN rooms rm ON rm.room_id = r.room_id " +
                "WHERE r.reservation_no=? AND r.user_id=? AND r.status='CONFIRMED' " +
                "LIMIT 1";

        try (Connection c = DBConnectionManager.getInstance().getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setString(1, reservationNo);
            ps.setInt(2, userId);

            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next())
                    return null;

                BillData d = new BillData();
                d.setReservationNo(rs.getString("reservation_no"));
                d.setRoomType(rs.getString("room_type"));
                d.setRate(rs.getBigDecimal("rate"));
                d.setCheckIn(rs.getDate("check_in").toLocalDate());
                d.setCheckOut(rs.getDate("check_out").toLocalDate());
                return d;
            }
        }
    }

    // STAFF: get all reservations (with optional filters)
    public List<ReservationView> staffFindAll(String status, String requestType) throws SQLException {

        String sql = "SELECT r.reservation_no, r.check_in, r.check_out, r.guests, r.status, r.request_type, r.expires_at, "
                +
                "       rm.room_type, rm.rate " +
                "FROM reservations r " +
                "JOIN rooms rm ON rm.room_id = r.room_id " +
                "WHERE (? IS NULL OR r.status = ?) " +
                "AND (? IS NULL OR r.request_type = ?) " +
                "ORDER BY r.created_at DESC";

        List<ReservationView> list = new ArrayList<>();

        try (Connection c = DBConnectionManager.getInstance().getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setString(2, status);
            ps.setString(3, requestType);
            ps.setString(4, requestType);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ReservationView v = new ReservationView();
                    v.setReservationNo(rs.getString("reservation_no"));
                    v.setCheckIn(rs.getDate("check_in").toLocalDate());
                    v.setCheckOut(rs.getDate("check_out").toLocalDate());
                    v.setGuests(rs.getInt("guests"));
                    v.setStatus(rs.getString("status"));
                    v.setRequestType(rs.getString("request_type"));
                    v.setRoomType(rs.getString("room_type"));
                    v.setRate(rs.getBigDecimal("rate"));
                    v.setExpiresAt(rs.getTimestamp("expires_at"));
                    list.add(v);
                }
            }
        }
        return list;
    }

    // STAFF: update reservation status (CONFIRMED -> COMPLETED, etc.)
    public void staffUpdateStatus(String reservationNo, String newStatus, int staffUserId) throws SQLException {

        String sql = "UPDATE reservations SET status=?, approved_by=?, approved_at=NOW() " +
                "WHERE reservation_no=?";

        try (Connection c = DBConnectionManager.getInstance().getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setString(1, newStatus);
            ps.setInt(2, staffUserId);
            ps.setString(3, reservationNo);
            ps.executeUpdate();
        }
    }

    public int countActivePendingReservationRequests() throws SQLException {
        String sql = "SELECT COUNT(*) " +
                "FROM reservations " +
                "WHERE request_type='RESERVATION' AND status='PENDING' " +
                "AND expires_at IS NOT NULL AND expires_at > NOW()";

        try (Connection c = DBConnectionManager.getInstance().getConnection();
                PreparedStatement ps = c.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            rs.next();
            return rs.getInt(1);
        }
    }
    // ========================= REPORTS & ANALYTICS =========================

    // Summary counts for all time
    public java.util.Map<String, Integer> reportStatusCounts() throws SQLException {
        String sql = "SELECT " +
                "SUM(CASE WHEN status='PENDING' THEN 1 ELSE 0 END) AS pending, " +
                "SUM(CASE WHEN status='CONFIRMED' THEN 1 ELSE 0 END) AS confirmed, " +
                "SUM(CASE WHEN status='COMPLETED' THEN 1 ELSE 0 END) AS completed, " +
                "SUM(CASE WHEN status='CANCELLED' THEN 1 ELSE 0 END) AS cancelled, " +
                "SUM(CASE WHEN status='REJECTED' THEN 1 ELSE 0 END) AS rejected, " +
                "SUM(CASE WHEN status='EXPIRED' THEN 1 ELSE 0 END) AS expired " +
                "FROM reservations";

        java.util.Map<String, Integer> m = new java.util.HashMap<>();

        try (Connection c = DBConnectionManager.getInstance().getConnection();
                PreparedStatement ps = c.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            rs.next();
            m.put("pending", rs.getInt("pending"));
            m.put("confirmed", rs.getInt("confirmed"));
            m.put("completed", rs.getInt("completed"));
            m.put("cancelled", rs.getInt("cancelled"));
            m.put("rejected", rs.getInt("rejected"));
            m.put("expired", rs.getInt("expired"));
        }
        return m;
    }

    // Revenue in date range (by check_in date)
    public java.math.BigDecimal reportRevenue(LocalDate from, LocalDate to) throws SQLException {

        String sql = "SELECT COALESCE(SUM(DATEDIFF(r.check_out, r.check_in) * rm.rate), 0) AS revenue " +
                "FROM reservations r " +
                "JOIN rooms rm ON rm.room_id = r.room_id " +
                "WHERE r.status IN ('CONFIRMED','COMPLETED') " +
                "AND r.check_in >= ? AND r.check_in < ?";

        try (Connection c = DBConnectionManager.getInstance().getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setDate(1, java.sql.Date.valueOf(from));
            ps.setDate(2, java.sql.Date.valueOf(to));

            try (ResultSet rs = ps.executeQuery()) {
                rs.next();
                return rs.getBigDecimal("revenue");
            }
        }
    }

    // Top room types by revenue (date range)
    public List<java.util.Map<String, Object>> reportTopRoomTypes(LocalDate from, LocalDate to, int limit)
            throws SQLException {

        String sql = "SELECT rm.room_type, " +
                "       COUNT(*) AS bookings, " +
                "       COALESCE(SUM(DATEDIFF(r.check_out, r.check_in) * rm.rate),0) AS revenue " +
                "FROM reservations r " +
                "JOIN rooms rm ON rm.room_id = r.room_id " +
                "WHERE r.status IN ('CONFIRMED','COMPLETED') " +
                "AND r.check_in >= ? AND r.check_in < ? " +
                "GROUP BY rm.room_type " +
                "ORDER BY revenue DESC " +
                "LIMIT ?";

        List<java.util.Map<String, Object>> list = new java.util.ArrayList<>();

        try (Connection c = DBConnectionManager.getInstance().getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setDate(1, java.sql.Date.valueOf(from));
            ps.setDate(2, java.sql.Date.valueOf(to));
            ps.setInt(3, limit);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    java.util.Map<String, Object> row = new java.util.HashMap<>();
                    row.put("roomType", rs.getString("room_type"));
                    row.put("bookings", rs.getInt("bookings"));
                    row.put("revenue", rs.getBigDecimal("revenue"));
                    list.add(row);
                }
            }
        }
        return list;
    }

    // Daily revenue (date range) - use for charts later
    public List<java.util.Map<String, Object>> reportDailyRevenue(LocalDate from, LocalDate to) throws SQLException {

        String sql = "SELECT r.check_in AS day, " +
                "       COALESCE(SUM(DATEDIFF(r.check_out, r.check_in) * rm.rate),0) AS revenue " +
                "FROM reservations r " +
                "JOIN rooms rm ON rm.room_id = r.room_id " +
                "WHERE r.status IN ('CONFIRMED','COMPLETED') " +
                "AND r.check_in >= ? AND r.check_in < ? " +
                "GROUP BY r.check_in " +
                "ORDER BY r.check_in ASC";

        List<java.util.Map<String, Object>> list = new java.util.ArrayList<>();

        try (Connection c = DBConnectionManager.getInstance().getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setDate(1, java.sql.Date.valueOf(from));
            ps.setDate(2, java.sql.Date.valueOf(to));

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    java.util.Map<String, Object> row = new java.util.HashMap<>();
                    row.put("day", rs.getDate("day").toLocalDate());
                    row.put("revenue", rs.getBigDecimal("revenue"));
                    list.add(row);
                }
            }
        }
        return list;
    }

    public BillData findBillDataByReservationNo(String reservationNo) throws SQLException {
        String sql = "SELECT r.reservation_no, r.user_id, r.check_in, r.check_out, rm.room_type, rm.rate " +
                "FROM reservations r " +
                "JOIN rooms rm ON rm.room_id = r.room_id " +
                "WHERE r.reservation_no=? " +
                "LIMIT 1";

        try (Connection c = DBConnectionManager.getInstance().getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setString(1, reservationNo);

            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next())
                    return null;

                BillData d = new BillData();
                d.setReservationNo(rs.getString("reservation_no"));
                d.setUserId(rs.getInt("user_id")); // ADD userId in BillData model (see note)
                d.setRoomType(rs.getString("room_type"));
                d.setRate(rs.getBigDecimal("rate"));
                d.setCheckIn(rs.getDate("check_in").toLocalDate());
                d.setCheckOut(rs.getDate("check_out").toLocalDate());
                return d;
            }
        }
    }
}