<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<c:set var="pageTitle" value="Scholar Reviews" scope="request"/>
<c:set var="currentPage" value="scholars" scope="request"/>
<%@ include file="../common/header.jsp" %>

<style>
    :root {
        --dutch-white: #EFDFBB;
        --wine: #722F37;
        --wine-dark: #5A242B;
        --wine-light: rgba(114, 47, 55, 0.8);
        --wine-transparent: rgba(114, 47, 55, 0.1);
        --text-wine: #722F37;
        --text-cream: #EFDFBB;
        --border-wine: #722F37;
        --shadow-wine: 0 10px 30px rgba(114, 47, 55, 0.2);
    }
    
    /* Background Pattern */
    .bg-pattern {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: 
            radial-gradient(circle at 10% 20%, rgba(114, 47, 55, 0.05) 0%, transparent 50%),
            radial-gradient(circle at 90% 80%, rgba(114, 47, 55, 0.05) 0%, transparent 50%),
            repeating-linear-gradient(45deg, 
                transparent, 
                transparent 20px, 
                rgba(114, 47, 55, 0.02) 20px, 
                rgba(114, 47, 55, 0.02) 40px);
        z-index: 0;
    }
    
    body {
        position: relative;
    }
    
    body > *:not(.bg-pattern) {
        position: relative;
        z-index: 1;
    }
    
    .card {
        border: 2px solid var(--border-wine);
        border-radius: 12px;
        box-shadow: var(--shadow-wine);
        background: white;
    }
    
    .card-header {
        background: linear-gradient(135deg, var(--wine) 0%, var(--wine-dark) 100%) !important;
        color: var(--text-cream) !important;
        border-bottom: 2px solid var(--border-wine);
    }
    
    .card-title {
        color: var(--text-cream) !important;
    }
    
    .text-teal {
        color: var(--text-cream) !important;
    }
    
    .text-primary {
        color: var(--text-wine) !important;
    }
    
    .btn-secondary {
        background: var(--wine);
        border: none;
        color: var(--text-cream);
        border-radius: 6px;
    }
    
    .btn-secondary:hover {
        background: var(--wine-dark);
        color: var(--text-cream);
    }
    
    .btn-outline-secondary {
        border: 2px solid var(--border-wine);
        color: var(--text-wine);
        border-radius: 6px;
    }
    
    .btn-outline-secondary:hover {
        background: var(--wine);
        color: var(--text-cream);
        border-color: var(--wine);
    }
    
    .btn-info {
        background: linear-gradient(135deg, var(--wine) 0%, var(--wine-dark) 100%);
        border: none;
        color: var(--text-cream);
        border-radius: 6px;
    }
    
    .btn-info:hover {
        background: linear-gradient(135deg, var(--wine-dark) 0%, var(--wine) 100%);
        color: var(--text-cream);
        transform: translateY(-1px);
        box-shadow: 0 4px 15px rgba(114, 47, 55, 0.3);
    }
    
    /* Badge Styling */
    .badge.bg-info, .badge.bg-purple {
        background: var(--wine) !important;
        color: var(--text-cream);
    }
    
    .text-muted {
        color: var(--wine-light) !important;
    }
    
    .text-warning {
        color: #ffc107 !important;
    }
    
    .card-text.text-muted {
        color: var(--wine-light) !important;
    }
    
    .float-end {
        color: var(--text-cream);
    }
    
    h2 {
        color: var(--text-wine);
    }
</style>

<!-- Background Pattern -->
<div class="bg-pattern"></div>

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