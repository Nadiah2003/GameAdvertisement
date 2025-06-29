<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="ads.db.DBConnection" %>
<%@ include file="layout/header.jsp" %>
<%@ include file="layout/nav_gamer.jsp" %>

<%
    String gamerName = (String) session.getAttribute("name");
    String gamerRole = (String) session.getAttribute("role");
    String profilePic = (String) session.getAttribute("profile_pic");

    if (gamerName == null || gamerRole == null || !gamerRole.equals("gamer")) {
        response.sendRedirect("login.jsp?error=session");
        return;
    }

    if (profilePic == null || profilePic.trim().isEmpty()) {
        profilePic = "img/default_profile.jpg";
    } else {
        profilePic = "img/" + profilePic.replace("\\", "/");
    }

    String searchKeyword = request.getParameter("search");
    if (searchKeyword == null) {
        searchKeyword = "";
    }

    Connection conn = DBConnection.getConnection();
    PreparedStatement ps = conn.prepareStatement(
        "SELECT * FROM games WHERE is_approved = 1 AND title LIKE ? ORDER BY created_at DESC");
    ps.setString(1, "%" + searchKeyword + "%");
    ResultSet rs = ps.executeQuery();
%>

<style>
    /* Keep your welcome/profile style exactly */
    body {
        background-color: #121212;
        color: #eee;
    }

    .neon-title {
        color: #00f7ff;
        text-shadow: 0 0 8px #00d5e0;
        margin-bottom: 1rem;
        font-weight: 700;
        letter-spacing: 2px;
        text-align: center;
    }

    .profile-floating {
        position: absolute;
        top: 40px;
        left: 50px;
        width: 100px;
        height: 100px;
        border-radius: 50%;
        border: 3px solid #00f7ff;
        box-shadow: 0 0 15px rgba(0, 247, 255, 0.8);
        overflow: hidden;
        z-index: 1000;
        background-color: #0a1930;
    }

    .profile-floating img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        border-radius: 50%;
        user-select: none;
    }

    .welcome-text {
        font-size: 1.25rem;
        color: #ccc;
        margin-top: 1.5rem;
        text-align: center;
        user-select: none;
    }

    .container {
        position: relative;
        padding-top: 80px;
        max-width: 1100px;
        margin-bottom: 60px;
    }

    /* New style for game list & search */
    .search-box {
        max-width: 400px;
        margin: 0 auto 30px auto;
    }

    .search-box input[type="text"] {
        width: 100%;
        padding: 10px 15px;
        border-radius: 30px;
        border: 1px solid #00f7ff;
        background-color: #0a1930;
        color: #eee;
        font-size: 1rem;
        transition: border-color 0.3s;
    }

    .search-box input[type="text"]:focus {
        outline: none;
        border-color: #00d5e0;
        box-shadow: 0 0 8px #00d5e0;
    }

    .game-list {
        display: grid;
        grid-template-columns: repeat(auto-fill,minmax(300px,1fr));
        gap: 20px;
    }

    .game-card {
        background-color: #0a1930;
        border: 1px solid #00f7ff;
        border-radius: 16px;
        box-shadow: 0 0 12px rgba(0, 247, 255, 0.2);
        color: #eee;
        display: flex;
        flex-direction: column;
        overflow: hidden;
        transition: box-shadow 0.3s ease;
    }

    .game-card:hover {
        box-shadow: 0 0 25px rgba(0, 247, 255, 0.6);
    }

    .game-image {
        width: 100%;
        height: 160px;
        object-fit: cover;
        user-select: none;
    }

    .game-content {
        padding: 15px;
        flex-grow: 1;
        display: flex;
        flex-direction: column;
    }

    .game-title {
        font-weight: 700;
        font-size: 1.2rem;
        margin-bottom: 5px;
        color: #00f7ff;
    }

    .game-category {
        font-size: 0.9rem;
        margin-bottom: 10px;
        color: #66d9ff;
        font-style: italic;
    }

    .game-description {
        font-size: 0.9rem;
        flex-grow: 1;
        color: #ccc;
        margin-bottom: 15px;
        user-select: text;
    }

    .game-actions {
        display: flex;
        justify-content: space-between;
        margin-bottom: 10px;
    }

    .btn-outline-info {
        border-color: #00f7ff;
        color: #00f7ff;
        padding: 5px 12px;
        font-weight: 600;
        border-radius: 20px;
        text-transform: uppercase;
        font-size: 0.85rem;
        transition: background-color 0.3s, color 0.3s;
        cursor: pointer;
        user-select: none;
    }

    .btn-outline-info:hover {
        background-color: #00f7ff;
        color: #0a1930;
        text-decoration: none;
    }

    /* Rating & like area */
    .rating-like-section {
        border-top: 1px solid #00f7ff;
        padding-top: 8px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        user-select: none;
    }

    .rating-stars {
        color: #00f7ff;
        font-size: 1.2rem;
    }

    .like-btn {
        cursor: pointer;
        color: #00f7ff;
        font-size: 1.2rem;
        user-select: none;
        background: none;
        border: none;
        padding: 0;
    }

    .like-btn.liked {
        color: #ff4081;
    }

    /* Comments */
    .comment-section {
        margin-top: 10px;
        font-size: 0.9rem;
        color: #ccc;
    }

    .comment-input {
        width: 100%;
        padding: 6px 10px;
        border-radius: 12px;
        border: 1px solid #00f7ff;
        background-color: #121212;
        color: #eee;
        resize: vertical;
        min-height: 40px;
        font-size: 0.9rem;
        margin-top: 6px;
    }

    .comment-submit-btn {
        margin-top: 6px;
        padding: 6px 14px;
        background-color: #00f7ff;
        color: #121212;
        border: none;
        border-radius: 20px;
        cursor: pointer;
        font-weight: 600;
        user-select: none;
    }
</style>

<div class="container position-relative">
    <!-- Floating Profile Picture -->
    <div class="profile-floating">
        <a href="setting_gamer.jsp" title="Your Profile & Settings">
            <img src="<%= request.getContextPath() + "/" + profilePic %>" alt="Gamer Profile"
                 onerror="this.onerror=null; this.src='img/default_profile.jpg';" />
        </a>
    </div>

    <h1 class="neon-title">Gamer Dashboard</h1>
    <p class="welcome-text">Welcome back, <strong><%= gamerName %></strong>!</p>

    <!-- Search box -->
    <form method="get" action="homeGamer.jsp" class="search-box">
        <input type="text" name="search" placeholder="Search games by title..." value="<%= searchKeyword %>"/>
    </form>

    <!-- Games list -->
    <div class="game-list">
        <%
            boolean hasGames = false;
            while (rs.next()) {
                hasGames = true;
                String bannerUrl = rs.getString("banner_url");
                if (bannerUrl == null || bannerUrl.trim().isEmpty()) {
                    bannerUrl = "images/default.png";
                }
        %>
        <div class="game-card">
            <img src="<%= bannerUrl %>" alt="Game Banner" class="game-image" onerror="this.src='images/default.png'"/>

            <div class="game-content">
                <div class="game-title"><%= rs.getString("title") %></div>
                <div class="game-category">Category: <%= rs.getString("category") %></div>
                <div class="game-description"><%= rs.getString("description") %></div>

                <div class="game-actions">
                    <a href="<%= rs.getString("game_url") %>" target="_blank" class="btn-outline-info">Play</a>
                    <a href="<%= rs.getString("trailer_url") %>" target="_blank" class="btn-outline-info">Watch Trailer</a>
                </div>

                <!-- Rate & Like & Comment (simplified for demo) -->
                <div class="rating-like-section">
                    <form method="post" action="RateGameServlet" style="flex-grow: 1; display: flex; align-items: center; gap: 6px;">
                        <input type="hidden" name="game_id" value="<%= rs.getInt("game_id") %>" />
                        
                        <!-- Simple rating select -->
                        <select name="rating" aria-label="Rate this game">
                            <option value="">Rate</option>
                            <option value="1">★ 1</option>
                            <option value="2">★★ 2</option>
                            <option value="3">★★★ 3</option>
                            <option value="4">★★★★ 4</option>
                            <option value="5">★★★★★ 5</option>
                        </select>

                        <!-- Like checkbox -->
                        <label>
                            <input type="checkbox" name="like" value="1" />
                            ❤ Favorite
                        </label>

                        <button type="submit" class="comment-submit-btn">Submit</button>
                    </form>
                </div>

                <!-- Comment box -->
                <form method="post" action="RateGameServlet" style="margin-top:10px;">
                    <input type="hidden" name="game_id" value="<%= rs.getInt("game_id") %>" />
                    <textarea name="comment" class="comment-input" placeholder="Write a comment..."></textarea>
                    <button type="submit" class="comment-submit-btn">Post Comment</button>
                </form>

                <!-- TODO: Below you can add code to fetch & display existing comments per game -->

            </div>
        </div>
        <% } %>

        <% if (!hasGames) { %>
            <p style="color:#ccc; text-align:center; grid-column:1/-1;">No games found matching your search.</p>
        <% } %>
    </div>

<%
    rs.close();
    ps.close();
    conn.close();
%>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<%@ include file="layout/footer.jsp" %>