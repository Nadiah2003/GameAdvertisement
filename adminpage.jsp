<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
    .admin-dashboard {
        padding: 20px;
        color: #e0e0e0;
        font-family: 'Segoe UI', sans-serif;
    }

    .welcome-admin {
        font-size: 22px;
        font-weight: bold;
        margin-bottom: 25px;
        color: #00bfff;
        text-shadow: 1px 1px 3px #000;
    }

    .dashboard-header {
        font-size: 26px;
        font-weight: bold;
        margin-bottom: 20px;
        color: #61dafb;
        text-shadow: 0 0 5px rgba(97,218,251,0.3);
    }

    .custom-table {
        background-color: #1a1f33;
        border-radius: 10px;
        overflow: hidden;
        border: 1px solid #007bff;
        box-shadow: 0 4px 10px rgba(0, 123, 255, 0.2);
    }

    .custom-table th {
        background-color: #29304d;
        color: #00ffff;
        text-align: center;
    }

    .custom-table td {
        background-color: #1f2647;
        color: #dcdcdc;
        text-align: center;
        vertical-align: middle;
    }

    .custom-table a.btn {
        font-size: 13px;
        padding: 6px 10px;
        margin: 0 2px;
        border-radius: 5px;
    }

    .no-data {
        text-align: center;
        padding: 30px;
        color: #aaa;
        font-style: italic;
    }

    .table-responsive {
        border-radius: 10px;
        overflow-x: auto;
    }
</style>

<div class="admin-dashboard">
    <div class="welcome-admin">
        👑 Welcome, <c:out value="${sessionScope.user.username}" /> (Admin)
    </div>

    <div class="dashboard-header">📊 Campaign Analytics</div>

    <c:choose>
        <c:when test="${not empty campaignStats}">
            <div class="table-responsive">
                <table class="table table-bordered custom-table">
                    <thead>
                        <tr>
                            <th>Campaign</th>
                            <th>Impressions</th>
                            <th>Clicks</th>
                            <th>Engagement Rate (%)</th>
                            <th>ROI</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="campaign" items="${campaignStats}">
                            <tr>
                                <td><c:out value="${campaign.name}" /></td>
                                <td><c:out value="${campaign.impressions}" /></td>
                                <td><c:out value="${campaign.clicks}" /></td>
                                <td><c:out value="${campaign.engagementRate}" /></td>
                                <td><c:out value="${campaign.roi}" /></td>
                                <td>
                                    <a href="campaigns?action=edit&campaign_id=${campaign.campaign_id}" class="btn btn-warning btn-sm">Edit</a>
                                    <a href="campaigns?action=delete&campaign_id=${campaign.campaign_id}" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this campaign?')">Delete</a>
                                    <a href="public-campaigns?id=${campaign.campaign_id}" class="btn btn-info btn-sm">View</a>
                                </td>

                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:when>
        <c:otherwise>
            <div class="no-data">🚫 No campaign statistics available at the moment.</div>
        </c:otherwise>
    </c:choose>
</div>