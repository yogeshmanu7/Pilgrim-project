<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment History - GlobalPiligrim</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        .user-theme {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            padding: 40px 0;
            margin-bottom: 30px;
        }
        .user-card {
            border-left: 4px solid #11998e;
            box-shadow: 0 4px 15px rgba(17, 153, 142, 0.2);
        }
    </style>
</head>
<body>
    <div class="user-theme">
        <div class="container">
            <h1 class="text-white mb-0" style="font-size: 36px;">💳 Payment History</h1>
        </div>
    </div>
    
    <div class="container">
        <div class="card user-card">
            <div class="card-header bg-success text-white">
                <h2 class="card-title mb-0">My Payments</h2>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${empty payments || payments.size() == 0}">
                        <p class="text-muted">No payment history found.</p>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Scholar</th>
                                        <th>Amount</th>
                                        <th>Status</th>
                                        <th>Date</th>
                                        <th>Transaction ID</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="payment" items="${payments}">
                                        <tr>
                                            <td>${payment.booking.scholar.user.name}</td>
                                            <td>₹<fmt:formatNumber value="${payment.amount}" pattern="#,##,##0.00"/></td>
                                            <td>
                                                <span class="badge bg-${payment.status == 'PAID' ? 'success' : payment.status == 'PENDING' ? 'warning' : 'secondary'}">
                                                    ${payment.status}
                                                </span>
                                            </td>
                                            <td>${payment.createdAt != null ? payment.createdAt.toString().replace('T', ' ').substring(0, 16) : 'N/A'}</td>
                                            <td>${payment.transactionId != null ? payment.transactionId : 'N/A'}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
                
                <div class="mt-3">
                    <a href="${pageContext.request.contextPath}/customer/scholar/dashboard" class="btn btn-outline-success">
                        <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

