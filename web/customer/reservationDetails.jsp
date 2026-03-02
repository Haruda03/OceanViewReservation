<%-- 
    Document   : reservationDetails
    Created on : Feb 28, 2026, 11:38:58 AM
    Author     : Haruda
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.ReservationDetails"%>
<%@page import="java.time.temporal.ChronoUnit"%>

<%
    String fullName = (String) session.getAttribute("fullName");
    String role = (String) session.getAttribute("role");

    String err = (String) request.getAttribute("error");
    ReservationDetails d = (ReservationDetails) request.getAttribute("detail");

    long nights = 0;
    if (d != null) nights = ChronoUnit.DAYS.between(d.getCheckIn(), d.getCheckOut());
%>

<!DOCTYPE html>
<html>
<head>
    <title>Reservation Details | Ocean View Resort</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/ocean-app.css">
    <style>
        .kv{ display:grid; grid-template-columns:220px 1fr; gap:10px; margin-top:10px; }
        .k{ color:#003366; font-weight:900; }
        .v{ color:#333; }
        .status{ padding:6px 10px; border-radius:999px; font-weight:900; font-size:12px; display:inline-block; }

        .CONFIRMED{ background:#e7ffe8; color:#0b6b12; }
        .PENDING{ background:#fff3cd; color:#8a6d00; }
        .REJECTED{ background:#f8d7da; color:#8a1c1c; }
        .EXPIRED{ background:#e2e3e5; color:#4b4f56; }
        .CANCELLED{ background:#ffe5e5; color:#a10000; }
        .COMPLETED{ background:#e9f7ff; color:#006a8e; }

        .note{ padding:10px 12px; border-radius:12px; margin-top:12px; background:#f2f8ff; color:#003366; }
        .note.warn{ background:#fff3cd; color:#8a6d00; }
        .note.bad{ background:#f8d7da; color:#8a1c1c; }
        .note.gray{ background:#e2e3e5; color:#4b4f56; }
    </style>
</head>
<body>

<div class="topbar">
    <div class="brand">Ocean View Resort • Customer Portal</div>
    <div class="userchip">
        <%= fullName %> • <%= role %> •
        <a class="link" style="color:white;" href="<%=request.getContextPath()%>/logout">Logout</a>
    </div>
</div>

<div class="container">

    <div class="hero">
        <h1>Reservation Details</h1>
        <p>View your booking request, approval status, and stay information. Use your reservation number when contacting the resort.</p>
        <div style="margin-top:12px;">
            <span class="badge">Secure Access</span>
            <span class="badge">Status Tracking</span>
            <span class="badge">Billing Ready</span>
        </div>
    </div>

    <div class="card" style="margin-top:16px;">
        <h3>Details</h3>

        <% if (err != null) { %>
            <div class="alert error"><%= err %></div>
        <% } %>

        <% if (d != null) { %>

            <div class="kv">
                <div class="k">Reservation No</div>
                <div class="v"><b><%= d.getReservationNo() %></b></div>

                <div class="k">Status</div>
                <div class="v"><span class="status <%= d.getStatus() %>"><%= d.getStatus() %></span></div>

                <div class="k">Guest</div>
                <div class="v"><%= d.getFullName() %> (<%= d.getEmail() %>)</div>

                <div class="k">Room</div>
                <div class="v"><%= d.getRoomType() %> • LKR <%= d.getRate() %> / night</div>

                <div class="k">Check-in</div>
                <div class="v"><%= d.getCheckIn() %></div>

                <div class="k">Check-out</div>
                <div class="v"><%= d.getCheckOut() %></div>

                <div class="k">Nights</div>
                <div class="v"><%= nights %></div>

                <div class="k">Guests</div>
                <div class="v"><%= d.getGuests() %></div>

                <div class="k">Requested At</div>
                <div class="v"><%= d.getRequestedAt() %></div>

                <div class="k">Expires At</div>
                <div class="v"><%= (d.getExpiresAt() == null ? "-" : d.getExpiresAt()) %></div>

                <div class="k">Approved At</div>
                <div class="v"><%= (d.getApprovedAt() == null ? "-" : d.getApprovedAt()) %></div>

                <div class="k">Approved By</div>
                <div class="v"><%= (d.getApprovedByName() == null ? "-" : d.getApprovedByName()) %></div>

                <div class="k">Decision Note</div>
                <div class="v"><%= (d.getDecisionNote() == null ? "-" : d.getDecisionNote()) %></div>
            </div>

            <%-- Status guidance message --%>
            <% if ("PENDING".equals(d.getStatus())) { %>
                <div class="note warn">
                    Your reservation is <b>PENDING</b>. Staff will approve within the allowed time period.
                    If not approved before expiry, it becomes <b>EXPIRED</b>.
                </div>
            <% } else if ("REJECTED".equals(d.getStatus())) { %>
                <div class="note bad">
                    Your request was <b>REJECTED</b>. If you need support, please contact the resort or submit a new request.
                </div>
            <% } else if ("EXPIRED".equals(d.getStatus())) { %>
                <div class="note gray">
                    Your request has <b>EXPIRED</b> because it was not approved within the allowed time.
                    Please submit a new reservation request.
                </div>
            <% } else if ("CONFIRMED".equals(d.getStatus())) { %>
                <div class="note">
                    Your reservation is <b>CONFIRMED</b>. You can now generate your bill and receipt.
                </div>
            <% } %>

            <div class="actions" style="margin-top:14px;">
                <a class="btnlink" href="<%=request.getContextPath()%>/customer/my-reservations">Back to List</a>
                <a class="btnlink" href="<%=request.getContextPath()%>/customer/book">New Request</a>

                <% if ("CONFIRMED".equals(d.getStatus()) || "COMPLETED".equals(d.getStatus())) { %>
                    <a class="btn" href="<%=request.getContextPath()%>/customer/bill?no=<%= d.getReservationNo() %>">
                        Go to Bill
                    </a>
                <% } %>
            </div>

        <% } %>
    </div>

    <div class="footer">© 2026 Ocean View Resort • Reservation Details</div>
</div>

</body>
</html>