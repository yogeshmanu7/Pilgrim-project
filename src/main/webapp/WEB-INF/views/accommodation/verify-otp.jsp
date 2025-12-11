<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verify OTP - GlobalPiligrim Accommodation</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background: var(--dutch-white);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            color: var(--text-wine);
            position: relative;
            overflow-x: hidden;
        }
        
        /* Background Pattern */
        .bg-pattern {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: 
                radial-gradient(circle at 20% 30%, rgba(114, 47, 55, 0.05) 0%, transparent 50%),
                radial-gradient(circle at 80% 70%, rgba(114, 47, 55, 0.05) 0%, transparent 50%),
                repeating-linear-gradient(45deg, 
                    transparent, 
                    transparent 15px, 
                    rgba(114, 47, 55, 0.02) 15px, 
                    rgba(114, 47, 55, 0.02) 30px);
            z-index: 0;
        }
        
        /* OTP Container */
        .otp-container {
            background: var(--dutch-white);
            border-radius: 25px;
            padding: 50px 40px;
            max-width: 500px;
            width: 100%;
            box-shadow: var(--shadow-wine);
            border: 3px solid var(--wine);
            text-align: center;
            position: relative;
            z-index: 1;
            transition: transform 0.3s ease;
        }
        
        .otp-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(114, 47, 55, 0.25);
        }
        
        /* Logo Header */
        .logo-header {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
            margin-bottom: 25px;
        }
        
        .logo-circle {
            width: 70px;
            height: 70px;
            background: var(--wine);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--dutch-white);
            font-size: 32px;
            border: 2px solid var(--dutch-white);
            box-shadow: 0 5px 15px rgba(114, 47, 55, 0.3);
        }
        
        .brand-name {
            font-family: 'Merriweather', serif;
            font-size: 2rem;
            font-weight: 700;
            color: var(--wine);
            text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.1);
        }
        
        /* Title */
        h2 {
            font-family: 'Merriweather', serif;
            font-size: 2.2rem;
            color: var(--wine);
            margin-bottom: 15px;
            position: relative;
            display: inline-block;
        }
        
        h2::after {
            content: '';
            position: absolute;
            bottom: -8px;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 3px;
            background: var(--wine);
            border-radius: 2px;
        }
        
        /* Subtitle */
        p {
            color: var(--wine-light);
            margin-bottom: 35px;
            font-size: 1.1rem;
            line-height: 1.5;
        }
        
        /* Form Styling */
        .form-group {
            margin-bottom: 25px;
            text-align: left;
        }
        
        .form-label {
            display: block;
            margin-bottom: 8px;
            color: var(--wine);
            font-weight: 600;
            font-size: 0.95rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .form-label i {
            color: var(--wine);
        }
        
        .input-wrapper {
            position: relative;
        }
        
        input[type="text"],
        input[type="email"] {
            width: 100%;
            padding: 16px 20px 16px 50px;
            border: 2px solid var(--wine);
            border-radius: 12px;
            background: var(--dutch-white);
            color: var(--text-wine);
            font-size: 1rem;
            font-family: 'Poppins', sans-serif;
            transition: all 0.3s ease;
        }
        
        input[type="text"]:focus,
        input[type="email"]:focus {
            outline: none;
            box-shadow: 0 0 0 3px var(--wine-transparent);
        }
        
        .input-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--wine);
            font-size: 1.2rem;
        }
        
        /* OTP Input Specific */
        .otp-input {
            letter-spacing: 15px;
            font-size: 1.8rem !important;
            font-weight: 600;
            text-align: center;
            padding: 16px !important;
        }
        
        .otp-input::placeholder {
            letter-spacing: normal;
            font-size: 1rem;
        }
        
        /* Button */
        .btn-submit {
            width: 100%;
            padding: 18px;
            background: var(--wine);
            color: var(--dutch-white);
            border: none;
            border-radius: 12px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            font-family: 'Poppins', sans-serif;
            margin-top: 10px;
            position: relative;
            overflow: hidden;
        }
        
        .btn-submit:hover {
            background: var(--wine-dark);
            transform: translateY(-2px);
            box-shadow: var(--shadow-wine);
        }
        
        .btn-submit:active {
            transform: translateY(0);
        }
        
        .btn-submit::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            transform: translate(-50%, -50%);
            transition: width 0.6s, height 0.6s;
        }
        
        .btn-submit:hover::after {
            width: 300px;
            height: 300px;
        }
        
        /* Messages */
        .error {
            background: rgba(114, 47, 55, 0.1);
            border: 2px solid var(--wine);
            border-left: 4px solid var(--wine);
            border-radius: 12px;
            padding: 18px;
            margin-bottom: 25px;
            color: var(--wine);
            text-align: left;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .error i {
            font-size: 1.2rem;
            flex-shrink: 0;
        }
        
        .success {
            background: rgba(114, 47, 55, 0.08);
            border: 2px solid var(--wine);
            border-left: 4px solid var(--wine);
            border-radius: 12px;
            padding: 18px;
            margin-bottom: 25px;
            color: var(--wine);
            text-align: left;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .success i {
            font-size: 1.2rem;
            flex-shrink: 0;
        }
        
        /* Resend OTP Link */
        .resend-otp {
            text-align: center;
            margin-top: 25px;
            color: var(--wine-light);
            font-size: 0.95rem;
        }
        
        .resend-otp a {
            color: var(--wine);
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            position: relative;
        }
        
        .resend-otp a:hover {
            color: var(--wine-dark);
        }
        
        .resend-otp a::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 0;
            height: 1px;
            background: var(--wine);
            transition: width 0.3s ease;
        }
        
        .resend-otp a:hover::after {
            width: 100%;
        }
        
        /* Timer */
        .timer {
            color: var(--wine);
            font-weight: 600;
            margin-top: 5px;
        }
        
        /* Back Link */
        .back-link {
            text-align: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid var(--border-wine);
        }
        
        .back-link a {
            color: var(--wine);
            text-decoration: none;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
        }
        
        .back-link a:hover {
            color: var(--wine-dark);
            gap: 12px;
        }
        
        /* Responsive Design */
        @media (max-width: 768px) {
            body {
                padding: 15px;
            }
            
            .otp-container {
                padding: 40px 30px;
                max-width: 400px;
            }
            
            .brand-name {
                font-size: 1.8rem;
            }
            
            h2 {
                font-size: 1.8rem;
            }
            
            .logo-circle {
                width: 60px;
                height: 60px;
                font-size: 28px;
            }
            
            .otp-input {
                letter-spacing: 10px;
                font-size: 1.6rem !important;
            }
        }
        
        @media (max-width: 480px) {
            .otp-container {
                padding: 30px 25px;
            }
            
            .logo-header {
                flex-direction: column;
                gap: 10px;
            }
            
            .brand-name {
                font-size: 1.6rem;
            }
            
            h2 {
                font-size: 1.6rem;
            }
            
            p {
                font-size: 1rem;
            }
            
            .otp-input {
                letter-spacing: 8px;
                font-size: 1.4rem !important;
                padding: 14px !important;
            }
            
            input[type="text"],
            input[type="email"] {
                padding: 14px 20px 14px 45px;
            }
        }
        
        /* Loading Animation */
        .loading {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 2px solid var(--dutch-white);
            border-top-color: transparent;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }
        
        @keyframes spin {
            to { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <!-- Background Pattern -->
    <div class="bg-pattern"></div>
    
    <div class="otp-container">
        <!-- Logo Header -->
        <div class="logo-header">
            <div class="logo-circle">
                <i class="fas fa-hands-praying"></i>
            </div>
            <div class="brand-name">GlobalPiligrim</div>
        </div>
        
        <h2><i class="fas fa-shield-alt"></i> OTP Verification</h2>
        <p>Enter the 6-digit OTP sent to your email address</p>
        
        <c:if test="${not empty error}">
            <div class="error">
                <i class="fas fa-exclamation-circle"></i> ${error}
            </div>
        </c:if>
        
        <c:if test="${not empty success}">
            <div class="success">
                <i class="fas fa-check-circle"></i> ${success}
            </div>
        </c:if>
        
        <form method="post" action="/pilgrim/accommodation/verify-otp" id="otpForm">
            <div class="form-group">
                <label class="form-label">
                    <i class="fas fa-envelope"></i> Email Address
                </label>
                <div class="input-wrapper">
                    <i class="fas fa-envelope input-icon"></i>
                    <input type="email" name="email" value="${email}" required 
                           placeholder="Enter your email address" autocomplete="email">
                </div>
            </div>
            
            <div class="form-group">
                <label class="form-label">
                    <i class="fas fa-key"></i> OTP Code
                </label>
                <div class="input-wrapper">
                    <i class="fas fa-key input-icon"></i>
                    <input type="text" name="otpCode" class="otp-input" maxlength="6" 
                           required placeholder="000000" pattern="[0-9]{6}" 
                           oninput="this.value = this.value.replace(/[^0-9]/g, '')"
                           autocomplete="one-time-code">
                </div>
            </div>
            
            <button type="submit" class="btn-submit" id="submitBtn">
                <i class="fas fa-shield-alt"></i> Verify OTP
            </button>
        </form>
        
        <div class="resend-otp">
            <p>Didn't receive the OTP? <a href="#" onclick="resendOTP()">Resend OTP</a></p>
            <div id="timer" class="timer"></div>
        </div>
        
        <div class="back-link">
            <a href="/pilgrim/accommodation/signin">
                <i class="fas fa-arrow-left"></i> Back to Sign In
            </a>
        </div>
    </div>

    <script>
        // OTP input auto-focus and auto-tab
        const otpInput = document.querySelector('input[name="otpCode"]');
        otpInput.addEventListener('input', function(e) {
            if (this.value.length === 6) {
                this.blur();
                document.getElementById('submitBtn').focus();
            }
        });
        
        // Form submission with loading state
        const form = document.getElementById('otpForm');
        const submitBtn = document.getElementById('submitBtn');
        
        form.addEventListener('submit', function(e) {
            const email = document.querySelector('input[name="email"]').value;
            const otp = document.querySelector('input[name="otpCode"]').value;
            
            if (!email || !otp || otp.length !== 6) {
                e.preventDefault();
                return;
            }
            
            // Show loading state
            const originalText = submitBtn.innerHTML;
            submitBtn.innerHTML = '<div class="loading"></div> Verifying...';
            submitBtn.disabled = true;
            
            // Reset button after 5 seconds (in case submission fails)
            setTimeout(() => {
                submitBtn.innerHTML = originalText;
                submitBtn.disabled = false;
            }, 5000);
        });
        
        // Timer for OTP resend
        let timerCount = 30;
        const timerElement = document.getElementById('timer');
        const resendLink = document.querySelector('.resend-otp a');
        
        function startTimer() {
            resendLink.style.pointerEvents = 'none';
            resendLink.style.opacity = '0.5';
            
            const timerInterval = setInterval(() => {
                timerElement.textContent = `Resend available in ${timerCount} seconds`;
                timerCount--;
                
                if (timerCount < 0) {
                    clearInterval(timerInterval);
                    timerElement.textContent = '';
                    resendLink.style.pointerEvents = 'auto';
                    resendLink.style.opacity = '1';
                    timerCount = 30;
                }
            }, 1000);
        }
        
        // Initialize timer on page load
        window.addEventListener('load', startTimer);
        
        // Resend OTP function
        function resendOTP() {
            const email = document.querySelector('input[name="email"]').value;
            
            if (!email) {
                alert('Please enter your email address first');
                return;
            }
            
            // Show loading state on resend link
            const originalText = resendLink.textContent;
            resendLink.innerHTML = '<div class="loading"></div> Sending...';
            resendLink.style.pointerEvents = 'none';
            
            // Simulate API call (replace with actual API call)
            setTimeout(() => {
                alert('OTP has been resent to your email');
                resendLink.textContent = originalText;
                startTimer();
            }, 1500);
        }
        
        // Auto-focus OTP input if email is pre-filled
        window.addEventListener('load', function() {
            const emailInput = document.querySelector('input[name="email"]');
            if (emailInput.value) {
                otpInput.focus();
            } else {
                emailInput.focus();
            }
        });
    </script>
</body>
</html>