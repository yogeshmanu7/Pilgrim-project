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
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&family=Merriweather:wght@300;400;700&display=swap" rel="stylesheet">
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
        
        body {
            font-family: 'Poppins', sans-serif;
            background: var(--dutch-white);
            color: var(--text-wine);
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
        
        .container {
            position: relative;
            z-index: 1;
        }
        
        .scholar-theme {
            background: linear-gradient(135deg, var(--wine) 0%, var(--wine-dark) 100%);
            padding: 40px 0;
            margin-bottom: 30px;
        }
        .scholar-card {
            background: white;
            border: 2px solid var(--border-wine);
            border-left: 4px solid var(--border-wine);
            border-radius: 12px;
            box-shadow: var(--shadow-wine);
        }
        
        h1, h2, h3, h4, h5, h6 {
            font-family: 'Merriweather', serif;
            color: var(--text-wine);
        }
        
        .text-primary {
            color: var(--text-wine) !important;
        }
        
        .text-muted {
            color: var(--wine-light) !important;
        }
        
        .text-danger {
            color: #dc3545 !important;
        }
        
        .bg-primary {
            background: linear-gradient(135deg, var(--wine) 0%, var(--wine-dark) 100%) !important;
            color: var(--text-cream) !important;
        }
        
        /* Badge Styling */
        .badge.bg-success {
            background: #198754 !important;
            color: white;
        }
        
        .badge.bg-warning {
            background: #ffc107 !important;
            color: #212529;
        }
        
        .badge.bg-danger {
            background: #dc3545 !important;
            color: white;
        }
        
        .badge.bg-secondary {
            background: #6c757d !important;
            color: white;
        }
        
        .display-4 {
            color: var(--text-wine) !important;
        }
        
        .display-4.text-danger {
            color: #dc3545 !important;
        }
        
        /* Card content styling */
        .card-title {
            color: var(--text-cream) !important;
        }
    </style>
</head>
<body>
    <!-- Background Pattern -->
    <div class="bg-pattern"></div>
    
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
            <div class="card-header bg-primary">
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