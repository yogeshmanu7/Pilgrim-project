<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Step 4/8 - Pricing & Payout - GlobalPiligrim Accommodation</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Merriweather:wght@300;400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --dutch-white: #EFDFBB;
            --wine: #722F37;
            --wine-dark: #5A242B;
            --wine-light: rgba(114, 47, 55, 0.8);
            --wine-transparent: rgba(114, 47, 55, 0.1);
            --wine-pale: rgba(114, 47, 55, 0.05);
            --text-wine: #722F37;
            --text-cream: #EFDFBB;
            --border-wine: #722F37;
            --shadow-wine: 0 10px 30px rgba(114, 47, 55, 0.15);
            --shadow-light: 0 4px 15px rgba(114, 47, 55, 0.08);
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background: var(--dutch-white);
            padding: 40px 20px;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--text-wine);
        }
        
        /* Main Container */
        .container {
            max-width: 900px;
            width: 100%;
        }
        
        /* Step Header */
        .step-header {
            text-align: center;
            margin-bottom: 40px;
        }
        
        .step-indicator {
            color: var(--wine);
            font-weight: 700;
            margin-bottom: 15px;
            font-size: 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            letter-spacing: 1px;
        }
        
        .step-indicator i {
            font-size: 1.2rem;
        }
        
        .step-header h1 {
            font-family: 'Merriweather', serif;
            font-size: 2.8rem;
            font-weight: 700;
            color: var(--wine);
            margin-bottom: 15px;
            position: relative;
            display: inline-block;
        }
        
        .step-header h1::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 120px;
            height: 3px;
            background: var(--wine);
            border-radius: 2px;
        }
        
        .step-subtitle {
            color: var(--wine-light);
            font-size: 1.1rem;
            margin-top: 20px;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
            line-height: 1.6;
        }
        
        /* Form Container */
        .form-container {
            background: var(--dutch-white);
            border-radius: 25px;
            padding: 50px 40px;
            border: 3px solid var(--wine);
            box-shadow: var(--shadow-wine);
            position: relative;
            overflow: hidden;
        }
        
        .form-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 8px;
            background: linear-gradient(90deg, 
                var(--wine) 0%, 
                var(--wine-dark) 50%, 
                var(--wine) 100%);
        }
        
        /* Payout Options */
        .payout-options {
            display: grid;
            gap: 25px;
            margin-bottom: 30px;
        }
        
        .payout-card {
            padding: 30px;
            border: 3px solid var(--wine);
            border-radius: 15px;
            cursor: pointer;
            transition: all 0.3s ease;
            background: var(--dutch-white);
            position: relative;
            overflow: hidden;
        }
        
        .payout-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-wine);
            background: var(--wine-pale);
        }
        
        .payout-card.selected {
            background: var(--wine);
            color: var(--dutch-white);
            transform: translateY(-5px);
            box-shadow: var(--shadow-wine);
            border-color: var(--wine);
        }
        
        .payout-card input[type="radio"] {
            display: none;
        }
        
        .payout-card h3 {
            font-size: 1.4rem;
            margin-bottom: 12px;
            font-weight: 700;
            color: var(--wine);
            transition: color 0.3s ease;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .payout-card.selected h3 {
            color: var(--dutch-white);
        }
        
        .payout-icon {
            width: 45px;
            height: 45px;
            background: var(--wine-pale);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--wine);
            font-size: 1.2rem;
            flex-shrink: 0;
            transition: all 0.3s ease;
        }
        
        .payout-card.selected .payout-icon {
            background: var(--dutch-white);
            color: var(--wine);
        }
        
        .payout-card p {
            color: var(--wine-light);
            font-size: 1rem;
            line-height: 1.5;
            margin-left: 57px;
            transition: color 0.3s ease;
        }
        
        .payout-card.selected p {
            color: rgba(239, 223, 187, 0.9);
        }
        
        /* Recommended Badge */
        .highlight {
            background: linear-gradient(135deg, #FFD700, #FFA500);
            color: var(--wine);
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 700;
            margin-left: auto;
            display: flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 2px 10px rgba(255, 215, 0, 0.3);
        }
        
        .payout-card.selected .highlight {
            background: var(--dutch-white);
            color: var(--wine);
        }
        
        /* Card Check Indicator */
        .card-check {
            position: absolute;
            top: 15px;
            right: 15px;
            width: 25px;
            height: 25px;
            border: 2px solid var(--wine);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: transparent;
            transition: all 0.3s ease;
        }
        
        .payout-card.selected .card-check {
            background: var(--dutch-white);
            color: var(--wine);
            border-color: var(--dutch-white);
        }
        
        /* Info Note */
        .info-note {
            background: var(--wine-pale);
            border: 2px solid var(--wine);
            border-radius: 12px;
            padding: 20px;
            margin-top: 30px;
            display: flex;
            align-items: flex-start;
            gap: 15px;
            color: var(--wine);
        }
        
        .info-note i {
            font-size: 1.2rem;
            color: var(--wine);
            margin-top: 3px;
            flex-shrink: 0;
        }
        
        .info-note p {
            color: var(--wine);
            font-size: 0.95rem;
            line-height: 1.5;
        }
        
        /* Button Group */
        .btn-group {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 40px;
            padding-top: 30px;
            border-top: 2px solid var(--border-wine);
        }
        
        .btn {
            padding: 16px 35px;
            border: none;
            border-radius: 12px;
            font-size: 1.1rem;
            cursor: pointer;
            font-weight: 600;
            font-family: 'Poppins', sans-serif;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 10px;
            text-decoration: none;
        }
        
        .btn-primary {
            background: var(--wine);
            color: var(--dutch-white);
            border: 2px solid var(--wine);
        }
        
        .btn-primary:hover {
            background: var(--wine-dark);
            transform: translateX(5px);
            box-shadow: var(--shadow-wine);
        }
        
        .btn-secondary {
            background: transparent;
            color: var(--wine);
            border: 2px solid var(--wine);
        }
        
        .btn-secondary:hover {
            background: var(--wine-transparent);
            transform: translateX(-5px);
            box-shadow: var(--shadow-light);
        }
        
        /* Progress Indicator */
        .progress-indicator {
            display: flex;
            align-items: center;
            gap: 15px;
            color: var(--wine);
            font-weight: 600;
        }
        
        .progress-dots {
            display: flex;
            gap: 8px;
        }
        
        .progress-dot {
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background: var(--wine-transparent);
            transition: all 0.3s ease;
        }
        
        .progress-dot.active {
            background: var(--wine);
            transform: scale(1.2);
        }
        
        /* Responsive Design */
        @media (max-width: 768px) {
            body {
                padding: 30px 15px;
            }
            
            .step-header h1 {
                font-size: 2.2rem;
            }
            
            .form-container {
                padding: 40px 25px;
            }
            
            .payout-card {
                padding: 25px;
            }
            
            .payout-card h3 {
                font-size: 1.2rem;
            }
            
            .payout-icon {
                width: 40px;
                height: 40px;
                font-size: 1.1rem;
            }
            
            .payout-card p {
                margin-left: 52px;
            }
            
            .btn-group {
                flex-direction: column;
                gap: 20px;
            }
            
            .btn {
                width: 100%;
                justify-content: center;
            }
            
            .progress-indicator {
                width: 100%;
                justify-content: center;
            }
        }
        
        @media (max-width: 576px) {
            .step-header h1 {
                font-size: 1.8rem;
            }
            
            .step-indicator {
                font-size: 0.9rem;
            }
            
            .form-container {
                padding: 30px 20px;
            }
            
            .payout-card {
                padding: 20px;
            }
            
            .payout-card h3 {
                flex-wrap: wrap;
                gap: 8px;
            }
            
            .highlight {
                margin-left: 0;
                width: 100%;
                justify-content: center;
                margin-top: 5px;
            }
            
            .payout-card p {
                margin-left: 0;
                margin-top: 15px;
            }
            
            .btn {
                padding: 14px 25px;
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Step Header -->
        <div class="step-header">
            <div class="step-indicator">
                <i class="fas fa-money-check-alt"></i> STEP 4/8 — PRICING & PAYOUT METHOD
            </div>
            <h1>Choose Your Payout Method</h1>
            <p class="step-subtitle">
                Select how you'd like to receive payments from your bookings. You can update your bank details later.
            </p>
        </div>
        
        <!-- Form Container -->
        <form method="post" action="/pilgrim/accommodation/property/listing/step4" class="form-container">
            <!-- Payout Options -->
            <div class="payout-options">
                <!-- Option 1: Virtual Credit Card (Multiple) -->
                <label class="payout-card" onclick="selectPayout(this)">
                    <input type="radio" name="payoutMethod" value="VIRTUAL_CREDIT_CARD_MULTIPLE">
                    <div class="card-check"><i class="fas fa-check"></i></div>
                    <h3>
                        <div class="payout-icon">
                            <i class="fas fa-credit-card"></i>
                        </div>
                        Virtual Credit Card (Multiple Bookings)
                    </h3>
                    <p>
                        Receive payments through virtual credit cards for multiple bookings. 
                        Ideal for properties with frequent bookings and bulk payments.
                    </p>
                </label>
                
                <!-- Option 2: Virtual Credit Card (Single) -->
                <label class="payout-card" onclick="selectPayout(this)">
                    <input type="radio" name="payoutMethod" value="VIRTUAL_CREDIT_CARD_SINGLE">
                    <div class="card-check"><i class="fas fa-check"></i></div>
                    <h3>
                        <div class="payout-icon">
                            <i class="fas fa-credit-card"></i>
                        </div>
                        Virtual Credit Card (Single Booking)
                    </h3>
                    <p>
                        Receive payments through virtual credit cards for individual bookings. 
                        Best for properties with occasional or single bookings.
                    </p>
                </label>
                
                <!-- Option 3: Bank Transfer (30 days) -->
                <label class="payout-card" onclick="selectPayout(this)">
                    <input type="radio" name="payoutMethod" value="BANK_TRANSFER_30_DAYS">
                    <div class="card-check"><i class="fas fa-check"></i></div>
                    <h3>
                        <div class="payout-icon">
                            <i class="fas fa-university"></i>
                        </div>
                        Bank Transfer (30 Days Post-Checkout)
                    </h3>
                    <p>
                        Receive payments via direct bank transfer 30 days after guest checkout. 
                        Traditional method with secure transfers to your registered bank account.
                    </p>
                </label>
                
                <!-- Option 4: Fastest Payout (Recommended) -->
                <label class="payout-card" onclick="selectPayout(this)">
                    <input type="radio" name="payoutMethod" value="FASTEST_PAYOUT">
                    <div class="card-check"><i class="fas fa-check"></i></div>
                    <h3>
                        <div class="payout-icon">
                            <i class="fas fa-bolt"></i>
                        </div>
                        Fastest Payout Option
                        <span class="highlight">
                            <i class="fas fa-star"></i> RECOMMENDED
                        </span>
                    </h3>
                    <p>
                        Get your payments faster with our optimized payout system. 
                        Combines security with speed for the best booking experience.
                    </p>
                </label>
            </div>
            
            <!-- Info Note -->
            <div class="info-note">
                <i class="fas fa-info-circle"></i>
                <p>
                    <strong>Note:</strong> Bank account details can be added or updated after your listing goes live. 
                    You'll receive email notifications for all payouts. All transactions are secured with 256-bit SSL encryption.
                </p>
            </div>
            
            <!-- Footer with Navigation -->
            <div class="btn-group">
                <div class="progress-indicator">
                    <div class="progress-dots">
                        <div class="progress-dot"></div>
                        <div class="progress-dot"></div>
                        <div class="progress-dot"></div>
                        <div class="progress-dot active"></div>
                        <div class="progress-dot"></div>
                        <div class="progress-dot"></div>
                        <div class="progress-dot"></div>
                        <div class="progress-dot"></div>
                    </div>
                    <span>Step 4 of 8</span>
                </div>
                
                <div style="display: flex; gap: 15px;">
                    <a href="/pilgrim/accommodation/property/listing/step3" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Back
                    </a>
                    <button type="button" class="btn btn-primary" onclick="submitForm()" id="submitBtn">
                        Next Step <i class="fas fa-arrow-right"></i>
                    </button>
                </div>
            </div>
        </form>
    </div>
    
    <script>
        let selectedMethod = null;
        
        // Select payout method
        function selectPayout(element) {
            // Remove selected class from all cards
            document.querySelectorAll('.payout-card').forEach(card => {
                card.classList.remove('selected');
            });
            
            // Add selected class to clicked card
            element.classList.add('selected');
            
            // Mark radio button as checked
            const radioButton = element.querySelector('input[type="radio"]');
            radioButton.checked = true;
            
            // Store selected method
            selectedMethod = radioButton.value;
            
            // Update progress indicator
            updateProgressDots();
        }
        
        // Update progress dots
        function updateProgressDots() {
            const dots = document.querySelectorAll('.progress-dot');
            dots.forEach((dot, index) => {
                if (index < 4) { // Step 4 is active
                    dot.classList.add('active');
                } else {
                    dot.classList.remove('active');
                }
            });
        }
        
        // Form validation and submission
        function submitForm() {
            if (!selectedMethod) {
                alert('Please select a payout method before proceeding.');
                return;
            }
            
            // Show loading state
            const submitBtn = document.getElementById('submitBtn');
            const originalText = submitBtn.innerHTML;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';
            submitBtn.disabled = true;
            
            // Validate and submit
            setTimeout(() => {
                // Submit the form
                document.querySelector('form').submit();
            }, 1500);
        }
        
        // Add keyboard navigation
        document.addEventListener('keydown', function(event) {
            if (event.key === 'Enter') {
                submitForm();
            }
            
            if (event.key === 'Escape') {
                window.history.back();
            }
        });
        
        // Initialize on page load
        document.addEventListener('DOMContentLoaded', function() {
            updateProgressDots();
            
            // Add click animations to cards
            const cards = document.querySelectorAll('.payout-card');
            cards.forEach(card => {
                card.addEventListener('click', function() {
                    this.style.transform = 'scale(0.98)';
                    setTimeout(() => {
                        this.style.transform = '';
                    }, 150);
                });
            });
            
            // Auto-select recommended option after 2 seconds (if none selected)
            setTimeout(() => {
                if (!selectedMethod) {
                    const recommendedCard = document.querySelector('input[value="FASTEST_PAYOUT"]').parentElement;
                    selectPayout(recommendedCard);
                    
                    // Show recommendation tooltip
                    const tooltip = document.createElement('div');
                    tooltip.style.cssText = `
                        position: fixed;
                        bottom: 20px;
                        left: 50%;
                        transform: translateX(-50%);
                        background: var(--wine);
                        color: var(--dutch-white);
                        padding: 10px 20px;
                        border-radius: 10px;
                        font-size: 0.9rem;
                        z-index: 1000;
                        box-shadow: var(--shadow-wine);
                        animation: fadeInUp 0.3s ease;
                    `;
                    tooltip.innerHTML = '<i class="fas fa-info-circle"></i> We\'ve selected the recommended payout method for you';
                    document.body.appendChild(tooltip);
                    
                    setTimeout(() => {
                        tooltip.style.opacity = '0';
                        tooltip.style.transform = 'translateX(-50%) translateY(10px)';
                        setTimeout(() => {
                            document.body.removeChild(tooltip);
                        }, 300);
                    }, 3000);
                }
            }, 2000);
        });
        
        // Add CSS animation for tooltip
        const style = document.createElement('style');
        style.textContent = `
            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateX(-50%) translateY(10px);
                }
                to {
                    opacity: 1;
                    transform: translateX(-50%) translateY(0);
                }
            }
        `;
        document.head.appendChild(style);
    </script>
</body>
</html>