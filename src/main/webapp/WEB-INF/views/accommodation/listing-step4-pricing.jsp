<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Step 4/8 - Pricing & Payout - GlobalPiligrim Accommodation</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f5f5;
            padding: 40px 20px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
        }
        .step-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .step-indicator {
            color: #667eea;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .form-container {
            background: white;
            border-radius: 15px;
            padding: 40px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .payout-options {
            display: grid;
            gap: 20px;
        }
        .payout-card {
            padding: 25px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
        }
        .payout-card:hover {
            border-color: #667eea;
            background: #f0f4ff;
        }
        .payout-card.selected {
            border-color: #667eea;
            background: #667eea;
            color: white;
        }
        .payout-card input[type="radio"] {
            display: none;
        }
        .payout-card h3 {
            margin-bottom: 10px;
        }
        .payout-card p {
            color: #666;
            font-size: 0.9rem;
        }
        .payout-card.selected p {
            color: rgba(255,255,255,0.9);
        }
        .highlight {
            background: #ffd700;
            color: #333;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 0.8rem;
            font-weight: bold;
            display: inline-block;
            margin-left: 10px;
        }
        .btn-group {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
        }
        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            cursor: pointer;
        }
        .btn-primary {
            background: #667eea;
            color: white;
        }
        .btn-secondary {
            background: #e0e0e0;
            color: #333;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="step-header">
            <div class="step-indicator">💰 STEP 4/8 — PRICING & PAYOUT METHOD</div>
            <h1><i class="fas fa-credit-card"></i> Choose Payout Method</h1>
        </div>
        
        <form method="post" action="/pilgrim/accommodation/property/listing/step4" class="form-container">
            <div class="payout-options">
                <label class="payout-card" onclick="selectPayout(this)">
                    <input type="radio" name="payoutMethod" value="VIRTUAL_CREDIT_CARD_MULTIPLE">
                    <h3>Virtual Credit Card (Multiple bookings)</h3>
                    <p>Receive payments through virtual credit card for multiple bookings</p>
                </label>
                
                <label class="payout-card" onclick="selectPayout(this)">
                    <input type="radio" name="payoutMethod" value="VIRTUAL_CREDIT_CARD_SINGLE">
                    <h3>Virtual Credit Card (Single booking)</h3>
                    <p>Receive payments through virtual credit card for single bookings</p>
                </label>
                
                <label class="payout-card" onclick="selectPayout(this)">
                    <input type="radio" name="payoutMethod" value="BANK_TRANSFER_30_DAYS">
                    <h3>Bank Transfer (30 days post-checkout)</h3>
                    <p>Receive payments via bank transfer 30 days after guest checkout</p>
                </label>
                
                <label class="payout-card" onclick="selectPayout(this)">
                    <input type="radio" name="payoutMethod" value="FASTEST_PAYOUT">
                    <h3>FASTEST PAYOUT <span class="highlight">RECOMMENDED</span></h3>
                    <p>Get your payments faster with our fastest payout option</p>
                </label>
            </div>
            
            <p style="margin-top: 20px; color: #666; font-size: 0.9rem;">
                <i class="fas fa-info-circle"></i> Bank details can be added after listing goes live.
            </p>
            
            <div class="btn-group">
                <a href="/pilgrim/accommodation/property/listing/step3" class="btn btn-secondary">Back</a>
                <button type="submit" class="btn btn-primary">Next Step <i class="fas fa-arrow-right"></i></button>
            </div>
        </form>
    </div>
    
    <script>
        function selectPayout(element) {
            document.querySelectorAll('.payout-card').forEach(card => {
                card.classList.remove('selected');
            });
            element.classList.add('selected');
            element.querySelector('input[type="radio"]').checked = true;
        }
    </script>
</body>
</html>

