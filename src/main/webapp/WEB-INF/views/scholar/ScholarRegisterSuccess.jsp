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
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: var(--dutch-white);
            position: relative;
        }
        
        /* Background Pattern (from your reference page) */
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
        
        .card {
            position: relative;
            z-index: 1;
            background: white;
            border: 2px solid var(--border-wine);
            border-radius: 15px;
            box-shadow: var(--shadow-wine);
        }
        
        h1, h2, h3, h4, h5, h6 {
            font-family: 'Merriweather', serif;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, var(--wine) 0%, var(--wine-dark) 100%);
            border: none;
            color: var(--text-cream);
            font-weight: 600;
            border-radius: 8px;
            padding: 10px 30px;
        }
        
        .btn-primary:hover {
            background: linear-gradient(135deg, var(--wine-dark) 0%, var(--wine) 100%);
            transform: translateY(-2px);
            box-shadow: var(--shadow-wine);
            color: var(--text-cream);
        }
        
        .text-primary {
            color: var(--text-wine) !important;
        }
        
        .text-muted {
            color: var(--wine-light) !important;
        }
        
        /* Success icon styling */
        .card-body > div:first-child {
            color: var(--wine);
        }
    </style>
</head>
<body>
    <!-- Background Pattern -->
    <div class="bg-pattern"></div>
    
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