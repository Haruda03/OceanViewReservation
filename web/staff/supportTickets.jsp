<%-- Document : supportTickets Created on : Mar 2, 2026, 10:36:40 AM Author : Haruda --%>

    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <%@page import="java.util.List" %>
            <%@page import="model.SupportTicket" %>

                <% String fullName=(String) session.getAttribute("fullName"); String role=(String)
                    session.getAttribute("role"); String err=(String) request.getAttribute("error"); List<SupportTicket>
                    tickets = (List<SupportTicket>) request.getAttribute("tickets");
                        %>

                        <!DOCTYPE html>
                        <html>

                        <head>
                            <title>Support Tickets | Staff Console</title>
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

                                select {
                                    padding: 8px 10px;
                                    border-radius: 10px;
                                    border: 1px solid #cfd9e6;
                                }

                                .btn-sm {
                                    padding: 8px 10px;
                                    border-radius: 10px;
                                    border: none;
                                    background: #00c3ff;
                                    color: #fff;
                                    font-weight: 900;
                                    cursor: pointer;
                                }

                                .btn-sm:hover {
                                    background: #009dcf;
                                }

                                .muted {
                                    color: #666;
                                    font-size: 12px;
                                }

                                .row-actions {
                                    display: flex;
                                    gap: 8px;
                                    align-items: center;
                                    flex-wrap: wrap;
                                }
                            </style>
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
                                    <h1>Support Tickets</h1>
                                    <p>View customer support requests and update ticket status for efficient service
                                        management.</p>
                                    <div style="margin-top:12px;">
                                        <span class="badge">Customer Support</span>
                                        <span class="badge">Status Workflow</span>
                                        <span class="badge">Service Quality</span>
                                    </div>
                                </div>

                                <div class="actions" style="margin-top:14px;">
                                    <a class="btn-back" href="<%=request.getContextPath()%>/staff/dashboard.jsp">
                                        <svg viewBox="0 0 24 24">
                                            <path d="M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z" />
                                        </svg> Back
                                    </a>
                                    <a class="btn" href="<%=request.getContextPath()%>/staff/support">Refresh</a>
                                </div>

                                <% if (err !=null) { %>
                                    <div class="alert error" style="margin-top:12px;">
                                        <%= err %>
                                    </div>
                                    <% } %>

                                        <div class="card" style="margin-top:16px;">
                                            <h3>All Tickets</h3>

                                            <% if (tickets==null || tickets.isEmpty()) { %>
                                                <p class="muted" style="margin-top:10px;">No tickets found.</p>
                                                <% } else { %>

                                                    <table>
                                                        <thead>
                                                            <tr>
                                                                <th>Ticket</th>
                                                                <th>Customer</th>
                                                                <th>Subject & Message</th>
                                                                <th>Status</th>
                                                                <th>Created</th>
                                                                <th>Update</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <% for (SupportTicket t : tickets) { %>
                                                                <tr>
                                                                    <td><b>#<%= t.getTicketId() %></b></td>
                                                                    <td>
                                                                        <b>
                                                                            <%= t.getCustomerName() %>
                                                                        </b>
                                                                        <div class="muted">
                                                                            <%= t.getCustomerEmail() %>
                                                                        </div>
                                                                        <div class="muted">User ID: <%= t.getUserId() %>
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <b>
                                                                            <%= t.getSubject() %>
                                                                        </b>
                                                                        <div class="muted" style="margin-top:6px;">
                                                                            <%= t.getMessage() %>
                                                                        </div>
                                                                    </td>
                                                                    <td><span class="chip <%= t.getStatus() %>">
                                                                            <%= t.getStatus() %>
                                                                        </span></td>
                                                                    <td>
                                                                        <%= t.getCreatedAt() %>
                                                                    </td>
                                                                    <td>
                                                                        <form method="post"
                                                                            action="<%=request.getContextPath()%>/staff/support">
                                                                            <div class="row-actions">
                                                                                <input type="hidden" name="ticketId"
                                                                                    value="<%= t.getTicketId() %>">
                                                                                <select name="status" required>
                                                                                    <option value="OPEN" <%="OPEN"
                                                                                        .equals(t.getStatus())
                                                                                        ? "selected" : "" %>>OPEN
                                                                                    </option>
                                                                                    <option value="IN_PROGRESS"
                                                                                        <%="IN_PROGRESS"
                                                                                        .equals(t.getStatus())
                                                                                        ? "selected" : "" %>>IN_PROGRESS
                                                                                    </option>
                                                                                    <option value="CLOSED" <%="CLOSED"
                                                                                        .equals(t.getStatus())
                                                                                        ? "selected" : "" %>>CLOSED
                                                                                    </option>
                                                                                </select>
                                                                                <button type="submit"
                                                                                    class="btn-sm">Save</button>
                                                                            </div>
                                                                        </form>
                                                                    </td>
                                                                </tr>
                                                                <% } %>
                                                        </tbody>
                                                    </table>

                                                    <% } %>
                                        </div>

                                        <div class="footer">© 2026 Ocean View Resort • Staff Support Console</div>
                            </div>

                        </body>

                        </html>