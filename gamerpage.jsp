<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
    .game-card-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
        gap: 24px;
        padding: 20px;
    }

    .game-card {
        background-color: #1f1f2e;
        border-radius: 16px;
        overflow: hidden;
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        color: white;
    }

    .game-card:hover {
        transform: translateY(-6px);
        box-shadow: 0 12px 30px rgba(0, 0, 0, 0.4);
    }

    .game-card img:first-child {
        width: 100%;
        height: 180px;
        object-fit: cover;
        border-top-left-radius: 16px;
        border-top-right-radius: 16px;
    }

    .game-card h3 {
        font-size: 20px;
        margin: 12px;
    }

    .game-card p {
        margin: 0 12px 12px;
        font-size: 14px;
        color: #bbb;
    }

    .game-card .button {
        margin: 8px 12px;
        padding: 8px 14px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 8px;
        text-decoration: none;
        display: inline-block;
        text-align: center;
        transition: background-color 0.3s ease;
        font-size: 14px;
    }

    .game-card .button:hover {
        background-color: #0056b3;
    }
</style>

<div class="homepage-content">
    <div class="welcome-user">
        Welcome, <c:out value="${sessionScope.user.username}" /> (Gamer)!
    </div>

    <div class="hero-section">
        <div class="hero-text">
            <h2>🔥 Discover New Worlds</h2>
            <p>Browse trending games, explore by category, and find your next obsession!</p>
            <div class="hero-buttons">
                <a href="public-campaigns?action=trending" class="button">Trending</a>
            </div>
        </div>
    </div>

    <div class="latest-games-section">
        <h2>Latest Games</h2>
        <div class="game-card-grid">
            <c:forEach var="game" items="${latestGames}">
                <div class="game-card">
                    <img src="${pageContext.request.contextPath}/${game.imagePath}" alt="${game.name}" />
                    <h3><c:out value="${game.name}" /></h3>
                    <p>Category: <c:out value="${game.category}" /></p>
                    <a href="campaigns?action=details&id=${game.campaign_id}" class="button">See Details</a>
                    <a href="${game.promotional_material_url}" class="button">Play Now</a>
                    <a href="${game.trailer_url}" class="button">Watch Trailer</a>
                </div>
            </c:forEach>
        </div>
    </div>
</div>