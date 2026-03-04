<%-- Document : manageReservations Created on : Feb 25, 2026, 10:10:44 PM Author : Haruda --%>

  <%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@page import="java.util.List" %>
      <%@page import="model.ReservationView" %>
        <%@page import="java.time.temporal.ChronoUnit" %>

          <% String fullName=(String) session.getAttribute("fullName"); String role=(String)
            session.getAttribute("role"); String err=(String) request.getAttribute("error"); List<ReservationView> list
            = (List<ReservationView>) request.getAttribute("list");
              %>

              <!DOCTYPE html>
              <html>

              <head>
                <title>Reservations Management | Staff</title>
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

                  .PENDING {
                    background: #fff3cd;
                    color: #8a6d00;
                  }

                  .CONFIRMED {
                    background: #e7ffe8;
                    color: #0b6b12;
                  }

                  .REJECTED {
                    background: #f8d7da;
                    color: #8a1c1c;
                  }

                  .EXPIRED {
                    background: #e2e3e5;
                    color: #4b4f56;
                  }

                  .CANCELLED {
                    background: #ffe5e5;
                    color: #a10000;
                  }

                  .COMPLETED {
                    background: #e9f7ff;
                    color: #006a8e;
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

                  .btn-danger {
                    padding: 8px 10px;
                    border-radius: 10px;
                    border: none;
                    background: #e64b4b;
                    color: #fff;
                    font-weight: 900;
                    cursor: pointer;
                  }

                  .row-actions {
                    display: flex;
                    gap: 8px;
                    flex-wrap: wrap;
                  }

                  select {
                    padding: 8px 10px;
                    border-radius: 10px;
                    border: 1px solid #cfd9e6;
                  }

                  .muted {
                    color: #666;
                    font-size: 12px;
                  }
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
                    <h1>Reservations Management</h1>
                    <p>Filter and manage bookings/reservations. Staff can cancel or mark a confirmed stay as completed.
                    </p>
                  </div>

                  <div class="actions" style="margin-top:14px;">
                    <a class="btn-back" href="<%=request.getContextPath()%>/staff/dashboard.jsp">
                      <svg viewBox="0 0 24 24">
                        <path d="M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z" />
                      </svg> Back
                    </a>
                    <a class="btn" href="<%=request.getContextPath()%>/staff/reservations-manage">Refresh</a>
                  </div>

                  <% if(err !=null){ %>
                    <div class="alert error" style="margin-top:12px;">
                      <%= err %>
                    </div>
                    <% } %>

                      <div class="card" style="margin-top:16px;">
                        <h3>Filter</h3>
                        <form method="get" action="<%=request.getContextPath()%>/staff/reservations-manage"
                          style="display:flex; gap:10px; flex-wrap:wrap; align-items:center;">
                          <label><b>Status</b></label>
                          <select name="status">
                            <option value="">All</option>
                            <option value="PENDING">PENDING</option>
                            <option value="CONFIRMED">CONFIRMED</option>
                            <option value="REJECTED">REJECTED</option>
                            <option value="EXPIRED">EXPIRED</option>
                            <option value="CANCELLED">CANCELLED</option>
                            <option value="COMPLETED">COMPLETED</option>
                          </select>

                          <label><b>Type</b></label>
                          <select name="type">
                            <option value="">All</option>
                            <option value="BOOKING">BOOKING</option>
                            <option value="RESERVATION">RESERVATION</option>
                          </select>

                          <button type="submit">Apply</button>
                        </form>
                      </div>

                      <div class="card" style="margin-top:16px;">
                        <h3>All Records</h3>

                        <% if(list==null || list.isEmpty()){ %>
                          <p class="muted" style="margin-top:10px;">No records found.</p>
                          <% } else { %>

                            <table>
                              <thead>
                                <tr>
                                  <th>No</th>
                                  <th>Type</th>
                                  <th>Room</th>
                                  <th>Dates</th>
                                  <th>Nights</th>
                                  <th>Guests</th>
                                  <th>Status</th>
                                  <th>Expires</th>
                                  <th>Actions</th>
                                </tr>
                              </thead>
                              <tbody>
                                <% for(ReservationView r : list){ long nights=ChronoUnit.DAYS.between(r.getCheckIn(),
                                  r.getCheckOut()); %>
                                  <tr>
                                    <td><b>
                                        <%= r.getReservationNo() %>
                                      </b></td>
                                    <td><span class="chip">
                                        <%= r.getRequestType() %>
                                      </span></td>
                                    <td>
                                      <%= r.getRoomType() %>
                                        <div class="muted">LKR <%= r.getRate() %>/night</div>
                                    </td>
                                    <td>
                                      <%= r.getCheckIn() %> → <%= r.getCheckOut() %>
                                    </td>
                                    <td>
                                      <%= nights %>
                                    </td>
                                    <td>
                                      <%= r.getGuests() %>
                                    </td>
                                    <td><span class="chip <%= r.getStatus() %>">
                                        <%= r.getStatus() %>
                                      </span></td>
                                    <td>
                                      <%= (r.getExpiresAt()==null ? "-" : r.getExpiresAt()) %>
                                    </td>
                                    <td>
                                      <div class="row-actions">
                                        <% if("CONFIRMED".equals(r.getStatus())) { %>
                                          <form method="post"
                                            action="<%=request.getContextPath()%>/staff/reservations-manage">
                                            <input type="hidden" name="action" value="complete">
                                            <input type="hidden" name="no" value="<%= r.getReservationNo() %>">
                                            <button class="btn-sm" type="submit">Check-out (Complete)</button>
                                          </form>

                                          <form method="post"
                                            action="<%=request.getContextPath()%>/staff/reservations-manage">
                                            <input type="hidden" name="action" value="cancel">
                                            <input type="hidden" name="no" value="<%= r.getReservationNo() %>">
                                            <button class="btn-danger" type="submit">Cancel</button>
                                          </form>
                                          <% } else { %>
                                            <span class="muted">No action</span>
                                            <% } %>
                                      </div>
                                    </td>
                                  </tr>
                                  <% } %>
                              </tbody>
                            </table>

                            <% } %>
                      </div>

                      <div class="footer">© 2026 Ocean View Resort • Staff Reservations</div>
                </div>
              </body>

              </html>