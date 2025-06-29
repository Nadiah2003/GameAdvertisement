<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<%@ page import="ads.db.DBConnection" %>
<%@ include file="layout/header.jsp" %>
<%@ include file="layout/nav_developer.jsp" %>

<c:if test="${empty sessionScope.name}">
    <c:redirect url="login.jsp" />
</c:if>

<!-- Set profile picture fallback -->
<c:choose>
    <c:when test="${empty sessionScope.profile_pic}">
        <c:set var="profilePic" value="img/default_profile.jpg" />
    </c:when>
    <c:otherwise>
        <c:set var="profilePic" value="${sessionScope.profile_pic}" />
    </c:otherwise>
</c:choose>

<style>
    form {
        background-color: #041b3d;
        border: 1px solid #00f7ff;
        box-shadow: 0 0 20px rgba(0, 247, 255, 0.3);
    }
    input.form-control, .form-label {
        color: #fff;
    }
    input.form-control {
        background-color: #0a1930;
        border: 1px solid #00f7ff;
    }
    input.form-control::placeholder {
        color: #aaa;
    }
</style>

<div class="container my-5">
    <h2 class="text-info mb-4">Settings</h2>

    <!-- Success/Error Alerts -->
    <c:choose>
        <c:when test="${param.success eq 'true'}">
            <div class="alert alert-success">Profile updated successfully!</div>
        </c:when>
        <c:when test="${param.error eq 'true'}">
            <div class="alert alert-danger">Failed to update profile. Please try again.</div>
        </c:when>
    </c:choose>

    <form action="UpdateDeveloperServlet" method="post" enctype="multipart/form-data"
          class="p-4 bg-dark text-white rounded-4 shadow-lg">

        <input type="hidden" name="user_id" value="${sessionScope.user_id}">

        <!-- Profile Picture -->
        <div class="mb-4 text-center">
            <label class="form-label">Profile Picture</label><br>
            <div id="drop-zone" class="mx-auto d-flex justify-content-center align-items-center border border-info rounded-circle"
                 style="height: 150px; width: 150px; background-color: #001e5c; cursor: pointer; overflow: hidden;">
                <img id="preview" src="${pageContext.request.contextPath}/${profilePic}" alt="Profile Picture"
                     class="img-fluid rounded-circle" style="object-fit: cover; height: 100%; width: 100%;">
                <input type="file" name="profile_pic" id="profile_pic"
                       accept="image/*" style="display: none;">
            </div>
            <small class="text-secondary d-block mt-2">Click or drag to change picture</small>
        </div>

        <!-- Name -->
        <div class="mb-3">
            <label class="form-label">Name</label>
            <input type="text" name="name" class="form-control" value="${sessionScope.name}" required>
        </div>

        <!-- Email -->
        <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" name="email" class="form-control" value="${sessionScope.email}" required>
        </div>

        <!-- Password -->
        <div class="mb-3">
            <label class="form-label">New Password <small class="text-muted">(Leave blank to keep current)</small></label>
            <input type="password" name="password" class="form-control" placeholder="********">
        </div>

        <div class="text-center mt-4">
            <button type="submit" class="btn btn-info px-4">Save Changes</button>
        </div>
    </form>
</div>

<!-- Image preview and drag-drop -->
<script>
    const dropZone = document.getElementById("drop-zone");
    const fileInput = document.getElementById("profile_pic");
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
            reader.onload = function (e) {
                previewImg.src = e.target.result;
            };
            reader.readAsDataURL(file);
        }
    });

    fileInput.addEventListener("change", () => {
        const file = fileInput.files[0];
        if (file && file.type.startsWith("image/")) {
            const reader = new FileReader();
            reader.onload = function (e) {
                previewImg.src = e.target.result;
            };
            reader.readAsDataURL(file);
        }
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<%@ include file="layout/footer.jsp" %>