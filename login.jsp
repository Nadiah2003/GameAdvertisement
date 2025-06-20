<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - Game Advertising</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #0a0f2c;
            color: #ffffff;
            font-family: 'Segoe UI', sans-serif;
        }

        .login-box {
            max-width: 400px;
            margin: 100px auto;
            background-color: #12183b;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 20px rgba(0, 123, 255, 0.3);
        }

        .login-box h2 {
            text-align: center;
            color: #00bfff;
            margin-bottom: 20px;
        }

        .form-control {
            background-color: #0e1430;
            color: #fff;
            border: 1px solid #007bff;
        }

        .form-control:focus {
            background-color: #0e1430;
            color: #fff;
            border-color: #00bfff;
            box-shadow: 0 0 0 0.2rem rgba(0, 191, 255, 0.25);
        }

        .btn-primary {
            background-color: #007bff;
            border: none;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        .alert {
            margin-top: 15px;
        }

        a {
            color: #00bfff;
        }

        a:hover {
            color: #66d9ff;
        }

        .btn-secondary {
            background-color: #6c757d;
            border: none;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body>

<div class="login-box">
    <h2>Login</h2>

    <!-- Success and Error Messages -->
    <c:if test="${param.success eq 'true'}">
        <div class="alert alert-success" role="alert">
            Signup successful! You can now log in.
        </div>
    </c:if>

    <c:if test="${param.error eq 'invalid'}">
        <div class="alert alert-danger" role="alert">
            Invalid username or password. Please try again.
        </div>
    </c:if>

    <c:if test="${param.error eq 'exists'}">
        <div class="alert alert-warning" role="alert">
            Username already exists. Please choose another.
        </div>
    </c:if>

    <!-- Login Form -->
    <form action="auth" method="post" autocomplete="off">
        <input type="hidden" name="action" value="login" />

        <div class="mb-3">
            <label for="username" class="form-label">Username</label>
            <input type="text"
                   class="form-control"
                   name="username"
                   id="username"
                   required
                   autocomplete="new-username" />
        </div>

        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password"
                   class="form-control"
                   name="password"
                   id="password"
                   required
                   autocomplete="new-password" />
        </div>

        <div class="d-grid gap-2">
            <button type="submit" class="btn btn-primary">Login</button>
        </div>
    </form>

    <div class="mt-3 text-center">
        Don't have an account? <a href="signup.jsp">Sign up</a>
        <a href="index.html" class="btn btn-outline-light mt-2">Back to Home</a>
    </div>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
