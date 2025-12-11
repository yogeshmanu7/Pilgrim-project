<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Details - GlobalPiligrim</title>
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
            padding: 20px 0;
            position: relative;
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
        
        .container {
            position: relative;
            z-index: 1;
        }
        
        h1, h2, h3, h4, h5, h6 {
            font-family: 'Merriweather', serif;
            color: var(--text-wine);
        }
        
        .card {
            border: 2px solid var(--border-wine);
            border-radius: 12px;
            box-shadow: var(--shadow-wine);
            background: white;
        }
        
        .bg-primary {
            background: linear-gradient(135deg, var(--wine) 0%, var(--wine-dark) 100%) !important;
            color: var(--text-cream) !important;
        }
        
        .card-title {
            color: var(--text-cream) !important;
        }
        
        .btn-secondary {
            background: var(--wine);
            border: none;
            color: var(--text-cream);
            border-radius: 8px;
        }
        
        .btn-secondary:hover {
            background: var(--wine-dark);
            color: var(--text-cream);
        }
        
        /* Badge Styling */
        .badge.bg-success {
            background: #198754 !important;
            color: white;
        }
        
        .badge.bg-danger {
            background: #dc3545 !important;
            color: white;
        }
        
        .badge.bg-warning {
            background: #ffc107 !important;
            color: #212529;
        }
        
        hr {
            border-color: var(--border-wine);
        }
        
        a {
            color: var(--text-wine);
            text-decoration: none;
        }
        
        a:hover {
            color: var(--wine-dark);
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <!-- Background Pattern -->
    <div class="bg-pattern"></div>
    
    <div class="container mt-4">
        <div class="card">
            <div class="card-header bg-primary">
                <h2 class="card-title mb-0">Booking Details</h2>
            </div>
            <div class="card-body">
                <c:if test="${not empty booking}">
                    <div class="row">
                        <div class="col-md-6">
                            <h5>Customer Information</h5>
                            <p><strong>Name:</strong> ${booking.customer.name}</p>
                            <p><strong>Email:</strong> ${booking.customer.email}</p>
                            <p><strong>Phone:</strong> ${booking.customer.phone}</p>
                        </div>
                        <div class="col-md-6">
                            <h5>Scholar Information</h5>
                            <p><strong>Name:</strong> ${booking.scholar.user.name}</p>
                            <p><strong>Type:</strong> ${booking.scholar.type}</p>
                            <p><strong>Email:</strong> ${booking.scholar.user.email}</p>
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-md-6">
                            <h5>Booking Information</h5>
                            <p><strong>Booking ID:</strong> ${booking.id}</p>
                            <p><strong>Status:</strong> 
                                <span class="badge bg-${booking.status == 'CONFIRMED' ? 'success' : booking.status == 'REJECTED' ? 'danger' : 'warning'}">
                                    ${booking.status}
                                </span>
                            </p>
                            <p><strong>Service Type:</strong> ${booking.serviceType}</p>
                            <p><strong>Service Date:</strong> ${booking.serviceDate != null ? booking.serviceDate.toString().replace('T', ' ').substring(0, 16) : 'N/A'}</p>
                            <p><strong>Booking Date:</strong> ${booking.bookingDate != null ? booking.bookingDate.toString().replace('T', ' ').substring(0, 16) : 'N/A'}</p>
                        </div>
                        <div class="col-md-6">
                            <h5>Service Details</h5>
                            <c:if test="${not empty booking.serviceLocation}">
                                <p><strong>Location:</strong> ${booking.serviceLocation}</p>
                            </c:if>
                            <p><strong>Amount:</strong> ₹<fmt:formatNumber value="${booking.totalAmount}" pattern="#,##,##0.00"/></p>
                            <c:if test="${not empty booking.serviceDescription}">
                                <p><strong>Description:</strong> ${booking.serviceDescription}</p>
                            </c:if>
                            <c:if test="${not empty booking.videoCallLink}">
                                <p><strong>Video Call Link:</strong> <a href="${booking.videoCallLink}" target="_blank">${booking.videoCallLink}</a></p>
                            </c:if>
                        </div>
                    </div>
                </c:if>
                <div class="mt-3">
                    <a href="${pageContext.request.contextPath}/admin/scholars/bookings" class="btn btn-secondary">
                        <i class="fas fa-arrow-left me-2"></i>Back to Bookings
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>