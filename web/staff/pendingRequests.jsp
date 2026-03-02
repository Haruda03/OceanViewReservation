<%-- 
    Document   : pendingRequests
    Created on : Mar 1, 2026, 8:10:09 PM
    Author     : Haruda
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.ReservationView"%>
<%@page import="java.time.temporal.ChronoUnit"%>

<%
    String fullName = (String) session.getAttribute("fullName");
    String role = (String) session.getAttribute("role");

    String err = (String) request.getAttribute("error");
    List<ReservationView> list = (List<ReservationView>) request.getAttribute("requests");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Pending Requests | Ocean View Resort</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/ocean-app.css">
    <style>
        table{ width:100%; border-collapse:collapse; margin-top:12px; }
        th, td{ padding:10px; border-bottom:1px solid #e7eef6; text-align:left; vertical-align:top; }
        th{ color:#003366; background:#f2f8ff; }

        .chip{ display:inline-block; padding:6px 10px; border-radius:999px; font-weight:900; font-size:12px; }
        .pending{ background:#fff3cd; color:#8a6d00; }

        .btn-sm{
            padding:8px 10px; border-radius:10px;
            background:#00c3ff; color:#fff; text-decoration:none; font-weight:900;
            border:none; cursor:pointer;
        }
        .btn-sm:hover{ background:#009dcf; }

        .btn-danger{
            padding:8px 10px; border-radius:10px;
            background:#e64b4b; color:#fff; font-weight:900;
            border:none; cursor:pointer;
        }
        .btn-danger:hover{ background:#c83a3a; }

        .note-input{
            padding:8px 10px; border-radius:10px; border:1px solid #cfd9e6;
            width:160px;
        }

        .row-actions{ display:flex; gap:8px; flex-wrap:wrap; align-items:center; }
        .muted{ color:#666; font-size:12px; }
    </style>
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
        <h1>Pending Reservation Requests</h1>
        <p>Review reservation requests submitted by customers. Approve or reject before expiry to maintain availability and booking accuracy.</p>
        <div style="margin-top:12px;">
            <span class="badge">Time-Limited Requests</span>
            <span class="badge">Approve / Reject</span>
            <span class="badge">Operational Control</span>
        </div>
    </div>

    <div class="card" style="margin-top:16px;">
        <h3>Requests Queue</h3>

        <% if (err != null) { %>
            <div class="alert error"><%= err %></div>
        <% } %>

        <div class="actions" style="margin-top:10px;">
            <a class="btnlink" href="<%=request.getContextPath()%>/staff/dashboard.jsp">Back to Dashboard</a>
            <a class="btn" href="<%=request.getContextPath()%>/staff/reservations">Refresh</a>
        </div>

        <%
            if (list == null || list.isEmpty()) {
        %>
            <p style="margin-top:14px;color:#555;">No active pending requests right now.</p>
        <%
            } else {
        %>

        <table>
            <thead>
            <tr>
                <th>Reservation No</th>
                <th>Room</th>
                <th>Check-in</th>
                <th>Check-out</th>
                <th>Nights</th>
                <th>Guests</th>
                <th>Status</th>
                <th>Expires</th>
                <th>Actions</th>
            </tr>
            </thead>

            <tbody>
            <%
                for (ReservationView r : list) {
                    long nights = ChronoUnit.DAYS.between(r.getCheckIn(), r.getCheckOut());
            %>
            <tr>
                <td><b><%= r.getReservationNo() %></b></td>
                <td>
                    <%= r.getRoomType() %>
                    <div class="muted">LKR <%= r.getRate() %> / night</div>
                </td>
                <td><%= r.getCheckIn() %></td>
                <td><%= r.getCheckOut() %></td>
                <td><%= nights %></td>
                <td><%= r.getGuests() %></td>
                <td><span class="chip pending">PENDING</span></td>
                <td><%= r.getExpiresAt() %></td>

                <td>
                    <div class="row-actions">
                        <!-- APPROVE -->
                        <form method="post" action="<%=request.getContextPath()%>/staff/reservations">
                            <input type="hidden" name="action" value="approve">
                            <input type="hidden" name="no" value="<%= r.getReservationNo() %>">
                            <button type="submit" class="btn-sm">Approve</button>
                        </form>

                        <!-- REJECT -->
                        <form method="post" action="<%=request.getContextPath()%>/staff/reservations">
                            <input type="hidden" name="action" value="reject">
                            <input type="hidden" name="no" value="<%= r.getReservationNo() %>">
                            <input type="text" class="note-input" name="note" placeholder="Reject reason" required>
                            <button type="submit" class="btn-danger">Reject</button>
                        </form>
                    </div>
                </td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>

        <% } %>
    </div>

    <div class="footer">© 2026 Ocean View Resort • Staff Requests Console</div>
</div>

</body>
</html>
