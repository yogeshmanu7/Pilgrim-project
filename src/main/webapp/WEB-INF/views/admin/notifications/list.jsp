<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="pageTitle" value="Notifications" scope="request"/>
<c:set var="currentPage" value="notifications" scope="request"/>
<%@ include file="../common/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h4 class="mb-0"></h4>
    <a href="${pageContext.request.contextPath}/admin/notifications/create" class="btn btn-primary">
        <i class="fas fa-plus me-2"></i> Create Notification
    </a>
</div>

<div class="card">
    <div class="card-header d-flex justify-content-between align-items-center">
        <h5 class="card-title mb-0"><i class="fas fa-bell me-2 text-teal"></i>All Notifications</h5>
        <span class="religion-badge religion-all"><i class="fas fa-globe-americas me-1"></i> Global Announcements</span>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Title</th>
                        <th>Type</th>
                        <th>Audience</th>
                        <th>Status</th>
                        <th>Sent At</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${notifications.content}" var="notification">
                        <tr>
                            <td>#${notification.id}</td>
                            <td>
                                <strong>${notification.title}</strong>
                                <br><small class="text-secondary">${notification.message.length() > 50 ? notification.message.substring(0, 50).concat('...') : notification.message}</small>
                            </td>
                            <td><span class="badge bg-secondary">${notification.notificationType}</span></td>
                            <td><span class="badge bg-info">${notification.targetAudience}</span></td>
                            <td>
                                <c:choose>
                                    <c:when test="${notification.sent}">
                                        <span class="badge badge-approved">Sent</span>
                                    </c:when>
                                    <c:when test="${notification.scheduled}">
                                        <span class="badge badge-pending">Scheduled</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary">Draft</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:if test="${notification.sentAt != null}">
                                    ${notification.sentAt.toLocalDate()}
                                </c:if>
                            </td>
                            <td>
                                <c:if test="${!notification.sent}">
                                    <form action="${pageContext.request.contextPath}/admin/notifications/${notification.id}/send" method="post" style="display: inline;">
                                        <button type="submit" class="btn btn-sm btn-success me-1" title="Send Now">
                                            <i class="fas fa-paper-plane"></i>
                                        </button>
                                    </form>
                                </c:if>
                                <form action="${pageContext.request.contextPath}/admin/notifications/${notification.id}/delete" method="post" style="display: inline;" onsubmit="return confirm('Are you sure you want to delete this notification?');">
                                    <button type="submit" class="btn btn-sm btn-danger">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty notifications.content}">
                        <tr>
                            <td colspan="7" class="text-center py-5 text-secondary">
                                <i class="fas fa-bell fa-3x mb-3 d-block" style="opacity: 0.5;"></i>
                                <p class="mb-0">No notifications found</p>
                                <small>Create notifications to keep pilgrims informed</small>
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
