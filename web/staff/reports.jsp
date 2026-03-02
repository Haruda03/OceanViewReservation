<%-- 
    Document   : reports
    Created on : Feb 25, 2026, 10:12:30?PM
    Author     : Haruda
--%>

<%@page import="java.util.Map"%>
<%
 String fullName=(String)session.getAttribute("fullName");
 String role=(String)session.getAttribute("role");
 String err=(String)request.getAttribute("error");
 Map summary=(Map)request.getAttribute("summary");
%>
<!DOCTYPE html>
<html>
<head>
  <title>Reports</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/ocean-app.css">
</head>
<body>
<div class="topbar">
  <div class="brand">Ocean View Resort ? Staff Console</div>
  <div class="userchip"><%=fullName%> ? <%=role%> ? <a class="link" style="color:white;" href="<%=request.getContextPath()%>/logout">Logout</a></div>
</div>

<div class="container">
  <div class="hero"><h1>Reports & Analytics</h1><p>Operational summary and revenue estimation.</p></div>
  <div class="actions" style="margin-top:14px;">
    <a class="btnlink" href="<%=request.getContextPath()%>/staff/dashboard.jsp">Back</a>
  </div>

  <% if(err!=null){ %><div class="alert error" style="margin-top:12px;"><%=err%></div><% } %>

  <div class="card" style="margin-top:16px;">
    <h3>Summary</h3>
    <p>Pending: <b><%=summary.get("pending")%></b></p>
    <p>Confirmed: <b><%=summary.get("confirmed")%></b></p>
    <p>Completed: <b><%=summary.get("completed")%></b></p>
    <p>Cancelled: <b><%=summary.get("cancelled")%></b></p>
    <p>Total Revenue (CONFIRMED+COMPLETED): <b>LKR <%=summary.get("revenue")%></b></p>
  </div>

  <div class="footer">© 2026 Ocean View Resort ? Reports</div>
</div>
</body>
</html>