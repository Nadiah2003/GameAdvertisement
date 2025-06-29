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
</style>

<div class="container d-flex align-items-center justify-content-center" style="min-height: 90vh;">
    <div class="neon-box text-white w-100" style="max-width: 460px;">

        <div class="text-center mb-4">
            <span class="material-symbols-outlined" style="font-size: 48px; color: #00f7ff;">lock</span>
            <h2 class="neon-title">Login</h2>
            <p class="text-secondary">Welcome back to WarriorAd 🎮</p>
        </div>

        <!-- Flash Messages -->
        <c:if test="${param.success eq 'true'}">
            <div class="alert alert-success">✅ Signup successful! You can now log in.</div>
        </c:if>
        <c:if test="${param.error eq 'invalid'}">
            <div class="alert alert-danger">❌ Invalid email or password.</div>
        </c:if>
        <c:if test="${param.error eq 'exists'}">
            <div class="alert alert-warning">⚠️ Email already exists.</div>
        </c:if>
        <c:if test="${param.error eq 'session'}">
            <div class="alert alert-warning">❌ Session expired. Please login again.</div>
        </c:if>

        <!-- Form -->
        <form action="auth" method="post" autocomplete="off">
            <input type="hidden" name="action" value="login" />

            <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="email" name="email" id="email" class="form-control" required readonly />
            </div>

            <div class="mb-3">
                <label class="form-label">Password</label>
                <div class="input-group">
                    <input type="password" name="password" id="password" class="form-control" required readonly />
                    <button class="btn btn-outline-light" type="button" onclick="togglePassword()" tabindex="-1">
                        <span id="eyeIcon" class="material-symbols-outlined">visibility</span>
                    </button>
                </div>
            </div>

            <div class="d-grid mt-4">
                <button type="submit" class="btn btn-neon btn-lg">Login</button>
            </div>
        </form>

        <div class="text-center mt-4">
            <p>Don't have an account? 
                <a href="register.jsp" class="text-info text-decoration-underline">Sign up</a>
            </p>
            <a href="index.jsp" class="btn btn-outline-light mt-2">⬅️ Back to Home</a>
        </div>
    </div>
</div>

<script>
  window.addEventListener("DOMContentLoaded", () => {
    setTimeout(() => {
      document.querySelectorAll("input[readonly]").forEach(input => input.removeAttribute("readonly"));
    }, 500);
  });

  function togglePassword() {
    const pass = document.getElementById("password");
    const icon = document.getElementById("eyeIcon");
    pass.type = pass.type === "password" ? "text" : "password";
    icon.textContent = pass.type === "password" ? "visibility" : "visibility_off";
  }
</script>

<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<%@ include file="layout/footer.jsp" %>