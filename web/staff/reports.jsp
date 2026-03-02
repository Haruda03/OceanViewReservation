<%-- 
    Document   : reports
    Created on : Feb 25, 2026, 10:12:30 PM
    Author     : Haruda
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.time.LocalDate"%>

<%
    String fullName = (String) session.getAttribute("fullName");
    String role = (String) session.getAttribute("role");

    String err = (String) request.getAttribute("error");

    LocalDate from = (LocalDate) request.getAttribute("from");
    LocalDate toIncl = (LocalDate) request.getAttribute("toInclusive");

    Map<String,Integer> statusCounts = (Map<String,Integer>) request.getAttribute("statusCounts");
    java.math.BigDecimal revenue = (java.math.BigDecimal) request.getAttribute("revenue");

    List<Map<String,Object>> topRooms = (List<Map<String,Object>>) request.getAttribute("topRooms");
    List<Map<String,Object>> dailyRevenue = (List<Map<String,Object>>) request.getAttribute("dailyRevenue");

    if(statusCounts == null) statusCounts = new HashMap<>();
    if(revenue == null) revenue = java.math.BigDecimal.ZERO;
%>

<!DOCTYPE html>
<html>
<head>
    <title>Reports & Analytics | Staff</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/ocean-app.css">
    <style>
        .grid2{ display:grid; grid-template-columns: 1fr 1fr; gap:14px; }
        @media(max-width:900px){ .grid2{ grid-template-columns:1fr; } }

        .stat{ padding:12px 14px; border-radius:16px; background:rgba(255,255,255,0.88); }
        .stat h4{ margin:0; color:#003366; }
        .stat .num{ font-size:24px; font-weight:900; margin-top:6px; }

        table{ width:100%; border-collapse:collapse; margin-top:10px; }
        th, td{ padding:10px; border-bottom:1px solid #e7eef6; text-align:left; vertical-align:top; }
        th{ color:#003366; background:#f2f8ff; }
        input{ padding:8px 10px; border-radius:10px; border:1px solid #cfd9e6; }
        .muted{ color:#666; font-size:12px; }
    </style>
</head>
<body>

<div class="topbar">
    <div class="brand">Ocean View Resort • Staff Console</div>
    <div class="userchip">
        <%= fullName %> • <%= role %> •
        <a class="link" style="color:white;" href="<%=request.getContextPath()%>/logout">Logout</a>
    </div>
</div>

<div class="container">

    <div class="hero">
        <h1>Reports & Analytics</h1>
        <p>Operational insights and revenue analysis for resort management.</p>
        <div style="margin-top:12px;">
            <span class="badge">Summary</span>
            <span class="badge">Revenue</span>
            <span class="badge">Top Rooms</span>
        </div>
    </div>

    <div class="actions" style="margin-top:14px;">
        <a class="btnlink" href="<%=request.getContextPath()%>/staff/dashboard">Back</a>
        <a class="btn" href="<%=request.getContextPath()%>/staff/reports">Refresh</a>
    </div>

    <% if(err != null){ %>
        <div class="alert error" style="margin-top:12px;"><%= err %></div>
    <% } %>

    <!-- Date filter -->
    <div class="card" style="margin-top:16px;">
        <h3>Date Range</h3>
        <form method="get" action="<%=request.getContextPath()%>/staff/reports" style="display:flex;gap:10px;flex-wrap:wrap;align-items:center;">
            <label><b>From</b></label>
            <input type="date" name="from" value="<%= from != null ? from.toString() : "" %>">

            <label><b>To</b></label>
            <input type="date" name="to" value="<%= toIncl != null ? toIncl.toString() : "" %>">

            <button type="submit">Apply</button>
            <span class="muted">Default is last 30 days.</span>
        </form>
    </div>

    <!-- Status summary -->
    <div class="card" style="margin-top:16px;">
        <h3>Operational Summary (All Time)</h3>

        <div class="grid2" style="margin-top:10px;">
            <div class="stat"><h4>Pending</h4><div class="num"><%= statusCounts.getOrDefault("pending",0) %></div></div>
            <div class="stat"><h4>Confirmed</h4><div class="num"><%= statusCounts.getOrDefault("confirmed",0) %></div></div>
            <div class="stat"><h4>Completed</h4><div class="num"><%= statusCounts.getOrDefault("completed",0) %></div></div>
            <div class="stat"><h4>Cancelled</h4><div class="num"><%= statusCounts.getOrDefault("cancelled",0) %></div></div>
            <div class="stat"><h4>Rejected</h4><div class="num"><%= statusCounts.getOrDefault("rejected",0) %></div></div>
            <div class="stat"><h4>Expired</h4><div class="num"><%= statusCounts.getOrDefault("expired",0) %></div></div>
        </div>
    </div>

    <!-- Revenue -->
    <div class="card" style="margin-top:16px;">
        <h3>Revenue (Selected Range)</h3>
        <p class="muted">
            Revenue is calculated as: nights × room rate for CONFIRMED/COMPLETED stays (based on check-in date).
        </p>
        <div style="font-size:28px;font-weight:900;margin-top:10px;">
            LKR <%= revenue %>
        </div>
    </div>

    <!-- Top room types -->
    <div class="card" style="margin-top:16px;">
        <h3>Top Room Types (Selected Range)</h3>

        <% if(topRooms == null || topRooms.isEmpty()){ %>
            <p class="muted">No data found for the selected range.</p>
        <% } else { %>

        <table>
            <thead>
                <tr>
                    <th>Room Type</th>
                    <th>Bookings</th>
                    <th>Revenue (LKR)</th>
                </tr>
            </thead>
            <tbody>
            <% for(Map<String,Object> row : topRooms){ %>
                <tr>
                    <td><b><%= row.get("roomType") %></b></td>
                    <td><%= row.get("bookings") %></td>
                    <td><%= row.get("revenue") %></td>
                </tr>
            <% } %>
            </tbody>
        </table>

        <% } %>
    </div>

    <!-- Daily revenue -->
    <div class="card" style="margin-top:16px;">
        <h3>Daily Revenue (Selected Range)</h3>
        <p class="muted">Use this table to create a chart in your report (optional upgrade).</p>

        <% if(dailyRevenue == null || dailyRevenue.isEmpty()){ %>
            <p class="muted">No daily revenue data.</p>
        <% } else { %>
            <table>
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Revenue (LKR)</th>
                    </tr>
                </thead>
                <tbody>
                <% for(Map<String,Object> row : dailyRevenue){ %>
                    <tr>
                        <td><%= row.get("day") %></td>
                        <td><%= row.get("revenue") %></td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        <% } %>
    </div>

    <div class="footer">© 2026 Ocean View Resort • Reports & Analytics</div>
</div>

</body>
</html>