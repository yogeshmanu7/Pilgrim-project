<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="pageTitle" value="Audit Logs" scope="request"/>
<c:set var="currentPage" value="logs" scope="request"/>
<%@ include file="../common/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <div class="d-flex gap-2">
        <select class="form-select" onchange="window.location.href='?action=' + this.value" style="width: 200px;">
            <option value="">All Actions</option>
            <c:forEach items="${actions}" var="action">
                <option value="${action}" ${selectedAction == action ? 'selected' : ''}>${action}</option>
            </c:forEach>
        </select>
    </div>
</div>

<div class="card">
    <div class="card-header d-flex justify-content-between align-items-center">
        <h5 class="card-title mb-0"><i class="fas fa-clipboard-list me-2 text-teal"></i>Audit Logs</h5>
        <span class="religion-badge religion-all"><i class="fas fa-globe-americas me-1"></i> System Activity</span>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Admin</th>
                        <th>Action</th>
                        <th>Entity</th>
                        <th>Description</th>
                        <th>IP Address</th>
                        <th>Timestamp</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${logs.content}" var="log">
                        <tr>
                            <td>#${log.id}</td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <div style="width: 35px; height: 35px; border-radius: 50%; margin-right: 10px; background: linear-gradient(135deg, var(--primary-teal), var(--accent-purple)); display: flex; align-items: center; justify-content: center; color: white; font-size: 0.8rem; font-weight: 600;">
                                        ${log.adminName.charAt(0)}
                                    </div>
                                    <div>
                                        <strong>${log.adminName}</strong>
                                        <br><small class="text-secondary">${log.adminEmail}</small>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <span class="badge ${log.action == 'CREATE' ? 'bg-success' : log.action == 'DELETE' ? 'bg-danger' : log.action == 'LOGIN' || log.action == 'LOGOUT' ? 'bg-info' : 'bg-warning'}">
                                    ${log.action}
                                </span>
                            </td>
                            <td>
                                ${log.entityType}
                                <c:if test="${log.entityId != null}">
                                    <br><small class="text-secondary">#${log.entityId}</small>
                                </c:if>
                            </td>
                            <td>${log.description}</td>
                            <td><code style="color: var(--primary-teal);">${log.ipAddress}</code></td>
                            <td>
                                ${log.createdAt.toLocalDate()}
                                <br><small class="text-secondary">${log.createdAt.toLocalTime()}</small>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty logs.content}">
                        <tr>
                            <td colspan="7" class="text-center py-5 text-secondary">
                                <i class="fas fa-clipboard-list fa-3x mb-3 d-block" style="opacity: 0.5;"></i>
                                <p class="mb-0">No logs found</p>
                                <small>System activity will appear here</small>
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
        
        <c:if test="${logs.totalPages > 1}">
            <nav class="mt-4">
                <ul class="pagination justify-content-center">
                    <c:forEach begin="0" end="${logs.totalPages - 1}" var="i">
                        <li class="page-item ${logs.number == i ? 'active' : ''}">
                            <a class="page-link" href="?page=${i}&action=${selectedAction}&entity=${selectedEntity}">${i + 1}</a>
                        </li>
                    </c:forEach>
                </ul>
            </nav>
        </c:if>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
