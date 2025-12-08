<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="pageTitle" value="Create Notification" scope="request"/>
<c:set var="currentPage" value="notifications" scope="request"/>
<%@ include file="../common/header.jsp" %>

<div class="card">
    <div class="card-header d-flex justify-content-between align-items-center">
        <h5 class="card-title mb-0"><i class="fas fa-bell me-2 text-teal"></i>Create New Notification</h5>
        <span class="religion-badge religion-all"><i class="fas fa-globe-americas me-1"></i> Global Announcement</span>
    </div>
    <div class="card-body">
        <form action="${pageContext.request.contextPath}/admin/notifications/save" method="post">
            <div class="row">
                <div class="col-md-8">
                    <div class="mb-3">
                        <label class="form-label">Title *</label>
                        <input type="text" name="title" class="form-control" required placeholder="Notification title">
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="mb-3">
                        <label class="form-label">Type</label>
                        <select name="notificationType" class="form-select">
                            <c:forEach items="${types}" var="type">
                                <option value="${type}">${type}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
            </div>
            
            <div class="mb-3">
                <label class="form-label">Message *</label>
                <textarea name="message" class="form-control" rows="4" required placeholder="Enter notification message for pilgrims..."></textarea>
            </div>
            
            <div class="row">
                <div class="col-md-6">
                    <div class="mb-3">
                        <label class="form-label">Target Audience</label>
                        <select name="targetAudience" class="form-select">
                            <c:forEach items="${audiences}" var="audience">
                                <option value="${audience}">${audience}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="mb-3">
                        <label class="form-label">Action URL (optional)</label>
                        <input type="text" name="actionUrl" class="form-control" placeholder="/path/to/page">
                    </div>
                </div>
            </div>
            
            <div class="mb-4">
                <div class="form-check">
                    <input type="checkbox" name="scheduled" class="form-check-input" id="scheduled" onchange="toggleSchedule()">
                    <label class="form-check-label" for="scheduled">Schedule for later</label>
                </div>
            </div>
            
            <div class="mb-3" id="scheduleDateTime" style="display: none;">
                <label class="form-label">Schedule Date & Time</label>
                <input type="datetime-local" name="scheduledAt" class="form-control">
            </div>
            
            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-paper-plane me-2"></i> Send Notification
                </button>
                <a href="${pageContext.request.contextPath}/admin/notifications" class="btn btn-outline-primary">Cancel</a>
            </div>
        </form>
    </div>
</div>

<script>
function toggleSchedule() {
    var checkbox = document.getElementById('scheduled');
    var scheduleDiv = document.getElementById('scheduleDateTime');
    scheduleDiv.style.display = checkbox.checked ? 'block' : 'none';
}
</script>

<%@ include file="../common/footer.jsp" %>
