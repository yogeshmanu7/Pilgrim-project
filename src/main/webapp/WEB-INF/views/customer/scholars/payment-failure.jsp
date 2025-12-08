<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Failed - GlobalPiligrim</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        .user-theme {
            background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
            padding: 40px 0;
            margin-bottom: 30px;
        }
        .error-icon {
            width: 100px;
            height: 100px;
            background: #ef4444;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            font-size: 48px;
            color: white;
        }
    </style>
</head>
<body>
    <div class="user-theme">
        <div class="container text-center">
            <div class="error-icon">
                <i class="fas fa-times"></i>
            </div>
            <h1 class="text-white mb-0" style="font-size: 36px;">Payment Failed</h1>
        </div>
    </div>
    
    <div class="container">
        <div class="card mx-auto" style="max-width: 600px;">
            <div class="card-body text-center">
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-circle me-2"></i>${error}
                    </div>
                </c:if>
                
                <p class="lead">We're sorry, but your payment could not be processed. Please try again.</p>
                
                <div class="mt-4">
                    <a href="${pageContext.request.contextPath}/customer/scholar/dashboard" class="btn btn-primary btn-lg me-2">
                        <i class="fas fa-arrow-left me-2"></i>Go to Dashboard
                    </a>
                    <a href="${pageContext.request.contextPath}/customer/scholar/payment/history" class="btn btn-outline-primary btn-lg">
                        <i class="fas fa-history me-2"></i>Payment History
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

