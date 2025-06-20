<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Campaign" %>
<%@ page import="dao.impl.CampaignDAOImpl" %>
<%@ page import="dao.CampaignDAO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    CampaignDAO dao = new CampaignDAOImpl();
    List<Campaign> campaignList = dao.getAllCampaigns(); // campaignList should contain performance data too
    request.setAttribute("campaignList", campaignList);
%>

<div class="homepage-content">
    <div class="welcome-user mb-4">
        Welcome, <c:out value="${sessionScope.user.username}" /> (Admin)! 👑
    </div>

    <h2 style="color: #61dafb;">📈 Campaign Performance List</h2>

    <table class="table table-dark table-striped table-bordered mt-4">
        <thead>
            <tr class="text-center">
                <th>Game Name</th>
                <th>Target Audience</th>
                <th>Platform</th>
                <th>Status</th>
                <th>Category</th>
                <th>Impressions</th>
                <th>Clicks</th>
                <th>Engagement Rate (%)</th>
                <th>ROI (%)</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="c" items="${campaignList}">
                <tr>
                    <td><c:out value="${c.name}" /></td>
                    <td><c:out value="${c.target_audience}" /></td>
                    <td><c:out value="${c.platform}" /></td>
                    <td><c:out value="${c.status}" /></td>
                    <td><c:out value="${c.category}" /></td>
                    
                    <!-- These fields should be fetched from performance_data -->
                    <td><c:out value="${c.impressions}" default="0" /></td>
                    <td><c:out value="${c.clicks}" default="0" /></td>
                    <td><c:out value="${c.engagementRate}" default="0.0" /></td>
                    <td><c:out value="${c.roi}" default="0.0" /></td>

                    <td class="text-center">
                        <a href="viewPerformance.jsp?id=${c.campaign_id}" class="btn btn-sm btn-info">View</a>
                        <a href="editPerformance.jsp?id=${c.campaign_id}" class="btn btn-sm btn-warning">Edit</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>