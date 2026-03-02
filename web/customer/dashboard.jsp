<%-- 
    Document   : dashboard
    Created on : Feb 25, 2026, 10:09:25 PM
    Author     : Haruda
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String fullName = (String) session.getAttribute("fullName");
    String role = (String) session.getAttribute("role");
    if (fullName == null || fullName.trim().isEmpty()) {
        fullName = "Guest";
    }
    if (role == null || role.trim().isEmpty()) {
        role = "CUSTOMER";
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Customer Dashboard | Ocean View Resort</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/dashboard.css">
</head>

<body>

<!-- TOPBAR -->
<div class="topbar">
    <div class="brand">Ocean View Resort • Customer Portal</div>
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
            Book instantly or request a reservation for staff approval. Track your bookings and reservations in real time.
        </p>

        <div style="margin-top:12px;">
            <span class="badge">Instant Booking</span>
            <span class="badge">Reservation Requests</span>
            <span class="badge">Secure Portal</span>
        </div>
    </div>

    <!-- CARDS -->
    <div class="grid">

        <div class="glass-card">
            <h3>Book / Request</h3>
            <p>Book instantly or submit a reservation request for staff approval (time-limited).</p>
            <div class="action">
                <a class="btn" href="<%=request.getContextPath()%>/customer/book">Open</a>
            </div>
        </div>

        <div class="glass-card">
            <h3>My Bookings</h3>
            <p>View your direct bookings that are confirmed instantly using <b>Book Now</b>.</p>
            <div class="action">
                <a class="btn" href="<%=request.getContextPath()%>/customer/my-bookings">View</a>
            </div>
        </div>

        <div class="glass-card">
            <h3>My Reservations</h3>
            <p>Track reservation requests (PENDING/CONFIRMED/REJECTED/EXPIRED) and see expiry time.</p>
            <div class="action">
                <a class="btn" href="<%=request.getContextPath()%>/customer/my-reservations">View</a>
            </div>
        </div>

        <div class="glass-card">
            <h3>Bill & Receipt</h3>
            <p>Generate your bill for confirmed bookings/reservations and print a receipt.</p>
            <div class="action">
                <a class="btn" href="<%=request.getContextPath()%>/customer/bill.jsp">Open</a>
            </div>
        </div>

            <div class="glass-card">
    <h3>Help & Support</h3>
    <p>Read FAQ and submit a support ticket to the resort team.</p>
    <div class="action">
        <a class="btn" href="<%=request.getContextPath()%>/customer/support">Open</a>
    </div>
</div>
    </div>

</div>
</div>

<!-- FOOTER -->
<div class="footer">
    © 2026 Ocean View Resort • Customer Portal
</div>

</body>
</html>