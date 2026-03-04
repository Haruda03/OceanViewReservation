<%-- Document : dashboard Created on : Feb 25, 2026, 10:10:30 PM Author : Haruda --%>

    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <% String fullName=(String) session.getAttribute("fullName"); String role=(String) session.getAttribute("role");
            if (fullName==null || fullName.trim().isEmpty()) { fullName="Staff" ; } if (role==null ||
            role.trim().isEmpty()) { role="STAFF" ; } Integer pendingRequestsCount=(Integer)
            request.getAttribute("pendingRequestsCount"); Integer openTicketsCount=(Integer)
            request.getAttribute("openTicketsCount"); Integer inProgressTicketsCount=(Integer)
            request.getAttribute("inProgressTicketsCount"); if (pendingRequestsCount==null) pendingRequestsCount=0; if
            (openTicketsCount==null) openTicketsCount=0; if (inProgressTicketsCount==null) inProgressTicketsCount=0;
            String dashErr=(String) request.getAttribute("error"); %>

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
                                <% if ("ADMIN".equals(role)) { %>
                                    <a class="link" style="color:white; font-weight:bold;"
                                        href="<%=request.getContextPath()%>/admin/dashboard.jsp">⬅ Admin Dashboard</a> •
                                    <% } %>
                                        <a class="link" style="color:#ffeb3b; font-weight:bold;"
                                            href="<%=request.getContextPath()%>/notifications">🔔 Notifications</a> •
                                        <a class="link" style="color:white;"
                                            href="<%=request.getContextPath()%>/logout">Logout</a>
                    </div>
                </div>

                <!-- FULL OCEAN BACKGROUND -->
                <div class="full-hero">
                    <div class="hero-inner">

                        <!-- WELCOME -->
                        <div style="text-align:center; margin-bottom:26px;">
                            <h1>Welcome, <%= fullName %> 🌊</h1>
                            <p>
                                Manage reservation requests, bookings, rooms, support tickets, and analytics for Ocean
                                View Resort.
                            </p>

                            <div style="margin-top:12px;">
                                <span class="badge">Operations</span>
                                <span class="badge">Approvals</span>
                                <span class="badge">Service Management</span>
                            </div>
                        </div>

                        <% if (dashErr !=null) { %>
                            <div class="alert error" style="max-width:980px; margin: 0 auto 18px;">
                                <%= dashErr %>
                            </div>
                            <% } %>

                                <!-- FEATURE CARDS -->
                                <div class="grid">

                                    <!-- Reservation Requests -->
                                    <div class="glass-card">
                                        <h3>
                                            Reservation Requests
                                            <span class="badge" style="margin-left:8px;">
                                                <%= pendingRequestsCount %> Pending
                                            </span>
                                        </h3>
                                        <p>
                                            View and process customer reservation requests (PENDING). Approve or reject
                                            before expiry.
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
                                            View all bookings/reservations with filters. Cancel confirmed stays or mark
                                            them as completed.
                                        </p>
                                        <div class="action">
                                            <a class="btn"
                                                href="<%=request.getContextPath()%>/staff/reservations-manage">
                                                Manage
                                            </a>
                                        </div>
                                    </div>

                                    <!-- Room Management -->
                                    <div class="glass-card">
                                        <h3>Room Management</h3>
                                        <p>
                                            Update room rates and toggle availability (ACTIVE / INACTIVE) to control
                                            inventory.
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
                                            View operational summary: pending, confirmed, completed, cancelled, and
                                            estimated revenue.
                                        </p>
                                        <div class="action">
                                            <a class="btn" href="<%=request.getContextPath()%>/staff/reports">
                                                Reports
                                            </a>
                                        </div>
                                    </div>

                                    <!-- Support Tickets -->
                                    <div class="glass-card">
                                        <h3>
                                            Support Tickets
                                            <span class="badge" style="margin-left:8px;">
                                                <%= openTicketsCount %> Open
                                            </span>
                                            <span class="badge" style="margin-left:8px;">
                                                <%= inProgressTicketsCount %> In-Progress
                                            </span>
                                        </h3>
                                        <p>
                                            View customer tickets with name and email. Update status workflow (OPEN →
                                            IN_PROGRESS → CLOSED).
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
                                        <p style="margin-bottom:10px;">
                                            Common staff tasks:
                                        </p>
                                        <div class="action" style="display:flex; gap:10px; flex-wrap:wrap;">
                                            <a class="btn"
                                                href="<%=request.getContextPath()%>/staff/reservations">Pending</a>
                                            <a class="btn" href="<%=request.getContextPath()%>/staff/rooms">Rates</a>
                                            <a class="btn"
                                                href="<%=request.getContextPath()%>/staff/support">Tickets</a>
                                            <a class="btn" href="<%=request.getContextPath()%>/staff/help.jsp">User
                                                Guide</a>
                                        </div>

                                        <p style="margin-top:12px; opacity:0.9;">
                                            Tip: Check the <b>User Guide</b> for system operations and task procedures.
                                        </p>
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