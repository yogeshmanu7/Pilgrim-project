<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="pageTitle" value="Settings" scope="request"/>
<c:set var="currentPage" value="settings" scope="request"/>
<%@ include file="../common/header.jsp" %>

<div class="card">
    <div class="card-header d-flex justify-content-between align-items-center">
        <h5 class="card-title mb-0"><i class="fas fa-cog me-2 text-teal"></i>Application Settings</h5>
        <span class="religion-badge religion-all"><i class="fas fa-globe-americas me-1"></i> Global Configuration</span>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Setting</th>
                        <th>Value</th>
                        <th>Type</th>
                        <th>Group</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${settings}" var="setting">
                        <tr>
                            <td>
                                <strong>${setting.settingKey}</strong>
                                <c:if test="${not empty setting.description}">
                                    <br><small class="text-secondary">${setting.description}</small>
                                </c:if>
                            </td>
                            <td>
                                <code style="color: var(--primary-teal);">${setting.settingValue}</code>
                            </td>
                            <td><span class="badge bg-secondary">${setting.settingType}</span></td>
                            <td><span class="badge bg-info">${setting.settingGroup}</span></td>
                            <td>
                                <c:if test="${setting.editable}">
                                    <button type="button" class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#editModal${setting.id}">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                </c:if>
                            </td>
                        </tr>
                        
                        <!-- Edit Modal -->
                        <div class="modal fade" id="editModal${setting.id}" tabindex="-1">
                            <div class="modal-dialog">
                                <div class="modal-content" style="background: var(--card-bg); border: 1px solid var(--border-color);">
                                    <div class="modal-header" style="border-color: var(--border-color);">
                                        <h5 class="modal-title text-teal">Edit Setting</h5>
                                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                                    </div>
                                    <form action="${pageContext.request.contextPath}/admin/settings/update" method="post">
                                        <input type="hidden" name="key" value="${setting.settingKey}">
                                        <div class="modal-body">
                                            <div class="mb-3">
                                                <label class="form-label">${setting.settingKey}</label>
                                                <c:if test="${not empty setting.description}">
                                                    <small class="text-secondary d-block mb-2">${setting.description}</small>
                                                </c:if>
                                                <input type="text" name="value" class="form-control" value="${setting.settingValue}" required>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="border-color: var(--border-color);">
                                            <button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal">Cancel</button>
                                            <button type="submit" class="btn btn-primary">Save Changes</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty settings}">
                        <tr>
                            <td colspan="5" class="text-center py-5 text-secondary">
                                <i class="fas fa-cog fa-3x mb-3 d-block" style="opacity: 0.5;"></i>
                                <p class="mb-0">No settings found</p>
                                <small>Application settings will appear here</small>
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
