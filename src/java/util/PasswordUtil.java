/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.Base64;

public class PasswordUtil {

    public static String generateSalt() {
        byte[] salt = new byte[16];
        new SecureRandom().nextBytes(salt);
        return Base64.getEncoder().encodeToString(salt);
    }

    public static String hashPassword(String password, String saltBase64) {
        try {
            byte[] salt = Base64.getDecoder().decode(saltBase64);
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(salt);
            byte[] hashed = md.digest(password.getBytes(StandardCharsets.UTF_8));
            return Base64.getEncoder().encodeToString(hashed);
        } catch (Exception e) {
            throw new RuntimeException("Password hashing failed", e);
        }
    }

    // Store as: salt:hash
    public static String createStoredPassword(String plainPassword) {
        String salt = generateSalt();
        String hash = hashPassword(plainPassword, salt);
        return salt + ":" + hash;
    }

    public static boolean verifyPassword(String plainPassword, String stored) {
        if (stored == null || !stored.contains(":")) return false;
        String[] parts = stored.split(":");
        if (parts.length != 2) return false;

        String salt = parts[0];
        String expectedHash = parts[1];
        String actualHash = hashPassword(plainPassword, salt);
        return expectedHash.equals(actualHash);
    }
}