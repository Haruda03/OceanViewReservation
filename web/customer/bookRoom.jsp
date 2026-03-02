<%-- 
    Document   : bookRoom
    Created on : Feb 28, 2026, 10:45:10 AM
    Author     : Haruda
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Room"%>
<%@page import="java.time.LocalDate"%>

<%
    String fullName = (String) session.getAttribute("fullName");
    String role = (String) session.getAttribute("role");

    String err = (String) request.getAttribute("error");

    LocalDate checkIn = (LocalDate) request.getAttribute("checkIn");
    LocalDate checkOut = (LocalDate) request.getAttribute("checkOut");
    Integer guests = (Integer) request.getAttribute("guests");

    List<Room> rooms = (List<Room>) request.getAttribute("rooms");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Book a Room | Ocean View Resort</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/ocean-app.css">
    <style>
        .grid{ display:grid; grid-template-columns: repeat(3, 1fr); gap:14px; }
        @media(max-width:1000px){ .grid{ grid-template-columns: repeat(2,1fr); } }
        @media(max-width:700px){ .grid{ grid-template-columns: 1fr; } }

        .room-card{
            background: rgba(255,255,255,0.18);
            border:1px solid rgba(255,255,255,0.28);
            border-radius:18px;
            padding:14px;
            backdrop-filter: blur(10px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.10);
        }
        .room-title{ font-size:18px; font-weight:900; color:#fff; }
        .room-meta{ color:rgba(255,255,255,0.92); margin-top:8px; font-size:13px; }
        .room-price{ font-size:22px; font-weight:900; color:#fff; margin-top:10px; }
        .room-actions{ display:flex; gap:10px; flex-wrap:wrap; margin-top:12px; }
        .btn2{
            padding:10px 12px; border-radius:12px; font-weight:900; text-decoration:none;
            background:#00c3ff; color:#fff; display:inline-block;
        }
        .btn2:hover{ background:#009dcf; }
        .btn3{
            padding:10px 12px; border-radius:12px; font-weight:900; text-decoration:none;
            background:#00c3ff; color:#fff; display:inline-block;
        }
        .btn3:hover{ background:#009dcf; }
        
        .room-card{
    background:#ffffff;               /* solid white card */
    border:1px solid #d0dde9;
    border-radius:18px;
    padding:14px;
    box-shadow:0 10px 25px rgba(0,0,0,0.08);
}
.room-title{
    font-size:18px;
    font-weight:900;
    color:#003366;                    /* dark blue, visible */
}
.room-meta{
    color:#334455;                    /* dark grey-blue */
    margin-top:8px;
    font-size:13px;
}
.room-price{
    font-size:22px;
    font-weight:900;
    color:#003366;                    /* dark blue, visible */
    margin-top:10px;
}
    </style>
</head>
<body>

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
        <p>Select dates and guests to view available rooms. Book instantly or request a reservation for staff approval.</p>
        <div style="margin-top:12px;">
            <span class="badge">Live Availability</span>
            <span class="badge">Instant Booking</span>
            <span class="badge">Reservation Request</span>
        </div>
    </div>

    <div class="actions" style="margin-top:14px;">
        <a class="btnlink" href="<%=request.getContextPath()%>/customer/dashboard.jsp">Back</a>
        <a class="btn" href="<%=request.getContextPath()%>/customer/book">New Search</a>
    </div>

    <% if (err != null) { %>
        <div class="alert error" style="margin-top:12px;"><%= err %></div>
    <% } %>

    <!-- SEARCH FORM -->
    <div class="card" style="margin-top:16px;">
        <h3>Search Availability</h3>

        <form method="post" action="<%=request.getContextPath()%>/customer/book"
              style="display:flex; gap:10px; flex-wrap:wrap; align-items:center; margin-top:10px;">

            <label><b>Check-in</b></label>
            <input type="date" name="checkIn" value="<%= checkIn != null ? checkIn.toString() : "" %>" required>

            <label><b>Check-out</b></label>
            <input type="date" name="checkOut" value="<%= checkOut != null ? checkOut.toString() : "" %>" required>

            <label><b>Guests</b></label>
            <input type="number" name="guests" min="1" max="20" value="<%= guests != null ? guests : 1 %>" required>

            <button type="submit">Search</button>
        </form>
    </div>

    <!-- RESULTS -->
    <div class="card" style="margin-top:16px;">
        <h3>Available Rooms</h3>

        <% if (rooms == null) { %>
            <p style="color:#555;">Search to view rooms.</p>

        <% } else if (rooms.isEmpty()) { %>
            <p style="color:#555;">No rooms available for the selected dates and guests.</p>

        <% } else { %>

            <div class="grid" style="margin-top:12px;">
                <% for (Room r : rooms) { %>
                    <div class="room-card">
                        <div class="room-title"><%= r.getRoomType() %></div>
                        <div class="room-meta">Max Guests: <b><%= r.getMaxGuests() %></b></div>
                        <div class="room-meta">Status: <b><%= r.getStatus() %></b></div>
                        <div class="room-price">LKR <%= r.getRate() %> / night</div>

                        <div class="room-actions">
                            <!-- Book Now (Instant CONFIRMED) -->
                            <a class="btn2"
                               href="<%=request.getContextPath()%>/customer/booking-action?action=book&roomId=<%=r.getRoomId()%>&checkIn=<%=checkIn%>&checkOut=<%=checkOut%>&guests=<%=guests%>">
                                Book Now
                            </a>

                            <!-- Request Reservation (PENDING approval) -->
                            <a class="btn3"
                               href="<%=request.getContextPath()%>/customer/booking-action?action=request&roomId=<%=r.getRoomId()%>&checkIn=<%=checkIn%>&checkOut=<%=checkOut%>&guests=<%=guests%>">
                                Request Reservation
                            </a>
                        </div>

                        <div style="margin-top:10px; color:rgba(0, 0, 0, 0.9); font-size:12px;">
                            * Reservation requests expire if not approved by staff.
                        </div>
                    </div>
                <% } %>
            </div>

        <% } %>
    </div>

    <div class="footer">© 2026 Ocean View Resort • Booking</div>
</div>

</body>
</html>