<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<c:set var="pageTitle" value="Scholar Details" scope="request"/>
<c:set var="currentPage" value="scholars" scope="request"/>
<%@ include file="../common/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2 class="mb-0"><i class="fas fa-user-graduate me-2 text-teal"></i>Scholar Details</h2>
    <a href="${pageContext.request.contextPath}/admin/scholars" class="btn btn-secondary">
        <i class="fas fa-arrow-left me-1"></i>Back to List
    </a>
</div>

<div class="row mb-4">
    <!-- Scholar Information Card -->
    <div class="col-md-4">
        <div class="card">
            <div class="card-header bg-teal text-white">
                <h5 class="card-title mb-0"><i class="fas fa-user me-2"></i>Scholar Information</h5>
            </div>
            <div class="card-body text-center">
                <c:if test="${not empty scholar.profilePhotoPath}">
                    <img src="${pageContext.request.contextPath}/uploads/${scholar.profilePhotoPath}" 
                         alt="${scholar.user.name}" 
                         class="rounded-circle mb-3" 
                         style="width: 120px; height: 120px; object-fit: cover;">
                </c:if>
                <c:if test="${empty scholar.profilePhotoPath}">
                    <div class="rounded-circle bg-secondary d-flex align-items-center justify-content-center mx-auto mb-3" 
                         style="width: 120px; height: 120px;">
                        <i class="fas fa-user text-white" style="font-size: 48px;"></i>
                    </div>
                </c:if>
                <h4>${scholar.user.name}</h4>
                <p class="mb-2">
                    <span class="badge ${scholar.type == 'ASTROLOGER' ? 'bg-info' : 'bg-purple'}">
                        ${scholar.type == 'ASTROLOGER' ? 'Astrologer' : 'Spiritual Scholar'}
                    </span>
                </p>
                <p class="mb-1"><strong>Email:</strong> ${scholar.user.email}</p>
                <p class="mb-1"><strong>Phone:</strong> ${scholar.user.phone}</p>
                <p class="mb-1"><strong>Experience:</strong> ${scholar.experienceYears != null ? scholar.experienceYears : 0} years</p>
                <p class="mb-1"><strong>Base Price:</strong> ₹<fmt:formatNumber value="${scholar.basePrice != null ? scholar.basePrice : 0}" pattern="#,##,##0.00"/></p>
                <p class="mb-1">
                    <strong>Status:</strong> 
                    <span class="badge badge-${scholar.status == 'APPROVED' ? 'approved' : scholar.status == 'REJECTED' ? 'rejected' : 'pending'}">
                        ${scholar.status}
                    </span>
                </p>
                <p class="mb-1">
                    <strong>Rating:</strong> 
                    <c:if test="${scholar.rating != null}">
                        <i class="fas fa-star text-warning"></i> ${scholar.rating} (${scholar.totalReviews != null ? scholar.totalReviews : 0} reviews)
                    </c:if>
                    <c:if test="${scholar.rating == null}">
                        <span class="text-muted">No rating yet</span>
                    </c:if>
                </p>
                <p class="mb-0">
                    <strong>Available:</strong> 
                    <span class="badge ${scholar.isAvailable != null && scholar.isAvailable ? 'bg-success' : 'bg-secondary'}">
                        ${scholar.isAvailable != null && scholar.isAvailable ? 'Yes' : 'No'}
                    </span>
                </p>
            </div>
        </div>
    </div>
    
    <!-- Statistics Card -->
    <div class="col-md-8">
        <div class="row">
            <div class="col-md-6 mb-3">
                <div class="card bg-primary text-white">
                    <div class="card-body">
                        <h5 class="card-title"><i class="fas fa-calendar-check me-2"></i>Total Bookings</h5>
                        <h2 class="mb-0">${totalBookings}</h2>
                        <small>Confirmed: ${confirmedBookings} | Completed: ${completedBookings}</small>
                    </div>
                </div>
            </div>
            <div class="col-md-6 mb-3">
                <div class="card bg-success text-white">
                    <div class="card-body">
                        <h5 class="card-title"><i class="fas fa-money-bill-wave me-2"></i>Total Revenue</h5>
                        <h2 class="mb-0">₹<fmt:formatNumber value="${totalRevenue != null ? totalRevenue : 0}" pattern="#,##,##0.00"/></h2>
                    </div>
                </div>
            </div>
            <div class="col-md-6 mb-3">
                <div class="card bg-info text-white">
                    <div class="card-body">
                        <h5 class="card-title"><i class="fas fa-hand-holding-usd me-2"></i>Settled Amount</h5>
                        <h2 class="mb-0">₹<fmt:formatNumber value="${totalSettled != null ? totalSettled : 0}" pattern="#,##,##0.00"/></h2>
                    </div>
                </div>
            </div>
            <div class="col-md-6 mb-3">
                <div class="card bg-warning text-white">
                    <div class="card-body">
                        <h5 class="card-title"><i class="fas fa-clock me-2"></i>Pending Settlement</h5>
                        <h2 class="mb-0">₹<fmt:formatNumber value="${pendingSettlement != null ? pendingSettlement : 0}" pattern="#,##,##0.00"/></h2>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Quick Actions -->
        <div class="card">
            <div class="card-header">
                <h5 class="card-title mb-0"><i class="fas fa-bolt me-2"></i>Quick Actions</h5>
            </div>
            <div class="card-body">
                <a href="${pageContext.request.contextPath}/admin/scholars/${scholar.id}/bookings" class="btn btn-primary me-2 mb-2">
                    <i class="fas fa-calendar-check me-1"></i>View Bookings
                </a>
                <a href="${pageContext.request.contextPath}/admin/scholars/${scholar.id}/payments" class="btn btn-success me-2 mb-2">
                    <i class="fas fa-money-bill-wave me-1"></i>View Payments
                </a>
                <a href="${pageContext.request.contextPath}/admin/scholars/${scholar.id}/reviews" class="btn btn-warning me-2 mb-2">
                    <i class="fas fa-star me-1"></i>View Reviews
                </a>
                <c:if test="${scholar.status == 'PENDING_APPROVAL'}">
                    <form action="${pageContext.request.contextPath}/admin/scholars/approve" method="post" style="display: inline;">
                        <input type="hidden" name="scholarId" value="${scholar.id}">
                        <button type="submit" class="btn btn-success me-2 mb-2">
                            <i class="fas fa-check me-1"></i>Approve
                        </button>
                    </form>
                </c:if>
            </div>
        </div>
    </div>
</div>

<!-- Additional Details -->
<div class="row">
    <div class="col-md-12">
        <div class="card">
            <div class="card-header">
                <h5 class="card-title mb-0"><i class="fas fa-info-circle me-2"></i>Additional Information</h5>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <p><strong>Specializations:</strong></p>
                        <c:if test="${not empty scholar.specializations}">
                            <c:forEach var="spec" items="${scholar.specializations}">
                                <span class="badge bg-secondary me-1">${spec}</span>
                            </c:forEach>
                        </c:if>
                        <c:if test="${empty scholar.specializations}">
                            <span class="text-muted">No specializations listed</span>
                        </c:if>
                    </div>
                    <div class="col-md-6">
                        <p><strong>Languages:</strong></p>
                        <c:if test="${not empty scholar.languages}">
                            <c:forEach var="lang" items="${scholar.languages}">
                                <span class="badge bg-info me-1">${lang}</span>
                            </c:forEach>
                        </c:if>
                        <c:if test="${empty scholar.languages}">
                            <span class="text-muted">No languages listed</span>
                        </c:if>
                    </div>
                    <div class="col-md-12 mt-3">
                        <p><strong>Service Areas:</strong></p>
                        <p>${not empty scholar.serviceAreas ? scholar.serviceAreas : 'Not specified'}</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>

