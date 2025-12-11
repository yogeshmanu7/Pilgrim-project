<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<c:set var="pageTitle" value="Scholar Payments" scope="request"/>
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
    
    .btn-success {
        background: var(--wine);
        border: none;
        color: var(--text-cream);
        border-radius: 6px;
    }
    
    .btn-success:hover {
        background: var(--wine-dark);
        color: var(--text-cream);
    }
    
    .table {
        border: 2px solid var(--border-wine);
        border-radius: 8px;
        overflow: hidden;
    }
    
    .table-hover tbody tr:hover {
        background-color: rgba(114, 47, 55, 0.1);
    }
    
    thead {
        background: linear-gradient(135deg, var(--wine) 0%, var(--wine-dark) 100%) !important;
        color: var(--text-cream) !important;
    }
    
    /* Badge Styling */
    .badge.bg-info, .badge.bg-purple {
        background: var(--wine) !important;
        color: var(--text-cream);
    }
    
    .badge.bg-success {
        background: #198754 !important;
        color: white;
    }
    
    .badge.bg-warning {
        background: #ffc107 !important;
        color: #212529;
    }
    
    .badge.bg-secondary {
        background: #6c757d !important;
        color: white;
    }
    
    h2 {
        color: var(--text-wine);
    }
</style>

<!-- Background Pattern -->
<div class="bg-pattern"></div>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2 class="mb-0">
        <i class="fas fa-money-bill-wave me-2 text-teal"></i>
        Payments for ${scholar.user.name}
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
                <strong>Total Payments:</strong> ${payments.size()}
            </div>
            <div class="col-md-3">
                <strong>Total Revenue:</strong> 
                ₹<fmt:formatNumber value="${totalRevenue != null ? totalRevenue : 0}" pattern="#,##,##0.00"/>
            </div>
        </div>
    </div>
</div>

<div class="card">
    <div class="card-header">
        <h5 class="card-title mb-0">Payment History</h5>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Customer</th>
                        <th>Booking ID</th>
                        <th>Amount</th>
                        <th>Platform Commission</th>
                        <th>Scholar Amount</th>
                        <th>Status</th>
                        <th>Payment Date</th>
                        <th>Settlement Date</th>
                        <th>Transaction ID</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${payments}" var="payment">
                        <tr>
                            <td>#${payment.id}</td>
                            <td>${payment.booking.customer.name}</td>
                            <td>#${payment.booking.id}</td>
                            <td><strong>₹<fmt:formatNumber value="${payment.amount}" pattern="#,##,##0.00"/></strong></td>
                            <td>₹<fmt:formatNumber value="${payment.platformCommission != null ? payment.platformCommission : 0}" pattern="#,##,##0.00"/></td>
                            <td><strong>₹<fmt:formatNumber value="${payment.scholarAmount != null ? payment.scholarAmount : 0}" pattern="#,##,##0.00"/></strong></td>
                            <td>
                                <span class="badge bg-${payment.status == 'PAID' ? 'success' : payment.status == 'SETTLED' ? 'info' : payment.status == 'PENDING' ? 'warning' : 'secondary'}">
                                    ${payment.status}
                                </span>
                            </td>
                            <td>${payment.paymentDate != null ? payment.paymentDate.toString().replace('T', ' ').substring(0, 16) : 'N/A'}</td>
                            <td>${payment.settlementDate != null ? payment.settlementDate.toString().replace('T', ' ').substring(0, 16) : 'Pending'}</td>
                            <td>${payment.transactionId != null ? payment.transactionId : 'N/A'}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/scholars/bookings/view/${payment.booking.id}" 
                                   class="btn btn-sm btn-info" title="View Booking">
                                    <i class="fas fa-eye"></i>
                                </a>
                                <c:if test="${payment.status == 'PAID' && payment.settlementDate == null}">
                                    <form action="${pageContext.request.contextPath}/admin/scholars/payments/settle" method="post" style="display: inline;">
                                        <input type="hidden" name="paymentId" value="${payment.id}">
                                        <button type="submit" class="btn btn-sm btn-success" title="Settle Payment">
                                            <i class="fas fa-hand-holding-usd"></i>
                                        </button>
                                    </form>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty payments}">
                        <tr>
                            <td colspan="11" class="text-center py-4">
                                <p class="mb-0">No payments found for this scholar</p>
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>