<%-- 
    Document   : bookRoom
    Created on : Feb 28, 2026, 10:45:10 AM
    Author     : Haruda
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Room"%>

<%
    String fullName = (String) session.getAttribute("fullName");
    String role = (String) session.getAttribute("role");
    List<Room> rooms = (List<Room>) request.getAttribute("rooms");

    String err = (String) request.getAttribute("error");
    String msg = (String) request.getAttribute("msg");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Book / Request | Ocean View Resort</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/ocean-app.css">
</head>
<body>

<!-- TOPBAR -->
<div class="topbar">
    <div class="brand">Ocean View Resort • Customer Portal</div>
    <div class="userchip">
        <%= fullName %> • <%= role %> •
        <a class="link" style="color:white;" href="<%=request.getContextPath()%>/logout">Logout</a>
    </div>
</div>

<div class="container">

    <div class="hero">
        <h1>Book Your Stay</h1>
        <p>
            You can either <b>Book Now</b> for instant confirmation, or <b>Request Reservation</b> for staff approval
            (requests expire if not approved within the set time period).
        </p>
        <div style="margin-top:12px;">
            <span class="badge">Instant Booking</span>
            <span class="badge">Reservation Request</span>
            <span class="badge">Conflict Prevention</span>
        </div>
    </div>

    <div class="card" style="max-width:760px; margin:16px auto 0;">
        <h3>Booking / Reservation Form</h3>

        <% if (err != null) { %>
            <div class="alert error"><%= err %></div>
        <% } %>
        <% if (msg != null) { %>
            <div class="alert success"><%= msg %></div>
        <% } %>

        <form method="post" action="<%=request.getContextPath()%>/customer/book">
            <!-- This value is set by the clicked button -->
            <input type="hidden" name="requestType" id="requestType" value="BOOKING">

            <div style="margin-top:10px;">
                <label>Room Type</label><br/>
                <select name="roomId" required>
                    <option value="">-- Select --</option>
                    <% if (rooms != null) {
                        for (Room r : rooms) { %>
                        <option value="<%= r.getRoomId() %>">
                            <%= r.getRoomType() %> - LKR <%= r.getRate() %> /night (Max <%= r.getMaxGuests() %>)
                        </option>
                    <%  } } %>
                </select>
            </div>

            <div style="margin-top:10px;">
                <label>Check-in Date</label><br/>
                <input type="date" name="checkIn" required/>
            </div>

            <div style="margin-top:10px;">
                <label>Check-out Date</label><br/>
                <input type="date" name="checkOut" required/>
            </div>

            <div style="margin-top:10px;">
                <label>Number of Guests</label><br/>
                <input type="number" name="guests" min="1" max="10" required/>
            </div>

            <div class="actions" style="margin-top:14px;">
                <!-- BOOKING: Direct Confirm -->
                <button type="submit"
                        onclick="document.getElementById('requestType').value='BOOKING'">
                    Book Now (Instant)
                </button>

                <!-- RESERVATION: Staff Approval -->
                <button type="submit"
                        onclick="document.getElementById('requestType').value='RESERVATION'">
                    Request Reservation (Staff Approval)
                </button>

                <a class="btnlink" href="<%=request.getContextPath()%>/customer/dashboard.jsp">Back</a>
            </div>

            <p style="margin-top:12px;color:#555;font-size:13px;">
                <b>Book Now</b> confirms instantly and will appear in <b>My Bookings</b>.
                <b>Request Reservation</b> creates a <b>PENDING</b> request and will appear in <b>My Reservations</b>
                until staff approves or it expires.
            </p>
        </form>
    </div>

    <div class="footer">© 2026 Ocean View Resort • Booking Portal</div>
</div>

</body>
</html>