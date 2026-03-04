<%-- Document : help Purpose : Staff help / guidance page --%>

    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <% String fullName=(String) session.getAttribute("fullName"); String role=(String) session.getAttribute("role");
            if (fullName==null || fullName.trim().isEmpty()) { fullName="Staff" ; } if (role==null ||
            role.trim().isEmpty()) { role="STAFF" ; } %>

            <!DOCTYPE html>
            <html>

            <head>
                <title>Help | Staff Console</title>
                <link rel="stylesheet" href="<%=request.getContextPath()%>/css/dashboard.css">
                <link rel="stylesheet" href="<%=request.getContextPath()%>/css/ocean-app.css">
            </head>

            <body>

                <div class="topbar">
                    <div class="brand">Ocean View Resort • Staff Console</div>
                    <div class="userchip">
                        <%= fullName %> • <%= role %> •
                                <a class="link" style="color:#ffeb3b; font-weight:bold;"
                                    href="<%=request.getContextPath()%>/notifications">🔔 Notifications</a> •
                                <a class="link" style="color:white;"
                                    href="<%=request.getContextPath()%>/logout">Logout</a>
                    </div>
                </div>

                <div class="container" style="max-width:900px; margin: 20px auto; padding: 20px;">
                    <div style="text-align:center; margin-bottom:30px;">
                        <h1>Ocean View Resort - System User Guide 🌊</h1>
                        <p style="color:#555;">Comprehensive guidance on using the Ocean View Resort Reservation System.
                        </p>
                    </div>

                    <style>
                        .faq details {
                            background: rgba(255, 255, 255, 0.85);
                            border-radius: 12px;
                            padding: 12px 16px;
                            margin-bottom: 12px;
                            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
                        }

                        .faq summary {
                            cursor: pointer;
                            font-weight: bold;
                            color: #003366;
                            font-size: 16px;
                            outline: none;
                        }

                        .faq ul {
                            margin-top: 10px;
                            color: #555;
                            padding-left: 20px;
                        }

                        .faq li {
                            margin-bottom: 6px;
                        }
                    </style>

                    <div class="card" style="margin-bottom: 24px;">
                        <h2
                            style="color:#003366; border-bottom: 2px solid #e7eef6; padding-bottom: 8px; margin-bottom: 16px;">
                            1. Customer User Guide</h2>
                        <p style="margin-bottom: 16px;">Guidance for guests booking rooms and tracking requests on the
                            Customer Portal.</p>

                        <div class="faq">
                            <details>
                                <summary>1.1 Account Registration & Login</summary>
                                <ul>
                                    <li><b>Registration:</b> Navigate to the home page and click "Register". Provide
                                        full name, email, phone number, and a secure password. Only customer accounts
                                        can be created via public registration.</li>
                                    <li><b>Login:</b> Click "Login" from the navigation bar using the registered email
                                        and password.</li>
                                </ul>
                            </details>

                            <details>
                                <summary>1.2 Making a Reservation</summary>
                                <ul>
                                    <li><b>Browse Rooms:</b> View available accommodations and current nightly rates
                                        from the "Rooms" page.</li>
                                    <li><b>Request a Booking:</b> Select a room, choose check-in and check-out dates,
                                        enter guest count, and submit the reservation request.</li>
                                    <li><b>Status Tracking:</b> Reservations start in a <code>PENDING</code> state.
                                        Staff will either mark it <code>CONFIRMED</code> or <code>REJECTED</code>.</li>
                                </ul>
                            </details>

                            <details>
                                <summary>1.3 Managing Bookings</summary>
                                <ul>
                                    <li><b>My Bookings:</b> Customers can view their status, dates, and total cost of
                                        their current/past reservations.</li>
                                    <li><b>Check-out / Invoices:</b> Detailed invoices are available for completed
                                        stays.</li>
                                    <li><b>Cancellations:</b> Customers can request cancellations for pending/confirmed
                                        reservations within the allowed window.</li>
                                </ul>
                            </details>

                            <details>
                                <summary>1.4 Support & Notifications</summary>
                                <ul>
                                    <li><b>Support Tickets:</b> Customers can open new tickets for special requests or
                                        complaints, and track staff responses.</li>
                                    <li><b>Notifications:</b> Real-time updates regarding reservation approvals and
                                        rejections appear in the 🔔 Notifications section.</li>
                                </ul>
                            </details>
                        </div>
                    </div>

                    <div class="card" style="margin-bottom: 24px;">
                        <h2
                            style="color:#003366; border-bottom: 2px solid #e7eef6; padding-bottom: 8px; margin-bottom: 16px;">
                            2. Staff User Guide</h2>
                        <p style="margin-bottom: 16px;">Operational guidelines for employees handling bookings,
                            inventory, and services.</p>

                        <div class="faq">
                            <details>
                                <summary>2.1 Staff Dashboard Overview</summary>
                                <ul>
                                    <li>The real-time dashboard displays highlights such as Pending Reservation
                                        Requests, Active Support Tickets, and quick action links.</li>
                                </ul>
                            </details>

                            <details>
                                <summary>2.2 Processing Reservation Requests</summary>
                                <ul>
                                    <li><b>Reviewing Requests:</b> Use the "Reservation Requests" tab to view
                                        <code>PENDING</code> bookings.
                                    </li>
                                    <li><b>Approve / Reject:</b> Verify availability and either approve
                                        (<code>CONFIRMED</code>) or reject the request.</li>
                                </ul>
                            </details>

                            <details>
                                <summary>2.3 Reservations Management</summary>
                                <ul>
                                    <li><b>Active Bookings:</b> Use dropdown filters on the "Manage Reservations" page
                                        to locate specific stays.</li>
                                    <li><b>Check-out Processing:</b> Locate a confirmed booking and click "Check-out
                                        (Complete)" when the guest leaves to mark it <code>COMPLETED</code> and generate
                                        the invoice.</li>
                                </ul>
                            </details>

                            <details>
                                <summary>2.4 Room Management & Reports</summary>
                                <ul>
                                    <li><b>Adjusting Rates:</b> Update nightly LKR rates and toggle active status in
                                        Room Management.</li>
                                    <li><b>Handling Support Tickets:</b> Update tickets from <code>OPEN</code> to
                                        <code>IN_PROGRESS</code>, communicate with the guest, and mark
                                        <code>CLOSED</code> when resolved.
                                    </li>
                                    <li><b>Analytical Reports:</b> View operational summaries like Total Confirmed Stays
                                        and Estimated Revenue.</li>
                                </ul>
                            </details>
                        </div>
                    </div>

                    <div class="card" style="margin-bottom: 24px;">
                        <h2
                            style="color:#003366; border-bottom: 2px solid #e7eef6; padding-bottom: 8px; margin-bottom: 16px;">
                            3. Admin User Guide</h2>
                        <p style="margin-bottom: 16px;">Tools for high-level control over system security, user access,
                            and staff provisioning.</p>

                        <div class="faq">
                            <details>
                                <summary>3.1 Admin Console Access</summary>
                                <ul>
                                    <li>Administrators log in through the standard portal and are automatically
                                        redirected to the secure <b>Admin Dashboard</b>.</li>
                                    <li>A dedicated <b>⬅ Admin Dashboard</b> button appears when an Admin is navigating
                                        within the Staff Console.</li>
                                </ul>
                            </details>

                            <details>
                                <summary>3.2 User Management & Provisioning</summary>
                                <ul>
                                    <li><b>Viewing Directory:</b> See all registered accounts across the platform under
                                        "Manage Users".</li>
                                    <li><b>Provisioning Accounts:</b> Elevate individuals by creating them explicitly
                                        via the "Create User" tool on the Admin Dashboard, securely assigning them
                                        <code>STAFF</code> or <code>ADMIN</code> roles.
                                    </li>
                                    <li><b>Deleting Accounts:</b> Remove obsolete accounts. System controls prevent
                                        administrators from unintentionally deleting their own active profile.</li>
                                </ul>
                            </details>
                        </div>
                    </div>

                    <div class="action" style="justify-content:center; margin-top:22px;">
                        <a class="btn-back" href="<%=request.getContextPath()%>/staff/dashboard.jsp">
                            <svg viewBox="0 0 24 24">
                                <path d="M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z" />
                            </svg> Back to Dashboard
                        </a>
                    </div>

                </div>

                <div class="footer">© 2026 Ocean View Resort • Staff Help</div>

            </body>

            </html>