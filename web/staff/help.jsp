<%-- 
    Document   : help
    Purpose    : Staff help / guidance page
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String fullName = (String) session.getAttribute("fullName");
    String role = (String) session.getAttribute("role");
    if (fullName == null || fullName.trim().isEmpty()) {
        fullName = "Staff";
    }
    if (role == null || role.trim().isEmpty()) {
        role = "STAFF";
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Help | Staff Console</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/ocean-app.css">
</head>
<body>

<div class="topbar">
    <div class="brand">Ocean View Resort • Staff Console</div>
    <div class="userchip">
        <%= fullName %> • <%= role %> •
        <a class="link" style="color:white;" href="<%=request.getContextPath()%>/logout">Logout</a>
    </div>
</div>

<div class="container">

    <div class="hero">
        <h1>Staff Help & Guide</h1>
        <p>Quick tips on how to use the staff console: reservations, rooms, reports, and support tickets.</p>
    </div>

    <div class="card" style="margin-top:16px;">
        <h3>Reservations & Requests</h3>
        <p>
            Use <b>Reservation Requests</b> to view and approve or reject pending reservation requests.
            Requests automatically expire after their configured time window.
        </p>
        <p>
            Use <b>Reservations Management</b> to see all bookings and reservations, filter by status,
            and mark confirmed stays as completed or cancelled.
        </p>
    </div>

    <div class="card" style="margin-top:16px;">
        <h3>Room Management</h3>
        <p>
            From <b>Room Management</b> you can add new rooms, update rates, and toggle status
            between <code>ACTIVE</code> and <code>INACTIVE</code>. Inactive rooms are hidden from
            customer booking searches.
        </p>
    </div>

    <div class="card" style="margin-top:16px;">
        <h3>Reports & Analytics</h3>
        <p>
            The <b>Reports</b> section shows summary counts by reservation status and revenue reports
            for a selected date range, including top room types and daily revenue.
        </p>
    </div>

    <div class="card" style="margin-top:16px; margin-bottom:16px;">
        <h3>Support Tickets</h3>
        <p>
            In <b>Support</b> you can view customer tickets with their name and email, update ticket
            statuses (OPEN → IN_PROGRESS → CLOSED), and keep a history of customer issues.
        </p>
    </div>

    <div class="actions" style="margin-bottom:20px;">
        <a class="btnlink" href="<%=request.getContextPath()%>/staff/dashboard">Back to Dashboard</a>
    </div>

    <div class="footer">© 2026 Ocean View Resort • Staff Help</div>
</div>

</body>
</html>

