<%-- Document : viewReservation Created on : Feb 25, 2026, 10:10:59 PM Author : Haruda --%>

    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <% String fullName=(String) session.getAttribute("fullName"); String role=(String) session.getAttribute("role");
            if (fullName==null || fullName.trim().isEmpty()) fullName="Staff" ; if (role==null || role.trim().isEmpty())
            role="STAFF" ; %>
            <!DOCTYPE html>
            <html>

            <head>
                <title>Reservation View | Staff Console</title>
                <link rel="stylesheet" href="<%=request.getContextPath()%>/css/ocean-app.css">
            </head>

            <body>

                <div class="topbar">
                    <div class="brand">Ocean View Resort • Staff Console</div>
                    <div class="userchip">
                        <%= fullName %> • <%= role %> •
                                <a class="link" style="color:white;"
                                    href="<%=request.getContextPath()%>/logout">Logout</a>
                    </div>
                </div>

                <div class="container">

                    <div class="hero">
                        <h1>Reservation View</h1>
                        <p>
                            Detailed reservation information for staff review will appear here when wired to the full
                            data model.
                            Use the reservations and requests pages for operational actions.
                        </p>
                        <div style="margin-top:12px;">
                            <span class="badge">Operations</span>
                            <span class="badge">Verification</span>
                        </div>
                    </div>

                    <div class="card" style="margin-top:16px;">
                        <h3>Quick Navigation</h3>
                        <p style="margin-top:6px;color:#555;">
                            To manage reservations now, use the dashboards below.
                        </p>
                        <div class="actions" style="margin-top:14px;">
                            <a class="btn" href="<%=request.getContextPath()%>/staff/reservations">Pending Requests</a>
                            <a class="btn" href="<%=request.getContextPath()%>/staff/reservations-manage">Reservations
                                Management</a>
                            <a class="btn-back" href="<%=request.getContextPath()%>/staff/dashboard.jsp">
                                <svg viewBox="0 0 24 24">
                                    <path d="M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z" />
                                </svg> Back to Dashboard
                            </a>
                        </div>
                    </div>

                    <div class="footer">© 2026 Ocean View Resort • Staff Reservations</div>
                </div>

            </body>

            </html>