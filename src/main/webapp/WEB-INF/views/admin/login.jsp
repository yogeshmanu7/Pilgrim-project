<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - Global Pilgrim</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;500;600;700&family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    
    <style>
        :root {
            --primary-teal: #0D9488;
            --primary-teal-dark: #0F766E;
            --celestial-blue: #1E3A5F;
            --accent-purple: #8B5CF6;
            --bg-dark: #0F172A;
            --bg-darker: #020617;
            --card-bg: #1E293B;
            --text-primary: #F1F5F9;
            --text-secondary: #94A3B8;
            --border-color: #334155;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Outfit', sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: var(--bg-dark);
            background-image: 
                radial-gradient(ellipse at top left, rgba(13, 148, 136, 0.15) 0%, transparent 50%),
                radial-gradient(ellipse at bottom right, rgba(139, 92, 246, 0.1) 0%, transparent 50%);
            position: relative;
            overflow: hidden;
        }
        
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: 
                radial-gradient(circle at 20% 20%, rgba(13, 148, 136, 0.08) 0%, transparent 40%),
                radial-gradient(circle at 80% 80%, rgba(139, 92, 246, 0.08) 0%, transparent 40%);
            pointer-events: none;
        }
        
        h1, h2, h3 {
            font-family: 'Cormorant Garamond', serif;
        }
        
        .login-container {
            width: 100%;
            max-width: 460px;
            padding: 20px;
            position: relative;
            z-index: 1;
        }
        
        .login-card {
            background: rgba(30, 41, 59, 0.9);
            backdrop-filter: blur(20px);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 50px 40px;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.4);
        }
        
        .logo-section {
            text-align: center;
            margin-bottom: 40px;
        }
        
        .logo-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, var(--primary-teal) 0%, var(--accent-purple) 100%);
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            font-size: 2rem;
            color: white;
            box-shadow: 0 10px 30px rgba(13, 148, 136, 0.3);
            position: relative;
        }
        
        .logo-icon::before {
            content: '';
            position: absolute;
            inset: -3px;
            border-radius: 23px;
            background: linear-gradient(135deg, var(--primary-teal), var(--accent-purple));
            z-index: -1;
            opacity: 0.5;
            filter: blur(10px);
        }
        
        .logo-section h2 {
            color: var(--text-primary);
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 5px;
        }
        
        .logo-section h2 span {
            color: var(--primary-teal);
        }
        
        .logo-section p {
            color: var(--text-secondary);
            font-size: 0.95rem;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-label {
            color: var(--text-secondary);
            font-weight: 600;
            margin-bottom: 10px;
            display: block;
            font-size: 0.9rem;
        }
        
        .input-group {
            position: relative;
        }
        
        .input-group-icon {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-secondary);
            z-index: 10;
        }
        
        .form-control {
            width: 100%;
            padding: 16px 16px 16px 48px;
            background: rgba(0, 0, 0, 0.3);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            color: var(--text-primary);
            font-size: 1rem;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            outline: none;
            border-color: var(--primary-teal);
            box-shadow: 0 0 0 4px rgba(13, 148, 136, 0.15);
            background: rgba(0, 0, 0, 0.4);
        }
        
        .form-control::placeholder {
            color: var(--text-secondary);
        }
        
        .btn-login {
            width: 100%;
            padding: 16px;
            background: linear-gradient(135deg, var(--primary-teal) 0%, var(--primary-teal-dark) 100%);
            border: none;
            border-radius: 12px;
            color: white;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .btn-login:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(13, 148, 136, 0.4);
        }
        
        .extra-links {
            margin-top: 30px;
            text-align: center;
        }
        
        .extra-links a {
            color: var(--primary-teal);
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .extra-links a:hover {
            color: var(--text-primary);
        }
        
        .alert {
            padding: 15px 20px;
            border-radius: 12px;
            margin-bottom: 25px;
            border: none;
        }
        
        .alert-danger {
            background: rgba(244, 63, 94, 0.15);
            color: #f87171;
            border-left: 4px solid #f43f5e;
        }
        
        .alert-success {
            background: rgba(34, 197, 94, 0.15);
            color: #4ade80;
            border-left: 4px solid #22c55e;
        }
        
        /* Decorative floating symbols */
        .floating-symbols {
            position: absolute;
            width: 100%;
            height: 100%;
            pointer-events: none;
            overflow: hidden;
        }
        
        .floating-symbols .symbol {
            position: absolute;
            font-size: 40px;
            opacity: 0.03;
            animation: float 20s ease-in-out infinite;
        }
        
        .symbol-1 { top: 10%; left: 10%; animation-delay: 0s; }
        .symbol-2 { top: 20%; right: 15%; animation-delay: -5s; }
        .symbol-3 { bottom: 30%; left: 8%; animation-delay: -10s; }
        .symbol-4 { bottom: 15%; right: 10%; animation-delay: -15s; }
        .symbol-5 { top: 50%; left: 5%; animation-delay: -8s; }
        .symbol-6 { top: 40%; right: 5%; animation-delay: -12s; }
        
        @keyframes float {
            0%, 100% { transform: translateY(0) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(5deg); }
        }
        
        .faith-icons {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid var(--border-color);
        }
        
        .faith-icons i {
            font-size: 1.2rem;
            color: var(--text-secondary);
            opacity: 0.5;
            transition: all 0.3s ease;
        }
        
        .faith-icons i:hover {
            color: var(--primary-teal);
            opacity: 1;
        }
    </style>
</head>
<body>
    <div class="floating-symbols">
        <div class="symbol symbol-1"><i class="fas fa-place-of-worship"></i></div>
        <div class="symbol symbol-2"><i class="fas fa-star"></i></div>
        <div class="symbol symbol-3"><i class="fas fa-moon"></i></div>
        <div class="symbol symbol-4"><i class="fas fa-cross"></i></div>
        <div class="symbol symbol-5"><i class="fas fa-dharmachakra"></i></div>
        <div class="symbol symbol-6"><i class="fas fa-sun"></i></div>
    </div>
    
    <div class="login-container">
        <div class="login-card">
            <div class="logo-section">
                <div class="logo-icon">
                    <i class="fas fa-globe-americas"></i>
                </div>
                <h2>Global <span>Pilgrim</span></h2>
                <p>Universal Faith Platform - Admin Panel</p>
            </div>
            
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle me-2"></i> ${error}
                </div>
            </c:if>
            
            <c:if test="${not empty success}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle me-2"></i> ${success}
                </div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/admin/login" method="post">
                <div class="form-group">
                    <label class="form-label">Email Address</label>
                    <div class="input-group">
                        <i class="fas fa-envelope input-group-icon"></i>
                        <input type="email" name="email" class="form-control" placeholder="Enter your email" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="form-label">Password</label>
                    <div class="input-group">
                        <i class="fas fa-lock input-group-icon"></i>
                        <input type="password" name="password" class="form-control" placeholder="Enter your password" required>
                    </div>
                </div>
                
                <button type="submit" class="btn-login">
                    <i class="fas fa-sign-in-alt me-2"></i> Sign In
                </button>
            </form>
            
            <div class="extra-links">
                <p class="mb-2"><a href="${pageContext.request.contextPath}/admin/forgot-password">Forgot Password?</a></p>
                <p class="text-secondary">Don't have an account? <a href="${pageContext.request.contextPath}/admin/register">Register</a></p>
            </div>
            
            <div class="faith-icons">
                <i class="fas fa-place-of-worship" title="All Sacred Places"></i>
                <i class="fas fa-cross" title="Christianity"></i>
                <i class="fas fa-star-and-crescent" title="Islam"></i>
                <i class="fas fa-dharmachakra" title="Buddhism"></i>
                <i class="fas fa-star-of-david" title="Judaism"></i>
                <i class="fas fa-om" title="Hinduism"></i>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
