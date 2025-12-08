<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Earnings - GlobalPiligrim</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        .scholar-theme {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 40px 0;
            margin-bottom: 30px;
        }
        .scholar-card {
            border-left: 4px solid #667eea;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.2);
        }
    </style>
</head>
<body>
    <div class="scholar-theme">
        <div class="container">
            <h1 class="text-white mb-0" style="font-size: 36px;">💰 Earnings Dashboard</h1>
            <p class="text-white mt-2" style="opacity: 0.9; font-size: 18px;">${scholar.user.name}</p>
        </div>
    </div>
    
    <div class="container">
        <div class="row g-4 mb-4">
            <div class="col-md-4">
                <div class="card scholar-card text-center">
                    <div class="card-body">
                        <h3 class="text-primary">Total Earnings</h3>
                        <p class="display-4 text-primary fw-bold">₹<fmt:formatNumber value="${totalEarnings != null ? totalEarnings : 0}" pattern="#,##,##0.00"/></p>
                        <p class="text-muted">Settled Payments</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card scholar-card text-center">
                    <div class="card-body">
                        <h3 class="text-primary">Pending Earnings</h3>
                        <p class="display-4 text-danger fw-bold">₹<fmt:formatNumber value="${pendingEarnings != null ? pendingEarnings : 0}" pattern="#,##,##0.00"/></p>
                        <p class="text-muted">Awaiting Settlement</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card scholar-card text-center">
                    <div class="card-body">
                        <h3 class="text-primary">Total Payments</h3>
                        <p class="display-4 text-primary fw-bold">${payments != null ? payments.size() : 0}</p>
                        <p class="text-muted">All Transactions</p>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="card scholar-card">
            <div class="card-header bg-primary text-white">
                <h2 class="card-title mb-0">Payment History</h2>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${empty payments || payments.size() == 0}">
                        <p class="text-center text-muted">No payments found.</p>
                    </c:when>
                    <c:otherwise>
                        <div class="row g-3">
                            <c:forEach var="payment" items="${payments}">
                                <div class="col-12">
                                    <div class="card scholar-card">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between align-items-start">
                                                <div>
                                                    <h5 class="text-primary">${payment.booking.customer.name}</h5>
                                                    <p class="mb-1"><strong>Total Amount:</strong> ₹<fmt:formatNumber value="${payment.amount}" pattern="#,##,##0.00"/></p>
                                                    <p class="mb-1"><strong>Your Earnings:</strong> ₹<fmt:formatNumber value="${payment.scholarAmount}" pattern="#,##,##0.00"/></p>
                                                    <p class="mb-1"><strong>Platform Commission:</strong> ₹<fmt:formatNumber value="${payment.platformCommission}" pattern="#,##,##0.00"/></p>
                                                    <p class="mb-1"><strong>Status:</strong> 
                                                        <span class="badge bg-${payment.status == 'SETTLED' ? 'success' : payment.status == 'PAID' ? 'warning' : payment.status == 'REFUNDED' ? 'danger' : 'secondary'}">
                                                            ${payment.status}
                                                        </span>
                                                    </p>
                                                    <p class="mb-1"><strong>Date:</strong> ${payment.createdAt != null ? payment.createdAt.toString().replace('T', ' ').substring(0, 16) : 'N/A'}</p>
                                                    <c:if test="${not empty payment.settlementDate}">
                                                        <p class="mb-0"><strong>Settled On:</strong> ${payment.settlementDate.toString().replace('T', ' ').substring(0, 16)}</p>
                                                    </c:if>
                                                </div>
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
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

