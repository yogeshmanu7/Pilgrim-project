<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment - GlobalPiligrim</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        .user-theme {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            padding: 40px 0;
            margin-bottom: 30px;
        }
        .user-card {
            border-left: 4px solid #11998e;
            box-shadow: 0 4px 15px rgba(17, 153, 142, 0.2);
        }
        .user-btn {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            border: none;
            color: white;
        }
        .user-btn:hover {
            background: linear-gradient(135deg, #38ef7d 0%, #11998e 100%);
            color: white;
        }
    </style>
</head>
<body>
    <div class="user-theme">
        <div class="container">
            <h1 class="text-white mb-0" style="font-size: 36px;">💳 Complete Payment</h1>
        </div>
    </div>
    
    <div class="container">
        <div class="card user-card mx-auto" style="max-width: 600px;">
            <div class="card-header bg-success text-white">
                <h2 class="card-title mb-0">Booking Details</h2>
            </div>
            <div class="card-body">
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-circle me-2"></i>${error}
                    </div>
                </c:if>
                
                <div class="mb-4">
                    <p><strong>Scholar:</strong> ${booking.scholar.user.name}</p>
                    <p><strong>Service Type:</strong> ${booking.serviceType}</p>
                    <p><strong>Service Date:</strong> ${booking.serviceDate != null ? booking.serviceDate.toString().replace('T', ' ').substring(0, 16) : 'N/A'}</p>
                    <c:if test="${not empty booking.serviceLocation}">
                        <p><strong>Location:</strong> ${booking.serviceLocation}</p>
                    </c:if>
                    <p><strong>Amount:</strong> ₹<fmt:formatNumber value="${booking.totalAmount}" pattern="#,##,##0.00"/></p>
                </div>
                
                <form id="paymentForm" action="${pageContext.request.contextPath}/customer/scholar/payment/success" method="POST">
                    <input type="hidden" name="bookingId" value="${booking.id}">
                    <input type="hidden" name="razorpay_order_id" id="razorpay_order_id">
                    <input type="hidden" name="razorpay_payment_id" id="razorpay_payment_id">
                    <input type="hidden" name="razorpay_signature" id="razorpay_signature">
                    
                    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
                    <button type="button" class="btn user-btn w-100" style="font-size: 1.2rem; padding: 15px;" onclick="payNow()">
                        <i class="fas fa-credit-card me-2"></i>Pay ₹<fmt:formatNumber value="${booking.totalAmount}" pattern="#,##,##0.00"/>
                    </button>
                </form>
            </div>
        </div>
    </div>
    
    <script>
        function payNow() {
            var options = {
                "key": "${keyId}",
                "amount": ${amount},
                "currency": "${currency}",
                "name": "GlobalPiligrim",
                "description": "Booking Payment for ${booking.scholar.user.name}",
                "order_id": "${orderId}",
                "handler": function (response) {
                    document.getElementById('razorpay_order_id').value = response.razorpay_order_id;
                    document.getElementById('razorpay_payment_id').value = response.razorpay_payment_id;
                    document.getElementById('razorpay_signature').value = response.razorpay_signature;
                    document.getElementById('paymentForm').submit();
                },
                "prefill": {
                    "name": "${booking.customer.name}",
                    "email": "${booking.customer.email}",
                    "contact": "${booking.customer.phone}"
                },
                "theme": {
                    "color": "#11998e"
                }
            };
            var rzp = new Razorpay(options);
            rzp.open();
        }
    </script>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

