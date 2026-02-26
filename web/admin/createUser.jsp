<%-- 
    Document   : createUser
    Created on : Feb 26, 2026, 6:47:05 PM
    Author     : Haruda
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String fullName = (String) session.getAttribute("fullName");
    String role = (String) session.getAttribute("role");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Create User | Ocean View Resort</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/ocean-app.css">
</head>
<body>

<div class="topbar">
    <div class="brand">Ocean View Resort • Admin Console</div>
    <div class="userchip">
        <%= fullName %> • <%= role %> •
        <a class="link" style="color:white;" href="<%=request.getContextPath()%>/logout">Logout</a>
    </div>
</div>

<div class="container">

    <div class="hero">
        <h1>Create Staff / Admin Account</h1>
        <p>Only administrators can create privileged users. This prevents unauthorized access and supports role-based security.</p>
        <div style="margin-top:12px;">
            <span class="badge">Least Privilege</span>
            <span class="badge">Secure Provisioning</span>
            <span class="badge">Role-Based Access</span>
        </div>
    </div>

    <div class="card" style="max-width:720px; margin:16px auto 0;">
        <h3>Create New User</h3>

        <%
            String err = (String) request.getAttribute("error");
            String msg = (String) request.getAttribute("msg");
            if (err != null) {
        %>
            <div class="alert error"><%= err %></div>
        <% } %>
        <% if (msg != null) { %>
            <div class="alert success"><%= msg %></div>
        <% } %>

        <form method="post" action="<%=request.getContextPath()%>/admin/create-user">
            <div style="margin-top:10px;">
                <label>Full Name</label><br/>
                <input type="text" name="fullName" required minlength="3"
                       placeholder="Reception Staff Member"/>
            </div>

            <div style="margin-top:10px;">
                <label>Email</label><br/>
                <input type="email" name="email" required placeholder="staff@ocean.com"/>
            </div>

            <div style="margin-top:10px;">
                <label>Phone (optional)</label><br/>
                <input type="text" name="phone" placeholder="+947XXXXXXXX"
                       pattern="^[0-9+]{9,15}$"
                       title="Enter 9–15 digits, can include +"/>
            </div>

            <div style="margin-top:10px;">
                <label>Temporary Password</label><br/>
                <input type="password" name="password" required minlength="6"
                       placeholder="Minimum 6 characters"/>
            </div>

            <div style="margin-top:10px;">
                <label>Role</label><br/>
                <select name="role" required>
                    <option value="STAFF">STAFF</option>
                    <option value="ADMIN">ADMIN</option>
                </select>
            </div>

            <div class="actions" style="margin-top:14px;">
                <button type="submit">Create User</button>
                <a class="btnlink" href="<%=request.getContextPath()%>/staff/dashboard.jsp">Back</a>
            </div>
        </form>
    </div>

    <div class="footer">© 2026 Ocean View Resort • Admin Console</div>
</div>

</body>
</html>