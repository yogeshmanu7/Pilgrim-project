<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Success - GlobalPiligrim</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        .user-theme {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            padding: 40px 0;
            margin-bottom: 30px;
        }
        .success-icon {
            width: 100px;
            height: 100px;
            background: #22c55e;
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
            <div class="success-icon">
                <i class="fas fa-check"></i>
            </div>
            <h1 class="text-white mb-0" style="font-size: 36px;">Payment Successful!</h1>
        </div>
    </div>
    
    <div class="container">
        <div class="card mx-auto" style="max-width: 600px;">
            <div class="card-body text-center">
                <c:if test="${not empty message}">
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle me-2"></i>${message}
                    </div>
                </c:if>
                
                <p class="lead">Your booking has been confirmed. You will receive a confirmation email shortly.</p>
                
                <div class="mt-4">
                    <a href="${pageContext.request.contextPath}/customer/scholar/dashboard" class="btn btn-success btn-lg">
                        <i class="fas fa-arrow-left me-2"></i>Go to Dashboard
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

