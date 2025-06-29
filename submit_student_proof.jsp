<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%@ include file="layout/header.jsp" %>
<%@ include file="layout/nav_developer.jsp" %>

<%
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("developer")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<%
    String status = request.getParameter("status");
    if ("success".equals(status)) {
%>
    <div class="alert alert-success">✅ Your student proof has been submitted successfully. Please wait for admin verification.</div>
<%
    } else if ("invalidfile".equals(status)) {
%>
    <div class="alert alert-danger">❌ Invalid file type. Only PDF, JPG, and PNG are allowed.</div>
<%
    } else if ("error".equals(status)) {
%>
    <div class="alert alert-danger">❌ Upload failed. Please try again later.</div>
<%
    }
%>

<style>
    .dropzone {
        border: 2px dashed #00f7ff;
        padding: 30px;
        text-align: center;
        background-color: #0a1930;
        color: #ccc;
        border-radius: 12px;
        transition: background-color 0.3s ease;
    }

    .dropzone.dragover {
        background-color: #112b4e;
    }

    .dropzone input {
        display: none;
    }

    .dropzone p {
        margin: 10px 0 0;
        font-size: 1rem;
    }
</style>

<div class="container my-5">
    <h2 class="text-info mb-4">🎓 Submit Student Verification</h2>

    <div class="alert alert-info">
        Please upload your valid student card in <strong>PDF or image format (JPG/PNG)</strong>. Admin will verify your status before applying student discount.
    </div>

    <form action="SubmitStudentProofServlet" method="post" enctype="multipart/form-data">
        <div class="mb-3">
            <label class="form-label">Upload Student Card</label>

            <div id="dropzone" class="dropzone">
                <p>Drag & drop your student card here (PDF, JPG, PNG)</p>
                <p>or click to select file</p>
                <input type="file" name="proof" id="proof" accept=".pdf, image/png, image/jpeg" required />
            </div>
        </div>
        <button type="submit" class="btn btn-outline-info">Submit Proof</button>
    </form>
</div>

<script>
    const dropzone = document.getElementById("dropzone");
    const fileInput = document.getElementById("proof");

    dropzone.addEventListener("click", () => fileInput.click());

    dropzone.addEventListener("dragover", (e) => {
        e.preventDefault();
        dropzone.classList.add("dragover");
    });

    dropzone.addEventListener("dragleave", () => {
        dropzone.classList.remove("dragover");
    });

    dropzone.addEventListener("drop", (e) => {
        e.preventDefault();
        dropzone.classList.remove("dragover");
        const file = e.dataTransfer.files[0];
        const validTypes = ['application/pdf', 'image/jpeg', 'image/png'];
        if (file && validTypes.includes(file.type)) {
            fileInput.files = e.dataTransfer.files;
            dropzone.querySelector("p").textContent = file.name;
        } else {
            alert("Please upload a valid PDF or image file (JPG/PNG).");
        }
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<%@ include file="layout/footer.jsp" %>