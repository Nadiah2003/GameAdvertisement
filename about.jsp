<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>About - Game Advertising</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #0b0c2a;
      color: #f0f8ff;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .about-container {
      max-width: 900px;
      margin: 60px auto;
      padding: 40px;
      background-color: #151635;
      border-radius: 20px;
      box-shadow: 0 0 20px rgba(0, 191, 255, 0.3);
    }

    h1 {
      color: #00bfff;
      text-shadow: 1px 1px 5px #0077aa;
      text-align: center;
      margin-bottom: 30px;
    }

    p {
      font-size: 1.1rem;
      line-height: 1.8;
    }

    .btn-back {
      background-color: #00bfff;
      border: none;
      font-weight: bold;
      margin-top: 30px;
    }

    .btn-back:hover {
      background-color: #009ecc;
    }

    .highlight {
      color: #aad8ff;
    }

    .about-image {
      width: 100%;
      max-height: 300px;
      object-fit: cover;
      border-radius: 15px;
      margin-bottom: 30px;
      box-shadow: 0 0 10px rgba(0, 191, 255, 0.4);
    }
  </style>
</head>
<body>

  <div class="container about-container">
    <!-- 🖼️ Game Banner Image -->
    <img src="banner_about.jpg" alt="Game Campaign" class="about-image">

    <h1>About Game Advertising</h1>

    <p>
      Welcome to <span class="highlight">Game Advertising</span> — a dynamic platform designed to showcase and manage 
      powerful advertising campaigns tailored for the gaming world. From promoting AAA titles like 
      <span class="highlight">Apex Legends</span>, <span class="highlight">Genshin Impact</span>, to 
      <span class="highlight">Valorant</span>, we help connect your brand with gamers everywhere.
    </p>
    <p>
      This project is built using <span class="highlight">JSP, Servlets, and MySQL</span> as the core technologies, 
      styled with <span class="highlight">Bootstrap</span> to deliver a modern and immersive interface. 
    </p>
    <p>
      Our system allows you to:
    </p>
    <ul>
      <li>Track performance of each campaign</li>
      <li>Add or edit promotional content easily</li>
      <li>Visualize engagement & ROI stats</li>
    </ul>
    <p>
      Whether you're a game developer or digital marketing enthusiast, our platform is built to serve and scale with your needs.
    </p>

    <a href="home" class="btn btn-back btn-lg">← Back to Home</a>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>