<%-- Document : viewReservations Created on : Feb 25, 2026, 10:09:50 PM Author : Haruda --%>

    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <% String fullName=(String) session.getAttribute("fullName"); String role=(String) session.getAttribute("role");
            if (fullName==null || fullName.trim().isEmpty()) fullName="Customer" ; if (role==null ||
            role.trim().isEmpty()) role="CUSTOMER" ; %>
            <!DOCTYPE html>
            <html>

            <head>
                <title>Reservations Overview | Ocean View Resort</title>
                <link rel="stylesheet" href="<%=request.getContextPath()%>/css/ocean-app.css">
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
                        <h1>Reservations Overview</h1>
                        <p>
                            View and manage your stays. Use <b>My Bookings</b> for instant bookings
                            and <b>My Reservations</b> for approval-based requests.
                        </p>
                        <div style="margin-top:12px;">
                            <span class="badge">Bookings</span>
                            <span class="badge">Reservation Requests</span>
                            <span class="badge">History</span>
                        </div>
                    </div>

                    <div class="card" style="margin-top:16px;">
                        <h3>Where do you want to go?</h3>
                        <p style="margin-top:6px;color:#555;">
                            Use the quick links below to open the detailed pages for your bookings and reservation
                            requests.
                        </p>

                        <div class="actions" style="margin-top:14px;">
                            <a class="btn" href="<%=request.getContextPath()%>/customer/my-bookings">My Bookings</a>
                            <a class="btn" href="<%=request.getContextPath()%>/customer/my-reservations">My
                                Reservations</a>
                            <a class="btn-back" href="<%=request.getContextPath()%>/customer/dashboard.jsp">
                                <svg viewBox="0 0 24 24">
                                    <path d="M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z" />
                                </svg> Back to Dashboard
                            </a>
                        </div>
                    </div>

                    <div class="footer">© 2026 Ocean View Resort • Reservations Overview</div>
                </div>

            </body>

            </html>