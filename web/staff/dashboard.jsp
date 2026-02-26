<%-- 
    Document   : dashboard
    Created on : Feb 25, 2026, 10:10:30 PM
    Author     : Haruda
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String name = (String) session.getAttribute("fullName");
    String role = (String) session.getAttribute("role");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String fullName = (String) session.getAttribute("fullName");
    String role = (String) session.getAttribute("role");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Staff Dashboard | Ocean View Resort</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/ocean-app.css">
</head>
<body>

<div class="topbar">
    <div class="brand">Ocean View Resort • Staff Console</div>
    <div class="userchip"><%= fullName %> • <%= role %> •
        <a class="link" style="color:white;" href="<%=request.getContextPath()%>/logout">Logout</a>
    </div>
</div>

<div class="container">

    <div class="hero">
        <h1>Staff Operations Dashboard 🧾</h1>
        <p>Search and verify reservations, manage booking status, generate reports, and support guests during check-in/check-out. Access is role-restricted for security.</p>
        <div style="margin-top:12px;">
            <span class="badge">Role-Based Access</span>
            <span class="badge">Reservation Search</span>
            <span class="badge">Reports</span>
        </div>
    </div>

    <div class="grid">
        <div class="card">
            <h3>Search Reservation</h3>
            <p>Retrieve complete booking information using reservation number. This supports quick verification at reception.</p>
            <div class="action">
                <a class="btn" href="<%=request.getContextPath()%>/staff/searchReservation.jsp">Search</a>
                <a class="link" href="<%=request.getContextPath()%>/staff/help.jsp">Help</a>
            </div>
        </div>

        <div class="card">
            <h3>Manage Reservations</h3>
            <p>Confirm, cancel, or mark reservations as completed. Staff actions update database records and status logs.</p>
            <div class="action">
                <a class="btn" href="<%=request.getContextPath()%>/staff/manageReservations.jsp">Manage</a>
                <a class="link" href="<%=request.getContextPath()%>/staff/reservationDetails.jsp">Details</a>
            </div>
        </div>

        <div class="card">
            <h3>Billing Support</h3>
            <p>Assist guests by calculating bills based on nights × rate, including discounts/seasonal rules if applicable.</p>
            <div class="action">
                <a class="btn" href="<%=request.getContextPath()%>/staff/billSupport.jsp">Generate Bill</a>
                <a class="link" href="<%=request.getContextPath()%>/staff/help.jsp">Billing guide</a>
            </div>
        </div>

        <div class="card">
            <h3>Reports (Value Added)</h3>
            <p>Daily check-ins/check-outs, occupancy summary, and revenue estimates for management decision-making.</p>
            <div class="action">
                <a class="btn" href="<%=request.getContextPath()%>/staff/reports.jsp">Open Reports</a>
                <a class="link" href="<%=request.getContextPath()%>/staff/help.jsp">How to use</a>
            </div>
        </div>

        <% if ("ADMIN".equals(role)) { %>
        <div class="card">
            <h3>Admin: Create Staff/Admin</h3>
            <p>Create user accounts with controlled permissions. Prevents privilege escalation through public registration.</p>
            <div class="action">
                <a class="btn" href="<%=request.getContextPath()%>/admin/createUser.jsp">Create User</a>
                <a class="link" href="<%=request.getContextPath()%>/admin/manageUsers.jsp">Manage Users</a>
            </div>
        </div>
        <% } %>
    </div>

    <div class="footer">© 2026 Ocean View Resort • Staff Console</div>
</div>
</body>
</html>