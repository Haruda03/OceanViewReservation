<%-- Document : helpSupport Created on : Mar 2, 2026, 10:25:26 AM Author : Haruda --%>

    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <%@page import="java.util.List" %>
            <%@page import="model.SupportTicket" %>

                <% String fullName=(String) session.getAttribute("fullName"); String role=(String)
                    session.getAttribute("role"); String err=(String) request.getAttribute("error"); String msg=(String)
                    request.getAttribute("msg"); List<SupportTicket> tickets = (List<SupportTicket>)
                        request.getAttribute("tickets");
                        %>

                        <!DOCTYPE html>
                        <html>

                        <head>
                            <title>Help & Support | Ocean View Resort</title>
                            <link rel="stylesheet" href="<%=request.getContextPath()%>/css/ocean-app.css">
                            <style>
                                .faq {
                                    margin-top: 14px;
                                }

                                details {
                                    background: rgba(255, 255, 255, 0.85);
                                    border-radius: 14px;
                                    padding: 12px 14px;
                                    margin-bottom: 10px;
                                }

                                summary {
                                    cursor: pointer;
                                    font-weight: 900;
                                    color: #003366;
                                }

                                .grid2 {
                                    display: grid;
                                    grid-template-columns: 1fr 1fr;
                                    gap: 14px;
                                }

                                @media(max-width:900px) {
                                    .grid2 {
                                        grid-template-columns: 1fr;
                                    }
                                }

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
                                    background: #f2f8ff;
                                    color: #003366;
                                }

                                .chip {
                                    padding: 6px 10px;
                                    border-radius: 999px;
                                    font-weight: 900;
                                    font-size: 12px;
                                    display: inline-block;
                                }

                                .OPEN {
                                    background: #fff3cd;
                                    color: #8a6d00;
                                }

                                .IN_PROGRESS {
                                    background: #e9f7ff;
                                    color: #006a8e;
                                }

                                .CLOSED {
                                    background: #e7ffe8;
                                    color: #0b6b12;
                                }

                                input,
                                textarea,
                                select {
                                    width: 100%;
                                    padding: 10px 12px;
                                    border-radius: 12px;
                                    border: 1px solid #cfd9e6;
                                    outline: none;
                                }

                                textarea {
                                    min-height: 120px;
                                    resize: vertical;
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
                                    <h1>Help & Support</h1>
                                    <p>Find quick answers or send a support request to the resort team.</p>
                                    <div style="margin-top:12px;">
                                        <span class="badge">FAQ</span>
                                        <span class="badge">Support Tickets</span>
                                        <span class="badge">Customer Assistance</span>
                                    </div>
                                </div>

                                <div class="actions" style="margin-top:14px;">
                                    <a class="btn-back" href="<%=request.getContextPath()%>/customer/dashboard.jsp">
                                        <svg viewBox="0 0 24 24">
                                            <path d="M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z" />
                                        </svg> Back
                                    </a>
                                    <a class="btn" href="<%=request.getContextPath()%>/customer/support">Refresh</a>
                                </div>

                                <% if (err !=null) { %>
                                    <div class="alert error" style="margin-top:12px;">
                                        <%= err %>
                                    </div>
                                    <% } %>
                                        <% if (msg !=null) { %>
                                            <div class="alert success" style="margin-top:12px;">
                                                <%= msg %>
                                            </div>
                                            <% } %>

                                                <!-- System User Guide Section -->
                                                <div class="card" style="margin-top:20px; text-align: left;">
                                                    <h2 style="color:#003366; padding-bottom: 8px;">Customer User Guide
                                                    </h2>
                                                    <p style="margin-bottom:16px;">The Customer Portal is designed to
                                                        provide guests with a seamless experience for booking rooms,
                                                        managing reservations, and communicating with resort staff.
                                                        Click on the topics below for details:</p>

                                                    <div class="faq">
                                                        <details>
                                                            <summary>1. Account Registration & Login</summary>
                                                            <div class="muted" style="margin-top:8px;">
                                                                <ul>
                                                                    <li><b>Registration:</b> Navigate to the home page
                                                                        and click "Register". Provide your full name,
                                                                        email, phone number, and a secure password.</li>
                                                                    <li><b>Login:</b> Click "Login" from the navigation
                                                                        bar. Enter your registered email and password to
                                                                        access your Customer Dashboard.</li>
                                                                </ul>
                                                            </div>
                                                        </details>

                                                        <details>
                                                            <summary>2. Making a Reservation</summary>
                                                            <div class="muted" style="margin-top:8px;">
                                                                <ul>
                                                                    <li><b>Browse Rooms:</b> From the dashboard or home
                                                                        page, navigate to "Rooms" to view available
                                                                        accommodations and current nightly rates.</li>
                                                                    <li><b>Request a Booking:</b> Select a room and
                                                                        click "Book Now". Choose your check-in and
                                                                        check-out dates, enter the number of guests, and
                                                                        submit the reservation request.</li>
                                                                    <li><b>Status Tracking:</b> Your reservation will
                                                                        initially be in a <code>PENDING</code> state.
                                                                        Once reviewed by staff, it will either be
                                                                        <code>CONFIRMED</code> or <code>REJECTED</code>.
                                                                    </li>
                                                                </ul>
                                                            </div>
                                                        </details>

                                                        <details>
                                                            <summary>3. Managing Bookings</summary>
                                                            <div class="muted" style="margin-top:8px;">
                                                                <ul>
                                                                    <li><b>My Bookings:</b> Access the "My Bookings"
                                                                        section from your dashboard to view the status,
                                                                        dates, and total cost of your current and past
                                                                        reservations.</li>
                                                                    <li><b>Check-out / Invoices:</b> Upon completion of
                                                                        your stay, you can view your final invoice,
                                                                        detailing room charges and total nights stayed.
                                                                    </li>
                                                                    <li><b>Cancellations:</b> If your reservation is
                                                                        still pending or confirmed (and within the
                                                                        cancellation window), you can request a
                                                                        cancellation from the bookings page.</li>
                                                                </ul>
                                                            </div>
                                                        </details>

                                                        <details>
                                                            <summary>4. Support & Notifications</summary>
                                                            <div class="muted" style="margin-top:8px;">
                                                                <ul>
                                                                    <li><b>Support Tickets:</b> If you have special
                                                                        requests or complaints, use the form below to
                                                                        open a new ticket. You can view staff responses
                                                                        and track your ticket status here.</li>
                                                                    <li><b>Notifications:</b> Check the 🔔 Notifications
                                                                        section on your dashboard for real-time updates
                                                                        regarding reservation approvals and rejections.
                                                                    </li>
                                                                </ul>
                                                            </div>
                                                        </details>
                                                    </div>
                                                </div>

                                                <div class="grid2" style="margin-top:16px;">

                                                    <!-- LEFT: FAQ -->
                                                    <div class="card">
                                                        <h3>Frequently Asked Questions</h3>
                                                        <div class="faq">
                                                            <details>
                                                                <summary>How do I book instantly?</summary>
                                                                <div class="muted" style="margin-top:8px;">
                                                                    Go to Book/Request page and click <b>Book Now
                                                                        (Instant)</b>. Your booking becomes
                                                                    <b>CONFIRMED</b> immediately.
                                                                </div>
                                                            </details>

                                                            <details>
                                                                <summary>How does reservation request work?</summary>
                                                                <div class="muted" style="margin-top:8px;">
                                                                    Click <b>Request Reservation</b>. It becomes
                                                                    <b>PENDING</b> and staff must approve it before the
                                                                    expiry time.
                                                                </div>
                                                            </details>

                                                            <details>
                                                                <summary>Why did my request expire?</summary>
                                                                <div class="muted" style="margin-top:8px;">
                                                                    If staff does not approve before the expiry time,
                                                                    the system automatically marks it <b>EXPIRED</b> and
                                                                    the room becomes available again.
                                                                </div>
                                                            </details>

                                                            <details>
                                                                <summary>When can I generate a bill?</summary>
                                                                <div class="muted" style="margin-top:8px;">
                                                                    Bills are available only for <b>CONFIRMED</b>
                                                                    bookings/reservations.
                                                                </div>
                                                            </details>
                                                        </div>

                                                        <h3 style="margin-top:16px;">Contact Info</h3>
                                                        <p class="muted">
                                                            Phone: +94 22 333 8888<br />
                                                            Email: support@oceanviewresort.com<br />
                                                            Hours: 08:00 – 20:00
                                                        </p>
                                                    </div>

                                                    <!-- RIGHT: Support request form -->
                                                    <div class="card">
                                                        <h3>Submit a Support Request</h3>
                                                        <form method="post"
                                                            action="<%=request.getContextPath()%>/customer/support">
                                                            <div style="margin-top:10px;">
                                                                <label><b>Subject</b></label>
                                                                <input type="text" name="subject" maxlength="120"
                                                                    placeholder="e.g., Booking issue / Payment question"
                                                                    required>
                                                            </div>

                                                            <div style="margin-top:10px;">
                                                                <label><b>Message</b></label>
                                                                <textarea name="message"
                                                                    placeholder="Write your issue clearly..."
                                                                    required></textarea>
                                                            </div>

                                                            <div class="actions" style="margin-top:14px;">
                                                                <button type="submit">Send Request</button>
                                                            </div>

                                                            <p class="muted" style="margin-top:10px;">
                                                                Your request will be stored as a ticket with status
                                                                <b>OPEN</b>.
                                                            </p>
                                                        </form>
                                                    </div>
                                                </div>

                                                <!-- Ticket history -->
                                                <div class="card" style="margin-top:16px;">
                                                    <h3>My Support Tickets</h3>

                                                    <% if (tickets==null || tickets.isEmpty()) { %>
                                                        <p class="muted" style="margin-top:10px;">No tickets submitted
                                                            yet.</p>
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
                                                                                    <div class="muted"
                                                                                        style="margin-top:6px;">
                                                                                        <%= t.getMessage() %>
                                                                                    </div>
                                                                            </td>
                                                                            <td><span class="chip <%= t.getStatus() %>">
                                                                                    <%= t.getStatus() %>
                                                                                </span></td>
                                                                            <td>
                                                                                <%= t.getCreatedAt() %>
                                                                            </td>
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