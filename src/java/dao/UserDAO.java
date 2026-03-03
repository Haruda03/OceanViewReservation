/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.User;
import util.DBConnectionManager;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    public boolean emailExists(String email) throws SQLException {
        String sql = "SELECT 1 FROM users WHERE email=?";
        try (Connection c = DBConnectionManager.getInstance().getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    public void createUser(User u) throws SQLException {
        String sql = "INSERT INTO users(full_name, email, phone, password_hash, role) VALUES (?,?,?,?,?)";
        try (Connection c = DBConnectionManager.getInstance().getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, u.getFullName());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getPhone());
            ps.setString(4, u.getPasswordHash());
            ps.setString(5, u.getRole());
            ps.executeUpdate();
        }
    }

    public User findByEmail(String email) throws SQLException {
        String sql = "SELECT user_id, full_name, email, phone, password_hash, role FROM users WHERE email=?";
        try (Connection c = DBConnectionManager.getInstance().getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next())
                    return null;

                User u = new User();
                u.setUserId(rs.getInt("user_id"));
                u.setFullName(rs.getString("full_name"));
                u.setEmail(rs.getString("email"));
                u.setPhone(rs.getString("phone"));
                u.setPasswordHash(rs.getString("password_hash"));
                u.setRole(rs.getString("role"));
                return u;
            }
        }
    }

    public List<User> findAllUsers(String roleFilter) throws SQLException {
        String sql = "SELECT user_id, full_name, email, phone, role FROM users";
        if (roleFilter != null && !roleFilter.trim().isEmpty() && !roleFilter.equalsIgnoreCase("ALL")) {
            sql += " WHERE role = ?";
        }
        sql += " ORDER BY role, full_name";

        List<User> list = new ArrayList<>();
        try (Connection c = DBConnectionManager.getInstance().getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {

            if (roleFilter != null && !roleFilter.trim().isEmpty() && !roleFilter.equalsIgnoreCase("ALL")) {
                ps.setString(1, roleFilter);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    User u = new User();
                    u.setUserId(rs.getInt("user_id"));
                    u.setFullName(rs.getString("full_name"));
                    u.setEmail(rs.getString("email"));
                    u.setPhone(rs.getString("phone"));
                    u.setRole(rs.getString("role"));
                    list.add(u);
                }
            }
        }
        return list;
    }

    public void deleteUser(int userId) throws SQLException {
        String sql = "DELETE FROM users WHERE user_id = ?";
        try (Connection c = DBConnectionManager.getInstance().getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.executeUpdate();
        }
    }
}