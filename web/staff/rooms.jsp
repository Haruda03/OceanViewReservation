<%-- Document : rooms Created on : Mar 2, 2026, 12:49:51 PM Author : Haruda --%>

    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <%@page import="java.util.List" %>
            <%@page import="model.Room" %>

                <% String fullName=(String) session.getAttribute("fullName"); String role=(String)
                    session.getAttribute("role"); String msg=(String) request.getAttribute("msg"); String err=(String)
                    request.getAttribute("error"); List<Room> rooms = (List<Room>) request.getAttribute("rooms");
                        %>

                        <!DOCTYPE html>
                        <html>

                        <head>
                            <title>Room Management | Staff</title>
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

                                input,
                                select {
                                    padding: 8px 10px;
                                    border-radius: 10px;
                                    border: 1px solid #cfd9e6;
                                }

                                .row-actions {
                                    display: flex;
                                    gap: 8px;
                                    flex-wrap: wrap;
                                    align-items: center;
                                }

                                .btn-sm {
                                    padding: 8px 12px;
                                    border-radius: 10px;
                                    border: none;
                                    background: #00c3ff;
                                    color: #fff;
                                    font-weight: 900;
                                    cursor: pointer;
                                }

                                .btn-danger {
                                    padding: 8px 12px;
                                    border-radius: 10px;
                                    border: none;
                                    background: #e64b4b;
                                    color: #fff;
                                    font-weight: 900;
                                    cursor: pointer;
                                }

                                .btn-sm:hover {
                                    background: #009dcf;
                                }

                                .btn-danger:hover {
                                    background: #c93b3b;
                                }

                                .muted {
                                    color: #666;
                                    font-size: 12px;
                                }

                                .split {
                                    display: grid;
                                    grid-template-columns: 1fr 1fr;
                                    gap: 14px;
                                }

                                @media(max-width:900px) {
                                    .split {
                                        grid-template-columns: 1fr;
                                    }
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
                                    <h1>Room Management</h1>
                                    <p>Manage room rates and availability. Add new rooms or deactivate rooms when
                                        needed.</p>
                                    <div style="margin-top:12px;">
                                        <span class="badge">Inventory</span>
                                        <span class="badge">Pricing</span>
                                        <span class="badge">Availability</span>
                                    </div>
                                </div>

                                <div class="actions" style="margin-top:14px;">
                                    <a class="btn-back" href="<%=request.getContextPath()%>/staff/dashboard">
                                        <svg viewBox="0 0 24 24">
                                            <path d="M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z" />
                                        </svg> Back
                                    </a>
                                    <a class="btn" href="<%=request.getContextPath()%>/staff/rooms">Refresh</a>
                                </div>

                                <% if (msg !=null) { %>
                                    <div class="alert success" style="margin-top:12px;">
                                        <%= msg %>
                                    </div>
                                    <% } %>
                                        <% if (err !=null) { %>
                                            <div class="alert error" style="margin-top:12px;">
                                                <%= err %>
                                            </div>
                                            <% } %>

                                                <div class="split" style="margin-top:16px;">

                                                    <!-- ADD ROOM -->
                                                    <div class="card">
                                                        <h3>Add New Room</h3>
                                                        <form method="post"
                                                            action="<%=request.getContextPath()%>/staff/rooms">
                                                            <input type="hidden" name="action" value="add">

                                                            <div style="margin-top:10px;">
                                                                <label><b>Room Type</b></label><br />
                                                                <input type="text" name="roomType"
                                                                    placeholder="e.g., Deluxe Ocean View" required>
                                                            </div>

                                                            <div style="margin-top:10px;">
                                                                <label><b>Rate (LKR)</b></label><br />
                                                                <input type="number" step="0.01" name="rate"
                                                                    placeholder="e.g., 15000" required>
                                                            </div>

                                                            <div style="margin-top:10px;">
                                                                <label><b>Max Guests</b></label><br />
                                                                <input type="number" name="maxGuests" min="1" max="20"
                                                                    value="2" required>
                                                            </div>

                                                            <div style="margin-top:10px;">
                                                                <label><b>Status</b></label><br />
                                                                <select name="status">
                                                                    <option value="ACTIVE">ACTIVE</option>
                                                                    <option value="INACTIVE">INACTIVE</option>
                                                                </select>
                                                            </div>

                                                            <div class="actions" style="margin-top:14px;">
                                                                <button type="submit">Add Room</button>
                                                            </div>

                                                            <p class="muted" style="margin-top:10px;">
                                                                Tip: Use INACTIVE to temporarily hide a room from
                                                                customer booking.
                                                            </p>
                                                        </form>
                                                    </div>

                                                    <!-- ROOMS TABLE -->
                                                    <div class="card">
                                                        <h3>Room List</h3>

                                                        <% if (rooms==null || rooms.isEmpty()) { %>
                                                            <p class="muted" style="margin-top:10px;">No rooms found.
                                                            </p>
                                                            <% } else { %>

                                                                <table>
                                                                    <thead>
                                                                        <tr>
                                                                            <th>Room</th>
                                                                            <th>Rate</th>
                                                                            <th>Max Guests</th>
                                                                            <th>Status</th>
                                                                            <th>Update</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <% for (Room r : rooms) { %>
                                                                            <tr>
                                                                                <td>
                                                                                    <b>#<%= r.getRoomId() %></b> - <%=
                                                                                        r.getRoomType() %>
                                                                                </td>

                                                                                <td>
                                                                                    <form method="post"
                                                                                        action="<%=request.getContextPath()%>/staff/rooms">
                                                                                        <input type="hidden"
                                                                                            name="action"
                                                                                            value="update">
                                                                                        <input type="hidden"
                                                                                            name="roomId"
                                                                                            value="<%= r.getRoomId() %>">
                                                                                        <input type="number" step="0.01"
                                                                                            name="rate"
                                                                                            value="<%= r.getRate() %>"
                                                                                            required>
                                                                                </td>

                                                                                <td>
                                                                                    <%= r.getMaxGuests() %>
                                                                                </td>

                                                                                <td>
                                                                                    <select name="status">
                                                                                        <option value="ACTIVE"
                                                                                            <%="ACTIVE"
                                                                                            .equals(r.getStatus())
                                                                                            ? "selected" : "" %>>ACTIVE
                                                                                        </option>
                                                                                        <option value="INACTIVE"
                                                                                            <%="INACTIVE"
                                                                                            .equals(r.getStatus())
                                                                                            ? "selected" : "" %>
                                                                                            >INACTIVE</option>
                                                                                    </select>
                                                                                </td>

                                                                                <td>
                                                                                    <div class="row-actions">
                                                                                        <button class="btn-sm"
                                                                                            type="submit">Save</button>
                                                                                        </form>

                                                                                        <form method="post"
                                                                                            action="<%=request.getContextPath()%>/staff/rooms"
                                                                                            onsubmit="return confirm('Delete this room? This cannot be undone.');">
                                                                                            <input type="hidden"
                                                                                                name="action"
                                                                                                value="delete">
                                                                                            <input type="hidden"
                                                                                                name="roomId"
                                                                                                value="<%= r.getRoomId() %>">
                                                                                            <button class="btn-danger"
                                                                                                type="submit">Delete</button>
                                                                                        </form>
                                                                                    </div>
                                                                                </td>
                                                                            </tr>
                                                                            <% } %>
                                                                    </tbody>
                                                                </table>

                                                                <% } %>
                                                    </div>

                                                </div>

                                                <div class="footer">© 2026 Ocean View Resort • Room Management</div>
                            </div>

                        </body>

                        </html>