<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sign Up - Game Advertising</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #0b0c2a;
            color: #fff;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .signup-box {
            max-width: 400px;
            margin: 80px auto;
            padding: 30px;
            background: #121440;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0, 191, 255, 0.3);
        }

        .btn-primary {
            background-color: #00bfff;
            border: none;
        }

        .btn-primary:hover {
            background-color: #009acd;
        }

        a {
            color: #00bfff;
        }

        a:hover {
            color: #009acd;
        }

        h2 {
            font-weight: bold;
            text-align: center;
        }
    </style>
</head>
<body>

    <div class="signup-box text-white">
        <h2>Sign Up</h2>

        <% if (request.getParameter("success") != null) { %>
            <div class="alert alert-success text-center" role="alert">
                Successfully registered!
            </div>
        <% } %>

        <% if (request.getParameter("error") != null) { %>
            <div class="alert alert-danger text-center" role="alert">
                Username already exists.
            </div>
        <% } %>

        <form action="auth" method="post" autocomplete="off">
            <input type="hidden" name="action" value="signup"/>

            <div class="mb-3">
                <label class="form-label">Username:</label>
                <input type="text" name="username" class="form-control" autocomplete="off" required/>
            </div>

            <div class="mb-3 position-relative">
                <label class="form-label">Password:</label>
                <div class="input-group">
                    <input type="password" name="password" id="signup-password" class="form-control" autocomplete="new-password" required/>
                    <button class="btn btn-outline-secondary" type="button" id="toggle-password" tabindex="-1">
                        <i class="bi bi-eye-slash" id="toggle-icon"></i>
                    </button>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label">Select Role:</label>
                <select name="role" class="form-select" required>
                    <option value="">-- Choose Role --</option>
                    <option value="admin">Admin</option>
                    <option value="developer">Developer</option>
                    <option value="gamer">Gamer</option>
                </select>
            </div>

            <div class="d-grid">
                <button type="submit" class="btn btn-primary">Register</button>
            </div>
        </form>

        <div class="mt-3 text-center">
            <p>Already have an account? <a href="login.jsp">Back to login</a></p>
            <a href="index.html" class="btn btn-outline-light mt-2">Back to Home</a>
        </div>
    </div>

    <!-- Bootstrap Icons CDN (Add in <head> if not already) -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <script>
        const toggleBtn = document.getElementById('toggle-password');
        const passwordField = document.getElementById('signup-password');
        const icon = document.getElementById('toggle-icon');

        toggleBtn.addEventListener('click', () => {
            const type = passwordField.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordField.setAttribute('type', type);
            icon.classList.toggle('bi-eye');
            icon.classList.toggle('bi-eye-slash');
        });
    </script>

</body>
</html>