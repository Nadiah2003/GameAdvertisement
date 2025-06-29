<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ include file="layout/header.jsp" %>
<%@ include file="layout/nav_guest.jsp" %>

<style>
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

  .neon-title {
    font-size: 2.2rem;
    color: #00f7ff;
    text-shadow: 0 0 5px #0053ff;
  }

  .form-control,
  .form-select {
    background-color: #061126;
    color: #ffffff;
    border: 1px solid #00f7ff;
  }

  .form-control:focus,
  .form-select:focus {
    border-color: #00f7ff;
    box-shadow: 0 0 10px rgba(0, 247, 255, 0.5);
  }

  .btn-neon {
    background-color: #3d62ae;
    color: #0b1b34;
    border: none;
    font-weight: bold;
    transition: 0.3s;
  }

  .btn-neon:hover {
    background-color: #00d5e0;
    box-shadow: 0 0 12px #00f7ff;
  }

  .btn-outline-light:hover {
    background-color: #00f7ff;
    color: #0b1b34;
  }

  #drop-zone {
    background-color: #061126;
    color: #fff;
    border: 2px dashed #00f7ff;
    cursor: pointer;
    transition: 0.3s;
  }

  #drop-zone:hover {
    background-color: #0c1c3b;
    box-shadow: 0 0 10px #00f7ff;
  }

  #preview {
    display: none;
    margin-top: 10px;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 247, 255, 0.4);
  }
</style>

<div class="container d-flex align-items-center justify-content-center" style="min-height: 90vh;">
  <div class="neon-box text-white w-100" style="max-width: 520px;">
    <div class="text-center mb-4">
      <span class="material-symbols-outlined" style="font-size: 48px; color: #00f7ff;">person_add</span>
      <h2 class="neon-title">Sign Up</h2>
      <p class="text-secondary">Create your WarriorAd account 🚀</p>
    </div>

    <!-- Flash Messages -->
    <c:if test="${param.success eq 'true'}">
      <div class="alert alert-success">🎉 Registration successful! <a href="login.jsp">Login here</a>.</div>
    </c:if>
    <c:if test="${param.error eq 'exists'}">
      <div class="alert alert-warning">⚠️ Username already exists. Choose another.</div>
    </c:if>
    <c:if test="${param.error eq 'invalid'}">
      <div class="alert alert-danger">❌ Please fill all required fields.</div>
    </c:if>
    <c:if test="${param.error eq 'insert'}">
      <div class="alert alert-danger">❌ Failed to register. Try again later.</div>
    </c:if>
    <c:if test="${param.error eq 'exception'}">
      <div class="alert alert-danger">🚨 Something went wrong. Contact support.</div>
    </c:if>

    <!-- Anti-autofill -->
    <input type="text" name="fakeUsername" style="display:none;" autocomplete="off">
    <input type="password" name="fakePassword" style="display:none;" autocomplete="new-password">

    <!-- Form -->
    <form action="register" method="post" enctype="multipart/form-data" autocomplete="off">
      <div class="mb-3">
        <label for="name" class="form-label">Username</label>
        <input type="text" class="form-control" id="name" name="name" required autocomplete="off" />
      </div>

      <div class="mb-3">
        <label for="email" class="form-label">Email</label>
        <input type="email" class="form-control" id="email" name="email" required autocomplete="off" />
      </div>

      <div class="mb-3 position-relative">
        <label for="password" class="form-label">Password</label>
        <div class="input-group">
          <input type="password" class="form-control" id="password" name="password" required autocomplete="new-password" />
          <button class="btn btn-outline-light" type="button" onclick="togglePassword()">
            <span id="eyeIcon" class="material-symbols-outlined">visibility</span>
          </button>
        </div>
      </div>

      <div class="mb-3">
        <label for="role" class="form-label">Select Role</label>
        <select class="form-select" id="role" name="role" required>
          <option value="">👾 Choose a Role</option>
          <option value="developer">👩‍💻 Developer</option>
          <option value="admin">🧑‍💼 Admin</option>
          <option value="gamer">🎮 Gamer</option>
        </select>
      </div>

      <div class="mb-3">
        <label class="form-label">Profile Picture (optional)</label>
        <div id="drop-zone" class="p-3 rounded text-center">
          <p>Drag & drop or click to upload profile picture</p>
          <input type="file" name="profile_pic" id="profile_pic"
                 class="form-control" accept="image/*" style="display: none;">
          <img id="preview" src="#" alt="Preview" class="img-fluid" style="max-height:200px;">
        </div>
      </div>

      <div class="d-grid mt-4">
        <button type="submit" class="btn btn-neon btn-lg">Register</button>
      </div>
    </form>

    <div class="text-center mt-4">
      <p>Already have an account? <a href="login.jsp" class="text-info text-decoration-underline">Login here</a></p>
      <a href="index.jsp" class="btn btn-outline-light mt-2">⬅️ Back to Home</a>
    </div>
  </div>
</div>

<!-- JS -->
<script>
  function togglePassword() {
    const pass = document.getElementById("password");
    const icon = document.getElementById("eyeIcon");
    pass.type = pass.type === "password" ? "text" : "password";
    icon.textContent = pass.type === "password" ? "visibility" : "visibility_off";
  }

  const dropZone = document.getElementById("drop-zone");
  const fileInput = document.getElementById("profile_pic");
  const previewImg = document.getElementById("preview");

  dropZone.addEventListener("click", () => fileInput.click());
  dropZone.addEventListener("dragover", e => {
    e.preventDefault();
    dropZone.classList.add("bg-primary", "text-white");
  });
  dropZone.addEventListener("dragleave", () => {
    dropZone.classList.remove("bg-primary", "text-white");
  });
  dropZone.addEventListener("drop", e => {
    e.preventDefault();
    dropZone.classList.remove("bg-primary", "text-white");
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

<!-- Icons & Bootstrap -->
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<%@ include file="layout/footer.jsp" %>