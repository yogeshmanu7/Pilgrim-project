<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Registration - Global Pilgrim</title>
    
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
            padding: 40px 20px;
        }
        
        h1, h2, h3 {
            font-family: 'Cormorant Garamond', serif;
        }
        
        .register-container {
            width: 100%;
            max-width: 500px;
        }
        
        .register-card {
            background: rgba(30, 41, 59, 0.9);
            backdrop-filter: blur(20px);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 40px;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.4);
        }
        
        .logo-section {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .logo-icon {
            width: 70px;
            height: 70px;
            background: linear-gradient(135deg, var(--primary-teal) 0%, var(--accent-purple) 100%);
            border-radius: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
            font-size: 1.8rem;
            color: white;
            box-shadow: 0 10px 30px rgba(13, 148, 136, 0.3);
        }
        
        .logo-section h2 {
            color: var(--text-primary);
            font-size: 1.5rem;
            font-weight: 700;
        }
        
        .logo-section h2 span {
            color: var(--primary-teal);
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-label {
            color: var(--text-secondary);
            font-weight: 600;
            margin-bottom: 8px;
            display: block;
            font-size: 0.9rem;
        }
        
        .input-group {
            position: relative;
        }
        
        .input-group-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-secondary);
            z-index: 10;
        }
        
        .form-control {
            width: 100%;
            padding: 14px 14px 14px 45px;
            background: rgba(0, 0, 0, 0.3);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            color: var(--text-primary);
            font-size: 0.95rem;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            outline: none;
            border-color: var(--primary-teal);
            box-shadow: 0 0 0 4px rgba(13, 148, 136, 0.15);
        }
        
        .form-control::placeholder {
            color: var(--text-secondary);
        }
        
        .btn-register {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, var(--primary-teal) 0%, var(--primary-teal-dark) 100%);
            border: none;
            border-radius: 12px;
            color: white;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(13, 148, 136, 0.4);
        }
        
        .extra-links {
            margin-top: 25px;
            text-align: center;
        }
        
        .extra-links a {
            color: var(--primary-teal);
            text-decoration: none;
            font-weight: 600;
        }
        
        .extra-links a:hover {
            color: var(--text-primary);
        }
        
        .alert {
            padding: 12px 15px;
            border-radius: 12px;
            margin-bottom: 20px;
            border: none;
        }
        
        .alert-danger {
            background: rgba(244, 63, 94, 0.15);
            color: #f87171;
            border-left: 4px solid #f43f5e;
        }
        
        .faith-icons {
            display: flex;
            justify-content: center;
            gap: 12px;
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px solid var(--border-color);
        }
        
        .faith-icons i {
            font-size: 1rem;
            color: var(--text-secondary);
            opacity: 0.4;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="register-card">
            <div class="logo-section">
                <div class="logo-icon">
                    <i class="fas fa-globe-americas"></i>
                </div>
                <h2>Global <span>Pilgrim</span></h2>
                <p class="text-secondary">Admin Registration</p>
            </div>
            
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle me-2"></i> ${error}
                </div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/admin/register" method="post">
                <div class="form-group">
                    <label class="form-label">Full Name</label>
                    <div class="input-group">
                        <i class="fas fa-user input-group-icon"></i>
                        <input type="text" name="name" class="form-control" placeholder="Enter your full name" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="form-label">Email Address</label>
                    <div class="input-group">
                        <i class="fas fa-envelope input-group-icon"></i>
                        <input type="email" name="email" class="form-control" placeholder="Enter your email" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="form-label">Phone Number</label>
                    <div class="input-group">
                        <i class="fas fa-phone input-group-icon"></i>
                        <input type="tel" name="phone" class="form-control" placeholder="Enter your phone number" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="form-label">Password</label>
                    <div class="input-group">
                        <i class="fas fa-lock input-group-icon"></i>
                        <input type="password" name="password" class="form-control" placeholder="Create a password" required minlength="6">
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="form-label">Confirm Password</label>
                    <div class="input-group">
                        <i class="fas fa-lock input-group-icon"></i>
                        <input type="password" name="confirmPassword" class="form-control" placeholder="Confirm your password" required minlength="6">
                    </div>
                </div>
                
                <button type="submit" class="btn-register">
                    <i class="fas fa-user-plus me-2"></i> Register
                </button>
            </form>
            
            <div class="extra-links">
                <p class="text-secondary">Already have an account? <a href="${pageContext.request.contextPath}/admin/login">Sign In</a></p>
            </div>
            
            <div class="faith-icons">
                <i class="fas fa-place-of-worship"></i>
                <i class="fas fa-cross"></i>
                <i class="fas fa-star-and-crescent"></i>
                <i class="fas fa-dharmachakra"></i>
                <i class="fas fa-star-of-david"></i>
                <i class="fas fa-om"></i>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
