<%-- Document : dashboard Created on : Feb 26, 2026, 9:49:43 PM Author : Haruda --%>
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <% String fullName=(String) session.getAttribute("fullName"); String role=(String) session.getAttribute("role");
            %>
            <!DOCTYPE html>
            <html>

            <head>
                <title>Admin Dashboard | Ocean View Resort</title>
                <link rel="stylesheet" href="<%=request.getContextPath()%>/css/ocean-app.css">
            </head>

            <body>

                <div class="topbar">
                    <div class="brand">Ocean View Resort • Admin Dashboard</div>
                    <div class="userchip">
                        <%= fullName %> • <%= role %> •
                                <a class="link" style="color:white;"
                                    href="<%=request.getContextPath()%>/logout">Logout</a>
                    </div>
                </div>

                <div class="container">
                    <div class="hero">
                        <h1>Administration Console</h1>
                        <p>Manage staff access, monitor operations, and maintain secure role-based control for Ocean
                            View Resort.</p>
                        <div style="margin-top:12px;">
                            <span class="badge">User Management</span>
                            <span class="badge">Security</span>
                            <span class="badge">Reports</span>
                        </div>
                    </div>

                    <div class="grid">
                        <div class="card">
                            <h3>Create Staff/Admin Users</h3>
                            <p>Create accounts with controlled permissions. Public registration remains CUSTOMER only to
                                prevent privilege escalation.</p>
                            <div class="action">
                                <a class="btn" href="<%=request.getContextPath()%>/admin/createUser.jsp">Create User</a>
                                <a class="link" href="<%=request.getContextPath()%>/admin/manage-users">Manage Users</a>
                            </div>
                        </div>

                        <div class="card">
                            <h3>Staff Console</h3>
                            <p>Access operational tools for reservation verification, booking management, billing
                                support, and front-desk tasks.</p>
                            <div class="action">
                                <a class="btn" href="<%=request.getContextPath()%>/staff/dashboard.jsp">Open Staff
                                    Console</a>
                                <a class="link" href="<%=request.getContextPath()%>/staff/reports.jsp">Reports</a>
                            </div>
                        </div>

                        <div class="card">
                            <h3>System User Guide</h3>
                            <p>View comprehensive guidelines for staff onboarding, operational procedures, and secure
                                usage of the system.</p>
                            <div class="action">
                                <a class="btn" href="<%=request.getContextPath()%>/staff/help.jsp">User Guide</a>
                                <a class="link" href="<%=request.getContextPath()%>/index.jsp">Resort Home</a>
                            </div>
                        </div>
                    </div>

                    <div class="footer">© 2026 Ocean View Resort • Admin Console</div>
                </div>

            </body>

            </html>