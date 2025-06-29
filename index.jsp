<!-- index.jsp -->
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="layout/header.jsp" %>
<%@ include file="layout/nav_guest.jsp" %>

<!-- ✅ Main content -->
<div class="hero py-5">
  <div class="container hero-content">
    <!-- Carousel -->
    <div id="gameCarousel" class="carousel slide mb-4" data-bs-ride="carousel">
      <div class="carousel-inner rounded-3 overflow-hidden">
        <div class="carousel-item active">
          <img src="images/slide1.jpg" class="d-block w-100" alt="Apex Legends Gameplay">
          <div class="carousel-caption d-none d-md-block">
            <h5>Apex Legends: Battle for Survival</h5>
          </div>
        </div>
        <div class="carousel-item">
          <img src="images/slide2.png" class="d-block w-100" alt="Genshin Impact Characters">
          <div class="carousel-caption d-none d-md-block">
            <h5>Genshin Impact: Explore the Unknown</h5>
          </div>
        </div>
        <div class="carousel-item">
          <img src="images/slide3.jpeg" class="d-block w-100" alt="Valorant Agents">
          <div class="carousel-caption d-none d-md-block">
            <h5>Valorant: Precision Meets Strategy</h5>
          </div>
        </div>
      </div>
      <button class="carousel-control-prev" type="button" data-bs-target="#gameCarousel" data-bs-slide="prev">
        <span class="carousel-control-prev-icon"></span>
        <span class="visually-hidden">Previous</span>
      </button>
      <button class="carousel-control-next" type="button" data-bs-target="#gameCarousel" data-bs-slide="next">
        <span class="carousel-control-next-icon"></span>
        <span class="visually-hidden">Next</span>
      </button>
    </div>

    <!-- Title & Description -->
    <h1 class="display-5 fw-bold text-center">Welcome to WarriorAd</h1>
    <p class="lead text-center">Advertise your online games. Engage more players. Grow your impact.</p>
    <div class="text-center mt-4">
      <a href="login.jsp" class="btn btn-outline-info btn-lg">Get Started</a>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<%@ include file="layout/footer.jsp" %>