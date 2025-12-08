<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<c:set var="pageTitle" value="Payment Settlements" scope="request"/>
<c:set var="currentPage" value="scholar_payments" scope="request"/>
<%@ include file="../common/header.jsp" %>

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

