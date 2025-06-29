<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%@ include file="layout/header.jsp" %>
<%@ include file="layout/nav_developer.jsp" %>

<c:if test="${empty sessionScope.name}">
    <c:redirect url="login.jsp" />
</c:if>

<%
    String profilePic = (String) session.getAttribute("profile_pic");
    if (profilePic == null || profilePic.trim().isEmpty()) {
        profilePic = "img/default_profile.jpg";
    }

    int developerId = (session.getAttribute("user_id") != null) ? (int) session.getAttribute("user_id") : 0;
    String studentStatus = (String) session.getAttribute("student_status");

    if (studentStatus == null) {
        try (Connection conn = ads.db.DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT student_status FROM users WHERE user_id = ?")) {
            stmt.setInt(1, developerId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                studentStatus = rs.getString("student_status");
                session.setAttribute("student_status", studentStatus);
            } else {
                studentStatus = "unknown";
            }
        } catch (Exception e) {
            e.printStackTrace();
            studentStatus = "unknown";
        }
    }
%>

<c:if test="${param.msg == 'payment_success'}">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    Swal.fire({
        icon: 'success',
        title: 'Payment Successful 🎉',
        text: 'Your payment has been recorded and your game is now published!',
        confirmButtonColor: '#3085d6'
    });
</script>
</c:if>

<style>
    .neon-title { color: #00f7ff; text-shadow: 0 0 5px #00d5e0; }
    .neon-card {
        background-color: #0a1930;
        border: 1px solid #00f7ff;
        border-radius: 16px;
        box-shadow: 0 0 15px rgba(0, 247, 255, 0.2);
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    .neon-card:hover { transform: translateY(-8px); box-shadow: 0 0 25px rgba(0, 247, 255, 0.6); }
    .neon-card img { border-radius: 16px 16px 0 0; height: 200px; object-fit: cover; }
    .btn-outline-info { border-color: #00f7ff; color: #00f7ff; }
    .btn-outline-info:hover { background-color: #00f7ff; color: #0a1930; }
    .welcome-text { font-size: 1.25rem; color: #ccc; }
    .profile-top {
        position: absolute; top: -30px; left: -20px;
        width: 120px; height: 120px;
        border-radius: 50%;
        border: 3px solid #00f7ff;
        box-shadow: 0 0 15px rgba(0, 247, 255, 0.8);
        overflow: hidden; z-index: 1000;
    }
    .profile-top img { width: 100%; height: 100%; object-fit: cover; border-radius: 50%; }
</style>

<div class="container my-5 position-relative">
    <div class="text-center mb-5">
        <div class="profile-top">
            <a href="settings_developer.jsp">
                <img src="${pageContext.request.contextPath}/<%= profilePic %>" alt="Profile" />
            </a>
        </div>

        <h1 class="neon-title">🎮 Developer Dashboard</h1>
        <p class="welcome-text">Welcome back, <strong>${sessionScope.name}</strong>!</p>

        <%
            if ("approved".equals(studentStatus)) {
        %>
            <span class="badge bg-info text-dark px-3 py-2" style="font-size: 1.1rem;">🎓 Verified Student</span>
        <%
            } else if ("pending".equals(studentStatus)) {
        %>
            <span class="badge bg-warning text-dark px-3 py-2" style="font-size: 1.1rem;">⏳ Verification Pending</span>
        <%
            }
        %>
    </div>

    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
        <!-- Cards -->
        <div class="col">
            <div class="card neon-card h-100 text-white">
                <img src="images/campaign.jpg" class="card-img-top" alt="Create Campaign" onerror="this.src='images/default.png';">
                <div class="card-body text-center">
                    <h5 class="card-title">📝 Create Campaign</h5>
                    <p class="card-text">Launch an ad campaign for your latest game.</p>
                    <a href="upload_game.jsp" class="btn btn-outline-info">Create</a>
                </div>
            </div>
        </div>

        <div class="col">
            <div class="card neon-card h-100 text-white">
                <img src="images/games.jpg" class="card-img-top" alt="My Games" onerror="this.src='images/default.png';">
                <div class="card-body text-center">
                    <h5 class="card-title">🎮 My Games</h5>
                    <p class="card-text">View and manage the games you've submitted.</p>
                    <a href="my_games.jsp" class="btn btn-outline-info">Open</a>
                </div>
            </div>
        </div>

        <div class="col">
            <div class="card neon-card h-100 text-white">
                <img src="images/analytic.jpg" class="card-img-top" alt="Campaign Stats" onerror="this.src='images/default.png';">
                <div class="card-body text-center">
                    <h5 class="card-title">📊 Campaign Stats</h5>
                    <p class="card-text">Monitor the performance of your game ads.</p>
                    <a href="analytics.jsp" class="btn btn-outline-info">View</a>
                </div>
            </div>
        </div>

        <div class="col">
            <div class="card neon-card h-100 text-white">
                <img src="images/student_card.jpg" class="card-img-top" alt="Student Proof" onerror="this.src='images/default.png';">
                <div class="card-body text-center">
                    <h5 class="card-title">👤 Student Proof</h5>
                    <p class="card-text">Submit student card to get discount.</p>
                    <a href="submit_student_proof.jsp" class="btn btn-outline-info">Submit</a>
                </div>
            </div>
        </div>

        <div class="col">
            <div class="card neon-card h-100 text-white">
                <img src="images/settings.jpg" class="card-img-top" alt="Manage Account" onerror="this.src='images/default.png';">
                <div class="card-body text-center">
                    <h5 class="card-title">⚙️ Manage Account</h5>
                    <p class="card-text">Update your profile or settings.</p>
                    <a href="settings_developer.jsp" class="btn btn-outline-info">Manage</a>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<%@ include file="layout/footer.jsp" %>