package controller;

import dao.NotificationDAO;
import model.Notification;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/notifications")
public class NotificationServlet extends HttpServlet {

    private final NotificationDAO dao = new NotificationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        Integer userId = (Integer) session.getAttribute("userId");
        String role = (String) session.getAttribute("role");

        try {
            List<Notification> notifs;
            int unreadCount;
            if ("STAFF".equals(role) || "ADMIN".equals(role)) {
                notifs = dao.getRecentNotifications(null, 50);
                unreadCount = dao.getUnreadCount(null);
            } else {
                notifs = dao.getRecentNotifications(userId, 50);
                unreadCount = dao.getUnreadCount(userId);
            }
            request.setAttribute("notifications", notifs);
            request.setAttribute("unreadCount", unreadCount);
            request.getRequestDispatcher("/notifications.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500,
                    "Error loading notifications. CAUSE: " + e.toString() + " | MSG: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        Integer userId = (Integer) session.getAttribute("userId");
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");

        try {
            if ("markRead".equals(action) && idStr != null) {
                int notifId = Integer.parseInt(idStr);
                dao.markAsRead(notifId);
            } else if ("markAll".equals(action)) {
                String role = (String) session.getAttribute("role");
                if ("STAFF".equals(role) || "ADMIN".equals(role)) {
                    dao.markAllAsRead(null);
                } else {
                    dao.markAllAsRead(userId);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/notifications");
    }
}
