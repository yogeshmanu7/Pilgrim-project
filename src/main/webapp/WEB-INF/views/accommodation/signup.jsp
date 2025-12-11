<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - GlobalPiligrim Accommodation</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
            padding: 0;
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
                radial-gradient(circle at 10% 20%, rgba(114, 47, 55, 0.05) 0%, transparent 50%),
                radial-gradient(circle at 90% 80%, rgba(114, 47, 55, 0.05) 0%, transparent 50%),
                repeating-linear-gradient(45deg, 
                    transparent, 
                    transparent 20px, 
                    rgba(114, 47, 55, 0.02) 20px, 
                    rgba(114, 47, 55, 0.02) 40px);
            z-index: 0;
        }
        
        /* Main Container */
        .registration-container {
            width: 100%;
            max-width: 1300px;
            margin: 0 auto;
            padding: 20px;
            position: relative;
            z-index: 1;
        }
        
        /* Registration Card */
        .registration-card {
            background: var(--dutch-white);
            border-radius: 25px;
            overflow: hidden;
            box-shadow: var(--shadow-wine);
            border: 2px solid var(--wine);
            min-height: 90vh;
            display: flex;
            flex-direction: column;
        }
        
        /* Top Header Section */
        .header-section {
            background: var(--wine);
            padding: 30px 40px;
            text-align: center;
            border-bottom: 2px solid var(--wine);
        }
        
        .logo-container {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 20px;
            margin-bottom: 15px;
        }
        
        .logo-icon {
            width: 60px;
            height: 60px;
            background: var(--dutch-white);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--wine);
            font-size: 28px;
            border: 2px solid var(--dutch-white);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        
        .brand-title {
            font-family: 'Merriweather', serif;
            font-size: 2.8rem;
            font-weight: 700;
            color: var(--dutch-white);
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
        }
        
        .brand-subtitle {
            color: var(--dutch-white);
            font-size: 1.1rem;
            opacity: 0.9;
            margin-bottom: 10px;
        }
        
        /* Main Content */
        .content-section {
            display: flex;
            flex: 1;
            min-height: 0;
        }
        
        /* Left Side - Features */
        .features-section {
            flex: 1;
            padding: 40px;
            background: rgba(239, 223, 187, 0.7);
            border-right: 2px solid var(--wine);
            overflow-y: auto;
        }
        
        .section-title {
            font-family: 'Merriweather', serif;
            font-size: 2rem;
            color: var(--wine);
            margin-bottom: 30px;
            text-align: center;
            position: relative;
            padding-bottom: 15px;
        }
        
        .section-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 3px;
            background: var(--wine);
        }
        
        .features-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .feature-card {
            background: var(--dutch-white);
            border: 2px solid var(--wine);
            border-radius: 15px;
            padding: 20px;
            transition: all 0.3s ease;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
        }
        
        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-wine);
        }
        
        .feature-icon {
            width: 50px;
            height: 50px;
            background: var(--wine);
            color: var(--dutch-white);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
            margin-bottom: 15px;
        }
        
        .feature-title {
            color: var(--wine);
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 1.1rem;
        }
        
        .feature-desc {
            color: var(--wine-light);
            font-size: 0.85rem;
            line-height: 1.4;
        }
        
        .universal-symbols {
            display: flex;
            justify-content: center;
            gap: 25px;
            margin-top: 30px;
            padding-top: 30px;
            border-top: 2px solid var(--wine);
        }
        
        .universal-symbols i {
            font-size: 24px;
            color: var(--wine);
            opacity: 0.7;
            transition: all 0.3s ease;
        }
        
        .universal-symbols i:hover {
            opacity: 1;
            transform: scale(1.2);
        }
        
        /* Right Side - Form */
        .form-section {
            flex: 1;
            padding: 40px;
            background: var(--dutch-white);
            overflow-y: auto;
        }
        
        .form-header {
            margin-bottom: 40px;
            text-align: center;
        }
        
        .form-title {
            font-family: 'Merriweather', serif;
            font-size: 2.2rem;
            color: var(--wine);
            margin-bottom: 15px;
        }
        
        .form-subtitle {
            color: var(--wine-light);
            font-size: 1rem;
        }
        
        /* Form Styling */
        .form-container {
            max-width: 500px;
            margin: 0 auto;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-label {
            display: block;
            margin-bottom: 8px;
            color: var(--wine);
            font-weight: 600;
            font-size: 0.95rem;
        }
        
        .input-group {
            position: relative;
        }
        
        .form-control {
            width: 100%;
            padding: 14px 20px 14px 50px;
            border: 2px solid var(--wine);
            border-radius: 12px;
            background: var(--dutch-white);
            color: var(--text-wine);
            font-size: 1rem;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
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
            z-index: 1;
        }
        
        .password-toggle {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: var(--wine);
            cursor: pointer;
            font-size: 1.2rem;
        }
        
        /* Role Selection */
        .role-selection {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
            margin-top: 10px;
        }
        
        .role-card {
            border: 2px solid var(--wine);
            border-radius: 12px;
            padding: 20px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
            background: var(--dutch-white);
        }
        
        .role-card:hover {
            background: var(--wine-transparent);
        }
        
        .role-card.active {
            background: var(--wine);
            color: var(--dutch-white);
        }
        
        .role-card.active .role-icon,
        .role-card.active .role-title,
        .role-card.active .role-desc {
            color: var(--dutch-white);
        }
        
        .role-icon {
            font-size: 28px;
            margin-bottom: 10px;
            color: var(--wine);
        }
        
        .role-title {
            font-weight: 600;
            margin-bottom: 5px;
            color: var(--wine);
        }
        
        .role-desc {
            font-size: 0.85rem;
            color: var(--wine-light);
        }
        
        /* Terms Checkbox */
        .form-check {
            display: flex;
            align-items: center;
            gap: 10px;
            margin: 25px 0;
        }
        
        .form-check-input {
            width: 20px;
            height: 20px;
            border: 2px solid var(--wine);
            border-radius: 4px;
            cursor: pointer;
            flex-shrink: 0;
        }
        
        .form-check-input:checked {
            background-color: var(--wine);
            border-color: var(--wine);
        }
        
        .form-check-label {
            color: var(--wine);
            font-size: 0.95rem;
        }
        
        .form-check-label a {
            color: var(--wine);
            font-weight: 600;
            text-decoration: none;
        }
        
        .form-check-label a:hover {
            text-decoration: underline;
        }
        
        /* Button */
        .btn-register {
            width: 100%;
            padding: 16px;
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
        }
        
        .btn-register:hover {
            background: var(--wine-dark);
            transform: translateY(-2px);
            box-shadow: var(--shadow-wine);
        }
        
        /* Error Message */
        .alert-error {
            background: rgba(114, 47, 55, 0.1);
            border: 2px solid var(--wine);
            border-radius: 12px;
            padding: 15px;
            margin-bottom: 25px;
            color: var(--wine);
            text-align: center;
        }
        
        /* Login Link */
        .login-link {
            text-align: center;
            margin-top: 25px;
            color: var(--wine-light);
        }
        
        .login-link a {
            color: var(--wine);
            font-weight: 600;
            text-decoration: none;
        }
        
        .login-link a:hover {
            text-decoration: underline;
        }
        
        /* Footer */
        .footer-note {
            text-align: center;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid var(--wine);
            color: var(--wine-light);
            font-size: 0.9rem;
        }
        
        /* Responsive Design */
        @media (max-width: 1200px) {
            .features-grid {
                grid-template-columns: 1fr;
            }
            
            .registration-card {
                min-height: auto;
            }
        }
        
        @media (max-width: 992px) {
            .content-section {
                flex-direction: column;
            }
            
            .features-section {
                border-right: none;
                border-bottom: 2px solid var(--wine);
            }
            
            .features-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }
        
        @media (max-width: 768px) {
            .registration-container {
                padding: 10px;
            }
            
            .header-section,
            .features-section,
            .form-section {
                padding: 30px 25px;
            }
            
            .brand-title {
                font-size: 2.2rem;
            }
            
            .form-title {
                font-size: 1.8rem;
            }
            
            .section-title {
                font-size: 1.6rem;
            }
            
            .features-grid {
                grid-template-columns: 1fr;
            }
            
            .role-selection {
                grid-template-columns: 1fr;
            }
        }
        
        @media (max-width: 576px) {
            .logo-container {
                flex-direction: column;
                gap: 15px;
            }
            
            .brand-title {
                font-size: 1.8rem;
            }
            
            .form-title {
                font-size: 1.5rem;
            }
            
            .header-section,
            .features-section,
            .form-section {
                padding: 25px 20px;
            }
            
            .universal-symbols {
                gap: 20px;
                font-size: 20px;
            }
        }
    </style>
</head>
<body>
    <!-- Background Pattern -->
    <div class="bg-pattern"></div>
    
    <!-- Main Container -->
    <div class="registration-container">
        <div class="registration-card">
            <!-- Header Section -->
            <div class="header-section">
                <div class="logo-container">
                    <div class="logo-icon">
                        <i class="fas fa-hands-praying"></i>
                    </div>
                    <h1 class="brand-title">GlobalPiligrim</h1>
                </div>
                <p class="brand-subtitle">Your Spiritual Journey Companion</p>
            </div>
            
            <!-- Content Section -->
            <div class="content-section">
                <!-- Left Side - Features -->
                <div class="features-section">
                    <h2 class="section-title">Complete Spiritual Ecosystem</h2>
                    
                    <div class="features-grid">
                        <div class="feature-card">
                            <div class="feature-icon">
                                <i class="fas fa-temple"></i>
                            </div>
                            <div class="feature-title">Temple Management</div>
                            <div class="feature-desc">Darshan booking, Pooja services, Donations</div>
                        </div>
                        
                        <div class="feature-card">
                            <div class="feature-icon">
                                <i class="fas fa-store"></i>
                            </div>
                            <div class="feature-title">Pooja Marketplace</div>
                            <div class="feature-desc">Vendor products & Online orders</div>
                        </div>
                        
                        <div class="feature-card">
                            <div class="feature-icon">
                                <i class="fas fa-hotel"></i>
                            </div>
                            <div class="feature-title">Accommodation</div>
                            <div class="feature-desc">Hotel booking & Stay management</div>
                        </div>
                        
                        <div class="feature-card">
                            <div class="feature-icon">
                                <i class="fas fa-bus"></i>
                            </div>
                            <div class="feature-title">Travel & Tours</div>
                            <div class="feature-desc">Packages & Transport services</div>
                        </div>
                        
                        <div class="feature-card">
                            <div class="feature-icon">
                                <i class="fas fa-user-tie"></i>
                            </div>
                            <div class="feature-title">Pandit Services</div>
                            <div class="feature-desc">Booking & Consultation</div>
                        </div>
                        
                        <div class="feature-card">
                            <div class="feature-icon">
                                <i class="fas fa-cogs"></i>
                            </div>
                            <div class="feature-title">Admin System</div>
                            <div class="feature-desc">Complete management control</div>
                        </div>
                    </div>
                    
                    <div class="universal-symbols">
                        <i class="fas fa-om" title="Hinduism"></i>
                        <i class="fas fa-cross" title="Christianity"></i>
                        <i class="fas fa-star-and-crescent" title="Islam"></i>
                        <i class="fas fa-dharmachakra" title="Buddhism"></i>
                        <i class="fas fa-yin-yang" title="Taoism"></i>
                        <i class="fas fa-menorah" title="Judaism"></i>
                    </div>
                </div>
                
                <!-- Right Side - Form -->
                <div class="form-section">
                    <div class="form-header">
                        <h2 class="form-title">Create Your Account</h2>
                        <p class="form-subtitle">Join our spiritual community today</p>
                    </div>
                    
                    <div class="form-container">
                        <c:if test="${not empty error}">
                            <div class="alert-error">
                                <i class="fas fa-exclamation-circle me-2"></i>
                                ${error}
                            </div>
                        </c:if>
                        
                        <form method="post" action="/pilgrim/accommodation/signup" id="registrationForm">
                            <!-- Full Name -->
                            <div class="form-group">
                                <label class="form-label">Full Name</label>
                                <div class="input-group">
                                    <i class="fas fa-user input-icon"></i>
                                    <input type="text" class="form-control" name="fullName" 
                                           placeholder="Enter your full name" required>
                                </div>
                            </div>
                            
                            <!-- Username -->
                            <div class="form-group">
                                <label class="form-label">Username</label>
                                <div class="input-group">
                                    <i class="fas fa-at input-icon"></i>
                                    <input type="text" class="form-control" name="username" 
                                           placeholder="Choose a username" required>
                                </div>
                            </div>
                            
                            <!-- Email -->
                            <div class="form-group">
                                <label class="form-label">Email Address</label>
                                <div class="input-group">
                                    <i class="fas fa-envelope input-icon"></i>
                                    <input type="email" class="form-control" name="email" 
                                           placeholder="your.email@example.com" required>
                                </div>
                            </div>
                            
                            <!-- Phone Number -->
                            <div class="form-group">
                                <label class="form-label">Phone Number</label>
                                <div class="input-group">
                                    <i class="fas fa-phone input-icon"></i>
                                    <input type="tel" class="form-control" name="phoneNumber" 
                                           placeholder="+91 9876543210" required>
                                </div>
                            </div>
                            
                            <!-- Password -->
                            <div class="form-group">
                                <label class="form-label">Password</label>
                                <div class="input-group">
                                    <i class="fas fa-lock input-icon"></i>
                                    <input type="password" class="form-control" id="password" name="password" 
                                           placeholder="Create a strong password" required>
                                    <button type="button" class="password-toggle" onclick="togglePassword('password')">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                            </div>
                            
                            <!-- Confirm Password -->
                            <div class="form-group">
                                <label class="form-label">Confirm Password</label>
                                <div class="input-group">
                                    <i class="fas fa-lock input-icon"></i>
                                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" 
                                           placeholder="Re-enter your password" required>
                                    <button type="button" class="password-toggle" onclick="togglePassword('confirmPassword')">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                            </div>
                            
                            <!-- Role Selection -->
                            <div class="form-group">
                                <label class="form-label">I want to</label>
                                <div class="role-selection">
                                    <div class="role-card" onclick="selectRole('PILGRIM')">
                                        <div class="role-icon">
                                            <i class="fas fa-search"></i>
                                        </div>
                                        <div class="role-title">Search & Book</div>
                                        <div class="role-desc">Find temples, hotels & services</div>
                                    </div>
                                    <div class="role-card" onclick="selectRole('PROPERTY_OWNER')">
                                        <div class="role-icon">
                                            <i class="fas fa-home"></i>
                                        </div>
                                        <div class="role-title">List Property</div>
                                        <div class="role-desc">Offer accommodation services</div>
                                    </div>
                                </div>
                                <input type="hidden" name="userRole" id="userRole" required>
                            </div>
                            
                            <!-- Terms & Submit -->
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="terms" required>
                                <label class="form-check-label" for="terms">
                                    I agree to the <a href="#">Terms</a> and <a href="#">Privacy Policy</a>
                                </label>
                            </div>
                            
                            <button type="submit" class="btn-register">
                                <i class="fas fa-user-plus"></i> Create Account
                            </button>
                        </form>
                        
                        <div class="login-link">
                            Already have an account? <a href="/pilgrim/accommodation/signin">Sign In</a>
                        </div>
                        
                        <div class="footer-note">
                            GlobalPiligrim respects all religious traditions and beliefs.<br>
                            <small>© 2024 GlobalPiligrim. All rights reserved.</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Password toggle functionality
        function togglePassword(fieldId) {
            const field = document.getElementById(fieldId);
            const button = field.parentElement.querySelector('.password-toggle');
            const icon = button.querySelector('i');
            
            if (field.type === 'password') {
                field.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                field.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        }
        
        // Role selection functionality
        function selectRole(role) {
            document.getElementById('userRole').value = role;
            
            // Update UI
            document.querySelectorAll('.role-card').forEach(card => {
                card.classList.remove('active');
            });
            
            event.currentTarget.classList.add('active');
        }
        
        // Set default role and initialize
        document.addEventListener('DOMContentLoaded', function() {
            selectRole('PILGRIM');
            
            // Form validation
            const form = document.getElementById('registrationForm');
            form.addEventListener('submit', function(e) {
                const password = document.getElementById('password').value;
                const confirmPassword = document.getElementById('confirmPassword').value;
                
                if (password !== confirmPassword) {
                    e.preventDefault();
                    showAlert('Passwords do not match!', 'error');
                    return false;
                }
                
                if (password.length < 8) {
                    e.preventDefault();
                    showAlert('Password must be at least 8 characters long!', 'error');
                    return false;
                }
                
                // Add loading state
                const submitBtn = form.querySelector('.btn-register');
                const originalText = submitBtn.innerHTML;
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Creating Account...';
                submitBtn.disabled = true;
                
                // Reset button after 5 seconds (in case submission fails)
                setTimeout(() => {
                    submitBtn.innerHTML = originalText;
                    submitBtn.disabled = false;
                }, 5000);
            });
        });
        
        function showAlert(message, type) {
            // Create alert element
            const alertDiv = document.createElement('div');
            alertDiv.className = `alert-${type}`;
            alertDiv.innerHTML = `
                <i class="fas fa-exclamation-circle me-2"></i>${message}
            `;
            
            // Insert at the beginning of form
            const form = document.getElementById('registrationForm');
            const formContainer = form.parentElement;
            formContainer.insertBefore(alertDiv, form);
            
            // Auto remove after 5 seconds
            setTimeout(() => {
                if (alertDiv.parentNode) {
                    alertDiv.remove();
                }
            }, 5000);
        }
    </script>
</body>
</html>