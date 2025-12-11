<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Scholar Login - GlobalPiligrim</title>
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
            min-height: 100vh;
            display: flex;
            align-items: center;
            padding: 40px 0;
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
        
        .container {
            position: relative;
            z-index: 1;
        }
        
        h1, h2, h3, h4, h5, h6 {
            font-family: 'Merriweather', serif;
        }
        
        .card {
            background: white;
            border: 2px solid var(--border-wine);
            border-radius: 15px;
            box-shadow: var(--shadow-wine);
        }
        
        .btn-primary {
            background: linear-gradient(135deg, var(--wine) 0%, var(--wine-dark) 100%);
            border: none;
            color: var(--text-cream);
            font-weight: 600;
            border-radius: 8px;
            padding: 10px;
        }
        
        .btn-primary:hover {
            background: linear-gradient(135deg, var(--wine-dark) 0%, var(--wine) 100%);
            transform: translateY(-2px);
            box-shadow: var(--shadow-wine);
            color: var(--text-cream);
        }
        
        .btn-outline-primary {
            border: 2px solid var(--border-wine);
            color: var(--text-wine);
            font-weight: 600;
            border-radius: 8px;
        }
        
        .btn-outline-primary:hover {
            background: linear-gradient(135deg, var(--wine) 0%, var(--wine-dark) 100%);
            color: var(--text-cream);
            border-color: var(--wine);
        }
        
        .form-control {
            background: white;
            border: 2px solid var(--border-wine);
            color: var(--text-wine);
            border-radius: 8px;
            padding: 10px 15px;
        }
        
        .form-control:focus {
            background: white;
            border-color: var(--wine);
            box-shadow: 0 0 0 3px var(--wine-transparent);
            color: var(--text-wine);
        }
        
        .form-label {
            color: var(--text-wine);
            font-weight: 600;
        }
        
        .text-primary {
            color: var(--text-wine) !important;
        }
        
        .alert-danger {
            background: rgba(220, 53, 69, 0.1);
            border: 2px solid #dc3545;
            color: #721c24;
            border-radius: 8px;
        }
        
        /* Header styling */
        h1 {
            color: var(--text-wine);
            font-size: 2rem;
            margin-bottom: 1.5rem;
        }
        
        .text-center p {
            color: var(--wine-light);
        }
    </style>
</head>
<body>
    <!-- Background Pattern -->
    <div class="bg-pattern"></div>
    
    <div class="container">
        <div class="card mx-auto" style="max-width: 500px;">
            <div class="card-body p-4">
                <h1 class="text-center text-primary mb-4">
                    <i class="fas fa-user-graduate me-2"></i>Scholar Login
                </h1>
                
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>
                
                <form method="post" action="${pageContext.request.contextPath}/scholar/login">
                    <div class="mb-3">
                        <label class="form-label">Email *</label>
                        <input type="email" name="email" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Password *</label>
                        <input type="password" name="password" class="form-control" required>
                    </div>
                    <button type="submit" class="btn btn-primary w-100 mb-3">Login</button>
                </form>
                
                <div class="text-center">
                    <p class="mb-2">Not registered yet?</p>
                    <a href="${pageContext.request.contextPath}/scholar/register/step1" class="btn btn-outline-primary">
                        Register as Scholar
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>