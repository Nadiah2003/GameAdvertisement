<%@ page import="java.sql.*" %>
<%@ page import="ads.db.DBConnection" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="layout/header.jsp" %>
<%@ include file="layout/nav_developer.jsp" %>

<%
    String name = (String) session.getAttribute("name");
    String role = (String) session.getAttribute("role");

    int developerId = 0;
    try {
        developerId = Integer.parseInt(String.valueOf(session.getAttribute("user_id")));
    } catch (Exception ex) {
        response.sendRedirect("login.jsp?error=session");
        return;
    }

    if (name == null || role == null || !role.equals("developer")) {
        response.sendRedirect("login.jsp?error=session");
        return;
    }

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
%>

<div class="container my-5">
    <h2 class="text-info mb-4">📊 Game Analytics</h2>

    <!-- Reviews Section -->
    <h4 class="text-white">📝 Gamer Reviews</h4>
    <div class="table-responsive shadow-lg rounded-4 overflow-hidden">
        <table class="table table-hover table-dark align-middle text-light mb-0">
            <thead class="bg-info text-dark">
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">🎮 Game Title</th>
                    <th scope="col">🧑 Reviewer</th>
                    <th scope="col">💬 Review</th>
                </tr>
            </thead>
            <tbody>
            <%
                try {
                    conn = DBConnection.getConnection();
                    String sql = "SELECT gr.review_id, g.title AS game_title, u.name AS reviewer, gr.review, gr.created_at " +
                                 "FROM game_reviews gr " +
                                 "JOIN games g ON gr.game_id = g.game_id " +
                                 "JOIN users u ON gr.user_id = u.user_id " +
                                 "WHERE g.developer_id = ? ORDER BY gr.created_at DESC";
                    stmt = conn.prepareStatement(sql);
                    stmt.setInt(1, developerId);
                    rs = stmt.executeQuery();

                    int i = 1;
                    boolean hasReview = false;
                    while (rs.next()) {
                        hasReview = true;
            %>
                <tr>
                    <td><strong><%= i++ %></strong></td>
                    <td><span class="text-info fw-semibold"><%= rs.getString("game_title") %></span></td>
                    <td><span class="badge bg-light text-dark px-3 py-2 rounded-pill"><%= rs.getString("reviewer") %></span></td>
                    <td><%= rs.getString("review") %></td>
                </tr>
            <%
                    }
                    if (!hasReview) {
            %>
                <tr>
                    <td colspan="5" class="text-warning text-center py-3">No reviews for your games yet.</td>
                </tr>
            <%
                    }
                } catch (Exception e) {
            %>
                <tr>
                    <td colspan="5" class="text-danger text-center py-3">⚠️ Error loading reviews.</td>
                </tr>
            <%
                    e.printStackTrace();
                } finally {
                    try { if (rs != null) rs.close(); } catch (Exception e) {}
                    try { if (stmt != null) stmt.close(); } catch (Exception e) {}
                    try { if (conn != null) conn.close(); } catch (Exception e) {}
                }
            %>
            </tbody>
        </table>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<%@ include file="layout/footer.jsp" %>