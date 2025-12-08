<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard - GlobalPiligrim</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        /* ===== GLOBAL STYLES ===== */
        body {
            background: #f3e6d3;
            font-family: 'Inter', sans-serif;
        }
        
        /* ===== HEADER THEME ===== */
        .user-theme {
            background: linear-gradient(135deg, rgba(20, 20, 20, 0.95) 0%, rgba(34, 34, 34, 0.95) 100%);
            padding: 50px 0;
            margin-bottom: 40px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }
        
        /* ===== CARD STYLES ===== */
        .user-card {
            border: none;
            border-radius: 22px;
            box-shadow: 0 20px 45px rgba(0, 0, 0, 0.12);
            transition: all 0.4s ease;
            background: #fff;
            overflow: hidden;
        }
        
        .user-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 35px 70px rgba(0, 0, 0, 0.18);
        }
        
        .card-header {
            background: linear-gradient(135deg, #d4af37 0%, #c19b2e 100%);
            border: none;
            padding: 20px 30px;
            border-radius: 22px 22px 0 0;
        }
        
        .card-header h2 {
            font-family: 'Playfair Display', serif;
            font-size: 1.8rem;
            color: #000;
            font-weight: 700;
            margin: 0;
        }
        
        /* ===== BUTTON STYLES ===== */
        .user-btn {
            background: linear-gradient(135deg, #d4af37, #c19b2e);
            border: none;
            color: #000;
            font-weight: 600;
            padding: 12px 30px;
            border-radius: 12px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(212, 175, 55, 0.3);
        }
        
        .user-btn:hover {
            background: linear-gradient(135deg, #c19b2e, #d4af37);
            color: #000;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(212, 175, 55, 0.4);
        }
        
        .btn-outline-success {
            border: 2px solid #d4af37;
            color: #d4af37;
            background: transparent;
            font-weight: 600;
            padding: 12px 30px;
            border-radius: 12px;
            transition: all 0.3s ease;
        }
        
        .btn-outline-success:hover {
            background: linear-gradient(135deg, #d4af37, #c19b2e);
            color: #000;
            border-color: #d4af37;
            transform: translateY(-2px);
        }
        
        /* ===== SCHOLAR CARD ENHANCEMENT ===== */
        .scholar-card {
            border-radius: 22px;
            overflow: hidden;
            transition: all 0.4s ease;
            height: 100%;
            border: 2px solid transparent;
        }
        
        .scholar-card:hover {
            border-color: #d4af37;
            transform: translateY(-10px);
        }
        
        .scholar-card .card-img-top {
            height: 250px;
            object-fit: cover;
            transition: transform 0.4s ease;
        }
        
        .scholar-card:hover .card-img-top {
            transform: scale(1.05);
        }
        
        .scholar-card .card-body {
            padding: 1.5rem;
        }
        
        .scholar-card h5 {
            color: #222;
            font-weight: 700;
            font-size: 1.3rem;
            margin-bottom: 1rem;
            font-family: 'Playfair Display', serif;
        }
        
        .scholar-card .text-success {
            color: #d4af37 !important;
        }
        
        .scholar-info {
            color: #666;
            font-size: 0.95rem;
            margin-bottom: 0.5rem;
        }
        
        .scholar-info strong {
            color: #222;
            font-weight: 600;
        }
        
        .rating-badge {
            background: linear-gradient(135deg, rgba(212, 175, 55, 0.1), rgba(212, 175, 55, 0.2));
            color: #5a4a1f;
            padding: 5px 12px;
            border-radius: 20px;
            display: inline-block;
            font-weight: 600;
        }
        
        /* ===== BOOKING CARD ENHANCEMENT ===== */
        .booking-card {
            border-radius: 22px;
            overflow: hidden;
            transition: all 0.4s ease;
            border: 2px solid transparent;
        }
        
        .booking-card:hover {
            border-color: #d4af37;
            transform: translateY(-5px);
        }
        
        .booking-card .card-body {
            padding: 1.5rem;
        }
        
        .booking-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #d4af37;
            box-shadow: 0 4px 15px rgba(212, 175, 55, 0.3);
        }
        
        .booking-avatar-placeholder {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: linear-gradient(135deg, #d4af37, #c19b2e);
            color: #000;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 32px;
            font-weight: 700;
            border: 3px solid #d4af37;
        }
        
        .booking-title {
            color: #222;
            font-weight: 700;
            font-size: 1.2rem;
            margin-bottom: 0.5rem;
            font-family: 'Playfair Display', serif;
        }
        
        .booking-detail {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 0.4rem;
        }
        
        .booking-detail strong {
            color: #222;
            font-weight: 600;
        }
        
        .status-badge {
            padding: 6px 14px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.85rem;
            display: inline-block;
        }
        
        .status-confirmed {
            background: linear-gradient(135deg, #2ecc71, #27ae60);
            color: white;
        }
        
        .status-pending {
            background: linear-gradient(135deg, #f39c12, #e67e22);
            color: white;
        }
        
        .status-rejected {
            background: linear-gradient(135deg, #e74c3c, #c0392b);
            color: white;
        }
        
        .status-completed {
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
        }
        
        /* ===== ALERT ENHANCEMENTS ===== */
        .alert-warning {
            background: linear-gradient(135deg, rgba(243, 156, 18, 0.1), rgba(230, 126, 34, 0.1));
            border-left: 4px solid #f39c12;
            color: #8b4513;
            border-radius: 12px;
            padding: 15px 20px;
        }
        
        .alert-info {
            background: linear-gradient(135deg, rgba(52, 152, 219, 0.1), rgba(41, 128, 185, 0.1));
            border-left: 4px solid #3498db;
            color: #1a5490;
            border-radius: 12px;
            padding: 15px 20px;
        }
        
        .alert-success {
            background: linear-gradient(135deg, rgba(46, 204, 113, 0.1), rgba(39, 174, 96, 0.1));
            border-left: 4px solid #2ecc71;
            color: #1e8449;
            border-radius: 12px;
            padding: 15px 20px;
        }
        
        /* ===== PRICE STYLING ===== */
        .price-highlight {
            color: #d4af37;
            font-weight: 700;
            font-size: 1.2rem;
        }
        
        /* ===== EMPTY STATE ===== */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }
        
        .empty-state i {
            font-size: 4rem;
            color: #d4af37;
            margin-bottom: 1rem;
        }
        
        /* ===== SECTION SPACING ===== */
        .section-spacing {
            margin-bottom: 3rem;
        }
        
        /* ===== RESPONSIVE ===== */
        @media (max-width: 768px) {
            .user-theme {
                padding: 30px 0;
            }
            
            .card-header h2 {
                font-size: 1.4rem;
            }
        }
    </style>
</head>
<body>
    <div class="user-theme">
        <div class="container">
            <h1 class="text-white mb-0" style="font-size: 42px; font-family: 'Playfair Display', serif; font-weight: 700;">
                <i class="fas fa-user-circle me-2" style="color: #d4af37;"></i>User Dashboard
            </h1>
            <p class="text-white mt-3" style="opacity: 0.95; font-size: 20px; font-weight: 500;">
                Welcome back, <span style="color: #d4af37; font-weight: 600;">${user.name}</span>
            </p>
        </div>
    </div>
    
    <div class="container">
        <!-- Available Scholars Section -->
        <div class="card user-card section-spacing">
            <div class="card-header">
                <h2 class="card-title mb-0">
                    <i class="fas fa-book-reader me-2"></i>Available Scholars to Book
                </h2>
            </div>
            <div class="card-body" style="padding: 2rem;">
                <c:choose>
                    <c:when test="${empty scholars || scholars.size() == 0}">
                        <div class="empty-state">
                            <i class="fas fa-user-slash"></i>
                            <h4 style="color: #222; margin-bottom: 1rem;">No Scholars Available</h4>
                            <p style="color: #666; font-size: 1.1rem;">No approved scholars available at the moment. Please check back later.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="row g-4">
                            <c:forEach var="scholar" items="${scholars}">
                                <div class="col-md-4">
                                    <div class="card scholar-card h-100">
                                        <c:choose>
                                            <c:when test="${not empty scholar.profilePhotoPath}">
                                                <img src="${pageContext.request.contextPath}/uploads/${scholar.profilePhotoPath}" 
                                                     alt="Profile" class="card-img-top">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="d-flex align-items-center justify-content-center" 
                                                     style="height: 250px; background: linear-gradient(135deg, #d4af37, #c19b2e); font-size: 64px; color: #000; font-weight: 700;">
                                                    ${scholar.user.name.charAt(0)}
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                        <div class="card-body">
                                            <h5 class="text-success">${scholar.user.name}</h5>
                                            
                                            <div class="scholar-info">
                                                <strong><i class="fas fa-user-tie me-1" style="color: #d4af37;"></i>Type:</strong> 
                                                ${scholar.type == 'ASTROLOGER' ? '🔮 Astrologer' : '📿 Spiritual Scholar'}
                                            </div>
                                            
                                            <div class="scholar-info">
                                                <strong><i class="fas fa-star me-1" style="color: #d4af37;"></i>Rating:</strong>
                                                <span class="rating-badge">
                                                    ${scholar.rating != null ? scholar.rating : 0} ⭐ 
                                                    (${scholar.totalReviews != null ? scholar.totalReviews : 0} reviews)
                                                </span>
                                            </div>
                                            
                                            <div class="scholar-info">
                                                <strong><i class="fas fa-rupee-sign me-1" style="color: #d4af37;"></i>Price:</strong>
                                                <span class="price-highlight">
                                                    ₹<fmt:formatNumber value="${scholar.basePrice != null ? scholar.basePrice : 0}" pattern="#,##,##0.00"/>
                                                </span>
                                            </div>
                                            
                                            <div class="scholar-info">
                                                <strong><i class="fas fa-briefcase me-1" style="color: #d4af37;"></i>Experience:</strong>
                                                ${scholar.experienceYears != null ? scholar.experienceYears : 0} years
                                            </div>
                                            
                                            <c:if test="${not empty scholar.serviceAreas}">
                                                <div class="scholar-info">
                                                    <strong><i class="fas fa-map-marker-alt me-1" style="color: #d4af37;"></i>Service Areas:</strong>
                                                    ${scholar.serviceAreas}
                                                </div>
                                            </c:if>
                                            
                                            <div class="mt-3">
                                                <a href="${pageContext.request.contextPath}/customer/scholar/book?scholarId=${scholar.id}" 
                                                   class="btn user-btn w-100">
                                                    <i class="fas fa-calendar-check me-2"></i>Book Now
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <div class="mt-4 text-center">
                            <a href="${pageContext.request.contextPath}/customer/scholar/search" class="btn btn-outline-success">
                                <i class="fas fa-search me-2"></i>Advanced Search
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        
        <!-- My Bookings Section -->
        <div class="card user-card">
            <div class="card-header">
                <h2 class="card-title mb-0">
                    <i class="fas fa-calendar-alt me-2"></i>My Bookings
                </h2>
            </div>
            <div class="card-body" style="padding: 2rem;">
                <c:choose>
                    <c:when test="${empty bookings || bookings.size() == 0}">
                        <div class="empty-state">
                            <i class="fas fa-calendar-times"></i>
                            <h4 style="color: #222; margin-bottom: 1rem;">No Bookings Yet</h4>
                            <p style="color: #666; font-size: 1.1rem; margin-bottom: 2rem;">
                                You haven't made any bookings yet. Start by exploring our available scholars!
                            </p>
                            <a href="${pageContext.request.contextPath}/customer/scholar/search" class="btn user-btn">
                                <i class="fas fa-search me-2"></i>Search & Book Scholars
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="row g-4">
                            <c:forEach var="booking" items="${bookings}">
                                <div class="col-md-6">
                                    <div class="card booking-card h-100">
                                        <div class="card-body">
                                            <div class="d-flex align-items-start gap-3 mb-3">
                                                <c:choose>
                                                    <c:when test="${not empty booking.scholar.profilePhotoPath}">
                                                        <img src="${pageContext.request.contextPath}/uploads/${booking.scholar.profilePhotoPath}" 
                                                             alt="Scholar Photo" class="booking-avatar">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="booking-avatar-placeholder">
                                                            ${booking.scholar.user.name.charAt(0)}
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                                <div style="flex: 1;">
                                                    <h5 class="booking-title text-success">${booking.scholar.user.name}</h5>
                                                    
                                                    <div class="booking-detail">
                                                        <strong><i class="fas fa-calendar me-1" style="color: #d4af37;"></i>Service Date:</strong>
                                                        ${booking.serviceDate != null ? booking.serviceDate.toString().replace('T', ' ').substring(0, 16) : 'N/A'}
                                                    </div>
                                                    
                                                    <div class="booking-detail">
                                                        <strong><i class="fas fa-info-circle me-1" style="color: #d4af37;"></i>Status:</strong>
                                                        <c:choose>
                                                            <c:when test="${booking.status == 'CONFIRMED'}">
                                                                <span class="status-badge status-confirmed">✓ CONFIRMED</span>
                                                            </c:when>
                                                            <c:when test="${booking.status == 'PENDING_CONFIRMATION'}">
                                                                <span class="status-badge status-pending">⏳ PENDING</span>
                                                            </c:when>
                                                            <c:when test="${booking.status == 'REJECTED'}">
                                                                <span class="status-badge status-rejected">✗ REJECTED</span>
                                                            </c:when>
                                                            <c:when test="${booking.status == 'COMPLETED'}">
                                                                <span class="status-badge status-completed">✅ COMPLETED</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="status-badge status-pending">${booking.status}</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    
                                                    <div class="booking-detail">
                                                        <strong><i class="fas fa-rupee-sign me-1" style="color: #d4af37;"></i>Amount:</strong>
                                                        <span class="price-highlight">
                                                            ₹<fmt:formatNumber value="${booking.totalAmount}" pattern="#,##,##0.00"/>
                                                        </span>
                                                    </div>
                                                    
                                                    <div class="booking-detail">
                                                        <strong><i class="fas fa-tag me-1" style="color: #d4af37;"></i>Service Type:</strong>
                                                        ${booking.serviceType}
                                                    </div>
                                                    
                                                    <c:if test="${not empty booking.serviceDescription}">
                                                        <div class="booking-detail">
                                                            <strong><i class="fas fa-file-alt me-1" style="color: #d4af37;"></i>Description:</strong>
                                                            <span style="color: #666; font-size: 0.9rem;">${booking.serviceDescription}</span>
                                                        </div>
                                                    </c:if>
                                                </div>
                                            </div>
                                            
                                            <c:if test="${booking.status == 'PENDING_CONFIRMATION'}">
                                                <div class="alert alert-warning">
                                                    <strong><i class="fas fa-exclamation-triangle me-2"></i>Payment Required</strong><br>
                                                    Please complete payment to confirm your booking.
                                                </div>
                                                <div class="d-flex gap-2 flex-wrap">
                                                    <a href="${pageContext.request.contextPath}/customer/scholar/payment/initiate?bookingId=${booking.id}" 
                                                       class="btn user-btn flex-fill">
                                                        <i class="fas fa-credit-card me-2"></i>Pay ₹<fmt:formatNumber value="${booking.totalAmount}" pattern="#,##,##0.00"/>
                                                    </a>
                                                    <form method="post" action="${pageContext.request.contextPath}/customer/scholar/booking/cancel" class="flex-fill">
                                                        <input type="hidden" name="bookingId" value="${booking.id}">
                                                        <button type="submit" class="btn btn-danger w-100" onclick="return confirm('Are you sure you want to cancel this booking?')">
                                                            <i class="fas fa-times me-2"></i>Cancel
                                                        </button>
                                                    </form>
                                                </div>
                                            </c:if>
                                            
                                            <c:if test="${booking.status == 'CONFIRMED'}">
                                                <div class="alert alert-info">
                                                    <strong><i class="fas fa-check-circle me-2"></i>Booking Confirmed!</strong><br>
                                                    You can now chat and use video call services with your scholar.
                                                </div>
                                                <div class="d-flex gap-2 flex-wrap">
                                                    <a href="${pageContext.request.contextPath}/customer/scholar/chat?scholarId=${booking.scholar.id}&bookingId=${booking.id}" 
                                                       class="btn user-btn flex-fill">
                                                        <i class="fas fa-comments me-2"></i>Chat with Scholar
                                                    </a>
                                                    <c:if test="${booking.serviceType == 'VIDEO_CALL' && not empty booking.videoCallLink}">
                                                        <a href="${pageContext.request.contextPath}/customer/scholar/video-call?bookingId=${booking.id}" 
                                                           class="btn user-btn flex-fill">
                                                            <i class="fas fa-video me-2"></i>Video Call
                                                        </a>
                                                    </c:if>
                                                </div>
                                            </c:if>
                                            
                                            <c:if test="${booking.status == 'COMPLETED'}">
                                                <div class="alert alert-success">
                                                    <strong><i class="fas fa-check-double me-2"></i>Service Completed</strong><br>
                                                    This booking has been completed. Share your experience with a review!
                                                </div>
                                                <div class="mt-2">
                                                    <a href="${pageContext.request.contextPath}/customer/scholar/review/submit?bookingId=${booking.id}" 
                                                       class="btn user-btn">
                                                        <i class="fas fa-star me-2"></i>Submit Review
                                                    </a>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

