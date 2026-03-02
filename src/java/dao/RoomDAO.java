/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.Room;
import util.DBConnectionManager;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoomDAO {

    public List<Room> findActiveRooms() throws SQLException {
        String sql = "SELECT room_id, room_type, rate, max_guests FROM rooms WHERE status='ACTIVE' ORDER BY rate ASC";
        List<Room> rooms = new ArrayList<>();

        try (Connection c = DBConnectionManager.getInstance().getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Room r = new Room();
                r.setRoomId(rs.getInt("room_id"));
                r.setRoomType(rs.getString("room_type"));
                r.setRate(rs.getBigDecimal("rate"));
                r.setMaxGuests(rs.getInt("max_guests"));
                rooms.add(r);
            }
        }
        return rooms;
    }
    public List<Room> findAllRooms() throws SQLException {
    String sql = "SELECT room_id, room_type, rate, max_guests, status FROM rooms ORDER BY room_id DESC";
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
            r.setStatus(rs.getString("status")); // ACTIVE / INACTIVE
            list.add(r);
        }
    }
    return list;
}

public void updateRoom(int roomId, java.math.BigDecimal rate, String status) throws SQLException {
    String sql = "UPDATE rooms SET rate=?, status=? WHERE room_id=?";
    try (Connection c = DBConnectionManager.getInstance().getConnection();
         PreparedStatement ps = c.prepareStatement(sql)) {
        ps.setBigDecimal(1, rate);
        ps.setString(2, status);
        ps.setInt(3, roomId);
        ps.executeUpdate();
    }
}

   
}
