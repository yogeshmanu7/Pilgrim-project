<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<c:set var="pageTitle" value="Scholar Bookings" scope="request"/>
<c:set var="currentPage" value="scholar_bookings" scope="request"/>
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
    
    .text-purple {
        color: var(--text-cream) !important;
    }
    
    .table {
        border: 2px solid var(--border-wine);
        border-radius: 8px;
        overflow: hidden;
    }
    
    .table-striped tbody tr:nth-of-type(odd) {
        background-color: rgba(114, 47, 55, 0.05);
    }
    
    .table-hover tbody tr:hover {
        background-color: rgba(114, 47, 55, 0.1);
    }
    
    thead {
        background: linear-gradient(135deg, var(--wine) 0%, var(--wine-dark) 100%) !important;
        color: var(--text-cream) !important;
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
    .badge.bg-info {
        background: var(--wine) !important;
        color: var(--text-cream);
    }
    
    .badge.bg-success {
        background: #198754 !important;
        color: white;
    }
    
    .badge.bg-danger {
        background: #dc3545 !important;
        color: white;
    }
    
    .badge.bg-primary {
        background: var(--wine) !important;
        color: var(--text-cream);
    }
    
    .badge.bg-warning {
        background: #ffc107 !important;
        color: #212529;
    }
    
    .text-muted {
        color: var(--wine-light) !important;
    }
</style>

<!-- Background Pattern -->
<div class="bg-pattern"></div>

<div class="container-fluid mt-4">
    <div class="card shadow-sm">
        <div class="card-header d-flex justify-content-between align-items-center">
            <h5 class="card-title mb-0"><i class="fas fa-calendar-check me-2 text-purple"></i>All Scholar Bookings</h5>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover table-striped align-middle">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Customer</th>
                            <th>Scholar</th>
                            <th>Service Date</th>
                            <th>Service Type</th>
                            <th>Amount</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${bookings}" var="booking">
                            <tr>
                                <td>#${booking.id}</td>
                                <td>
                                    <strong>${booking.customer.name}</strong><br>
                                    <small class="text-muted">${booking.customer.email}</small>
                                </td>
                                <td>
                                    <strong>${booking.scholar.user.name}</strong><br>
                                    <small class="text-muted">${booking.scholar.type}</small>
                                </td>
                                <td>${booking.serviceDate != null ? booking.serviceDate.toString().replace('T', ' ').substring(0, 16) : 'N/A'}</td>
                                <td><span class="badge bg-info">${booking.serviceType}</span></td>
                                <td>₹<fmt:formatNumber value="${booking.totalAmount}" pattern="#,##,##0.00"/></td>
                                <td>
                                    <span class="badge bg-${booking.status == 'CONFIRMED' ? 'success' : booking.status == 'REJECTED' ? 'danger' : booking.status == 'COMPLETED' ? 'primary' : 'warning'}">
                                        ${booking.status}
                                    </span>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/scholars/bookings/view/${booking.id}" 
                                       class="btn btn-sm btn-info" title="View Details">
                                        <i class="fas fa-eye"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty bookings}">
                            <tr>
                                <td colspan="8" class="text-center">No bookings found.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>