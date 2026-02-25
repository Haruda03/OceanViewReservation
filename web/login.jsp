<%-- 
    Document   : login
    Created on : Feb 25, 2026, 9:22:06 PM
    Author     : Haruda
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
</head>
<body>
    <h2>Login</h2>

    <% String err = (String) request.getAttribute("error"); %>
    <% if (err != null) { %>
        <p style="color:red;"><%= err %></p>
    <% } %>

    <form method="post" action="login">
        <label>Email:</label><br/>
        <input type="email" name="email" required /><br/><br/>

        <label>Password:</label><br/>
        <input type="password" name="password" required minlength="6"/><br/><br/>

        <button type="submit">Login</button>
    </form>

    <p>Don’t have an account? <a href="register.jsp">Register</a></p>
</body>
</html>