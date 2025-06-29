<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="ads.db.DBConnection" %>
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
        "SELECT g.*, u.name AS developer_name, u.email AS developer_email " +
        "FROM games g JOIN users u ON g.developer_id = u.user_id " +
        "WHERE g.is_approved = 0"
    );
%>

<style>
    .game-card {
        background-color: #0a1930;
        border: 1px solid #00f7ff;
        border-radius: 12px;
        box-shadow: 0 0 15px rgba(0, 247, 255, 0.2);
        color: #fff;
        transition: transform 0.3s;
    }
    .game-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 0 25px rgba(0, 247, 255, 0.5);
    }
    .game-image {
        height: 200px;
        object-fit: cover;
        border-top-left-radius: 12px;
        border-top-right-radius: 12px;
    }
    .game-card-body {
        padding: 1rem;
    }
    .btn-custom {
        border-color: #00f7ff;
        color: #00f7ff;
    }
    .btn-custom:hover {
        background-color: #00f7ff;
        color: #0a1930;
    }
</style>

<div class="container my-5">
    <h2 class="text-info mb-4 text-center">🕹️ Pending Game Ads</h2>

    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
        <%
            boolean hasData = false;
            while (rs.next()) {
                hasData = true;
                String image = rs.getString("banner_url");
                if (image == null || image.isEmpty()) {
                    image = "images/default.png";
                }
        %>
        <div class="col">
            <div class="card game-card h-100">
                <img src="<%= image %>" class="card-img-top game-image" alt="Game Image" onerror="this.src='images/default.png'">
                <div class="game-card-body">
                    <h5 class="card-title"><%= rs.getString("title") %></h5>
                    <p class="mb-1"><strong>Developer:</strong> <%= rs.getString("developer_name") %> (<%= rs.getString("developer_email") %>)</p>
                    <p class="mb-1"><strong>Category:</strong> <%= rs.getString("category") %></p>
                    <p style="color:#00f7ff;"><%= rs.getString("description") %></p>
                    
                    <form action="GameApprovalServlet" method="post">
                        <input type="hidden" name="game_id" value="<%= rs.getInt("game_id") %>">
                        <input type="hidden" name="developer_id" value="<%= rs.getInt("developer_id") %>">
                        <input type="hidden" name="developer_email" value="<%= rs.getString("developer_email") %>">
                        <input type="hidden" name="title" value="<%= rs.getString("title") %>">
                        <div class="d-flex justify-content-between">
                            <button name="action" value="approve" class="btn btn-success btn-sm">Approve</button>
                            <button name="action" value="reject" class="btn btn-danger btn-sm" onclick="return confirm('Reject this game?')">Reject</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <%
            }
            if (!hasData) {
        %>
        <div class="col-12">
            <div class="alert alert-secondary text-center">No pending games found.</div>
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