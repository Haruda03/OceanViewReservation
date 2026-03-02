<%-- 
    Document   : helpSupport
    Created on : Mar 2, 2026, 10:25:26 AM
    Author     : Haruda
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.SupportTicket"%>

<%
    String fullName = (String) session.getAttribute("fullName");
    String role = (String) session.getAttribute("role");

    String err = (String) request.getAttribute("error");
    String msg = (String) request.getAttribute("msg");
    List<SupportTicket> tickets = (List<SupportTicket>) request.getAttribute("tickets");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Help & Support | Ocean View Resort</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/ocean-app.css">
    <style>
        .faq{ margin-top:14px; }
        details{ background:rgba(255,255,255,0.85); border-radius:14px; padding:12px 14px; margin-bottom:10px; }
        summary{ cursor:pointer; font-weight:900; color:#003366; }
        .grid2{ display:grid; grid-template-columns:1fr 1fr; gap:14px; }
        @media(max-width:900px){ .grid2{ grid-template-columns:1fr; } }

        table{ width:100%; border-collapse:collapse; margin-top:10px; }
        th,td{ padding:10px; border-bottom:1px solid #e7eef6; text-align:left; vertical-align:top; }
        th{ background:#f2f8ff; color:#003366; }

        .chip{ padding:6px 10px; border-radius:999px; font-weight:900; font-size:12px; display:inline-block; }
        .OPEN{ background:#fff3cd; color:#8a6d00; }
        .IN_PROGRESS{ background:#e9f7ff; color:#006a8e; }
        .CLOSED{ background:#e7ffe8; color:#0b6b12; }

        input, textarea, select{
            width:100%;
            padding:10px 12px;
            border-radius:12px;
            border:1px solid #cfd9e6;
            outline:none;
        }
        textarea{ min-height:120px; resize:vertical; }
        .muted{ color:#666; font-size:12px; }
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
        <h1>Help & Support</h1>
        <p>Find quick answers or send a support request to the resort team.</p>
        <div style="margin-top:12px;">
            <span class="badge">FAQ</span>
            <span class="badge">Support Tickets</span>
            <span class="badge">Customer Assistance</span>
        </div>
    </div>

    <div class="actions" style="margin-top:14px;">
        <a class="btnlink" href="<%=request.getContextPath()%>/customer/dashboard.jsp">Back</a>
        <a class="btn" href="<%=request.getContextPath()%>/customer/support">Refresh</a>
    </div>

    <% if (err != null) { %>
        <div class="alert error" style="margin-top:12px;"><%= err %></div>
    <% } %>
    <% if (msg != null) { %>
        <div class="alert success" style="margin-top:12px;"><%= msg %></div>
    <% } %>

    <div class="grid2" style="margin-top:16px;">

        <!-- LEFT: FAQ -->
        <div class="card">
            <h3>Frequently Asked Questions</h3>
            <div class="faq">
                <details>
                    <summary>How do I book instantly?</summary>
                    <div class="muted" style="margin-top:8px;">
                        Go to Book/Request page and click <b>Book Now (Instant)</b>. Your booking becomes <b>CONFIRMED</b> immediately.
                    </div>
                </details>

                <details>
                    <summary>How does reservation request work?</summary>
                    <div class="muted" style="margin-top:8px;">
                        Click <b>Request Reservation</b>. It becomes <b>PENDING</b> and staff must approve it before the expiry time.
                    </div>
                </details>

                <details>
                    <summary>Why did my request expire?</summary>
                    <div class="muted" style="margin-top:8px;">
                        If staff does not approve before the expiry time, the system automatically marks it <b>EXPIRED</b> and the room becomes available again.
                    </div>
                </details>

                <details>
                    <summary>When can I generate a bill?</summary>
                    <div class="muted" style="margin-top:8px;">
                        Bills are available only for <b>CONFIRMED</b> bookings/reservations.
                    </div>
                </details>
            </div>

            <h3 style="margin-top:16px;">Contact Info</h3>
            <p class="muted">
                Phone: +94 22 333 8888<br/>
                Email: support@oceanviewresort.com<br/>
                Hours: 08:00 – 20:00
            </p>
        </div>

        <!-- RIGHT: Support request form -->
        <div class="card">
            <h3>Submit a Support Request</h3>
            <form method="post" action="<%=request.getContextPath()%>/customer/support">
                <div style="margin-top:10px;">
                    <label><b>Subject</b></label>
                    <input type="text" name="subject" maxlength="120" placeholder="e.g., Booking issue / Payment question" required>
                </div>

                <div style="margin-top:10px;">
                    <label><b>Message</b></label>
                    <textarea name="message" placeholder="Write your issue clearly..." required></textarea>
                </div>

                <div class="actions" style="margin-top:14px;">
                    <button type="submit">Send Request</button>
                </div>

                <p class="muted" style="margin-top:10px;">
                    Your request will be stored as a ticket with status <b>OPEN</b>.
                </p>
            </form>
        </div>
    </div>

    <!-- Ticket history -->
    <div class="card" style="margin-top:16px;">
        <h3>My Support Tickets</h3>

        <% if (tickets == null || tickets.isEmpty()) { %>
            <p class="muted" style="margin-top:10px;">No tickets submitted yet.</p>
        <% } else { %>
            <table>
                <thead>
                <tr>
                    <th>Ticket ID</th>
                    <th>Subject</th>
                    <th>Status</th>
                    <th>Created</th>
                </tr>
                </thead>
                <tbody>
                <% for (SupportTicket t : tickets) { %>
                    <tr>
                        <td><b>#<%= t.getTicketId() %></b></td>
                        <td>
                            <%= t.getSubject() %>
                            <div class="muted" style="margin-top:6px;"><%= t.getMessage() %></div>
                        </td>
                        <td><span class="chip <%= t.getStatus() %>"><%= t.getStatus() %></span></td>
                        <td><%= t.getCreatedAt() %></td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        <% } %>
    </div>

    <div class="footer">© 2026 Ocean View Resort • Help & Support</div>
</div>

</body>
</html>
