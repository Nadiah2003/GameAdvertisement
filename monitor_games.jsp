<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="ads.db.DBConnection" %>
<%@ page session="true" %>
<%@ include file="layout/header.jsp" %>
<%@ include file="layout/nav_admin.jsp" %>

<%
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("admin")) {
        response.sendRedirect("login.jsp?error=session");
        return;
    }

    Connection conn = DBConnection.getConnection();
    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery(
        "SELECT g.*, u.name AS developer_name, u.email AS developer_email, " +
        "(SELECT AVG(rating) FROM game_ratings WHERE game_id = g.game_id) AS rating " +
        "FROM games g JOIN users u ON g.developer_id = u.user_id WHERE g.is_approved = 1"
    );
%>

<style>
    .game-box {
        border-radius: 12px;
        padding: 15px;
        margin-bottom: 20px;
        color: #fff;
        box-shadow: 0 0 10px rgba(0, 247, 255, 0.2);
        transition: transform 0.3s;
    }
    .game-box:hover {
        transform: translateY(-5px);
    }
    .game-box img {
        height: 180px;
        width: 100%;
        object-fit: cover;
        border-radius: 8px;
    }
    .low-rating {
        border: 2px solid #ff4d4d;
        background-color: #330000;
    }
    .high-rating {
        border: 2px solid #00f7ff;
        background-color: #0a1930;
    }
</style>

<div class="container my-5">
    <h2 class="text-info text-center mb-4">📊 Monitor Approved Games</h2>

    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
        <%
            boolean hasData = false;
            while (rs.next()) {
                hasData = true;
                double rating = rs.getDouble("rating");
                String image = rs.getString("banner_url");
                if (image == null || image.isEmpty()) {
                    image = "images/default.png";
                }

                String ratingClass = (rating < 3.5) ? "low-rating" : "high-rating";
        %>
        <div class="col">
            <div class="game-box <%= ratingClass %>">
                <img src="<%= image %>" alt="Game Image" onerror="this.src='images/default.png';">
                <h5 class="mt-3"><%= rs.getString("title") %></h5>
                <p><strong>Developer:</strong> <%= rs.getString("developer_name") %> (<%= rs.getString("developer_email") %>)</p>
                <p><strong>Category:</strong> <%= rs.getString("category") %></p>
                <p><strong>Rating:</strong> <%= String.format("%.2f", rating) %> ⭐</p>
                <p><strong>Description:</strong> <%= rs.getString("description") %></p>
            </div>
        </div>
        <%
            }
            if (!hasData) {
        %>
        <div class="col-12">
            <div class="alert alert-secondary text-center">No approved games found.</div>
        </div>
        <% } %>
    </div>

    <%
        rs.close();
        stmt.close();
        conn.close();
    %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<%@ include file="layout/footer.jsp" %>