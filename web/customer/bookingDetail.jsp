<%-- Document : bookingDetail Created on : Mar 3, 2026, 8:57:08 AM Author : Haruda --%>

    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <% String fullName=(String) session.getAttribute("fullName"); String role=(String) session.getAttribute("role");
            if (fullName==null || fullName.trim().isEmpty()) fullName="Customer" ; if (role==null ||
            role.trim().isEmpty()) role="CUSTOMER" ; %>
            <!DOCTYPE html>
            <html>

            <head>
                <title>Booking Details | Ocean View Resort</title>
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
                        <h1>Booking Details</h1>
                        <p>
                            Detailed information about a specific confirmed booking will appear here.
                            For now, please use <b>My Bookings</b> and <b>Reservation Details</b> pages.
                        </p>
                        <div style="margin-top:12px;">
                            <span class="badge">Instant Bookings</span>
                            <span class="badge">Stay Information</span>
                        </div>
                    </div>

                    <div class="card" style="margin-top:16px;">
                        <h3>Access Your Booking</h3>
                        <p style="margin-top:6px;color:#555;">
                            To view a booking, go to <b>My Bookings</b>, then click <b>View</b> next to the reservation
                            you want.
                        </p>
                        <div class="actions" style="margin-top:14px;">
                            <a class="btn" href="<%=request.getContextPath()%>/customer/my-bookings">Open My
                                Bookings</a>
                            <a class="btn-back" href="<%=request.getContextPath()%>/customer/dashboard.jsp">
                                <svg viewBox="0 0 24 24">
                                    <path d="M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z" />
                                </svg> Back to Dashboard
                            </a>
                        </div>
                    </div>

                    <div class="footer">© 2026 Ocean View Resort • Booking Details</div>
                </div>

            </body>

            </html>