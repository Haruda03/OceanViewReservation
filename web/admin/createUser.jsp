<%-- Document : createUser Created on : Feb 26, 2026, 6:47:05 PM Author : Haruda --%>

    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <% String fullName=(String) session.getAttribute("fullName"); String role=(String) session.getAttribute("role");
            %>
            <!DOCTYPE html>
            <html>

            <head>
                <title>Admin - Create User | Ocean View Resort</title>
                <link rel="stylesheet" href="<%=request.getContextPath()%>/css/ocean-app.css">
            </head>

            <body>

                <div class="topbar">
                    <div class="brand">Ocean View Resort • Admin Console</div>
                    <div class="userchip">
                        <%= fullName %> • <%= role %> •
                                <a class="link" style="color:white;"
                                    href="<%=request.getContextPath()%>/logout">Logout</a>
                    </div>
                </div>

                <div class="container">

                    <div class="hero">
                        <h1>Create Staff / Admin Account</h1>
                        <p>Only administrators can create privileged users. This prevents unauthorized access and
                            supports role-based security.</p>
                        <div style="margin-top:12px;">
                            <span class="badge">Least Privilege</span>
                            <span class="badge">Secure Provisioning</span>
                            <span class="badge">Role-Based Access</span>
                        </div>
                    </div>

                    <div class="card" style="max-width:720px; margin:16px auto 0;">
                        <h3>Create New User</h3>

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

                                        <form method="post" action="<%=request.getContextPath()%>/admin/create-user"
                                            style="display:flex; flex-direction:column; gap:16px;">
                                            <div style="display:grid; grid-template-columns:1fr 1fr; gap:16px;">
                                                <div class="field">
                                                    <label
                                                        style="font-weight:700; color:#555; display:block; margin-bottom:6px;">Full
                                                        Name</label>
                                                    <input type="text" name="fullName" required minlength="3"
                                                        placeholder="Reception Staff Member"
                                                        style="width:100%; padding:10px 14px; border:1px solid #cfd9e6; border-radius:10px; font-size:14px; outline:none; transition:border 0.2s;"
                                                        onfocus="this.style.borderColor='#006a8e'"
                                                        onblur="this.style.borderColor='#cfd9e6'" />
                                                </div>

                                                <div class="field">
                                                    <label
                                                        style="font-weight:700; color:#555; display:block; margin-bottom:6px;">Email</label>
                                                    <input type="email" name="email" required
                                                        placeholder="staff@ocean.com"
                                                        style="width:100%; padding:10px 14px; border:1px solid #cfd9e6; border-radius:10px; font-size:14px; outline:none; transition:border 0.2s;"
                                                        onfocus="this.style.borderColor='#006a8e'"
                                                        onblur="this.style.borderColor='#cfd9e6'" />
                                                </div>
                                            </div>

                                            <div style="display:grid; grid-template-columns:1fr 1fr; gap:16px;">
                                                <div class="field">
                                                    <label
                                                        style="font-weight:700; color:#555; display:block; margin-bottom:6px;">Phone
                                                        (optional)</label>
                                                    <input type="text" name="phone" placeholder="+947XXXXXXXX"
                                                        pattern="^[0-9+]{9,15}$"
                                                        title="Enter 9–15 digits, can include +"
                                                        style="width:100%; padding:10px 14px; border:1px solid #cfd9e6; border-radius:10px; font-size:14px; outline:none; transition:border 0.2s;"
                                                        onfocus="this.style.borderColor='#006a8e'"
                                                        onblur="this.style.borderColor='#cfd9e6'" />
                                                </div>

                                                <div class="field">
                                                    <label
                                                        style="font-weight:700; color:#555; display:block; margin-bottom:6px;">Role</label>
                                                    <select name="role" required
                                                        style="width:100%; padding:10px 14px; border:1px solid #cfd9e6; border-radius:10px; font-size:14px; outline:none; cursor:pointer; background:white; transition:border 0.2s;"
                                                        onfocus="this.style.borderColor='#006a8e'"
                                                        onblur="this.style.borderColor='#cfd9e6'">
                                                        <option value="STAFF">Staff (Standard Access)</option>
                                                        <option value="ADMIN">Admin (Full Control)</option>
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="field">
                                                <label
                                                    style="font-weight:700; color:#555; display:block; margin-bottom:6px;">Temporary
                                                    Password</label>
                                                <input type="password" name="password" required minlength="6"
                                                    placeholder="Assign a secure minimum 6 character password"
                                                    style="width:100%; padding:10px 14px; border:1px solid #cfd9e6; border-radius:10px; font-size:14px; outline:none; transition:border 0.2s;"
                                                    onfocus="this.style.borderColor='#006a8e'"
                                                    onblur="this.style.borderColor='#cfd9e6'" />
                                            </div>

                                            <div class="actions"
                                                style="margin-top:8px; display:flex; justify-content:space-between; align-items:center;">
                                                <a class="btn-back"
                                                    href="<%=request.getContextPath()%>/admin/dashboard.jsp">
                                                    <svg viewBox="0 0 24 24">
                                                        <path
                                                            d="M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z" />
                                                    </svg> Back
                                                </a>
                                                <button type="submit"
                                                    style="background:#003366; color:white; border:none; padding:10px 24px; border-radius:10px; font-weight:800; cursor:pointer; font-size:14px;"
                                                    onmouseover="this.style.background='#006a8e'"
                                                    onmouseout="this.style.background='#003366'">+ Provision
                                                    Account</button>
                                            </div>
                                        </form>
                    </div>

                    <div class="footer">© 2026 Ocean View Resort • Admin Console</div>
                </div>

            </body>

            </html>