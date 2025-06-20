<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%-- This JSP is included by main_layout.jsp. So no <html>, <head>, <body> needed --%>

<style>
    .homepage-content {
        padding: 30px;
        color: #fff;
        background-color: #0d1117;
    }

    .welcome-user {
        font-size: 18px;
        margin-bottom: 20px;
        font-weight: 500;
        color: #b3d4fc;
        text-align: left;
    }

    .hero-section {
        display: flex;
        flex-wrap: wrap;
        gap: 30px;
        margin-bottom: 50px;
        align-items: center;
        justify-content: center;
    }

    .video-placeholder {
        flex: 1 1 500px;
        text-align: center;
    }

    .video-placeholder img {
        width: 100%;
        border-radius: 12px;
        box-shadow: 0 0 10px rgba(255,255,255,0.1);
    }

    .hero-text {
        flex: 1 1 400px;
    }

    .hero-text h2 {
        font-size: 32px;
        margin-bottom: 10px;
        color: #61dafb;
    }

    .hero-text p {
        font-size: 16px;
        color: #ccc;
        margin-bottom: 20px;
    }

    .hero-buttons a {
        margin-right: 15px;
        padding: 10px 20px;
        background-color: #007bff;
        color: white;
        text-decoration: none;
        border-radius: 6px;
        transition: background-color 0.3s ease;
    }

    .hero-buttons a:hover {
        background-color: #0056b3;
    }

    .latest-games-section {
        margin-top: 60px;
        padding: 20px;
    }

    .latest-games-section h2 {
        font-size: 28px;
        margin-bottom: 20px;
        text-align: center;
        font-weight: bold;
    }

    .game-card-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 20px;
    }

    .game-card {
        background-color: #1a1a2e;
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 4px 10px rgba(0,0,0,0.3);
        transition: transform 0.2s;
        color: #fff;
        padding-bottom: 10px;
    }

    .game-card:hover {
        transform: translateY(-5px);
    }

    .game-card img {
        width: 100%;
        height: 180px;
        object-fit: cover;
        border-top-left-radius: 12px;
        border-top-right-radius: 12px;
    }

    .game-card h3 {
        font-size: 20px;
        margin: 10px;
    }

    .game-card p {
        margin: 0 10px 10px 10px;
        color: #bbb;
    }

    .game-card .button {
        margin: 10px;
        padding: 8px 16px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 6px;
        text-decoration: none;
        display: inline-block;
        font-size: 14px;
    }

    .game-card .button:hover {
        background-color: #0056b3;
    }
</style>

<div class="homepage-content">
    <div class="welcome-user">
        <c:if test="${not empty sessionScope.user}">
            Welcome, <c:out value="${sessionScope.user.username}" />!
        </c:if>
    </div>

    <div class="hero-section">
        <div class="video-placeholder">
            <img src="mobile-video-gaming.jpg" alt="Game Teaser">
        </div>
        <div class="hero-text">
            <h2>Experience the Future of Gaming</h2>
            <p>Dive into immersive worlds, challenge your skills, and connect with players worldwide.</p>
            <div class="hero-buttons">
                <a href="public-campaigns" class="button primary-button">PLAY NOW</a>
            </div>
        </div>
    </div>

    <div class="latest-games-section">
        <h2>LATEST GAMES</h2>
        <div class="game-card-grid">
            <div class="game-card">
                <img src="play.jpg" alt="Game Title 1">
                <h3>Mystic Quest</h3>
                <p>Genre: RPG</p>
                <a href="public-campaigns?id=game1" class="button">Learn More</a>
            </div>
            <div class="game-card">
                <img src="cyber.jpg" alt="Game Title 2">
                <h3>Cyber Heist</h3>
                <p>Genre: Action</p>
                <a href="public-campaigns?id=game2" class="button">Learn More</a>
            </div>
            <div class="game-card">
                <img src="tycoon.webp" alt="Game Title 3">
                <h3>Farm Tycoon</h3>
                <p>Genre: Simulation</p>
                <a href="public-campaigns?id=game3" class="button">Learn More</a>
            </div>
            <div class="game-card">
                <img src="space.jpg" alt="Game Title 4">
                <h3>Space Saga</h3>
                <p>Genre: Sci-Fi</p>
                <a href="public-campaigns?id=game4" class="button">Learn More</a>
            </div>
        </div>
    </div>
</div>