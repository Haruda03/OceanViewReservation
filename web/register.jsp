<%-- Document : register Created on : Feb 25, 2026, 10:08:22 PM Author : Haruda --%>

    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>Register | Ocean View Resort</title>
            <link rel="stylesheet" href="<%=request.getContextPath()%>/css/ocean-auth.css">
        </head>

        <body>
            <div class="auth-bg">

                <div class="navbar">
                    <div class="logo">Ocean View Resort</div>
                    <div class="nav-links">
                        <a href="<%=request.getContextPath()%>/index.jsp">Home</a>
                        <a href="<%=request.getContextPath()%>/login.jsp">Login</a>
                    </div>
                </div>

                <div class="center">
                    <div class="card" style="max-width:620px;">
                        <h2>Create Account</h2>
                        <div class="sub">Register to book rooms and view your reservations.</div>

                        <% String err=(String) request.getAttribute("error"); String msg=(String)
                            request.getAttribute("msg"); if (err !=null) { %>
                            <div class="alert error">
                                <%= err %>
                            </div>
                            <% } %>
                                <% if (msg !=null) { %>
                                    <div class="alert success">
                                        <%= msg %>
                                    </div>
                                    <% } %>

                                        <form method="post" action="<%=request.getContextPath()%>/register">
                                            <div class="field">
                                                <label>Full Name</label>
                                                <input type="text" name="fullName" placeholder="Full name" required
                                                    minlength="3">
                                            </div>

                                            <div class="field">
                                                <label>Email</label>
                                                <input type="email" name="email" placeholder="you@example.com" required>
                                            </div>

                                            <div class="field">
                                                <label>Phone</label>
                                                <input type="text" name="phone" placeholder="+947XXXXXXXX"
                                                    pattern="^[0-9+]{9,15}$" title="Enter 9–15 digits, can include +">
                                            </div>

                                            <div class="field">
                                                <label>Password</label>
                                                <input type="password" name="password"
                                                    placeholder="Minimum 6 characters" required minlength="6">
                                            </div>

                                            <div class="actions">
                                                <button type="submit">Register</button>
                                                <a class="btn-back" href="<%=request.getContextPath()%>/login.jsp">
                                                    <svg viewBox="0 0 24 24">
                                                        <path
                                                            d="M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z" />
                                                    </svg> Back to login
                                                </a>
                                            </div>
                                        </form>
                    </div>
                </div>

                <div class="footer">© 2026 Ocean View Resort • Privacy & Security</div>
            </div>
        </body>

        </html>