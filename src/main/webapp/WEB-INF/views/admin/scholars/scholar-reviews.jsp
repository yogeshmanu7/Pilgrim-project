<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<c:set var="pageTitle" value="Scholar Reviews" scope="request"/>
<c:set var="currentPage" value="scholars" scope="request"/>
<%@ include file="../common/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2 class="mb-0">
        <i class="fas fa-star me-2 text-teal"></i>
        Reviews for ${scholar.user.name}
    </h2>
    <div>
        <a href="${pageContext.request.contextPath}/admin/scholars/view/${scholar.id}" class="btn btn-secondary me-2">
            <i class="fas fa-arrow-left me-1"></i>Back to Scholar
        </a>
        <a href="${pageContext.request.contextPath}/admin/scholars" class="btn btn-outline-secondary">
            <i class="fas fa-list me-1"></i>All Scholars
        </a>
    </div>
</div>

<div class="card mb-3">
    <div class="card-body">
        <div class="row">
            <div class="col-md-3">
                <strong>Type:</strong> 
                <span class="badge ${scholar.type == 'ASTROLOGER' ? 'bg-info' : 'bg-purple'}">
                    ${scholar.type == 'ASTROLOGER' ? 'Astrologer' : 'Spiritual Scholar'}
                </span>
            </div>
            <div class="col-md-3">
                <strong>Email:</strong> ${scholar.user.email}
            </div>
            <div class="col-md-3">
                <strong>Total Reviews:</strong> ${reviews.size()}
            </div>
            <div class="col-md-3">
                <strong>Rating:</strong> 
                <c:if test="${scholar.rating != null}">
                    <i class="fas fa-star text-warning"></i> ${scholar.rating} / 5.0
                </c:if>
                <c:if test="${scholar.rating == null}">
                    <span class="text-muted">No rating yet</span>
                </c:if>
            </div>
        </div>
    </div>
</div>

<div class="card">
    <div class="card-header">
        <h5 class="card-title mb-0">Customer Reviews</h5>
    </div>
    <div class="card-body">
        <div class="row">
            <c:forEach items="${reviews}" var="review">
                <div class="col-md-6 mb-4">
                    <div class="card h-100">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-start mb-3">
                                <div>
                                    <h5 class="card-title mb-1">${review.customer.name}</h5>
                                    <p class="text-muted small mb-0">${review.customer.email}</p>
                                </div>
                                <div class="text-end">
                                    <div class="mb-1">
                                        <c:forEach begin="1" end="5" var="i">
                                            <i class="fas fa-star ${i <= review.rating ? 'text-warning' : 'text-muted'}"></i>
                                        </c:forEach>
                                    </div>
                                    <small class="text-muted">
                                        ${review.createdAt != null ? review.createdAt.toString().replace('T', ' ').substring(0, 16) : 'N/A'}
                                    </small>
                                </div>
                            </div>
                            <c:if test="${not empty review.comment}">
                                <p class="card-text">${review.comment}</p>
                            </c:if>
                            <c:if test="${empty review.comment}">
                                <p class="card-text text-muted"><em>No comment provided</em></p>
                            </c:if>
                            <div class="mt-3">
                                <small class="text-muted">
                                    Booking ID: #${review.booking.id}
                                </small>
                                <a href="${pageContext.request.contextPath}/admin/scholars/bookings/view/${review.booking.id}" 
                                   class="btn btn-sm btn-info float-end">
                                    <i class="fas fa-eye me-1"></i>View Booking
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty reviews}">
                <div class="col-12">
                    <div class="text-center py-5">
                        <i class="fas fa-star fa-3x text-muted mb-3"></i>
                        <p class="text-muted">No reviews found for this scholar</p>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>

