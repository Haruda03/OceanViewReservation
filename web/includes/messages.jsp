<%-- 
    Document   : messages
    Created on : Feb 26, 2026, 8:18:34?PM
    Author     : Haruda
--%>

<%
    String err = (String) request.getAttribute("error");
    String msg = (String) request.getAttribute("msg");
%>
<% if (err != null) { %>
    <div class="alert error"><%= err %></div>
<% } %>
<% if (msg != null) { %>
    <div class="alert success"><%= msg %></div>
<% } %>
