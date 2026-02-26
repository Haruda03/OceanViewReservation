<%-- 
    Document   : dashboard
    Created on : Feb 25, 2026, 10:09:25 PM
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
    <title>Customer Dashboard | Ocean View Resort</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/ocean-app.css">
</head>
<body>

<div class="topbar">
    <div class="brand">Ocean View Resort • Customer Portal</div>
    <div class="userchip"><%= fullName %> • <%= role %> •
        <a class="link" style="color:white;" href="<%=request.getContextPath()%>/logout">Logout</a>
    </div>
</div>

<div class="container">

    <div class="hero">
        <h1>Welcome back, <%= fullName %> 🌊</h1>
        <p>Book beachfront rooms, manage your reservations, and generate your bill securely. Enjoy a smooth check-in experience at Ocean View Resort, Galle.</p>
        <div style="margin-top:12px;">
            <span class="badge">Secure Login</span>
            <span class="badge">Online Booking</span>
            <span class="badge">Bill & Receipt</span>
        </div>
    </div>

    <div class="grid">
        <div class="card">
            <h3>Book a Room</h3>
            <p>Create a new reservation by selecting room type, check-in/out dates, and guest details. Validation will prevent wrong dates and conflicts.</p>
            <div class="action">
                <a class="btn" href="<%=request.getContextPath()%>/customer/bookRoom.jsp">New Reservation</a>
                <a class="link" href="<%=request.getContextPath()%>/customer/help.jsp">How it works</a>
            </div>
        </div>

        <div class="card">
            <h3>My Reservations</h3>
            <p>View your reservation list with status (Confirmed/Cancelled/Completed). Quickly open reservation details using your reservation number.</p>
            <div class="action">
                <a class="btn" href="<%=request.getContextPath()%>/customer/myReservations.jsp">View List</a>
                <a class="link" href="<%=request.getContextPath()%>/customer/reservationDetails.jsp">Find by No.</a>
            </div>
        </div>

        <div class="card">
            <h3>Bill & Print</h3>
            <p>Generate your bill based on number of nights and room rate. Print or download a receipt for check-out.</p>
            <div class="action">
                <a class="btn" href="<%=request.getContextPath()%>/customer/bill.jsp">Calculate Bill</a>
                <a class="link" href="<%=request.getContextPath()%>/customer/help.jsp">Billing help</a>
            </div>
        </div>

        <div class="card">
            <h3>Help & Support</h3>
            <p>Guidelines for booking, changing dates, and viewing bills. Designed for new users with clear steps and messages.</p>
            <div class="action">
                <a class="btn" href="<%=request.getContextPath()%>/customer/help.jsp">Open Help</a>
                <a class="link" href="<%=request.getContextPath()%>/index.jsp">Resort Home</a>
            </div>
        </div>
    </div>

    <div class="footer">© 2026 Ocean View Resort • Customer Portal</div>
</div>
</body>
</html>