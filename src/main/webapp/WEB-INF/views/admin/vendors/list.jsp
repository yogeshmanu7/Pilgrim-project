<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="pageTitle" value="Partners" scope="request"/>
<c:set var="currentPage" value="vendors" scope="request"/>
<%@ include file="../common/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <div class="d-flex gap-2">
        <select class="form-select" onchange="window.location.href='?status=' + this.value" style="width: 200px;">
            <option value="">All Status</option>
            <c:forEach items="${statuses}" var="status">
                <option value="${status}" ${selectedStatus == status ? 'selected' : ''}>${status}</option>
            </c:forEach>
        </select>
        <c:if test="${pendingCount > 0}">
            <span class="badge bg-warning align-self-center">${pendingCount} Pending</span>
        </c:if>
    </div>
</div>

<div class="card">
    <div class="card-header d-flex justify-content-between align-items-center">
        <h5 class="card-title mb-0"><i class="fas fa-store me-2 text-teal"></i>All Partners</h5>
        <span class="religion-badge religion-all"><i class="fas fa-globe-americas me-1"></i> Global Network</span>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Business Name</th>
                        <th>Owner</th>
                        <th>Email</th>
                        <th>Status</th>
                        <th>Products</th>
                        <th>Joined</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${vendors.content}" var="vendor">
                        <tr>
                            <td>#${vendor.id}</td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <div style="width: 40px; height: 40px; border-radius: 10px; margin-right: 12px; background: linear-gradient(135deg, var(--sacred-gold), var(--warm-amber)); display: flex; align-items: center; justify-content: center; color: white; font-weight: 600;">
                                        ${vendor.businessName.charAt(0)}
                                    </div>
                                    <strong>${vendor.businessName}</strong>
                                </div>
                            </td>
                            <td>${vendor.ownerName}</td>
                            <td>${vendor.email}</td>
                            <td>
                                <span class="badge badge-${vendor.status == 'APPROVED' ? 'approved' : vendor.status == 'REJECTED' ? 'rejected' : 'pending'}">
                                    ${vendor.status}
                                </span>
                            </td>
                            <td><span class="badge bg-secondary">${vendor.totalProducts}</span></td>
                            <td>${vendor.createdAt.toLocalDate()}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/vendors/view/${vendor.id}" class="btn btn-sm btn-outline-primary me-1">
                                    <i class="fas fa-eye"></i>
                                </a>
                                <c:if test="${vendor.status == 'PENDING'}">
                                    <form action="${pageContext.request.contextPath}/admin/vendors/approve/${vendor.id}" method="post" style="display: inline;">
                                        <button type="submit" class="btn btn-sm btn-success me-1" title="Approve">
                                            <i class="fas fa-check"></i>
                                        </button>
                                    </form>
                                    <button type="button" class="btn btn-sm btn-danger" data-bs-toggle="modal" data-bs-target="#rejectModal${vendor.id}">
                                        <i class="fas fa-times"></i>
                                    </button>
                                </c:if>
                            </td>
                        </tr>
                        
                        <!-- Reject Modal -->
                        <div class="modal fade" id="rejectModal${vendor.id}" tabindex="-1">
                            <div class="modal-dialog">
                                <div class="modal-content" style="background: var(--card-bg); border: 1px solid var(--border-color);">
                                    <div class="modal-header" style="border-color: var(--border-color);">
                                        <h5 class="modal-title text-teal">Reject Partner</h5>
                                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                                    </div>
                                    <form action="${pageContext.request.contextPath}/admin/vendors/reject/${vendor.id}" method="post">
                                        <div class="modal-body">
                                            <div class="mb-3">
                                                <label class="form-label">Rejection Reason</label>
                                                <textarea name="reason" class="form-control" required placeholder="Please provide a reason for rejection"></textarea>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="border-color: var(--border-color);">
                                            <button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal">Cancel</button>
                                            <button type="submit" class="btn btn-danger">Reject</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty vendors.content}">
                        <tr>
                            <td colspan="8" class="text-center py-5 text-secondary">
                                <i class="fas fa-store fa-3x mb-3 d-block" style="opacity: 0.5;"></i>
                                <p class="mb-0">No partners found</p>
                                <small>Partners will appear here once they register</small>
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
        
        <c:if test="${vendors.totalPages > 1}">
            <nav class="mt-4">
                <ul class="pagination justify-content-center">
                    <c:forEach begin="0" end="${vendors.totalPages - 1}" var="i">
                        <li class="page-item ${vendors.number == i ? 'active' : ''}">
                            <a class="page-link" href="?page=${i}&status=${selectedStatus}">${i + 1}</a>
                        </li>
                    </c:forEach>
                </ul>
            </nav>
        </c:if>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
