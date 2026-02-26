<%-- 
    Document   : index
    Created on : Feb 25, 2026, 10:07:35 PM
    Author     : Haruda
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Ocean View Resort</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/ocean-style.css">
</head>
<body>

    <!-- Navigation -->
    <div class="navbar">
        <div class="logo">Ocean View Resort</div>
        <div class="nav-links">
            <a href="<%=request.getContextPath()%>/login.jsp">Login</a>
            <a href="<%=request.getContextPath()%>/register.jsp">Register</a>
        </div>
    </div>

    <!-- Hero Section -->
    <div class="hero">
        <div class="overlay">
            <div class="hero-content">
                <h1>Welcome to Paradise</h1>
                <p>Experience luxury, comfort, and breathtaking ocean views.</p>

                <div class="buttons">
                    <a href="<%=request.getContextPath()%>/login.jsp" class="btn primary">Login</a>
                    <a href="<%=request.getContextPath()%>/register.jsp" class="btn secondary">Book Your Stay</a>
                </div>
            </div>
        </div>
    </div>

    <!-- About Section -->
    <section class="about">
        <h2>Why Choose Ocean View Resort?</h2>
        <div class="features">
            <div class="feature">
                🌊 Beachfront Rooms
                <p>Wake up to stunning ocean views every morning.</p>
            </div>
            <div class="feature">
                🏝 Luxury Suites
                <p>Premium comfort with world-class service.</p>
            </div>
            <div class="feature">
                🍽 Fine Dining
                <p>Enjoy exquisite cuisine by the sea.</p>
            </div>
        </div>
    </section>

    <footer>
        © 2026 Ocean View Resort | All Rights Reserved
    </footer>

</body>
</html>