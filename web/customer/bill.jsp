<%-- Document : bill Created on : Feb 25, 2026, 10:10:04 PM Author : Haruda --%>

    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <%@page import="model.BillData" %>
            <%@page import="model.BillResult" %>

                <% String fullName=(String) session.getAttribute("fullName"); String role=(String)
                    session.getAttribute("role"); if (fullName==null || fullName.trim().isEmpty()) { fullName="Customer"
                    ; } if (role==null || role.trim().isEmpty()) { role="CUSTOMER" ; } String err=(String)
                    request.getAttribute("error"); BillData data=(BillData) request.getAttribute("billData"); BillResult
                    res=(BillResult) request.getAttribute("billResult"); %>

                    <!DOCTYPE html>
                    <html>

                    <head>
                        <title>Bill | Ocean View Resort</title>
                        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/ocean-app.css">
                        <style>
                            .line {
                                display: flex;
                                justify-content: space-between;
                                padding: 8px 0;
                                border-bottom: 1px solid #e7eef6;
                            }

                            .total {
                                font-weight: 900;
                                font-size: 18px;
                            }

                            .pill {
                                display: inline-block;
                                padding: 6px 10px;
                                border-radius: 999px;
                                background: #f2f8ff;
                                color: #003366;
                                font-weight: 900;
                                font-size: 12px;
                            }

                            .formrow {
                                display: flex;
                                gap: 8px;
                                flex-wrap: wrap;
                                align-items: center;
                                margin-top: 10px;
                            }

                            select,
                            input {
                                padding: 8px 10px;
                                border-radius: 10px;
                                border: 1px solid #cfd9e6;
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
                                <h1>Bill & Receipt</h1>
                                <p>Bills can be generated only for <b>CONFIRMED</b> bookings/reservations.</p>
                            </div>

                            <div class="card" style="margin-top:16px; max-width:780px;">
                                <h3>Bill Details</h3>

                                <% if (err !=null) { %>
                                    <div class="alert error">
                                        <%= err %>
                                    </div>
                                    <% } %>

                                        <% if (data !=null && res !=null) { %>

                                            <!-- Choose pricing strategy -->
                                            <form method="get" action="<%=request.getContextPath()%>/customer/bill">
                                                <input type="hidden" name="no" value="<%= data.getReservationNo() %>">
                                                <div class="formrow">
                                                    <label><b>Pricing Strategy:</b></label>
                                                    <select name="pricing">
                                                        <option value="normal">Normal</option>
                                                        <option value="weekend">Weekend Rate</option>
                                                        <option value="discount">Discount</option>
                                                    </select>

                                                    <input type="number" name="discount" min="1" max="50"
                                                        placeholder="Discount % (e.g. 10)">
                                                    <button type="submit">Apply</button>
                                                    <span class="pill">
                                                        <%= res.getStrategyName() %>
                                                    </span>
                                                </div>
                                                <p style="margin-top:8px;color:#555;font-size:13px;">
                                                    * Weekend Rate charges Friday/Saturday nights higher. Discount
                                                    applies to the normal total.
                                                </p>
                                            </form>

                                            <div class="line"><span>Booking No</span><span><b>
                                                        <%= data.getReservationNo() %>
                                                    </b></span></div>
                                            <div class="line"><span>Room</span><span>
                                                    <%= data.getRoomType() %>
                                                </span></div>
                                            <div class="line"><span>Rate (LKR/night)</span><span>
                                                    <%= data.getRate() %>
                                                </span></div>
                                            <div class="line"><span>Check-in</span><span>
                                                    <%= data.getCheckIn() %>
                                                </span></div>
                                            <div class="line"><span>Check-out</span><span>
                                                    <%= data.getCheckOut() %>
                                                </span></div>
                                            <div class="line"><span>Total Nights</span><span>
                                                    <%= data.getTotalNights() %>
                                                </span></div>

                                            <div class="line"><span>Weekday Nights</span><span>
                                                    <%= res.getWeekdayNights() %>
                                                </span></div>
                                            <div class="line"><span>Weekend Nights</span><span>
                                                    <%= res.getWeekendNights() %>
                                                </span></div>

                                            <div class="line"><span>Subtotal (LKR)</span><span>
                                                    <%= res.getSubtotal() %>
                                                </span></div>
                                            <div class="line"><span>Discount (LKR)</span><span>
                                                    <%= res.getDiscountAmount() %>
                                                </span></div>
                                            <div class="line total"><span>Total (LKR)</span><span>
                                                    <%= res.getTotal() %>
                                                </span></div>

                                            <div class="actions" style="margin-top:14px;">
                                                <button onclick="window.print()">Print Receipt</button>
                                                <a class="btn-back"
                                                    href="<%=request.getContextPath()%>/customer/dashboard.jsp">
                                                    <svg viewBox="0 0 24 24">
                                                        <path
                                                            d="M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z" />
                                                    </svg> Back
                                                </a>
                                            </div>

                                            <% } else { %>
                                                <% java.util.List<model.ReservationView> eligibleList = (java.util.List
                                                    <model.ReservationView>) request.getAttribute("eligibleList"); %>
                                                        <% if (eligibleList !=null && !eligibleList.isEmpty()) { %>
                                                            <p style="margin-bottom:14px;">Select a confirmed booking
                                                                below to generate your bill.</p>
                                                            <div style="display:flex; flex-direction:column; gap:10px;">
                                                                <% for (model.ReservationView v : eligibleList) { %>
                                                                    <div
                                                                        style="border:1px solid #cfd9e6; border-radius:12px; padding:14px; display:flex; justify-content:space-between; align-items:center; background:#f9fbff;">
                                                                        <div>
                                                                            <h4
                                                                                style="color:#003366; margin-bottom:4px;">
                                                                                <%= v.getRoomType() %>
                                                                            </h4>
                                                                            <div style="font-size:13px; color:#555;">
                                                                                <strong>Check-in:</strong>
                                                                                <%= v.getCheckIn() %> |
                                                                                    <strong>Check-out:</strong>
                                                                                    <%= v.getCheckOut() %>
                                                                            </div>
                                                                            <div
                                                                                style="font-size:12px; margin-top:4px; opacity:0.8;">
                                                                                Booking No: <%= v.getReservationNo() %>
                                                                            </div>
                                                                        </div>
                                                                        <a class="btn"
                                                                            href="<%=request.getContextPath()%>/customer/bill?no=<%= v.getReservationNo() %>">View
                                                                            Bill</a>
                                                                    </div>
                                                                    <% } %>
                                                            </div>
                                                            <% } else if (eligibleList !=null) { %>
                                                                <div class="alert warn"
                                                                    style="background:#fff3cd; color:#8a6d00; border:1px solid #ffe69c;">
                                                                    You do not have any CONFIRMED or COMPLETED bookings
                                                                    to generate bills for.
                                                                </div>
                                                                <% } %>

                                                                    <div class="actions" style="margin-top:14px;">
                                                                        <a class="btn-back"
                                                                            href="<%=request.getContextPath()%>/customer/dashboard.jsp">
                                                                            <svg viewBox="0 0 24 24">
                                                                                <path
                                                                                    d="M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z" />
                                                                            </svg> Back
                                                                        </a>
                                                                    </div>
                                                                    <% } %>
                            </div>

                            <div class="footer">© 2026 Ocean View Resort • Billing</div>
                        </div>

                    </body>

                    </html>