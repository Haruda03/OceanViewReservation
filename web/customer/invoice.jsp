<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@page import="java.text.SimpleDateFormat" %>
        <%@page import="java.text.DecimalFormat" %>
            <% String fullName=(String) session.getAttribute("fullName"); String role=(String)
                session.getAttribute("role"); Integer userId=(Integer) session.getAttribute("userId"); if
                (fullName==null || fullName.trim().isEmpty()) { fullName="Guest" ; } if (role==null ||
                role.trim().isEmpty()) { role="CUSTOMER" ; } SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
                DecimalFormat df=new DecimalFormat("0.00"); String invReqNo=(String)
                request.getAttribute("inv_reservation_no"); String invRoomType=(String)
                request.getAttribute("inv_room_type"); java.util.Date invCheckIn=(java.util.Date)
                request.getAttribute("inv_check_in"); java.util.Date invCheckOut=(java.util.Date)
                request.getAttribute("inv_check_out"); Integer invNightsObj=(Integer)
                request.getAttribute("inv_nights"); int invNights=invNightsObj !=null ? invNightsObj : 0;
                java.math.BigDecimal invRate=(java.math.BigDecimal) request.getAttribute("inv_rate");
                java.math.BigDecimal invSubtotal=(java.math.BigDecimal) request.getAttribute("inv_subtotal");
                java.math.BigDecimal invDiscount=(java.math.BigDecimal) request.getAttribute("inv_discount");
                java.math.BigDecimal invTotal=(java.math.BigDecimal) request.getAttribute("inv_total"); String
                invStrategy=(String) request.getAttribute("inv_strategy"); java.util.Date invCreated=(java.util.Date)
                request.getAttribute("inv_created"); %>
                <!DOCTYPE html>
                <html>

                <head>
                    <title>Invoice | Ocean View Resort</title>
                    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/dashboard.css">
                    <style>
                        .invoice-box {
                            max-width: 800px;
                            margin: auto;
                            padding: 30px;
                            border: 1px solid #eee;
                            box-shadow: 0 0 10px rgba(0, 0, 0, 0.15);
                            font-size: 16px;
                            line-height: 24px;
                            font-family: 'Helvetica Neue', 'Helvetica', Helvetica, Arial, sans-serif;
                            color: #555;
                            background: white;
                            border-radius: 10px;
                        }

                        .invoice-box table {
                            width: 100%;
                            text-align: left;
                            border-collapse: collapse;
                        }

                        .invoice-box table td {
                            padding: 5px;
                            vertical-align: top;
                        }

                        .invoice-box table tr.top table td {
                            padding-bottom: 20px;
                        }

                        .invoice-box table tr.top table td.title {
                            font-size: 35px;
                            line-height: 45px;
                            color: #333;
                        }

                        .invoice-box table tr.information table td {
                            padding-bottom: 40px;
                        }

                        .invoice-box table tr.heading td {
                            background: #eee;
                            border-bottom: 1px solid #ddd;
                            font-weight: bold;
                        }

                        .invoice-box table tr.details td {
                            padding-bottom: 20px;
                        }

                        .invoice-box table tr.item td {
                            border-bottom: 1px solid #eee;
                        }

                        .invoice-box table tr.item.last td {
                            border-bottom: none;
                        }

                        .invoice-box table tr.total td:nth-child(2) {
                            border-top: 2px solid #eee;
                            font-weight: bold;
                        }

                        .print-btn {
                            display: block;
                            width: 200px;
                            margin: 20px auto;
                            text-align: center;
                            background: #007bff;
                            color: white;
                            padding: 10px;
                            text-decoration: none;
                            border-radius: 5px;
                            font-weight: bold;
                            cursor: pointer;
                            border: none;
                        }

                        .print-btn:hover {
                            background: #0056b3;
                        }

                        @media print {

                            .topbar,
                            .footer,
                            .print-btn,
                            .full-hero {
                                display: none !important;
                            }

                            .invoice-box {
                                box-shadow: none;
                                border: none;
                                margin: 0;
                                padding: 0;
                            }

                            body {
                                background: white;
                                margin: 0;
                                padding: 0;
                            }
                        }
                    </style>
                </head>

                <body>

                    <!-- TOPBAR -->
                    <div class="topbar">
                        <div class="brand">Ocean View Resort • Invoice</div>
                        <div class="userchip">
                            <%= fullName %> • <%= role %> •
                                    <a class="link" style="color:white;"
                                        href="<%=request.getContextPath()%>/logout">Logout</a>
                        </div>
                    </div>

                    <div
                        style="padding-top: 80px; padding-bottom: 50px; background: rgba(0,0,0,0.05); min-height: 100vh;">
                        <div class="invoice-box">
                            <table cellpadding="0" cellspacing="0">
                                <tr class="top">
                                    <td colspan="2">
                                        <table>
                                            <tr>
                                                <td class="title">
                                                    <h2>Ocean View Resort</h2>
                                                </td>
                                                <td style="text-align: right;">
                                                    <strong>Invoice #:</strong>
                                                    <%= (invReqNo !=null ? invReqNo : "" ) %><br>
                                                        <strong>Created:</strong>
                                                        <%= (invCreated !=null ? sdf.format(invCreated) : "" ) %><br>
                                                            <strong>Check-in:</strong>
                                                            <%= (invCheckIn !=null ? sdf.format(invCheckIn) : "" ) %>
                                                                <br>
                                                                <strong>Check-out:</strong>
                                                                <%= (invCheckOut !=null ? sdf.format(invCheckOut) : "" )
                                                                    %>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>

                                <tr class="information">
                                    <td colspan="2">
                                        <table>
                                            <tr>
                                                <td>
                                                    Ocean View Resort<br>
                                                    123 Beachfront Avenue<br>
                                                    Ocean City, OC 12345<br>
                                                    contact@oceanview.com
                                                </td>
                                                <td style="text-align: right;">
                                                    Billed To:<br>
                                                    <strong>
                                                        <%= fullName %>
                                                    </strong><br>
                                                    Customer ID: <%= userId %>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>

                                <tr class="heading">
                                    <td>Description</td>
                                    <td style="text-align: right;">Amount</td>
                                </tr>

                                <tr class="item">
                                    <td>
                                        <strong>Room:</strong>
                                        <%= (invRoomType !=null ? invRoomType : "" ) %><br>
                                            <small>Rate: $<%= (invRate !=null ? df.format(invRate) : "0.00" ) %> x <%=
                                                        invNights %> nights</small>
                                    </td>
                                    <td style="text-align: right;">$<%= (invSubtotal !=null ? df.format(invSubtotal)
                                            : "0.00" ) %>
                                    </td>
                                </tr>

                                <tr class="item last">
                                    <td>
                                        <strong>Discount/Strategy applied:</strong>
                                        <%= (invStrategy !=null ? invStrategy : "None" ) %>
                                    </td>
                                    <td style="text-align: right;">
                                        -$<%= (invDiscount !=null ? df.format(invDiscount) : "0.00" ) %>
                                    </td>
                                </tr>

                                <tr class="total">
                                    <td></td>
                                    <td style="text-align: right;">
                                        <strong>Total: $<%= (invTotal !=null ? df.format(invTotal) : "0.00" ) %>
                                        </strong>
                                    </td>
                                </tr>
                            </table>

                            <button class="print-btn" onclick="window.print()">Print Invoice</button>
                            <div style="text-align: center; margin-top: 15px;">
                                <a href="<%=request.getContextPath()%>/customer/my-bookings" style="color: #555;">Back
                                    to My Bookings</a>
                            </div>
                        </div>
                    </div>

                </body>

                </html>