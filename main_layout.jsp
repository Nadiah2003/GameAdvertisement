<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title><c:out value="${pageTitle}" default="Game Advertising" /> - Game Advertising</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #0a0f2c;
            color: #ffffff;
            font-family: 'Segoe UI', sans-serif;
        }

        .container-wrapper {
            margin: 30px auto;
            max-width: 1300px;
            background-color: #12183b;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 123, 255, 0.3);
            overflow: hidden;
        }

        .header {
            background-color: #1a1f4c;
            padding: 20px;
            text-align: center;
            border-bottom: 2px solid #007bff;
        }

        .header h1 {
            color: #00bfff;
            font-weight: bold;
            text-shadow: 1px 1px 3px #0056b3;
            margin: 0;
        }

        .main-layout {
            display: flex;
        }

        .sidebar {
            width: 220px;
            background-color: #1c234d;
            border-right: 1px solid #007bff;
            padding-top: 30px;
        }

        .sidebar nav ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .sidebar nav ul li {
            margin: 0;
        }

        .sidebar nav ul li a {
            display: block;
            padding: 14px 20px;
            color: #ffffff;
            text-decoration: none;
            font-weight: bold;
            transition: all 0.3s;
        }

        .sidebar nav ul li a:hover,
        .sidebar nav ul li a.active {
            background-color: #007bff;
            color: #ffffff;
            border-left: 4px solid #00ffff;
        }

        .content-area {
            flex-grow: 1;
            padding: 30px;
            background-color: #0e1430;
        }

        .footer {
            background-color: #1a1f4c;
            color: #ccc;
            text-align: center;
            padding: 15px;
            border-top: 2px solid #007bff;
        }
    </style>
</head>
<body>

<div class="container-wrapper">
    <div class="header">
        <h1>GAME ADVERTISING PLATFORM</h1>
    </div>

    <div class="main-layout">
        <!-- Sidebar Menu -->
        <div class="sidebar">
            <nav>
                <ul>
                    <!-- Common for all roles -->
                    <li><a href="home" class="${activeNav eq 'home' ? 'active' : ''}">🏠 Home</a></li>

                    <!-- Role: Admin -->
                    <c:if test="${sessionScope.role eq 'admin'}">
                        <li><a href="campaigns?action=list" class="${activeNav eq 'admin_campaigns' ? 'active' : ''}">🛠️ Manage Campaigns</a></li>
                        <li><a href="auth?action=performance" class="${activeNav eq 'performance' ? 'active' : ''}">📊 View Analytics</a></li>
                    </c:if>

                    <!-- Role: Developer -->
                    <c:if test="${sessionScope.role eq 'developer'}">
                        <li><a href="campaigns?action=new&activeNav=submit" class="${activeNav eq 'submit' ? 'active' : ''}">🚀 Submit Promotion</a></li>
                        <li><a href="campaigns?action=list" class="${activeNav eq 'admin_campaigns' ? 'active' : ''}">🎮 Manage Campaigns</a></li>
                    </c:if>

                    <!-- Role: Gamer -->
                    <c:if test="${sessionScope.role eq 'gamer'}">
                        <li><a href="public-campaigns" class="${activeNav eq 'trending' ? 'active' : ''}">🔥 Trending Games</a></li>
                    </c:if>

                    <!-- Universal Access Page -->
                    <li><a href="about.jsp" class="${activeNav eq 'about' ? 'active' : ''}">📘 About</a></li>
                    <li><a href="auth?action=logout" class="${activeNav eq 'logout' ? 'active' : ''}">🚪 Logout</a></li>
                </ul>
            </nav>
        </div>

        <!-- Dynamic Content Area -->
        <div class="content-area">
            <jsp:include page="${contentPage}" />
        </div>
    </div>

    <div class="footer">
        &copy; 2025 Game Advertising Platform 💙
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>