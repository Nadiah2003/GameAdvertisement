<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="ads.db.DBConnection, java.sql.*" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    Connection conn = DBConnection.getConnection();
    PreparedStatement ps = conn.prepareStatement(
        "SELECT * FROM performance_data WHERE id=?"
    );
    ps.setInt(1, id);
    ResultSet rs = ps.executeQuery();
    if (!rs.next()) {
        response.sendRedirect("performance"); return;
    }
%>

<div class="container text-white">
    <h2 class="text-warning">✏️ Edit Performance Data</h2>
    <form action="update" method="post" class="mt-4">
        <input type="hidden" name="id" value="<%= rs.getInt("id") %>" />
        <div class="mb-3">
            <label>Campaign Name</label>
            <input type="text" name="campaign_name" value="<%= rs.getString("campaign_name") %>" class="form-control" required>
        </div>
        <div class="mb-3">
            <label>Platform</label>
            <input type="text" name="platform" value="<%= rs.getString("platform") %>" class="form-control" required>
        </div>
        <div class="mb-3">
            <label>Impressions</label>
            <input type="number" name="impressions" value="<%= rs.getInt("impressions") %>" class="form-control" required>
        </div>
        <div class="mb-3">
            <label>Clicks</label>
            <input type="number" name="clicks" value="<%= rs.getInt("clicks") %>" class="form-control" required>
        </div>
        <div class="mb-3">
            <label>Engagement Rate (%)</label>
            <input type="text" name="engagement_rate" value="<%= rs.getDouble("engagement_rate") %>" class="form-control" required>
        </div>
        <div class="mb-3">
            <label>ROI (%)</label>
            <input type="text" name="roi" value="<%= rs.getDouble("roi") %>" class="form-control" required>
        </div>
        <div class="mb-3">
            <label>Campaign Date</label>
            <input type="date" name="campaign_date" value="<%= rs.getDate("campaign_date") %>" class="form-control" required>
        </div>
        <button type="submit" class="btn btn-primary">💾 Save Changes</button>
        <a href="performance" class="btn btn-secondary">Cancel</a>
    </form>
</div>