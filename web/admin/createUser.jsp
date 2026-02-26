<%-- 
    Document   : createUser
    Created on : Feb 26, 2026, 6:47:05 PM
    Author     : Haruda
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Create Staff/Admin User</title>
</head>
<body>
    <h2>Admin - Create User</h2>

    <% String err = (String) request.getAttribute("error"); %>
    <% String msg = (String) request.getAttribute("msg"); %>
    <% if (err != null) { %>
        <p style="color:red;"><%= err %></p>
    <% } %>
    <% if (msg != null) { %>
        <p style="color:green;"><%= msg %></p>
    <% } %>

    <form method="post" action="<%=request.getContextPath()%>/admin/create-user">
        <label>Full Name:</label><br/>
        <input type="text" name="fullName" required minlength="3"/><br/><br/>

        <label>Email:</label><br/>
        <input type="email" name="email" required /><br/><br/>

        <label>Phone:</label><br/>
        <input type="text" name="phone" pattern="^[0-9+]{9,15}$"
               title="Enter 9-15 digits, can include +"/><br/><br/>

        <label>Password:</label><br/>
        <input type="password" name="password" required minlength="6"/><br/><br/>

        <label>Role:</label><br/>
        <select name="role" required>
            <option value="STAFF">STAFF</option>
            <option value="ADMIN">ADMIN</option>
        </select><br/><br/>

        <button type="submit">Create User</button>
    </form>

    <p><a href="<%=request.getContextPath()%>/staff/dashboard.jsp">Back to Staff Dashboard</a></p>
</body>
</html>
