<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Success - GlobalPiligrim</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        body {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #f8f9fa;
        }
    </style>
</head>
<body>
    <div class="card mx-auto" style="max-width: 500px; text-align: center;">
        <div class="card-body p-5">
            <div style="font-size: 64px; margin-bottom: 20px;">✅</div>
            <h1 class="text-primary mb-4">Registration Successful!</h1>
            <div class="text-muted mb-4" style="line-height: 1.6;">
                <c:if test="${not empty success}">
                    ${success}
                </c:if>
                <c:if test="${empty success}">
                    Your application has been submitted successfully. Please wait for admin approval.
                </c:if>
            </div>
            <a href="${pageContext.request.contextPath}/scholar/login" class="btn btn-primary">Go to Login</a>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

