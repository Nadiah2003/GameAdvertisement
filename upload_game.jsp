<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${param.error eq 'fail'}">
    <div class="alert alert-danger text-center">Failed to upload game. Please try again.</div>
</c:if>
<c:if test="${param.error eq 'empty'}">
    <div class="alert alert-warning text-center">Please fill in all required fields.</div>
</c:if>
<c:if test="${param.error eq 'nofile'}">
    <div class="alert alert-warning text-center">Please upload a banner image.</div>
</c:if>
<c:if test="${param.error eq 'sql'}">
    <div class="alert alert-danger text-center">Database error occurred.</div>
</c:if>
<c:if test="${param.success eq 'true'}">
    <div class="alert alert-success text-center">Game uploaded successfully!</div>
</c:if>

<%@ include file="layout/header.jsp" %>
<%@ include file="layout/nav_developer.jsp" %>

<%
    String name = (String) session.getAttribute("name");
    String role = (String) session.getAttribute("role");

    // ? Guna session attribute yang betul
    Object devObj = session.getAttribute("user_id");
    int developerId = (devObj != null) ? (int) devObj : 0;

    if (name == null || role == null || !role.equals("developer")) {
        response.sendRedirect("login.jsp?error=session");
        return;
    }
%>

<style>
    .neon-title {
        color: #00f7ff;
        text-shadow: 0 0 8px #00d5e0;
    }

    .neon-form {
        background-color: #0a1930;
        padding: 2rem;
        border-radius: 16px;
        box-shadow: 0 0 25px rgba(0, 247, 255, 0.15);
        border: 1px solid #00f7ff;
    }
    
    .neon-box {
    background-color: #002572;
    border: 2px solid #0053ff;
    box-shadow: 0 0 25px rgba(0, 247, 255, 0.3);
    padding: 40px;
    border-radius: 16px;
    transition: 0.4s;
  }
  
  .neon-box:hover {
    box-shadow: 0 0 35px rgba(0, 247, 255, 0.6);
  }

    .form-control,
    .form-select {
        background-color: #0f263f;
        color: white;
        border: 1px solid #00f7ff;
    }

    .form-control:focus,
    .form-select:focus {
        box-shadow: 0 0 10px rgba(0, 247, 255, 0.5);
        border-color: #00f7ff;
    }

    .btn-primary {
        background-color: #00d5e0;
        border: none;
        font-weight: bold;
        color: #0a1930;
    }

    .btn-primary:hover {
        background-color: #00f7ff;
        box-shadow: 0 0 12px #00f7ff;
    }

    #drop-zone {
        transition: all 0.3s ease;
    }

    #drop-zone.bg-info {
        background-color: #009bc1 !important;
        border: 2px dashed #00f7ff;
    }

    .alert {
        border-radius: 12px;
    }

    #preview {
        max-height: 200px;
        margin-top: 10px;
        border-radius: 10px;
        border: 2px solid #00f7ff;
    }
</style>

<div class="container my-5">
    <div class="text-center mb-4">
        <a href="dashboardDeveloper.jsp" class="btn btn-outline-light">Back to Dashboard</a>
        <h2 class="neon-title">Upload New Game</h2>
        <p class="text-light">Ready to showcase your game? Fill in the details below.</p>
    </div>

    <form action="UploadGameServlet" method="post" enctype="multipart/form-data" class="neon-form mx-auto" style="max-width: 700px;">
        
        <input type="hidden" name="developer_id" value="<%= developerId %>">


        <div class="mb-3">
            <label for="title" class="form-label text-info">Game Title</label>
            <input type="text" class="form-control" name="title" id="title" required maxlength="100">
        </div>

        <div class="mb-3">
            <label for="category" class="form-label text-info">Game Category</label>
            <select class="form-select" name="category" id="category" required>
                <option value="" disabled selected>Select category</option>
                <option value="Action">Action</option>
                <option value="Adventure">Adventure</option>
                <option value="Puzzle">Puzzle</option>
                <option value="Simulation">Simulation</option>
                <option value="Strategy">Strategy</option>
                <option value="RPG">RPG</option>
                <option value="Sports">Sports</option>
                <option value="Horror">Horror</option>
                <option value="Casual">Casual</option>
            </select>
        </div>

        <div class="mb-3">
            <label for="description" class="form-label text-info">Game Description</label>
            <textarea class="form-control" name="description" id="description" rows="4" placeholder="Briefly describe your game..."></textarea>
        </div>

        <div class="mb-3">
            <label class="form-label text-info">Banner Image</label>
            <div id="drop-zone" class="border border-info rounded-3 p-3 text-center bg-secondary" style="cursor:pointer;">
                <p class="m-0 text-white">Drag & drop or click to upload your banner</p>
                <input type="file" name="banner_url" id="banner_url" class="form-control" accept="image/*" style="display: none;" required>
                <img id="preview" src="#" alt="Preview" style="display:none;">
            </div>
        </div>

        <div class="mb-3">
            <label for="trailer_url" class="form-label text-info">YouTube Trailer URL</label>
            <input type="url" class="form-control" name="trailer_url" id="trailer_url" placeholder="https://youtube.com/...">
        </div>

        <div class="mb-4">
            <label for="game_url" class="form-label text-info">Playable Game URL</label>
            <input type="url" class="form-control" name="game_url" id="game_url" placeholder="https://yourgame.com/...">
        </div>
        
        <!-- Payment Section -->
        <div class="mb-3">
            <label class="form-label text-info">Amount to Pay</label>
            <div class="form-control bg-dark text-white">
                <c:choose>
                    <c:when test="${sessionScope.student_status eq 'approved'}">
                        RM10.00
                        <input type="hidden" name="payment_amount" value="10.00" />
                    </c:when>
                    <c:otherwise>
                        RM20.00
                        <input type="hidden" name="payment_amount" value="20.00" />
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="text-center">
            <button type="submit" class="btn btn-primary px-4 py-2">Upload Game</button>
        </div>
    </form>
</div>

<!-- JS for Drag & Drop and Preview -->
<script>
    const dropZone = document.getElementById("drop-zone");
    const fileInput = document.getElementById("banner_url");
    const previewImg = document.getElementById("preview");

    dropZone.addEventListener("click", () => fileInput.click());

    dropZone.addEventListener("dragover", e => {
        e.preventDefault();
        dropZone.classList.add("bg-info");
    });

    dropZone.addEventListener("dragleave", () => {
        dropZone.classList.remove("bg-info");
    });

    dropZone.addEventListener("drop", e => {
        e.preventDefault();
        dropZone.classList.remove("bg-info");
        const file = e.dataTransfer.files[0];
        if (file && file.type.startsWith("image/")) {
            fileInput.files = e.dataTransfer.files;
            const reader = new FileReader();
            reader.onload = e => {
                previewImg.src = e.target.result;
                previewImg.style.display = "block";
            };
            reader.readAsDataURL(file);
        }
    });

    fileInput.addEventListener("change", () => {
        const file = fileInput.files[0];
        if (file && file.type.startsWith("image/")) {
            const reader = new FileReader();
            reader.onload = e => {
                previewImg.src = e.target.result;
                previewImg.style.display = "block";
            };
            reader.readAsDataURL(file);
        }
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<%@ include file="layout/footer.jsp" %>