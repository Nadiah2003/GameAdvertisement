<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="ads.db.DBConnection" %>
<%@ include file="layout/header.jsp" %>
<%@ include file="layout/nav_gamer.jsp" %>

<%
    String gamerRole = (String) session.getAttribute("role");
    if (gamerRole == null || !gamerRole.equals("gamer")) {
        response.sendRedirect("login.jsp?error=session");
        return;
    }

    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
%>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
    body {
        background-color: #121212;
        color: #f1f1f1;
    }

    .card-custom {
        background-color: #0a1930;
        border: 1px solid #00f7ff;
        border-radius: 12px;
        box-shadow: 0 0 15px rgba(0, 247, 255, 0.2);
        color: #fff;
        transition: transform 0.3s;
    }

    .card-custom:hover {
        transform: translateY(-5px);
        box-shadow: 0 0 30px rgba(0, 247, 255, 0.4);
    }

    .card-img-top {
        height: 200px;
        object-fit: cover;
        border-top-left-radius: 12px;
        border-top-right-radius: 12px;
    }

    .form-select,
    .form-control {
        background-color: #0f2a3e;
        color: #fff;
        border: 1px solid #00f7ff;
    }

    .form-select:focus,
    .form-control:focus {
        border-color: #00f7ff;
        box-shadow: 0 0 8px #00f7ff;
        background-color: #102c40;
        color: #fff;
    }

    .btn-submit {
        background-color: #00f7ff;
        color: #0a1930;
        border: none;
        font-weight: bold;
        transition: background-color 0.3s;
    }

    .btn-submit:hover {
        background-color: #00e0e0;
    }

    .neon-title {
        text-align: center;
        color: #00f7ff;
        font-weight: 700;
        text-shadow: 0 0 10px #00f7ff;
        margin-bottom: 30px;
    }
</style>

<div class="container py-5">
    <h2 class="neon-title">🌟 Rate & Review Games</h2>

    <% if (request.getParameter("msg") != null && request.getParameter("msg").equals("success")) { %>
        <div class="alert alert-success text-center" role="alert">
            ✅ Thank you! Your rating & review has been submitted.
        </div>
    <% } %>

    <div class="row g-4">
    <%
        try {
            conn = DBConnection.getConnection();
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM games WHERE is_approved = 1 AND is_paid = 1");

            while (rs.next()) {
                int gameId = rs.getInt("game_id");
                String title = rs.getString("title");
                String description = rs.getString("description");
                String image = rs.getString("banner_url");
                if (image == null || image.isEmpty()) image = "images/default.png";

                // Rating & review data
                double avgRating = 0.0;
                int totalRatings = 0, totalReviews = 0;

                PreparedStatement ratingStmt = conn.prepareStatement(
                    "SELECT AVG(rating) AS avg_rating, COUNT(*) AS total FROM game_ratings WHERE game_id = ?");
                ratingStmt.setInt(1, gameId);
                ResultSet ratingRS = ratingStmt.executeQuery();
                if (ratingRS.next()) {
                    avgRating = ratingRS.getDouble("avg_rating");
                    totalRatings = ratingRS.getInt("total");
                }
                ratingRS.close();
                ratingStmt.close();

                PreparedStatement reviewStmt = conn.prepareStatement(
                    "SELECT COUNT(*) AS total FROM game_reviews WHERE game_id = ?");
                reviewStmt.setInt(1, gameId);
                ResultSet reviewRS = reviewStmt.executeQuery();
                if (reviewRS.next()) {
                    totalReviews = reviewRS.getInt("total");
                }
                reviewRS.close();
                reviewStmt.close();
    %>
        <div class="col-md-6 col-lg-4">
            <div class="card card-custom h-100">
                <img src="<%= image %>" class="card-img-top" alt="Game Image" onerror="this.src='images/default.png'">
                <div class="card-body">
                    <h5 class="card-title text-info"><%= title %></h5>
                    <p class="card-text" style="min-height: 80px;"><%= description %></p>

                    <!-- Ratings display -->
                    <div class="mb-3">
                        <% if (totalRatings > 0) { %>
                            <p>
                                ⭐ <strong><%= String.format("%.1f", avgRating) %></strong> from <%= totalRatings %> gamer<%= totalRatings > 1 ? "s" : "" %><br>
                                💬 <%= totalReviews %> review<%= totalReviews > 1 ? "s" : "" %>
                            </p>
                        <% } else { %>
                            <p class="text-muted">No ratings or reviews yet.</p>
                        <% } %>
                    </div>

                    <!-- Rate/Review Form -->
                    <form action="RateGameServlet" method="post">
                        <input type="hidden" name="game_id" value="<%= gameId %>">

                        <div class="mb-2">
                            <label class="form-label">⭐ Rating</label>
                            <select class="form-select" name="rating" required>
                                <option value="">Select rating</option>
                                <% for (int i = 1; i <= 5; i++) { %>
                                    <option value="<%= i %>"><%= i %> Star<%= i > 1 ? "s" : "" %></option>
                                <% } %>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">💬 Review</label>
                            <textarea class="form-control" name="review" rows="3" placeholder="Say something..." maxlength="500"></textarea>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-submit">Submit</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    <%
            }
        } catch (Exception e) {
            out.println("<div class='alert alert-danger'>Error loading games.</div>");
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception ignored) {}
            if (stmt != null) try { stmt.close(); } catch (Exception ignored) {}
            if (conn != null) try { conn.close(); } catch (Exception ignored) {}
        }
    %>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<%@ include file="layout/footer.jsp" %>