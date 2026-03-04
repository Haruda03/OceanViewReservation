<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@page import="model.User" %>
        <%@page import="java.util.List" %>
            <% String fullName=(String) session.getAttribute("fullName"); String role=(String)
                session.getAttribute("role"); /* Auth check */ if (role==null || !"ADMIN".equals(role)) {
                response.sendRedirect(request.getContextPath() + "/login.jsp" ); return; } String
                err=request.getParameter("err"); String msg=request.getParameter("msg"); if (err==null) { err=(String)
                request.getAttribute("error"); } List<User> userList = (List<User>) request.getAttribute("userList");
                    String currentFilter = (String) request.getAttribute("roleFilter");
                    if (currentFilter == null) {
                    currentFilter = "ALL";
                    }

                    Integer currentUserId = (Integer) session.getAttribute("userId");
                    %>
                    <!DOCTYPE html>
                    <html>

                    <head>
                        <title>Manage Users | Ocean View Resort</title>
                        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/ocean-app.css">
                        <style>
                            table {
                                width: 100%;
                                border-collapse: collapse;
                                margin-top: 16px;
                                font-size: 14px;
                            }

                            th,
                            td {
                                padding: 12px 10px;
                                border-bottom: 1px solid #e7eef6;
                                text-align: left;
                                vertical-align: middle;
                            }

                            th {
                                color: #003366;
                                background: #f2f8ff;
                                font-weight: 800;
                                border-radius: 4px;
                            }

                            .role-badge {
                                padding: 6px 12px;
                                border-radius: 999px;
                                font-size: 11px;
                                font-weight: bold;
                            }

                            .role-ADMIN {
                                background-color: #ffe5e5;
                                color: #a10000;
                            }

                            .role-STAFF {
                                background-color: #e9f7ff;
                                color: #006a8e;
                            }

                            .role-CUSTOMER {
                                background-color: #e7ffe8;
                                color: #0b6b12;
                            }

                            .smallbtn {
                                padding: 6px 10px;
                                border-radius: 6px;
                                background: #dc3545;
                                border: none;
                                color: #fff;
                                text-decoration: none;
                                font-weight: 900;
                                font-size: 12px;
                                cursor: pointer;
                                display: inline-block;
                            }

                            .smallbtn:hover {
                                background: #c82333;
                            }

                            .smallbtn:disabled {
                                background: #e0e0e0;
                                color: #999;
                                cursor: not-allowed;
                            }

                            .filter-form {
                                display: flex;
                                gap: 10px;
                                align-items: center;
                                margin-top: 10px;
                                margin-bottom: 20px;
                            }

                            select {
                                padding: 8px 10px;
                                border-radius: 10px;
                                border: 1px solid #cfd9e6;
                            }

                            .filter-btn {
                                padding: 8px 16px;
                                border-radius: 10px;
                                background: #003366;
                                color: #fff;
                                border: none;
                                cursor: pointer;
                                font-weight: bold;
                            }

                            .filter-btn:hover {
                                background: #002244;
                            }
                        </style>
                    </head>

                    <body>

                        <div class="topbar">
                            <div class="brand">Ocean View Resort • Admin Portal</div>
                            <div class="userchip">
                                <%= fullName %> • <%= role %> •
                                        <a class="link" style="color:white;"
                                            href="<%=request.getContextPath()%>/logout">Logout</a>
                            </div>
                        </div>

                        <div class="container">
                            <div class="hero">
                                <h1>Manage Users</h1>
                                <p>View, filter, and remove accounts for all staff members and customers.</p>
                            </div>

                            <div class="card"
                                style="margin-top:16px; max-width:900px; margin-left:auto; margin-right:auto;">

                                <div style="display:flex; justify-content:space-between; align-items:center;">
                                    <h3>User Directory</h3>
                                    <div>
                                        <a class="btn" href="<%=request.getContextPath()%>/admin/createUser.jsp">Create
                                            New User</a>
                                        <a class="btn-back" href="<%=request.getContextPath()%>/admin/dashboard.jsp">
                                            <svg viewBox="0 0 24 24">
                                                <path
                                                    d="M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z" />
                                            </svg> Back to Dashboard
                                        </a>
                                    </div>
                                </div>

                                <% if (err !=null && !err.isEmpty()) { %>
                                    <div class="alert error">
                                        <%= err %>
                                    </div>
                                    <% } %>

                                        <% if (msg !=null && !msg.isEmpty()) { %>
                                            <div class="alert success"
                                                style="background:#e7ffe8; color:#0b6b12; padding:12px; border-radius:8px; margin-bottom:12px;">
                                                <%= msg %>
                                            </div>
                                            <% } %>

                                                <form method="GET"
                                                    action="<%=request.getContextPath()%>/admin/manage-users"
                                                    class="filter-form">
                                                    <label style="font-weight:bold; color:#555;">Filter by Role:</label>
                                                    <select name="role">
                                                        <option value="ALL" <%="ALL" .equals(currentFilter) ? "selected"
                                                            : "" %>>All Users</option>
                                                        <option value="CUSTOMER" <%="CUSTOMER" .equals(currentFilter)
                                                            ? "selected" : "" %>>Customers</option>
                                                        <option value="STAFF" <%="STAFF" .equals(currentFilter)
                                                            ? "selected" : "" %>>Staff</option>
                                                        <option value="ADMIN" <%="ADMIN" .equals(currentFilter)
                                                            ? "selected" : "" %>>Admins</option>
                                                    </select>
                                                    <button type="submit" class="filter-btn">Apply</button>
                                                </form>

                                                <% if (userList==null || userList.isEmpty()) { %>
                                                    <p style="margin-top:14px;color:#555;text-align:center;">No users
                                                        found.</p>
                                                    <% } else { %>
                                                        <table>
                                                            <thead>
                                                                <tr>
                                                                    <th>ID</th>
                                                                    <th>Full Name</th>
                                                                    <th>Email</th>
                                                                    <th>Phone</th>
                                                                    <th>Role</th>
                                                                    <th>Action</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <% for (User u : userList) { %>
                                                                    <tr>
                                                                        <td>
                                                                            <%= u.getUserId() %>
                                                                        </td>
                                                                        <td style="font-weight:bold; color:#003366;">
                                                                            <%= u.getFullName() %>
                                                                        </td>
                                                                        <td>
                                                                            <%= u.getEmail() %>
                                                                        </td>
                                                                        <td>
                                                                            <%= (u.getPhone() !=null) ? u.getPhone()
                                                                                : "-" %>
                                                                        </td>
                                                                        <td>
                                                                            <span
                                                                                class="role-badge role-<%= u.getRole() %>">
                                                                                <%= u.getRole() %>
                                                                            </span>
                                                                        </td>
                                                                        <td>
                                                                            <% if (currentUserId !=null &&
                                                                                currentUserId.equals(u.getUserId())) {
                                                                                %>
                                                                                <button class="smallbtn" disabled
                                                                                    title="You cannot delete yourself">Delete</button>
                                                                                <% } else { %>
                                                                                    <form method="POST"
                                                                                        action="<%=request.getContextPath()%>/admin/manage-users"
                                                                                        style="display:inline;"
                                                                                        onsubmit="return confirm('Are you sure you want to permanently delete this user? This action cannot be undone.');">
                                                                                        <input type="hidden"
                                                                                            name="action"
                                                                                            value="delete">
                                                                                        <input type="hidden"
                                                                                            name="userId"
                                                                                            value="<%= u.getUserId() %>">
                                                                                        <button type="submit"
                                                                                            class="smallbtn">Delete</button>
                                                                                    </form>
                                                                                    <% } %>
                                                                        </td>
                                                                    </tr>
                                                                    <% } %>
                                                            </tbody>
                                                        </table>
                                                        <% } %>

                            </div>

                            <div class="footer">© 2026 Ocean View Resort • Admin Management</div>
                        </div>

                    </body>

                    </html>