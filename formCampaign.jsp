<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div>
    <h1>
        <c:if test="${campaign != null}">Edit Campaign</c:if>
        <c:if test="${campaign == null}">Add New Campaign</c:if>
    </h1>

    <c:if test="${not empty errorMessage}">
        <p class="error-message">${errorMessage}</p>
    </c:if>

    <form action="campaigns" method="POST" enctype="multipart/form-data">
        <c:if test="${campaign != null}">
            <input type="hidden" name="action" value="update" />
            <input type="hidden" name="campaign_id" value="<c:out value='${campaign.campaign_id}' />" />
        </c:if>
        <c:if test="${campaign == null}">
            <input type="hidden" name="action" value="create" />
        </c:if>

        <div>
            <label for="name">Campaign Name:</label>
            <input type="text" id="name" name="name" value="<c:out value='${campaign.name}' />" required /> <br><br>
        </div>

        <div>
            <label for="target_audience">Target Audience:</label>
            <textarea id="target_audience" name="target_audience" rows="3"><c:out value='${campaign.target_audience}' /></textarea> <br><br>
        </div>

        <div>
            <label for="budget">Budget ($):</label>
            <input type="number" id="budget" name="budget" step="0.01" value="<c:out value='${campaign.budget}' />" required /> <br><br>
        </div>

        <div>
            <label for="start_date">Start Date:</label>
            <input type="date" id="start_date" name="start_date" value="<c:out value='${campaign.start_date}' />" required /> <br><br>
        </div>

        <div>
            <label for="end_date">End Date:</label>
            <input type="date" id="end_date" name="end_date" value="<c:out value='${campaign.end_date}' />" required /> <br><br>
        </div>

        <div>
            <label for="platform">Platform:</label>
            <input type="text" id="platform" name="platform" value="<c:out value='${campaign.platform}' />" /> <br><br>
        </div>

        <div>
            <label for="category">Category:</label>
            <select id="category" name="category" required>
                <option value="">-- Select Category --</option>
                <option value="Action" <c:if test="${campaign.category eq 'Action'}">selected</c:if>>Action</option>
                <option value="Adventure" <c:if test="${campaign.category eq 'Adventure'}">selected</c:if>>Adventure</option>
                <option value="RPG" <c:if test="${campaign.category eq 'RPG'}">selected</c:if>>RPG</option>
                <option value="Simulation" <c:if test="${campaign.category eq 'Simulation'}">selected</c:if>>Simulation</option>
                <option value="Puzzle" <c:if test="${campaign.category eq 'Puzzle'}">selected</c:if>>Puzzle</option>
                <option value="Sports" <c:if test="${campaign.category eq 'Sports'}">selected</c:if>>Sports</option>
            </select>
            <br><br>
        </div>

        <div>
            <label for="status">Status:</label>
            <select id="status" name="status" required>
                <option value="Active" <c:if test="${campaign.status eq 'Active'}">selected</c:if>>Active</option>
                <option value="Paused" <c:if test="${campaign.status eq 'Paused'}">selected</c:if>>Paused</option>
                <option value="Completed" <c:if test="${campaign.status eq 'Completed'}">selected</c:if>>Completed</option>
                <option value="Archived" <c:if test="${campaign.status eq 'Archived'}">selected</c:if>>Archived</option>
                <option value="Canceled" <c:if test="${campaign.status eq 'Canceled'}">selected</c:if>>Canceled</option>
            </select>
            <br><br>
        </div>

        <div>
            <label for="promotional_material_url">Play Now URL:</label>
            <input type="url" id="promotional_material_url" name="promotional_material_url" value="<c:out value='${campaign.promotional_material_url}' />" /> <br><br>
        </div>

        <div>
            <label for="trailer_url">Trailer (YouTube) URL:</label>
            <input type="url" id="trailer_url" name="trailer_url" value="<c:out value='${campaign.trailer_url}' />" /> <br><br>
        </div>

        <div>
            <label for="promo_img">Upload Campaign Image:</label>
            <input type="file" name="image_path" id="image_path" accept="img/*" />
            <br><br>
        </div>

        <div>
            <button type="submit" class="btn btn-primary">
                <c:if test="${campaign != null}">Update Campaign</c:if>
                <c:if test="${campaign == null}">Add Campaign</c:if>
            </button>
            <a href="campaigns?action=list" class="btn btn-secondary ms-2">Cancel</a>
        </div>

        <% String error = (String) request.getAttribute("errorMessage");
            if (error != null) { %>
            <div class="alert alert-danger">
                <%= error %>
            </div>
        <% } %>
    </form>
</div>