/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import dao.UserDAO;
import model.User;
import util.PasswordUtil;

public class AuthService {
    private final UserDAO userDAO = new UserDAO();

    public User login(String email, String password) throws Exception {
        User u = userDAO.findByEmail(email);
        if (u == null) return null;

        boolean ok = PasswordUtil.verifyPassword(password, u.getPasswordHash());
        return ok ? u : null;
    }
}
