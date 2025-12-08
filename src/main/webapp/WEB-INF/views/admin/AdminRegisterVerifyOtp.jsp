<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verify OTP - Global Pilgrim</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;500;600;700&family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    
    <style>
        :root {
            --primary-teal: #0D9488;
            --primary-teal-dark: #0F766E;
            --accent-purple: #8B5CF6;
            --bg-dark: #0F172A;
            --bg-darker: #020617;
            --card-bg: #1E293B;
            --text-primary: #F1F5F9;
            --text-secondary: #94A3B8;
            --border-color: #334155;
            --accent-rose: #F43F5E;
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
        }
        
        h1, h2, h3 {
            font-family: 'Cormorant Garamond', serif;
        }
        
        .otp-container {
            width: 100%;
            max-width: 420px;
            padding: 20px;
        }
        
        .otp-card {
            background: rgba(30, 41, 59, 0.9);
            backdrop-filter: blur(20px);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 40px;
            text-align: center;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.4);
        }
        
        .otp-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, var(--primary-teal) 0%, var(--accent-purple) 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 25px;
            font-size: 2rem;
            color: white;
            box-shadow: 0 10px 30px rgba(13, 148, 136, 0.3);
        }
        
        .otp-card h2 {
            color: var(--text-primary);
            margin-bottom: 10px;
        }
        
        .otp-card h2 span {
            color: var(--primary-teal);
        }
        
        .otp-card p {
            color: var(--text-secondary);
            margin-bottom: 30px;
        }
        
        .form-control {
            width: 100%;
            padding: 16px;
            background: rgba(0, 0, 0, 0.3);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            color: var(--text-primary);
            font-size: 1.5rem;
            text-align: center;
            letter-spacing: 10px;
            font-weight: 700;
        }
        
        .form-control:focus {
            outline: none;
            border-color: var(--primary-teal);
            box-shadow: 0 0 0 4px rgba(13, 148, 136, 0.15);
            background: rgba(0, 0, 0, 0.4);
        }
        
        .form-control::placeholder {
            color: var(--text-secondary);
            letter-spacing: 5px;
        }
        
        .btn-verify {
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
            margin-bottom: 15px;
        }
        
        .btn-verify:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(13, 148, 136, 0.4);
        }
        
        .btn-resend {
            background: transparent;
            border: 2px solid var(--primary-teal);
            color: var(--primary-teal);
            width: 100%;
            padding: 12px;
            border-radius: 12px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .btn-resend:hover {
            background: var(--primary-teal);
            color: white;
        }
        
        .alert {
            padding: 12px 15px;
            border-radius: 12px;
            margin-bottom: 20px;
            text-align: left;
        }
        
        .alert-danger {
            background: rgba(244, 63, 94, 0.15);
            color: #f87171;
            border-left: 4px solid var(--accent-rose);
        }
        
        .alert-info {
            background: rgba(13, 148, 136, 0.15);
            color: var(--primary-teal);
            border-left: 4px solid var(--primary-teal);
        }
    </style>
</head>
<body>
    <div class="otp-container">
        <div class="otp-card">
            <div class="otp-icon">
                <i class="fas fa-shield-alt"></i>
            </div>
            
            <h2>Verify <span>OTP</span></h2>
            <p>Please enter the 6-digit OTP sent to your email</p>
            
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle me-2"></i> ${error}
                </div>
            </c:if>
            
            <c:if test="${not empty message}">
                <div class="alert alert-info">
                    <i class="fas fa-info-circle me-2"></i> ${message}
                </div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/admin/register/verify-otp" method="post">
                <div class="mb-4">
                    <input type="text" name="otp" class="form-control" placeholder="------" maxlength="6" required pattern="[0-9]{6}">
                </div>
                
                <button type="submit" class="btn-verify">
                    <i class="fas fa-check-circle me-2"></i> Verify OTP
                </button>
            </form>
            
            <form action="${pageContext.request.contextPath}/admin/register/resend-otp" method="post">
                <button type="submit" class="btn-resend">
                    <i class="fas fa-redo me-2"></i> Resend OTP
                </button>
            </form>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

