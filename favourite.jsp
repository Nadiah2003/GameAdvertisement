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

    try {
        conn = DBConnection.getConnection();
        stmt = conn.createStatement();
        rs = stmt.executeQuery("SELECT game_id, title, description, banner_url, game_url FROM games WHERE is_approved = 1 AND is_paid = 1");
%>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
    body {
        background: #002542;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .btn-outline-info {
        border-color: #00f7ff;
        color: #00f7ff;
        font-weight: 600;
        cursor: pointer;
        padding: 6px 12px;
        border-radius: 6px;
        background-color: transparent;
        transition: background-color 0.3s, color 0.3s;
    }

    .btn-outline-info:hover {
        background-color: #00f7ff;
        color: #0a1930;
    }

    .game-title-link {
        color: #00f7ff;
        cursor: pointer;
        text-decoration: underline;
    }

    .game-title-link:hover {
        color: #00d5e0;
    }
</style>

<div class="container my-4">
    <h2 class="text-info mb-4">🎮 All Available Games</h2>
    <div>
        <%
            while (rs.next()) {
                int gameId = rs.getInt("game_id");
                String title = rs.getString("title");
                String description = rs.getString("description");
                String banner = rs.getString("banner_url");
                String gameUrl = rs.getString("game_url");
                if (banner == null || banner.isEmpty()) {
                    banner = "images/default.png";
                }
        %>
        <div class="mb-3">
            <span class="game-title-link" 
                  data-bs-toggle="modal" 
                  data-bs-target="#gameDetailModal" 
                  data-title="<%= title.replace("\"","&quot;") %>" 
                  data-description="<%= description.replace("\"","&quot;") %>" 
                  data-banner="<%= banner %>" 
                  data-url="<%= gameUrl %>">
                <%= title %>
            </span>

            <form method="post" action="FavoriteServlet" style="display:inline; margin-left: 15px;">
                <input type="hidden" name="game_id" value="<%= gameId %>" />
                <button type="submit" class="btn btn-outline-info">&#10084; Favorite</button>
            </form>
        </div>
        <% } %>
    </div>
</div>

<!-- MODAL -->
<div class="modal fade" id="gameDetailModal" tabindex="-1" aria-labelledby="gameDetailModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content bg-dark text-white">
      <div class="modal-header">
        <h5 class="modal-title" id="gameDetailModalLabel">Game Title</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body d-flex flex-column flex-md-row gap-4">
        <img id="modalGameBanner" src="images/default.png" alt="Game Banner" class="img-fluid rounded" style="max-width: 300px; object-fit: cover;">
        <div class="flex-grow-1">
            <p id="modalGameDescription" style="white-space: pre-wrap;"></p>
            <a id="modalPlayButton" href="#" target="_blank" class="btn btn-outline-info mt-3" style="display: none;">▶ Play Game</a>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    var gameDetailModal = document.getElementById('gameDetailModal');
    gameDetailModal.addEventListener('show.bs.modal', function (event) {
        var trigger = event.relatedTarget;
        var title = trigger.getAttribute('data-title');
        var description = trigger.getAttribute('data-description');
        var banner = trigger.getAttribute('data-banner');
        var gameUrl = trigger.getAttribute('data-url');

        gameDetailModal.querySelector('.modal-title').textContent = title;
        gameDetailModal.querySelector('#modalGameDescription').textContent = description;
        gameDetailModal.querySelector('#modalGameBanner').src = banner;

        var playBtn = gameDetailModal.querySelector('#modalPlayButton');
        if (gameUrl && gameUrl.trim() !== "") {
            playBtn.href = gameUrl;
            playBtn.style.display = "inline-block";
        } else {
            playBtn.style.display = "none";
        }
    });
</script>

<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception ignored) {}
        if (stmt != null) try { stmt.close(); } catch (Exception ignored) {}
        if (conn != null) try { conn.close(); } catch (Exception ignored) {}
    }
%>

<%@ include file="layout/footer.jsp" %>