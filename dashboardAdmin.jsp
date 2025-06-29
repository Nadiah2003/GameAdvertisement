<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<%@ include file="layout/header.jsp" %>
<%@ include file="layout/nav_admin.jsp" %>

<%
    String name = (String) session.getAttribute("name");
    String role = (String) session.getAttribute("role");
    String profilePic = (String) session.getAttribute("profile_pic");

    if (name == null || role == null || !role.equals("admin")) {
        response.sendRedirect("login.jsp?error=session");
        return;
    }

    if (profilePic == null || profilePic.trim().isEmpty()) {
        profilePic = "img/default_profile.jpg";
    } else {
        profilePic = "img/" + profilePic.replace("\\", "/");
    }
%>

<style>
    .neon-title {
        color: #00f7ff;
        text-shadow: 0 0 5px #00d5e0;
    }

    .neon-card {
        background-color: #0a1930;
        border: 1px solid #00f7ff;
        border-radius: 16px;
        box-shadow: 0 0 15px rgba(0, 247, 255, 0.2);
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .neon-card:hover {
        transform: translateY(-8px);
        box-shadow: 0 0 25px rgba(0, 247, 255, 0.6);
    }

    .neon-card img {
        border-radius: 16px 16px 0 0;
        height: 200px;
        object-fit: cover;
    }

    .btn-outline-info {
        border-color: #00f7ff;
        color: #00f7ff;
    }

    .btn-outline-info:hover {
        background-color: #00f7ff;
        color: #0a1930;
    }

    .profile-floating {
        position: absolute;
        top: -30px;
        left: 30px;
        width: 100px;
        height: 100px;
        border-radius: 50%;
        border: 3px solid #00f7ff;
        box-shadow: 0 0 15px rgba(0, 247, 255, 0.8);
        overflow: hidden;
        z-index: 1000;
    }

    .profile-floating img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        border-radius: 50%;
    }

    .welcome-text {
        font-size: 1.25rem;
        color: #ccc;
    }
</style>

<div class="container my-5 position-relative">
    <!-- Floating Profile Picture -->
    <div class="profile-floating">
        <a href="setting_admin.jsp">
            <img src="<%= request.getContextPath() + "/" + profilePic %>" alt="Admin Profile"
                 onerror="this.onerror=null; this.src='img/default_profile.jpg';">
        </a>
    </div>

    <div class="text-center mb-5">
        <h1 class="neon-title">Admin Dashboard</h1>
        <p class="welcome-text">Welcome back, <strong><%= name %></strong>!</p>
    </div>

    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">

        <!-- Manage Games -->
        <div class="col">
            <div class="card neon-card h-100 text-white">
                <img src="images/gameconsole.jpg" class="card-img-top" alt="Manage Games"
                     onerror="this.src='images/default.png';">
                <div class="card-body text-center">
                    <h5 class="card-title">🎮 Manage Games</h5>
                    <p class="card-text">Add, remove or monitor all games in the system.</p>
                    <a href="manage_game.jsp" class="btn btn-outline-info">View</a>
                </div>
            </div>
        </div>
        
        <!-- Monitor Games -->
        <div class="col">
            <div class="card neon-card h-100 text-white">
                <img src="images/manage_game.jpg" class="card-img-top" alt="Manage Games"
                     onerror="this.src='images/default.png';">
                <div class="card-body text-center">
                    <h5 class="card-title">🎮 Monitor Games</h5>
                    <p class="card-text">Add, remove or monitor all games in the system.</p>
                    <a href="monitor_games.jsp" class="btn btn-outline-info">View</a>
                </div>
            </div>
        </div>

        <!-- Reports -->
        <div class="col">
            <div class="card neon-card h-100 text-white">
                <img src="images/reports.jpg" class="card-img-top" alt="Reports"
                     onerror="this.src='images/default.png';">
                <div class="card-body text-center">
                    <h5 class="card-title">📊 Reports</h5>
                    <p class="card-text">Access payment and application reports.</p>
                    <a href="payment_report.jsp" class="btn btn-outline-info">View</a>
                </div>
            </div>
        </div>
        
        <!-- Student ID -->
        <div class="col">
            <div class="card neon-card h-100 text-white">
                <img src="images/studentid.jpg" class="card-img-top" alt="StudentID"
                     onerror="this.src='images/default.png';">
                <div class="card-body text-center">
                    <h5 class="card-title">👤 Student ID Confirmation</h5>
                    <p class="card-text">Confirm developer as student with student id card.</p>
                    <a href="verify_student.jsp" class="btn btn-outline-info">View</a>
                </div>
            </div>
        </div>
        
        <div class="col">
            <div class="card neon-card h-100 text-white">
                <img src="images/settings.jpg" class="card-img-top" alt="Manage Account">
                <div class="card-body text-center">
                    <h5 class="card-title">⚙️ Manage Account</h5>
                    <p class="card-text">Update your profile or settings.</p>
                    <a href="settings_admin.jsp" class="btn btn-outline-info">Manage</a>
                </div>
            </div>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<%@ include file="layout/footer.jsp" %>