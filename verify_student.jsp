<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%@ include file="layout/header.jsp" %>
<%@ include file="layout/nav_admin.jsp" %>

<%
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("admin")) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection conn = ads.db.DBConnection.getConnection();
    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery(
        "SELECT user_id, name, email, student_proof_path, student_status FROM users " +
        "WHERE student_status = 'pending' AND student_proof_path IS NOT NULL"
    );
%>

<style>
    .proof-card {
        background-color: #0a1930;
        border: 1px solid #00f7ff;
        border-radius: 15px;
        padding: 20px;
        color: #fff;
        margin-bottom: 20px;
        box-shadow: 0 0 12px rgba(0, 247, 255, 0.2);
    }
    .proof-card h5 {
        margin-bottom: 10px;
    }
    .proof-card img {
        max-width: 250px;
        border-radius: 10px;
        margin-bottom: 10px;
    }
</style>

<div class="container my-5">
    <h2 class="text-info mb-4 text-center">🎓 Pending Student Verifications</h2>

    <%
        boolean hasData = false;
        while (rs.next()) {
            hasData = true;
            String filePath = rs.getString("student_proof_path");
            String fileName = filePath != null ? filePath.toLowerCase() : "";
            boolean isImage = fileName.endsWith(".jpg") || fileName.endsWith(".jpeg") || fileName.endsWith(".png");
    %>
        <div class="proof-card">
            <h5><%= rs.getString("name") %> (<%= rs.getString("email") %>)</h5>
            <p>Status: <strong><%= rs.getString("student_status") %></strong></p>

            <% if (isImage) { %>
                <img src="<%= filePath %>" alt="Proof Image" onerror="this.src='images/default.png'">
            <% } else { %>
                <p><a href="<%= filePath %>" target="_blank">📎 View Proof (PDF)</a></p>
            <% } %>

            <form action="VerifyStudentServlet" method="post" class="mt-3">
                <input type="hidden" name="user_id" value="<%= rs.getInt("user_id") %>">
                <button name="action" value="approve" class="btn btn-success btn-sm me-2">Approve</button>
                <button name="action" value="reject" class="btn btn-danger btn-sm" onclick="return confirm('Reject this proof?')">Reject</button>
            </form>
        </div>
    <%
        }

        if (!hasData) {
    %>
        <div class="alert alert-secondary text-center">No pending student proofs submitted.</div>
    <%
        }

        rs.close();
        stmt.close();
        conn.close();
    %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<%@ include file="layout/footer.jsp" %>