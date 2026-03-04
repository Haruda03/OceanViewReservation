<%-- Document : myReservations Created on : Feb 28, 2026, 11:00:24 AM Author : Haruda --%>

    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <%@page import="java.util.List" %>
            <%@page import="model.ReservationView" %>
                <%@page import="java.time.temporal.ChronoUnit" %>

                    <% String fullName=(String) session.getAttribute("fullName"); String role=(String)
                        session.getAttribute("role"); String err=(String) request.getAttribute("error");
                        List<ReservationView> reservations = (List<ReservationView>)
                            request.getAttribute("reservations");
                            %>

                            <!DOCTYPE html>
                            <html>

                            <head>
                                <title>My Reservations (Requests) | Ocean View Resort</title>
                                <link rel="stylesheet" href="<%=request.getContextPath()%>/css/ocean-app.css">
                                <style>
                                    table {
                                        width: 100%;
                                        border-collapse: collapse;
                                        margin-top: 10px;
                                    }

                                    th,
                                    td {
                                        padding: 10px;
                                        border-bottom: 1px solid #e7eef6;
                                        text-align: left;
                                        vertical-align: top;
                                    }

                                    th {
                                        color: #003366;
                                        background: #f2f8ff;
                                    }

                                    .status {
                                        padding: 6px 10px;
                                        border-radius: 999px;
                                        font-weight: 800;
                                        font-size: 12px;
                                        display: inline-block;
                                    }

                                    .PENDING {
                                        background: #fff3cd;
                                        color: #8a6d00;
                                    }

                                    .CONFIRMED {
                                        background: #e7ffe8;
                                        color: #0b6b12;
                                    }

                                    .REJECTED {
                                        background: #f8d7da;
                                        color: #8a1c1c;
                                    }

                                    .EXPIRED {
                                        background: #e2e3e5;
                                        color: #4b4f56;
                                    }

                                    .CANCELLED {
                                        background: #ffe5e5;
                                        color: #a10000;
                                    }

                                    .COMPLETED {
                                        background: #e9f7ff;
                                        color: #006a8e;
                                    }

                                    .smallbtn {
                                        padding: 8px 10px;
                                        border-radius: 10px;
                                        background: #00c3ff;
                                        color: #fff;
                                        text-decoration: none;
                                        font-weight: 800;
                                    }

                                    .smallbtn:hover {
                                        background: #009dcf;
                                    }

                                    .muted {
                                        color: #666;
                                        font-size: 12px;
                                    }
                                </style>
                            </head>

                            <body>

                                <div class="topbar">
                                    <div class="brand">Ocean View Resort • Customer Portal</div>
                                    <div class="userchip">
                                        <%= fullName %> • <%= role %> •
                                                <a class="link" style="color:white;"
                                                    href="<%=request.getContextPath()%>/logout">Logout</a>
                                    </div>
                                </div>

                                <div class="container">

                                    <div class="hero">
                                        <h1>My Reservations (Requests)</h1>
                                        <p>
                                            These are reservation requests sent for staff approval. Requests expire if
                                            staff does not approve within the allowed time period.
                                        </p>
                                        <div style="margin-top:12px;">
                                            <span class="badge">PENDING → CONFIRMED</span>
                                            <span class="badge">Approval Workflow</span>
                                            <span class="badge">Expiry Handling</span>
                                        </div>
                                    </div>

                                    <div class="card" style="margin-top:16px;">
                                        <h3>Reservation Requests</h3>

                                        <% if (err !=null) { %>
                                            <div class="alert error">
                                                <%= err %>
                                            </div>
                                            <% } %>

                                                <div class="actions" style="margin-top:10px;">
                                                    <a class="btn"
                                                        href="<%=request.getContextPath()%>/customer/book">New
                                                        Request</a>
                                                    <a class="btn-back"
                                                        href="<%=request.getContextPath()%>/customer/dashboard.jsp">
                                                        <svg viewBox="0 0 24 24">
                                                            <path
                                                                d="M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z" />
                                                        </svg> Back
                                                    </a>
                                                </div>

                                                <% if (reservations==null || reservations.isEmpty()) { %>
                                                    <p style="margin-top:14px;color:#555;">
                                                        No reservation requests found yet. Use <b>Request
                                                            Reservation</b> on the booking page.
                                                    </p>
                                                    <% } else { %>

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
                                                                    <th>Action</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <% for (ReservationView r : reservations) { long
                                                                    nights=ChronoUnit.DAYS.between(r.getCheckIn(),
                                                                    r.getCheckOut()); String st=r.getStatus(); %>
                                                                    <tr>
                                                                        <td><b>
                                                                                <%= r.getReservationNo() %>
                                                                            </b></td>
                                                                        <td>
                                                                            <%= r.getRoomType() %>
                                                                                <div class="muted">LKR <%= r.getRate()
                                                                                        %> / night</div>
                                                                        </td>
                                                                        <td>
                                                                            <%= r.getCheckIn() %>
                                                                        </td>
                                                                        <td>
                                                                            <%= r.getCheckOut() %>
                                                                        </td>
                                                                        <td>
                                                                            <%= nights %>
                                                                        </td>
                                                                        <td>
                                                                            <%= r.getGuests() %>
                                                                        </td>
                                                                        <td><span class="status <%= st %>">
                                                                                <%= st %>
                                                                            </span></td>

                                                                        <td>
                                                                            <% if ("PENDING".equals(st) &&
                                                                                r.getExpiresAt() !=null) { %>
                                                                                <%= r.getExpiresAt() %>
                                                                                    <% } else { %>
                                                                                        -
                                                                                        <% } %>
                                                                        </td>

                                                                        <td>
                                                                            <a class="smallbtn"
                                                                                href="<%=request.getContextPath()%>/customer/reservation-details?no=<%= r.getReservationNo() %>">
                                                                                View
                                                                            </a>
                                                                        </td>
                                                                    </tr>
                                                                    <% } %>
                                                            </tbody>
                                                        </table>
                                                        <% } %>
                                    </div>

                                    <div class="footer">© 2026 Ocean View Resort • My Reservations</div>
                                </div>

                            </body>

                            </html>