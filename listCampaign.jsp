<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container">
    <h2 class="mb-4 text-info">${pageTitle}</h2>

    <c:if test="${not empty successMessage}">
        <div class="alert alert-success">${successMessage}</div>
    </c:if>

    <c:if test="${empty listCampaigns}">
        <div class="alert alert-warning">No campaigns available at the moment.</div>
    </c:if>

    <div class="row row-cols-1 row-cols-md-3 g-4">
        <c:forEach var="campaign" items="${listCampaigns}">
            <div class="col">
                <div class="card h-100 bg-dark text-light border border-info shadow">
                    <c:if test="${not empty campaign.imagePath}">
                        <img src="img/${campaign.imagePath}" class="card-img-top" alt="${campaign.name}">
                    </c:if>
                    <div class="card-body">
                        <h5 class="card-title">${campaign.name}</h5>
                        <p class="card-text">
                            <strong>Category:</strong> ${campaign.category}<br>
                            <strong>Platform:</strong> ${campaign.platform}<br>
                            <strong>Status:</strong> ${campaign.status}
                        </p>
                        <div class="d-grid gap-2">
                            <a href="${campaign.promotional_material_url}" target="_blank" class="btn btn-success btn-sm">🎮 Play Now</a>
                            <a href="${campaign.trailer_url}" target="_blank" class="btn btn-warning btn-sm">🎬 Watch Trailer</a>
                            <a href="campaigns?action=edit&campaign_id=${campaign.campaign_id}" class="btn btn-info btn-sm">📄 See Details</a>

                            <c:if test="${sessionScope.role eq 'admin'}">
                                <a href="campaigns?action=edit&campaign_id=${campaign.campaign_id}" class="btn btn-outline-light btn-sm">✏️ Edit</a>
                                <a href="campaigns?action=delete&campaign_id=${campaign.campaign_id}" class="btn btn-outline-danger btn-sm" onclick="return confirm('Are you sure?')">🗑️ Delete</a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>