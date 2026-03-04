<%-- 
    Document   : 403
    Created on : Feb 25, 2026, 10:37:14 PM
    Author     : Haruda
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>403 • Access Denied | Ocean View Resort</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/ocean-style.css">
    <style>
        .error-card{
            max-width:520px;
            margin:auto;
            padding:26px 26px 22px;
            border-radius:18px;
            background:rgba(255,255,255,0.14);
            border:1px solid rgba(255,255,255,0.35);
            box-shadow:0 14px 35px rgba(0,0,0,0.45);
            color:#fff;
            text-align:center;
        }
        .error-card h1{ font-size:40px; margin-bottom:6px; }
        .error-card p{ font-size:14px; opacity:0.9; }
        .error-actions{ margin-top:18px; display:flex; justify-content:center; gap:10px; flex-wrap:wrap; }
        .error-actions a{
            padding:10px 18px;
            border-radius:999px;
            text-decoration:none;
            font-weight:800;
            border:1px solid rgba(255,255,255,0.9);
            color:#fff;
        }
        .error-actions a.primary{
            background:#00c3ff;
            border-color:#00c3ff;
        }
        .error-actions a.primary:hover{ background:#009dcf; }
    </style>
</head>
<body>

<!-- Reuse public hero background -->
<div class="hero">
    <div class="overlay">

        <div class="error-card">
            <h1>403</h1>
            <p>You don't have permission to access this page.<br/>Please sign in with an allowed account or go back home.</p>

            <div class="error-actions">
                <a class="primary" href="<%=request.getContextPath()%>/index.jsp">Go to Home</a>
                <a href="<%=request.getContextPath()%>/login.jsp">Login</a>
            </div>
        </div>

    </div>
</div>

<footer>
    © 2026 Ocean View Resort | Access Control
    </footer>

</body>
</html>
