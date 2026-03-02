<%-- 
    Document   : dashboard
    Created on : Feb 25, 2026, 10:10:30 PM
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
    <title>Staff Dashboard | Ocean View Resort</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/dashboard.css">
</head>

<body>

<!-- TOPBAR -->
<div class="topbar">
    <div class="brand">Ocean View Resort • Staff Console</div>
    <div class="userchip">
        <%= fullName %> • <%= role %> •
        <a class="link" style="color:white;" href="<%=request.getContextPath()%>/logout">Logout</a>
    </div>
</div>

<!-- FULL OCEAN BACKGROUND -->
<div class="full-hero">
<div class="hero-inner">

    <!-- WELCOME -->
    <div style="text-align:center; margin-bottom:30px;">
        <h1>Welcome, <%= fullName %> 🌊</h1>
        <p>
            Manage reservation requests, confirmed bookings, room availability, customer support, and reports for Ocean View Resort.
        </p>

        <div style="margin-top:12px;">
            <span class="badge">Operations</span>
            <span class="badge">Approvals</span>
            <span class="badge">Service Management</span>
        </div>
    </div>

    <!-- FEATURE CARDS -->
    <div class="grid">

        <!-- Reservation Requests -->
        <div class="glass-card">
            <h3>Reservation Requests</h3>
            <p>
                View and process customer reservation requests (PENDING). Approve or reject before expiry.
            </p>
            <div class="action">
                <a class="btn" href="<%=request.getContextPath()%>/staff/reservations">
                    View Requests
                </a>
            </div>
        </div>

        <!-- Reservations Management -->
        <div class="glass-card">
            <h3>Reservations Management</h3>
            <p>
                View all bookings/reservations with filters. Cancel confirmed stays or mark them as completed.
            </p>
            <div class="action">
                <a class="btn" href="<%=request.getContextPath()%>/staff/reservations-manage">
                    Manage
                </a>
            </div>
        </div>

        <!-- Room Management -->
        <div class="glass-card">
            <h3>Room Management</h3>
            <p>
                Update room rates and toggle availability (ACTIVE / INACTIVE) to control inventory.
            </p>
            <div class="action">
                <a class="btn" href="<%=request.getContextPath()%>/staff/rooms">
                    Rooms
                </a>
            </div>
        </div>

        <!-- Reports -->
        <div class="glass-card">
            <h3>Reports & Analytics</h3>
            <p>
                View operational summary: pending, confirmed, completed, cancelled, and estimated revenue.
            </p>
            <div class="action">
                <a class="btn" href="<%=request.getContextPath()%>/staff/reports">
                    Reports
                </a>
            </div>
        </div>

        <!-- Support Tickets -->
        <div class="glass-card">
            <h3>Support Tickets</h3>
            <p>
                View customer support tickets with name and email. Update ticket status workflow.
            </p>
            <div class="action">
                <a class="btn" href="<%=request.getContextPath()%>/staff/support">
                    Support
                </a>
            </div>
        </div>

        <!-- Quick Links -->
        <div class="glass-card">
            <h3>Quick Actions</h3>
            <p style="margin-bottom:10px;">Common staff tasks:</p>
            <div class="action" style="display:flex; gap:10px; flex-wrap:wrap;">
                <a class="btn" href="<%=request.getContextPath()%>/staff/reservations">Pending</a>
                <a class="btn" href="<%=request.getContextPath()%>/staff/rooms">Rates</a>
                <a class="btn" href="<%=request.getContextPath()%>/staff/support">Tickets</a>
            </div>
        </div>

    </div>

</div>
</div>

<!-- FOOTER -->
<div class="footer">
    © 2026 Ocean View Resort • Staff Operations Portal
</div>

</body>
</html>