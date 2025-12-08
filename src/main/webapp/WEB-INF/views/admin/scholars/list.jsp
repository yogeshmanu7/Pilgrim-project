<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<c:set var="pageTitle" value="Scholars & Astrologers" scope="request"/>
<c:set var="currentPage" value="scholars" scope="request"/>
<%@ include file="../common/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2 class="mb-0"><i class="fas fa-user-graduate me-2 text-teal"></i>Scholars & Astrologers</h2>
    <div>
        <a href="${pageContext.request.contextPath}/admin/scholars/bookings" class="btn btn-outline-primary me-2">
            <i class="fas fa-calendar-check me-1"></i>All Bookings
        </a>
        <a href="${pageContext.request.contextPath}/admin/scholars/payments" class="btn btn-outline-success me-2">
            <i class="fas fa-money-bill-wave me-1"></i>All Payments
        </a>
        <a href="${pageContext.request.contextPath}/admin/scholars/reviews" class="btn btn-outline-warning me-2">
            <i class="fas fa-star me-1"></i>All Reviews
        </a>
        <a href="${pageContext.request.contextPath}/admin/scholars/payments/settle" class="btn btn-outline-info">
            <i class="fas fa-hand-holding-usd me-1"></i>Settlements
        </a>
    </div>
</div>

<div class="card">
    <div class="card-header">
        <h5 class="card-title mb-0">All Scholars</h5>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Photo</th>
                        <th>Name</th>
                        <th>Type</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Experience</th>
                        <th>Price</th>
                        <th>Status</th>
                        <th>Rating</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${scholars}" var="scholar">
                        <tr>
                            <td>#${scholar.id}</td>
                            <td>
                                <c:if test="${not empty scholar.profilePhotoPath}">
                                    <img src="${pageContext.request.contextPath}/uploads/${scholar.profilePhotoPath}" 
                                         alt="${scholar.user.name}" 
                                         style="width: 40px; height: 40px; border-radius: 50%; object-fit: cover;">
                                </c:if>
                                <c:if test="${empty scholar.profilePhotoPath}">
                                    <div class="rounded-circle bg-secondary d-flex align-items-center justify-content-center" 
                                         style="width: 40px; height: 40px;">
                                        <i class="fas fa-user text-white"></i>
                                    </div>
                                </c:if>
                            </td>
                            <td><strong>${scholar.user.name}</strong></td>
                            <td>
                                <span class="badge ${scholar.type == 'ASTROLOGER' ? 'bg-info' : 'bg-purple'}">
                                    ${scholar.type == 'ASTROLOGER' ? 'Astrologer' : 'Spiritual Scholar'}
                                </span>
                            </td>
                            <td>${scholar.user.email}</td>
                            <td>${scholar.user.phone}</td>
                            <td>${scholar.experienceYears != null ? scholar.experienceYears : 0} years</td>
                            <td>₹${scholar.basePrice != null ? scholar.basePrice : 0}</td>
                            <td>
                                <span class="badge badge-${scholar.status == 'APPROVED' ? 'approved' : scholar.status == 'REJECTED' ? 'rejected' : 'pending'}">
                                    ${scholar.status}
                                </span>
                            </td>
                            <td>
                                <c:if test="${scholar.rating != null}">
                                    <i class="fas fa-star text-warning"></i> ${scholar.rating}
                                </c:if>
                                <c:if test="${scholar.rating == null}">
                                    <span class="text-muted">No rating</span>
                                </c:if>
                            </td>
                            <td>
                                <div class="btn-group" role="group">
                                    <a href="${pageContext.request.contextPath}/admin/scholars/view/${scholar.id}" 
                                       class="btn btn-sm btn-info" title="View Details">
                                        <i class="fas fa-eye"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/scholars/${scholar.id}/bookings" 
                                       class="btn btn-sm btn-primary" title="View Bookings">
                                        <i class="fas fa-calendar-check"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/scholars/${scholar.id}/payments" 
                                       class="btn btn-sm btn-success" title="View Payments">
                                        <i class="fas fa-money-bill-wave"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/scholars/${scholar.id}/reviews" 
                                       class="btn btn-sm btn-warning" title="View Reviews">
                                        <i class="fas fa-star"></i>
                                    </a>
                                    <c:if test="${scholar.status == 'PENDING_APPROVAL'}">
                                        <form action="${pageContext.request.contextPath}/admin/scholars/approve" method="post" style="display: inline;">
                                            <input type="hidden" name="scholarId" value="${scholar.id}">
                                            <button type="submit" class="btn btn-sm btn-success" title="Approve">
                                                <i class="fas fa-check"></i>
                                            </button>
                                        </form>
                                        <button type="button" class="btn btn-sm btn-danger" 
                                                data-bs-toggle="modal" data-bs-target="#rejectModal${scholar.id}" title="Reject">
                                            <i class="fas fa-times"></i>
                                        </button>
                                    </c:if>
                                </div>
                            </td>
                        </tr>
                        
                        <!-- Reject Modal -->
                        <div class="modal fade" id="rejectModal${scholar.id}" tabindex="-1">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <form action="${pageContext.request.contextPath}/admin/scholars/reject" method="post">
                                        <div class="modal-header">
                                            <h5 class="modal-title">Reject Scholar</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                        </div>
                                        <div class="modal-body">
                                            <input type="hidden" name="scholarId" value="${scholar.id}">
                                            <div class="mb-3">
                                                <label class="form-label">Rejection Reason</label>
                                                <textarea name="rejectionReason" class="form-control" rows="3" required></textarea>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                            <button type="submit" class="btn btn-danger">Reject</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty scholars}">
                        <tr>
                            <td colspan="11" class="text-center py-4">
                                <p class="mb-0">No scholars found</p>
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>

