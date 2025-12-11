<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment - GlobalPiligrim Accommodation</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #EFDFBB; /* Dutch White - CHANGED */
        }
        .header {
            background: #EFDFBB; /* Dutch White - CHANGED */
            padding: 20px 30px;
            box-shadow: 0 2px 4px rgba(114, 47, 55, 0.1); /* Wine with opacity - CHANGED */
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid #722F37; /* Wine - CHANGED */
        }
        .header h1 {
            color: #722F37; /* Wine - CHANGED */
            font-size: 1.5rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .nav-links {
            display: flex;
            gap: 20px;
            align-items: center;
        }
        .nav-links a {
            color: #722F37; /* Wine - CHANGED */
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        .nav-links a:hover {
            color: #5a2530; /* Darker Wine - CHANGED */
            transform: translateY(-1px);
        }
        .container {
            max-width: 1000px;
            margin: 40px auto;
            padding: 0 20px;
        }
        .payment-container {
            display: grid;
            grid-template-columns: 1fr 400px;
            gap: 30px;
        }
        .payment-form-section {
            background: #EFDFBB; /* Dutch White - CHANGED */
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 4px 15px rgba(114, 47, 55, 0.1); /* Wine with opacity - CHANGED */
            border: 2px solid #722F37; /* Wine - CHANGED */
        }
        .booking-summary {
            background: #EFDFBB; /* Dutch White - CHANGED */
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 4px 15px rgba(114, 47, 55, 0.1); /* Wine with opacity - CHANGED */
            height: fit-content;
            position: sticky;
            top: 20px;
            border: 2px solid #722F37; /* Wine - CHANGED */
        }
        .section-title {
            font-size: 1.5rem;
            color: #722F37; /* Wine - CHANGED */
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #722F37; /* Wine - CHANGED */
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .form-group {
            margin-bottom: 25px;
        }
        .form-group label {
            display: block;
            color: #722F37; /* Wine - CHANGED */
            font-weight: 600;
            margin-bottom: 10px;
            font-size: 0.95rem;
        }
        .form-group select,
        .form-group input {
            width: 100%;
            padding: 14px;
            border: 2px solid #722F37; /* Wine - CHANGED */
            border-radius: 8px;
            font-size: 1rem;
            background: rgba(255, 255, 255, 0.9);
            color: #722F37; /* Wine - CHANGED */
            transition: all 0.3s ease;
        }
        .form-group select:focus,
        .form-group input:focus {
            outline: none;
            border-color: #5a2530; /* Darker Wine - CHANGED */
            box-shadow: 0 0 0 3px rgba(114, 47, 55, 0.1); /* Wine with opacity - CHANGED */
            transform: translateY(-2px);
        }
        .payment-method-options {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(140px, 1fr));
            gap: 15px;
            margin-top: 10px;
        }
        .payment-method-card {
            border: 2px solid #722F37; /* Wine - CHANGED */
            border-radius: 10px;
            padding: 20px 15px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.9);
        }
        .payment-method-card:hover {
            border-color: #5a2530; /* Darker Wine - CHANGED */
            background: rgba(114, 47, 55, 0.05); /* Wine with opacity - CHANGED */
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(114, 47, 55, 0.1); /* Wine with opacity - CHANGED */
        }
        .payment-method-card input[type="radio"] {
            display: none;
        }
        .payment-method-card.selected {
            border-color: #5a2530; /* Darker Wine - CHANGED */
            background: rgba(114, 47, 55, 0.1); /* Wine with opacity - CHANGED */
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(114, 47, 55, 0.15); /* Wine with opacity - CHANGED */
        }
        .method-icon {
            font-size: 2.2rem;
            color: #722F37; /* Wine - CHANGED */
            margin-bottom: 12px;
            transition: all 0.3s ease;
        }
        .payment-method-card.selected .method-icon {
            color: #5a2530; /* Darker Wine - CHANGED */
            transform: scale(1.1);
        }
        .method-label {
            font-size: 0.9rem;
            color: #722F37; /* Wine - CHANGED */
            display: block;
            font-weight: 500;
            text-transform: capitalize;
        }
        .summary-item {
            display: flex;
            justify-content: space-between;
            padding: 14px 0;
            border-bottom: 1px solid rgba(114, 47, 55, 0.2); /* Wine with opacity - CHANGED */
        }
        .summary-item:last-child {
            border-bottom: none;
        }
        .summary-label {
            color: #722F37; /* Wine - CHANGED */
            font-weight: 500;
        }
        .summary-value {
            color: #722F37; /* Wine - CHANGED */
            font-weight: 600;
        }
        .summary-total {
            font-size: 1.3rem;
            color: #722F37; /* Wine - CHANGED */
            font-weight: 700;
        }
        .btn {
            padding: 16px 30px;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            cursor: pointer;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            transition: all 0.3s ease;
            width: 100%;
            font-weight: 600;
            letter-spacing: 0.5px;
        }
        .btn-primary {
            background: #722F37; /* Wine - CHANGED */
            color: #EFDFBB; /* Dutch White - CHANGED */
            border: 2px solid #722F37; /* Wine - CHANGED */
        }
        .btn-primary:hover {
            background: #5a2530; /* Darker Wine - CHANGED */
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(114, 47, 55, 0.3); /* Wine with opacity - CHANGED */
        }
        .btn-secondary {
            background: #EFDFBB; /* Dutch White - CHANGED */
            color: #722F37; /* Wine - CHANGED */
            border: 2px solid #722F37; /* Wine - CHANGED */
            margin-top: 15px;
        }
        .btn-secondary:hover {
            background: #722F37; /* Wine - CHANGED */
            color: #EFDFBB; /* Dutch White - CHANGED */
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(114, 47, 55, 0.2); /* Wine with opacity - CHANGED */
        }
        .property-info {
            background: rgba(114, 47, 55, 0.05); /* Wine with opacity - CHANGED */
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 25px;
            border: 2px solid #722F37; /* Wine - CHANGED */
        }
        .property-info h4 {
            color: #722F37; /* Wine - CHANGED */
            margin-bottom: 12px;
            font-size: 1.2rem;
        }
        .property-info p {
            color: #722F37; /* Wine - CHANGED */
            font-size: 0.95rem;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .property-info i {
            color: #722F37; /* Wine - CHANGED */
        }
        .alert {
            padding: 18px;
            border-radius: 10px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 12px;
            font-weight: 500;
        }
        .alert-info {
            background: rgba(114, 47, 55, 0.1); /* Wine with opacity - CHANGED */
            color: #722F37; /* Wine - CHANGED */
            border: 2px solid #722F37; /* Wine - CHANGED */
        }
        .alert i {
            color: #722F37; /* Wine - CHANGED */
            font-size: 1.2rem;
        }
        .security-badge {
            margin-top: 25px;
            padding-top: 20px;
            border-top: 2px solid rgba(114, 47, 55, 0.2); /* Wine with opacity - CHANGED */
            text-align: center;
        }
        .security-badge p {
            color: #722F37; /* Wine - CHANGED */
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            opacity: 0.8;
        }
        .security-badge i {
            color: #722F37; /* Wine - CHANGED */
        }
        
        /* Payment method specific styling */
        .payment-method-card[data-method="CREDIT_CARD"] .method-icon,
        .payment-method-card[data-method="DEBIT_CARD"] .method-icon {
            color: #722F37; /* Wine - CHANGED */
        }
        .payment-method-card[data-method="UPI"] .method-icon {
            color: #722F37; /* Wine - CHANGED */
        }
        .payment-method-card[data-method="NET_BANKING"] .method-icon {
            color: #722F37; /* Wine - CHANGED */
        }
        .payment-method-card[data-method="WALLET"] .method-icon {
            color: #722F37; /* Wine - CHANGED */
        }
        
        /* Responsive Design */
        @media (max-width: 992px) {
            .payment-container {
                grid-template-columns: 1fr;
                gap: 20px;
            }
            .booking-summary {
                position: static;
            }
        }
        
        @media (max-width: 768px) {
            .payment-method-options {
                grid-template-columns: repeat(2, 1fr);
            }
            .header {
                padding: 15px 20px;
                flex-direction: column;
                gap: 15px;
            }
            .nav-links {
                flex-wrap: wrap;
                justify-content: center;
            }
        }
        
        @media (max-width: 480px) {
            .payment-method-options {
                grid-template-columns: 1fr;
            }
            .payment-form-section,
            .booking-summary {
                padding: 20px;
            }
            .btn {
                padding: 14px 20px;
            }
        }
        
        /* Animation for payment processing */
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        .processing {
            animation: pulse 1.5s infinite;
        }
    </style>
    <script>
        function selectPaymentMethod(method, element) {
            document.querySelectorAll('.payment-method-card').forEach(card => {
                card.classList.remove('selected');
            });
            element.classList.add('selected');
            document.getElementById('paymentMethod').value = method;
            
            // Add subtle animation
            element.style.animation = 'none';
            setTimeout(() => {
                element.style.animation = 'pulse 0.5s ease';
            }, 10);
        }
        
        function handlePaymentSubmit(event) {
            const selectedMethod = document.getElementById('paymentMethod').value;
            if (!selectedMethod) {
                event.preventDefault();
                alert('Please select a payment method');
                return false;
            }
            
            const submitBtn = event.target.querySelector('button[type="submit"]');
            if (submitBtn) {
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing Payment...';
                submitBtn.disabled = true;
                submitBtn.classList.add('processing');
            }
            
            return true;
        }
        
        // Auto-select first payment method
        document.addEventListener('DOMContentLoaded', function() {
            const firstCard = document.querySelector('.payment-method-card');
            if (firstCard) {
                const method = firstCard.dataset.method;
                selectPaymentMethod(method, firstCard);
            }
        });
    </script>
</head>
<body>
    <div class="header">
        <h1><i class="fas fa-building"></i> GlobalPiligrim Accommodation</h1>
        <div class="nav-links">
            <a href="/pilgrim/accommodation/">Home</a>
            <a href="/pilgrim/accommodation/user/dashboard">Dashboard</a>
            <a href="/pilgrim/accommodation/logout">Logout</a>
        </div>
    </div>

    <div class="container">
        <c:if test="${not empty booking}">
            <div class="payment-container">
                <div class="payment-form-section">
                    <h2 class="section-title"><i class="fas fa-credit-card"></i> Payment Details</h2>
                    
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle"></i> This is a demo payment. Your booking will be confirmed after payment.
                    </div>
                    
                    <form method="post" action="/pilgrim/accommodation/user/payment/process" onsubmit="return handlePaymentSubmit(event)">
                        <input type="hidden" name="bookingId" value="${booking.id}">
                        <input type="hidden" id="paymentMethod" name="paymentMethod" value="">
                        
                        <div class="form-group">
                            <label>Select Payment Method</label>
                            <div class="payment-method-options">
                                <c:forEach var="method" items="${paymentMethods}">
                                    <div class="payment-method-card" data-method="${method}" onclick="selectPaymentMethod('${method}', this)">
                                        <input type="radio" name="paymentMethod" value="${method}" id="method_${method}" required>
                                        <div class="method-icon">
                                            <c:choose>
                                                <c:when test="${method == 'CREDIT_CARD'}"><i class="fas fa-credit-card"></i></c:when>
                                                <c:when test="${method == 'DEBIT_CARD'}"><i class="fas fa-credit-card"></i></c:when>
                                                <c:when test="${method == 'UPI'}"><i class="fas fa-mobile-alt"></i></c:when>
                                                <c:when test="${method == 'NET_BANKING'}"><i class="fas fa-university"></i></c:when>
                                                <c:when test="${method == 'WALLET'}"><i class="fas fa-wallet"></i></c:when>
                                                <c:otherwise><i class="fas fa-money-bill"></i></c:otherwise>
                                            </c:choose>
                                        </div>
                                        <label for="method_${method}" class="method-label">
                                            ${fn:replace(fn:toLowerCase(method), '_', ' ')}
                                        </label>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                        
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-lock"></i> Pay ₹${booking.totalAmount}
                        </button>
                        
                        <a href="/pilgrim/accommodation/user/bookings" class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i> Back to Bookings
                        </a>
                    </form>
                </div>
                
                <div class="booking-summary">
                    <h3 class="section-title"><i class="fas fa-receipt"></i> Booking Summary</h3>
                    
                    <div class="property-info">
                        <h4>
                            <c:choose>
                                <c:when test="${booking.property.details != null && booking.property.details.propertyName != null}">
                                    ${booking.property.details.propertyName}
                                </c:when>
                                <c:otherwise>
                                    Property #${booking.property.id}
                                </c:otherwise>
                            </c:choose>
                        </h4>
                        <p><i class="fas fa-map-marker-alt"></i> 
                            <c:choose>
                                <c:when test="${booking.property.location != null && booking.property.location.city != null}">
                                    ${booking.property.location.city}, ${booking.property.location.state}
                                </c:when>
                                <c:otherwise>
                                    Location not available
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                    
                    <div class="summary-item">
                        <span class="summary-label">Check-in</span>
                        <span class="summary-value">${booking.checkInDate}</span>
                    </div>
                    <div class="summary-item">
                        <span class="summary-label">Check-out</span>
                        <span class="summary-value">${booking.checkOutDate}</span>
                    </div>
                    <div class="summary-item">
                        <span class="summary-label">Guests</span>
                        <span class="summary-value">${booking.numberOfGuests}</span>
                    </div>
                    <c:if test="${booking.numberOfRooms != null}">
                        <div class="summary-item">
                            <span class="summary-label">Rooms</span>
                            <span class="summary-value">${booking.numberOfRooms}</span>
                        </div>
                    </c:if>
                    <div class="summary-item">
                        <span class="summary-label">Booking Reference</span>
                        <span class="summary-value">${booking.referenceNumber}</span>
                    </div>
                    
                    <div class="summary-item" style="margin-top: 20px; padding-top: 20px; border-top: 2px solid rgba(114, 47, 55, 0.3);">
                        <span class="summary-label summary-total">Total Amount</span>
                        <span class="summary-value summary-total">₹${booking.totalAmount}</span>
                    </div>
                    
                    <div class="security-badge">
                        <p>
                            <i class="fas fa-shield-alt"></i> Secure & Encrypted Payment
                        </p>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
</body>
</html>