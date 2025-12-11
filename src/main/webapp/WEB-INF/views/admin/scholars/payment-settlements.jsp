<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<c:set var="pageTitle" value="Payment Settlements" scope="request"/>
<c:set var="currentPage" value="scholar_payments" scope="request"/>
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
    
    .text-primary {
        color: var(--text-wine) !important;
    }
    
    .btn-success {
        background: linear-gradient(135deg, var(--wine) 0%, var(--wine-dark) 100%);
        border: none;
        color: var(--text-cream);
        font-weight: 600;
        border-radius: 8px;
    }
    
    .btn-success:hover {
        background: linear-gradient(135deg, var(--wine-dark) 0%, var(--wine) 100%);
        color: var(--text-cream);
        transform: translateY(-2px);
        box-shadow: var(--shadow-wine);
    }
    
    .alert-info {
        background: rgba(114, 47, 55, 0.05);
        border: 2px solid var(--border-wine);
        color: var(--text-wine);
        border-radius: 8px;
    }
    
    .alert-info i {
        color: var(--text-wine);
    }
</style>

<!-- Background Pattern -->
<div class="bg-pattern"></div>

<div class="container-fluid mt-4">
    <div class="card shadow-sm">
        <div class="card-header d-flex justify-content-between align-items-center">
            <h5 class="card-title mb-0"><i class="fas fa-money-bill-wave me-2 text-purple"></i>Pending Payment Settlements</h5>
        </div>
        <div class="card-body">
            <c:choose>
                <c:when test="${empty pendingPayments || pendingPayments.size() == 0}">
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle me-2"></i>No pending settlements.
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="row g-3">
                        <c:forEach items="${pendingPayments}" var="payment">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-start">
                                            <div>
                                                <h5 class="text-primary">${payment.booking.scholar.user.name}</h5>
                                                <p class="mb-1"><strong>Customer:</strong> ${payment.booking.customer.name}</p>
                                                <p class="mb-1"><strong>Total Amount:</strong> ₹<fmt:formatNumber value="${payment.amount}" pattern="#,##,##0.00"/></p>
                                                <p class="mb-1"><strong>Scholar Amount:</strong> ₹<fmt:formatNumber value="${payment.scholarAmount}" pattern="#,##,##0.00"/></p>
                                                <p class="mb-1"><strong>Platform Commission:</strong> ₹<fmt:formatNumber value="${payment.platformCommission}" pattern="#,##,##0.00"/></p>
                                                <p class="mb-1"><strong>Payment Date:</strong> ${payment.paymentDate != null ? payment.paymentDate.toString().replace('T', ' ').substring(0, 16) : 'N/A'}</p>
                                                <p class="mb-0"><strong>Transaction ID:</strong> ${payment.transactionId != null ? payment.transactionId : 'N/A'}</p>
                                            </div>
                                            <form method="post" action="${pageContext.request.contextPath}/admin/scholars/payments/settle" style="display: inline;">
                                                <input type="hidden" name="paymentId" value="${payment.id}">
                                                <button type="submit" class="btn btn-success">
                                                    <i class="fas fa-check me-2"></i>Settle Payment
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>