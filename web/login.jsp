<%-- 
    Document   : login
    Created on : Feb 25, 2026, 9:22:06 PM
    Author     : Haruda
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login | Ocean View Resort</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/ocean-auth.css">
</head>
<body>
<div class="auth-bg">

    <div class="navbar">
        <div class="logo">Ocean View Resort</div>
        <div class="nav-links">
            <a href="<%=request.getContextPath()%>/index.jsp">Home</a>
            <a href="<%=request.getContextPath()%>/register.jsp">Register</a>
        </div>
    </div>

    <div class="center">
        <div class="card">
            <h2>Login</h2>
            <div class="sub">Sign in to manage your reservations and billing.</div>

            <%
                String err = (String) request.getAttribute("error");
                String msg = (String) request.getAttribute("msg");
                if (err != null) {
            %>
                <div class="alert error"><%= err %></div>
            <% } %>
            <% if (msg != null) { %>
                <div class="alert success"><%= msg %></div>
            <% } %>

            <form method="post" action="<%=request.getContextPath()%>/login">
                <div class="field">
                    <label>Email</label>
                    <input type="email" name="email" placeholder="you@example.com" required>
                </div>

                <div class="field">
                    <label>Password</label>
                    <input type="password" name="password" placeholder="••••••••" required minlength="6">
                </div>

                <div class="actions">
                    <button type="submit">Login</button>
                    <a class="btnlink" href="<%=request.getContextPath()%>/register.jsp">Create account</a>
                </div>
            </form>
        </div>
    </div>

    <div class="footer">© 2026 Ocean View Resort • Secure Access</div>
</div>
</body>
</html>