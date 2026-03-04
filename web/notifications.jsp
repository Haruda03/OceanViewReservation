<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@page import="java.util.List" %>
        <%@page import="model.Notification" %>
            <%@page import="java.text.SimpleDateFormat" %>
                <% String roleUrl="customer/dashboard.jsp" ; String role=(String) session.getAttribute("role"); if
                    ("STAFF".equals(role) || "ADMIN" .equals(role)) { roleUrl="staff/dashboard.jsp" ; }
                    List<Notification> notifications = (List<Notification>) request.getAttribute("notifications");
                        Integer unreadCountObj = (Integer) request.getAttribute("unreadCount");
                        int unreadCount = (unreadCountObj != null) ? unreadCountObj : 0;
                        SimpleDateFormat sdf = new SimpleDateFormat("MMM dd, yyyy HH:mm");
                        %>
                        <!DOCTYPE html>
                        <html>

                        <head>
                            <title>Activity & Notifications</title>
                            <link rel="stylesheet" href="<%=request.getContextPath()%>/css/dashboard.css">
                            <style>
                                .notif-container {
                                    max-width: 800px;
                                    margin: 40px auto;
                                    padding: 20px;
                                    background: #fff;
                                    border-radius: 10px;
                                    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                                }

                                .notif-item {
                                    padding: 15px;
                                    border-bottom: 1px solid #eee;
                                    display: flex;
                                    justify-content: space-between;
                                    align-items: center;
                                }

                                .notif-item:last-child {
                                    border-bottom: none;
                                }

                                .unread {
                                    background-color: #f0f8ff;
                                    border-left: 4px solid #007bff;
                                }

                                .notif-msg {
                                    font-size: 16px;
                                    color: #333;
                                    margin-bottom: 5px;
                                }

                                .notif-time {
                                    font-size: 13px;
                                    color: #888;
                                }

                                .btn-sm {
                                    padding: 6px 12px;
                                    font-size: 13px;
                                    text-decoration: none;
                                    border-radius: 4px;
                                    border: none;
                                    cursor: pointer;
                                }

                                .btn-sm-primary {
                                    background: #007bff;
                                    color: white;
                                }

                                .btn-all {
                                    display: inline-block;
                                    padding: 8px 16px;
                                    margin-bottom: 15px;
                                    background: #28a745;
                                    color: #fff;
                                    text-decoration: none;
                                    border-radius: 4px;
                                }

                                .header-flex {
                                    display: flex;
                                    justify-content: space-between;
                                    align-items: center;
                                    border-bottom: 2px solid #eee;
                                    padding-bottom: 10px;
                                    margin-bottom: 20px;
                                }
                            </style>
                        </head>

                        <body style="background:#f4f7f6;">

                            <div class="topbar">
                                <div class="brand">Notifications Portal</div>
                                <div class="userchip">
                                    <a class="btn-back" href="<%=request.getContextPath()%>/<%=roleUrl%>">
                                        <svg viewBox="0 0 24 24">
                                            <path d="M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z" />
                                        </svg> Back to Dashboard
                                    </a>
                                    <a class="link" style="color:white;"
                                        href="<%=request.getContextPath()%>/logout">Logout</a>
                                </div>
                            </div>

                            <div class="notif-container" style="margin-top:80px;">
                                <div class="header-flex">
                                    <h2>Your Notifications <% if(unreadCount> 0) { %><span
                                                style="color:red; font-size:16px;">(<%=unreadCount%> Unread)</span>
                                            <% } %>
                                    </h2>
                                    <% if(unreadCount> 0) { %>
                                        <form action="<%=request.getContextPath()%>/notifications" method="post"
                                            style="margin:0;">
                                            <input type="hidden" name="action" value="markAll">
                                            <button type="submit" class="btn-all"
                                                style="border:none; cursor:pointer;">Mark All as Read</button>
                                        </form>
                                        <% } %>
                                </div>

                                <% if (notifications==null || notifications.isEmpty()) { %>
                                    <p>No new notifications at this time.</p>
                                    <% } else { %>
                                        <% for(Notification n : notifications) { %>
                                            <div class="notif-item <%= (n.isRead() ? "" : " unread") %>">
                                                <div>
                                                    <div class="notif-msg">
                                                        <%= n.getMessage().replace("<", "&lt;" ).replace(">", "&gt;") %>
                                                    </div>
                                                    <div class="notif-time">
                                                        <%= sdf.format(n.getCreatedAt()) %>
                                                    </div>
                                                </div>
                                                <% if (!n.isRead()) { %>
                                                    <form action="<%=request.getContextPath()%>/notifications"
                                                        method="post" style="margin:0;">
                                                        <input type="hidden" name="action" value="markRead">
                                                        <input type="hidden" name="id" value="<%= n.getNotifId() %>">
                                                        <button type="submit" class="btn-sm btn-sm-primary">Mark
                                                            Read</button>
                                                    </form>
                                                    <% } %>
                                            </div>
                                            <% } %>
                                                <% } %>
                            </div>

                        </body>

                        </html>