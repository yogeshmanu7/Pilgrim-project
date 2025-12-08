<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<c:set var="pageTitle" value="All Payments" scope="request"/>
<c:set var="currentPage" value="scholars" scope="request"/>
<%@ include file="../common/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2 class="mb-0"><i class="fas fa-money-bill-wave me-2 text-teal"></i>All Payments</h2>
    <div>
        <a href="${pageContext.request.contextPath}/admin/scholars" class="btn btn-secondary me-2">
            <i class="fas fa-arrow-left me-1"></i>Back to Scholars
        </a>
        <a href="${pageContext.request.contextPath}/admin/scholars/payments/settle" class="btn btn-info">
            <i class="fas fa-hand-holding-usd me-1"></i>Pending Settlements
        </a>
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
                        <th>Scholar</th>
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
                            <td>
                                <strong>${payment.booking.scholar.user.name}</strong><br>
                                <small class="text-muted">${payment.booking.scholar.type}</small>
                            </td>
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
                            <td colspan="12" class="text-center py-4">
                                <p class="mb-0">No payments found</p>
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>

