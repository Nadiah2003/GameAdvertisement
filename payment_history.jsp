<%@ page import="java.sql.*, ads.db.DBConnection" %>
<%@ include file="layout/header.jsp" %>
<%@ include file="layout/nav_developer.jsp" %>

<%
    int developerId = (session.getAttribute("user_id") != null) ? (int) session.getAttribute("user_id") : -1;
    if (developerId == -1) {
        response.sendRedirect("login.jsp");
    }

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
%>

<style>
    .payment-card {
        border-radius: 15px;
        box-shadow: 0 0 20px rgba(0,0,0,0.1);
    }
    .table thead th {
        background-color: #0056b3;
        color: white;
        font-weight: bold;
    }
    .table-hover tbody tr:hover {
        background-color: #f0f8ff;
    }
    .status-icon {
        font-size: 1.1rem;
        margin-right: 5px;
    }
</style>

<div class="container mt-5">
    <div class="card payment-card">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0"><i class="bi bi-credit-card-2-back-fill"></i> Your Payment History</h4>
        </div>
        <div class="card-body table-responsive">
            <table class="table table-hover table-bordered align-middle text-center">
                <thead>
                    <tr>
                        <th>Payment ID</th>
                        <th>Game Title</th>
                        <th>Amount (RM)</th>
                        <th>Date</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        boolean hasData = false;
                        try {
                            conn = DBConnection.getConnection();
                            String sql = "SELECT p.payment_id, g.title, p.amount, p.payment_date, p.status " +
                                         "FROM payments p " +
                                         "JOIN games g ON p.game_id = g.game_id " +
                                         "WHERE g.developer_id = ? ORDER BY p.payment_date DESC";
                            stmt = conn.prepareStatement(sql);
                            stmt.setInt(1, developerId);
                            rs = stmt.executeQuery();

                            while (rs.next()) {
                                hasData = true;
                                String status = rs.getString("status");
                                String statusIcon = "";
                                String badgeClass = "";

                                switch (status.toLowerCase()) {
                                    case "approved":
                                        statusIcon = "?";
                                        badgeClass = "bg-success";
                                        break;
                                    case "rejected":
                                        statusIcon = "?";
                                        badgeClass = "bg-danger";
                                        break;
                                    default:
                                        statusIcon = "?";
                                        badgeClass = "bg-warning text-dark";
                                        break;
                                }
                    %>
                        <tr>
                            <td><%= rs.getInt("payment_id") %></td>
                            <td><%= rs.getString("title") %></td>
                            <td><strong>RM <%= String.format("%.2f", rs.getDouble("amount")) %></strong></td>
                            <td><%= rs.getString("payment_date") %></td>
                            <td>
                                <span class="badge <%= badgeClass %> px-3 py-2">
                                    <%= statusIcon %> <%= status %>
                                </span>
                            </td>
                        </tr>
                    <%
                            }

                            if (!hasData) {
                    %>
                        <tr>
                            <td colspan="5" class="text-muted">No payment records found.</td>
                        </tr>
                    <%
                            }

                        } catch (Exception e) {
                            out.println("<tr><td colspan='5'>Error: " + e.getMessage() + "</td></tr>");
                        } finally {
                            if (rs != null) rs.close();
                            if (stmt != null) stmt.close();
                            if (conn != null) conn.close();
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Bootstrap Icons CDN for icon (? ? ? just text here) -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<%@ include file="layout/footer.jsp" %>