<%-- 
    Document   : dashboard
    Created on : Feb 25, 2026, 10:10:30 PM
    Author     : Haruda
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String name = (String) session.getAttribute("fullName");
%>
<!DOCTYPE html>
<html>
<head><title>Staff Dashboard</title></head>
<body>
    <h2>Staff Dashboard</h2>
    <p>Welcome, <%= name %></p>

    <a href="<%=request.getContextPath()%>/logout">Logout</a>
</body>
</html>
