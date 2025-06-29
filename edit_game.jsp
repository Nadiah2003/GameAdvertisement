<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="ads.model.Game" %>
<%@ include file="layout/header.jsp" %>
<%@ include file="layout/nav_developer.jsp" %>

<%
    Game game = (Game) request.getAttribute("game");
    if (game == null) {
        response.sendRedirect("my_games.jsp?error=notfound");
        return;
    }
%>

<div class="container my-5">
    <h2 class="text-primary mb-4">Edit Game</h2>

    <form action="EditGameServlet" method="post" enctype="multipart/form-data">
        <input type="hidden" name="game_id" value="<%= game.getGameId() %>">
        <input type="hidden" name="existing_banner_url" value="<%= game.getBannerUrl() %>">

        <!-- Title -->
        <div class="mb-3">
            <label class="form-label">Title</label>
            <input type="text" name="title" class="form-control" value="<%= game.getTitle() %>" required>
        </div>

        <!-- Category -->
        <div class="mb-3">
            <label class="form-label">Category</label>
            <input type="text" name="category" class="form-control" value="<%= game.getCategory() %>" required>
        </div>

        <!-- Drag & Drop Upload Area -->
        <div class="mb-3">
            <label class="form-label">Banner Image</label>
            <div id="drop-area" class="border rounded p-3 text-center" style="cursor: pointer;">
                <p class="mb-1">Drag & drop image here or click to select file</p>
                <input type="file" name="banner" id="bannerInput" accept="image/*" class="form-control" hidden>
                <img id="preview" src="<%= request.getContextPath() + "/" + game.getBannerUrl() %>" class="img-thumbnail mt-2" style="max-height: 150px;">
            </div>
        </div>

        <!-- Trailer URL -->
        <div class="mb-3">
            <label class="form-label">Trailer YouTube URL</label>
            <input type="url" name="trailer_url" class="form-control" value="<%= game.getTrailerUrl() %>">
        </div>

        <!-- Game URL -->
        <div class="mb-3">
            <label class="form-label">Play Game URL</label>
            <input type="url" name="game_url" class="form-control" value="<%= game.getGameUrl() %>">
        </div>

        <!-- Description -->
        <div class="mb-3">
            <label class="form-label">Description</label>
            <textarea name="description" rows="4" class="form-control" required><%= game.getDescription() %></textarea>
        </div>

        <!-- Buttons -->
        <button type="submit" class="btn btn-success">Save Changes</button>
        <a href="my_games.jsp" class="btn btn-secondary">Cancel</a>
    </form>
</div>

<!-- Drag & Drop Script -->
<script>
    const dropArea = document.getElementById('drop-area');
    const bannerInput = document.getElementById('bannerInput');
    const preview = document.getElementById('preview');

    dropArea.addEventListener('click', () => bannerInput.click());

    bannerInput.addEventListener('change', function () {
        if (this.files && this.files[0]) {
            const reader = new FileReader();
            reader.onload = function (e) {
                preview.src = e.target.result;
            }
            reader.readAsDataURL(this.files[0]);
        }
    });

    dropArea.addEventListener('dragover', e => {
        e.preventDefault();
        dropArea.classList.add('bg-light');
    });

    dropArea.addEventListener('dragleave', () => {
        dropArea.classList.remove('bg-light');
    });

    dropArea.addEventListener('drop', e => {
        e.preventDefault();
        dropArea.classList.remove('bg-light');
        bannerInput.files = e.dataTransfer.files;
        bannerInput.dispatchEvent(new Event('change'));
    });
</script>

<%@ include file="layout/footer.jsp" %>