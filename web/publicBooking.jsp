<%-- 
    Public Resort Booking Page (no login required)
    Visitors can search dates & guests, then are routed into the customer booking flow.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Book Your Stay | Ocean View Resort</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/ocean-style.css">
    <style>
        .booking-overlay{
            position:absolute;
            top:0;
            left:0;
            width:100%;
            height:100%;
            background:rgba(0,0,0,0.45);
            display:flex;
            align-items:center;
            justify-content:center;
            padding:20px;
        }
        .booking-card{
            width:100%;
            max-width:640px;
            background:rgba(255,255,255,0.95);
            border-radius:18px;
            padding:22px 22px 18px;
            box-shadow:0 14px 35px rgba(0,0,0,0.35);
        }
        .booking-card h1{
            font-size:28px;
            color:#003366;
            margin-bottom:4px;
        }
        .booking-card p{
            font-size:13px;
            color:#445;
            margin-bottom:12px;
        }
        .booking-grid{
            display:grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap:10px 12px;
            align-items:flex-end;
        }
        @media(max-width:700px){
            .booking-grid{
                grid-template-columns: 1fr;
            }
        }
        .booking-grid .full{
            grid-column:1 / -1;
        }
        .booking-card label{
            font-weight:700;
            font-size:13px;
            color:#003366;
        }
        .booking-card input,
        .booking-card select{
            width:100%;
            margin-top:6px;
            padding:9px 10px;
            border-radius:10px;
            border:1px solid #ccd7e4;
            outline:none;
            font-size:13px;
        }
        .booking-card button{
            width:100%;
            padding:11px 16px;
            border-radius:999px;
            border:none;
            cursor:pointer;
            font-weight:800;
            background:#00c3ff;
            color:#fff;
        }
        .booking-card button:hover{
            background:#009dcf;
        }
        .booking-note{
            margin-top:8px;
            font-size:11px;
            color:#667;
        }
        .top-links{
            position:absolute;
            top:18px;
            right:40px;
            z-index:20;
        }
        .top-links a{
            color:#fff;
            text-decoration:none;
            margin-left:18px;
            font-weight:700;
        }
        .top-links a:hover{
            color:#00e0ff;
        }
    </style>
</head>
<body>

<!-- Reuse hero background from landing page -->
<div class="hero">
    <div class="booking-overlay">

        <div class="top-links">
            <a href="<%=request.getContextPath()%>/login.jsp">Login</a>
            <a href="<%=request.getContextPath()%>/register.jsp">Register</a>
        </div>

        <div class="booking-card">
            <h1>Plan Your Oceanfront Escape</h1>
            <p>
                Choose your dates and number of guests to start your reservation.
                You’ll be able to sign in or create an account to complete the booking.
            </p>

            <!-- Public search form:
                 This forwards to the existing /customer/book flow which can
                 either show availability or redirect to login based on your filters. -->
            <form method="post" action="<%=request.getContextPath()%>/customer/book" class="booking-grid">

                <div>
                    <label>Check‑in</label>
                    <input type="date" name="checkIn" required>
                </div>

                <div>
                    <label>Check‑out</label>
                    <input type="date" name="checkOut" required>
                </div>

                <div>
                    <label>Guests</label>
                    <input type="number" name="guests" min="1" max="20" value="2" required>
                </div>

                <div>
                    <label>Room Type (optional)</label>
                    <select name="roomType">
                        <option value="">Any</option>
                        <option value="DELUXE">Deluxe</option>
                        <option value="SUITE">Suite</option>
                        <option value="FAMILY">Family</option>
                        <option value="STANDARD">Standard</option>
                    </select>
                </div>

                <div class="full">
                    <button type="submit">Search Availability</button>
                </div>
            </form>

            <div class="booking-note">
                You won’t be charged yet. Final confirmation happens after you login or create an account.
            </div>
        </div>

    </div>
</div>

<footer>
    © 2026 Ocean View Resort | All Rights Reserved
</footer>

</body>
</html>

