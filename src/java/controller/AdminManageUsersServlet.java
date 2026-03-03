package controller;

import dao.UserDAO;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/manage-users")
public class AdminManageUsersServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    private boolean isAdmin(HttpSession s) {
        if (s == null)
            return false;
        String role = (String) s.getAttribute("role");
        return "ADMIN".equals(role);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession s = req.getSession(false);
        if (!isAdmin(s)) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String roleFilter = req.getParameter("role");
        if (roleFilter == null) {
            roleFilter = "ALL";
        }

        try {
            List<User> list = userDAO.findAllUsers(roleFilter);
            req.setAttribute("userList", list);
            req.setAttribute("roleFilter", roleFilter);
            req.getRequestDispatcher("/admin/manageUsers.jsp").forward(req, resp);
        } catch (SQLException e) {
            e.printStackTrace();
            req.setAttribute("error", "Database error loading users: " + e.getMessage());
            req.getRequestDispatcher("/admin/manageUsers.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession s = req.getSession(false);
        if (!isAdmin(s)) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String action = req.getParameter("action");
        String idStr = req.getParameter("userId");

        if ("delete".equals(action) && idStr != null) {
            try {
                int userId = Integer.parseInt(idStr);
                // Prevent admin from deleting themselves
                Integer currentUserId = (Integer) s.getAttribute("userId");
                if (currentUserId != null && currentUserId == userId) {
                    resp.sendRedirect(req.getContextPath() + "/admin/manage-users?err=Cannot+delete+your+own+account");
                    return;
                }

                userDAO.deleteUser(userId);
                resp.sendRedirect(req.getContextPath() + "/admin/manage-users?msg=User+deleted+successfully");
            } catch (Exception e) {
                e.printStackTrace();
                resp.sendRedirect(req.getContextPath() + "/admin/manage-users?err=Error+deleting+user");
            }
        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/manage-users");
        }
    }
}
