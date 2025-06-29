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
        "SELECT title, developer_id, payment_amount, created_at, is_approved " +
        "FROM games WHERE is_paid = 1 ORDER BY created_at DESC"
    );
%>

<style>
    .neon-table {
        background-color: #0a1930;
        border: 1px solid #00f7ff;
        color: #ffffff;
        border-radius: 10px;
        overflow: hidden;
    }

    .neon-table th, .neon-table td {
        padding: 12px;
        border-bottom: 1px solid #005f73;
        vertical-align: middle;
    }

    .neon-table th {
        background-color: #002b5c;
        color: #00f7ff;
        text-align: center;
    }

    .neon-table tr:hover {
        background-color: #003f7f;
    }

    .table-wrapper {
        overflow-x: auto;
        border-radius: 10px;
        margin-top: 30px;
    }

    h2 {
        color: #00f7ff;
    }

    .badge-paid {
        background-color: #00f7ff;
        color: #0a1930;
        border-radius: 6px;
        padding: 4px 8px;
        font-weight: bold;
    }

    .badge-approve {
        background-color: #28a745;
        color: white;
        border-radius: 6px;
        padding: 4px 8px;
        font-weight: bold;
    }

    .badge-pending {
        background-color: #ffc107;
        color: #0a1930;
        border-radius: 6px;
        padding: 4px 8px;
        font-weight: bold;
    }
</style>

<div class="container my-5">
    <h2 class="text-center mb-4">Payment Report</h2>

    <div class="table-wrapper">
        <table class="table neon-table text-center">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Game Title</th>
                    <th>Developer ID</th>
                    <th>Total (RM)</th>
                    <th>Paid At</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <%
                    int no = 1;
                    boolean hasData = false;
                    while (rs.next()) {
                        hasData = true;
                        int isApproved = rs.getInt("is_approved");
                %>
                <tr>
                    <td><%= no++ %></td>
                    <td><%= rs.getString("title") %></td>
                    <td><%= rs.getInt("developer_id") %></td>
                    <td>
                        <%
                            double amount = rs.getDouble("payment_amount");
                            if (rs.wasNull()) {
                                out.print("-");
                            } else {
                                out.print("RM" + String.format("%.2f", amount));
                            }
                        %>
                    </td>
                    <td><%= rs.getTimestamp("created_at") %></td>
                    <td>
                        <span class="badge-paid">Paid</span>
                        <% if (isApproved == 1) { %>
                            <span class="badge-approve">Approved</span>
                        <% } else { %>
                            <span class="badge-pending">Pending</span>
                        <% } %>
                    </td>
                </tr>
                <%
                    }
                    if (!hasData) {
                %>
                <tr>
                    <td colspan="6" class="text-warning text-center">No payment records found.</td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <%
        rs.close();
        stmt.close();
        conn.close();
    %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<%@ include file="layout/footer.jsp" %>