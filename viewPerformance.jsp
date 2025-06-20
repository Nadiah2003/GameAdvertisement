<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="ads.db.DBConnection, java.sql.*" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    Connection conn = DBConnection.getConnection();
    PreparedStatement ps = conn.prepareStatement(
        "SELECT p.*, c.name AS campaign_name, c.platform FROM performance_data p JOIN campaigns c ON p.campaign_id = c.campaign_id WHERE p.id = ?"
    );
    ps.setInt(1, id);
    ResultSet rs = ps.executeQuery();
    if (!rs.next()) {
        response.sendRedirect("performance"); return;
    }
%>

<div class="container text-white">
    <h2 class="text-info">📊 View Campaign Performance</h2>
    <table class="table table-dark table-bordered mt-4">
        <tr><th>Campaign Name</th><td><%= rs.getString("campaign_name") %></td></tr>
        <tr><th>Platform</th><td><%= rs.getString("platform") %></td></tr>
        <tr><th>Impressions</th><td><%= rs.getInt("impressions") %></td></tr>
        <tr><th>Clicks</th><td><%= rs.getInt("clicks") %></td></tr>
        <tr><th>Engagement Rate</th><td><%= rs.getDouble("engagement_rate") %> %</td></tr>
        <tr><th>ROI</th><td><%= rs.getDouble("roi") %> %</td></tr>
        <tr><th>Date</th><td><%= rs.getDate("campaign_date") %></td></tr>
    </table>
    <a href="performance" class="btn btn-info">← Back to Performance List</a>
</div>