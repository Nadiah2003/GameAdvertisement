<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="ads.db.DBConnection" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="layout/header.jsp" %>
<%@ include file="layout/nav_developer.jsp" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

<%
    String name = (String) session.getAttribute("name");
    String role = (String) session.getAttribute("role");
    Integer devIdObj = (Integer) session.getAttribute("user_id");
    int developerId = (devIdObj != null) ? devIdObj : 0;

    if (name == null || role == null || !role.equals("developer") || developerId == 0) {
        response.sendRedirect("login.jsp?error=session");
        return;
    }

    Connection conn = DBConnection.getConnection();
    PreparedStatement stmt = conn.prepareStatement(
        "SELECT g.*, ROUND(AVG(r.rating),1) AS avg_rating " +
        "FROM games g LEFT JOIN game_ratings r ON g.game_id = r.game_id " +
        "WHERE g.developer_id = ? GROUP BY g.game_id",
        ResultSet.TYPE_SCROLL_INSENSITIVE,
        ResultSet.CONCUR_READ_ONLY
    );
    stmt.setInt(1, developerId);
    ResultSet rs = stmt.executeQuery();
%>

<div class="container my-5">

    <!-- ? Alert Message Section -->
    <c:if test="${param.delete eq 'success'}">
        <div class="alert alert-success text-center">Game successfully deleted.</div>
    </c:if>
    <c:if test="${param.error eq 'unauthorized'}">
        <div class="alert alert-danger text-center">You are not authorized to delete this game.</div>
    </c:if>
    <c:if test="${param.error eq 'invalidid'}">
        <div class="alert alert-warning text-center">Invalid game ID.</div>
    </c:if>
    <c:if test="${param.error eq 'notfound'}">
        <div class="alert alert-warning text-center">Game not found or already deleted.</div>
    </c:if>
    <c:if test="${param.error eq 'internal'}">
        <div class="alert alert-danger text-center">An internal error occurred while deleting the game.</div>
    </c:if>
    <c:if test="${not empty param.msg}">
        <div class="alert alert-info text-center">Debug Info: ${param.msg}</div>
    </c:if>

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="text-info m-0">My Uploaded Games</h2>
        <a href="dashboardDeveloper.jsp" class="btn btn-outline-info mb-4">Back to Dashboard</a>
    </div>

    <a href="upload_game.jsp" class="btn btn-outline-info mb-4">+ Upload New Game</a>

    <!-- ? Approved Games -->
    <h4 class="text-success mt-4">Approved Games</h4>
    <div class="row g-4">
        <%
            boolean hasApproved = false;
            rs.beforeFirst();
            while (rs.next()) {
                if (rs.getInt("is_approved") != 1) continue;
                hasApproved = true;
                String bannerPath = rs.getString("banner_url") != null ? rs.getString("banner_url").replace("\\", "/") : "img/no_image_available.png";
                String desc = rs.getString("description");
                boolean isLong = desc != null && desc.length() > 100;
                String shortDesc = isLong ? desc.substring(0, 100) + "..." : desc;
                double avgRating = rs.getDouble("avg_rating");
                boolean hasRating = !rs.wasNull();
        %>
        <div class="col-md-6 col-lg-4">
            <div class="card h-100 bg-dark text-white border-success shadow-lg rounded-4">
                <img src="<%= request.getContextPath() + "/" + bannerPath %>" class="card-img-top" style="height:200px; object-fit:cover;">
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title text-success"><%= rs.getString("title") %></h5>
                    <p class="card-text">Category: <%= rs.getString("category") %></p>
                    <p class="card-text text-light">
                        Description:
                        <span class="short-desc"><%= shortDesc %></span>
                        <% if (isLong) { %>
                            <span class="full-desc d-none"><%= desc %></span>
                            <a href="javascript:void(0);" class="toggle-desc text-info text-decoration-underline">See more</a>
                        <% } %>
                    </p>

                    <% if (hasRating) { %>
                    <div class="mb-2 text-warning">
                        <%
                            int fullStars = (int) avgRating;
                            boolean halfStar = (avgRating - fullStars) >= 0.5;
                            for (int i = 0; i < fullStars; i++) { %>
                                <i class="fas fa-star"></i>
                        <% } if (halfStar) { %>
                                <i class="fas fa-star-half-alt"></i>
                        <% } for (int i = fullStars + (halfStar ? 1 : 0); i < 5; i++) { %>
                                <i class="far fa-star"></i>
                        <% } %>
                        <span class="ms-2 text-light"><%= avgRating %>/5</span>
                    </div>
                    <% } else { %>
                    <p class="text-muted">No ratings yet</p>
                    <% } %>

                    <p class="badge bg-success">Approved</p>
                    <div class="mt-auto">
                        <form action="EditGameFormServlet" method="post" class="d-inline">
                            <input type="hidden" name="game_id" value="<%= rs.getInt("game_id") %>">
                            <button type="submit" class="btn btn-sm btn-primary">Edit</button>
                        </form>
                        <form action="DeleteGameServlet" method="post" class="d-inline" onsubmit="return confirm('Are you sure you want to delete this game?')">
                            <input type="hidden" name="game_id" value="<%= rs.getInt("game_id") %>">
                            <button type="submit" class="btn btn-sm btn-danger">Delete</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <% } if (!hasApproved) { %>
        <div class="alert alert-warning text-center">No approved games yet.</div>
        <% } %>
    </div>

    <!-- ? Pending Games -->
    <h4 class="text-warning mt-5">Pending Approval</h4>
    <div class="row g-4">
        <%
            boolean hasPending = false;
            rs.beforeFirst();
            while (rs.next()) {
                if (rs.getInt("is_approved") != 0) continue;
                hasPending = true;
                String bannerPath = rs.getString("banner_url") != null ? rs.getString("banner_url").replace("\\", "/") : "img/no_image_available.png";
                String desc = rs.getString("description");
                boolean isLong = desc != null && desc.length() > 100;
                String shortDesc = isLong ? desc.substring(0, 100) + "..." : desc;
        %>
        <div class="col-md-6 col-lg-4">
            <div class="card h-100 bg-dark text-white border-warning shadow-lg rounded-4">
                <img src="<%= request.getContextPath() + "/" + bannerPath %>" class="card-img-top" style="height:200px; object-fit:cover;">
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title text-warning"><%= rs.getString("title") %></h5>
                    <p class="card-text">Category: <%= rs.getString("category") %></p>
                    <p class="card-text text-light">
                        Description:
                        <span class="short-desc"><%= shortDesc %></span>
                        <% if (isLong) { %>
                            <span class="full-desc d-none"><%= desc %></span>
                            <a href="javascript:void(0);" class="toggle-desc text-info text-decoration-underline">See more</a>
                        <% } %>
                    </p>

                    <p class="badge bg-warning text-dark">Pending Approval</p>
                    <div class="mt-auto">
                        <form action="EditGameFormServlet" method="post" class="d-inline">
                            <input type="hidden" name="game_id" value="<%= rs.getInt("game_id") %>">
                            <button type="submit" class="btn btn-sm btn-primary">Edit</button>
                        </form>
                        <form action="DeleteGameServlet" method="post" class="d-inline" onsubmit="return confirm('Are you sure you want to delete this game?')">
                            <input type="hidden" name="game_id" value="<%= rs.getInt("game_id") %>">
                            <button type="submit" class="btn btn-sm btn-danger">Delete</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <% } if (!hasPending) { %>
        <div class="alert alert-secondary text-center">No pending games.</div>
        <% } %>
    </div>

    <% rs.close(); stmt.close(); conn.close(); %>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const toggles = document.querySelectorAll('.toggle-desc');
        toggles.forEach(toggle => {
            toggle.addEventListener('click', function () {
                const shortDesc = this.previousElementSibling.previousElementSibling;
                const fullDesc = this.previousElementSibling;
                if (fullDesc.classList.contains('d-none')) {
                    shortDesc.classList.add('d-none');
                    fullDesc.classList.remove('d-none');
                    this.textContent = 'See less';
                } else {
                    fullDesc.classList.add('d-none');
                    shortDesc.classList.remove('d-none');
                    this.textContent = 'See more';
                }
            });
        });
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<%@ include file="layout/footer.jsp" %>