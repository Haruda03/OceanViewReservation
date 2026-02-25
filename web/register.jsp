<%-- 
    Document   : register
    Created on : Feb 25, 2026, 10:08:22 PM
    Author     : Haruda
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
</head>
<body>
    <h2>Register</h2>

    <% String err = (String) request.getAttribute("error"); %>
    <% String msg = (String) request.getAttribute("msg"); %>
    <% if (err != null) { %>
        <p style="color:red;"><%= err %></p>
    <% } %>
    <% if (msg != null) { %>
        <p style="color:green;"><%= msg %></p>
    <% } %>

    <form method="post" action="register">
        <label>Full Name:</label><br/>
        <input type="text" name="fullName" required minlength="3"/><br/><br/>

        <label>Email:</label><br/>
        <input type="email" name="email" required /><br/><br/>

        <label>Phone:</label><br/>
        <input type="text" name="phone" pattern="^[0-9+]{9,15}$"
               title="Enter 9-15 digits, can include +"/><br/><br/>

        <label>Password:</label><br/>
        <input type="password" name="password" required minlength="6"/><br/><br/>

        <button type="submit">Create Account</button>
    </form>

    <p>Already have an account? <a href="login.jsp">Login</a></p>
</body>
</html>