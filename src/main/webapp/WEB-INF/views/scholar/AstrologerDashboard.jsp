<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Astrologer Dashboard - GlobalPiligrim</title>
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
        color: var(--text-wine);
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
    
    main {
        position: relative;
        z-index: 1;
    }
    
    .astrologer-theme {
        background: linear-gradient(135deg, var(--wine) 0%, var(--wine-dark) 100%);
    }
    .astrologer-card {
        background: white;
        border: 2px solid var(--border-wine);
        border-left: 4px solid var(--border-wine);
        border-radius: 12px;
        box-shadow: var(--shadow-wine);
    }
    .astrologer-btn {
        background: linear-gradient(135deg, var(--wine) 0%, var(--wine-dark) 100%);
        border: none;
        color: var(--text-cream);
        border-radius: 8px;
        font-weight: 600;
        transition: all 0.3s ease;
    }
    .astrologer-btn:hover {
        background: linear-gradient(135deg, var(--wine-dark) 0%, var(--wine) 100%);
        transform: translateY(-2px);
        box-shadow: var(--shadow-wine);
        color: var(--text-cream);
    }
    
    /* Badge Styling */
    .badge-approved {
        background: var(--wine);
        color: var(--dutch-white);
    }
    .badge-rejected {
        background: #dc3545;
        color: white;
    }
    .badge-pending {
        background: #ffc107;
        color: #212529;
    }
    
    h1, h2, h3, h4, h5, h6 {
        font-family: 'Merriweather', serif;
        color: var(--text-wine);
    }
    
    /* Logout Button */
    .btn-logout-scholar {
        background: rgba(239, 223, 187, 0.2);
        color: var(--text-cream);
        border: 2px solid rgba(239, 223, 187, 0.3);
        padding: 12px 24px;
        border-radius: 25px;
        text-decoration: none;
        font-weight: 600;
        font-size: 1rem;
        transition: all 0.3s ease;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        white-space: nowrap;
    }
    
    .btn-logout-scholar:hover {
        background: rgba(239, 223, 187, 0.3);
        border-color: rgba(239, 223, 187, 0.5);
        color: var(--text-cream);
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
    }
    
    .btn-logout-scholar i {
        font-size: 0.9rem;
    }
</style>
</head>
<body>
    <!-- Background Pattern -->
    <div class="bg-pattern"></div>
    
<main>
    <div class="astrologer-theme" style="padding: 40px 0; margin-bottom: 30px;">
        <div class="container">
            <div style="display: flex; justify-content: space-between; align-items: center;">
                <div>
                    <h1 style="color: var(--text-cream); margin: 0; font-size: 36px;">🔮 Astrologer Dashboard</h1>
                    <p style="color: var(--text-cream); opacity: 0.9; margin-top: 10px; font-size: 18px;">Welcome, ${scholar.user.name}</p>
                </div>
                <a href="${pageContext.request.contextPath}/scholar/logout" class="btn-logout-scholar">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </div>
        </div>
    </div>
    
    <div class="container">
        <!-- Profile Section -->
        <div class="card astrologer-card" style="margin-bottom: 30px;">
            <div style="display: flex; align-items: center; gap: 20px;">
                <div>
                    <c:choose>
                        <c:when test="${not empty scholar.profilePhotoPath}">
                            <img src="${pageContext.request.contextPath}/uploads/${scholar.profilePhotoPath}" alt="Profile Photo" 
                                 style="width: 150px; height: 150px; border-radius: 50%; object-fit: cover; border: 3px solid var(--border-wine);">
                        </c:when>
                        <c:otherwise>
                            <div style="width: 150px; height: 150px; border-radius: 50%; background: linear-gradient(135deg, var(--wine) 0%, var(--wine-dark) 100%); display: flex; align-items: center; justify-content: center; color: var(--text-cream); font-size: 48px;">
                                ${scholar.user.name.charAt(0)}
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div style="flex: 1;">
                    <h2 style="color: var(--text-wine);">${scholar.user.name}</h2>
                    <p><strong>Type:</strong> <span style="color: var(--text-wine); font-weight: 600;">Astrologer</span></p>
                    <p><strong>Experience:</strong> ${scholar.experienceYears != null ? scholar.experienceYears : 0} years</p>
                    <p><strong>Rating:</strong> ${scholar.rating != null ? scholar.rating : 0} ⭐ (${scholar.totalReviews != null ? scholar.totalReviews : 0} reviews)</p>
                    <p><strong>Base Price:</strong> ₹${scholar.basePrice != null ? scholar.basePrice : 0}</p>
                    <p><strong>Status:</strong> <span class="badge badge-${scholar.status == 'APPROVED' ? 'approved' : scholar.status == 'REJECTED' ? 'rejected' : 'pending'}">${scholar.status}</span></p>
                </div>
            </div>
        </div>
        
        <!-- Services Section -->
        <div class="card astrologer-card" style="margin-bottom: 30px;">
            <div class="card-header" style="background: linear-gradient(135deg, var(--wine) 0%, var(--wine-dark) 100%); color: var(--text-cream); display: flex; justify-content: space-between; align-items: center;">
                <h2 class="card-title mb-0">My Astrology Services</h2>
                <a href="${pageContext.request.contextPath}/scholar/service/list" class="btn btn-light btn-sm" style="background: white; color: var(--text-wine); border: 1px solid var(--border-wine);">
                    <i class="fas fa-cog me-1"></i>Manage Services
                </a>
            </div>
            <div class="card-body">
                <h3>Specializations:</h3>
                <div style="display: flex; flex-wrap: wrap; gap: 10px; margin-top: 10px;">
                    <c:forEach var="spec" items="${scholar.specializations}">
                        <span style="background: linear-gradient(135deg, var(--wine) 0%, var(--wine-dark) 100%); color: var(--text-cream); padding: 5px 15px; border-radius: 20px; font-size: 14px; border: 1px solid var(--border-wine);">${spec}</span>
                    </c:forEach>
                </div>
                
                <h3 style="margin-top: 20px;">Languages:</h3>
                <div style="display: flex; flex-wrap: wrap; gap: 10px; margin-top: 10px;">
                    <c:forEach var="lang" items="${scholar.languages}">
                        <span style="background: var(--wine-dark); color: var(--text-cream); padding: 5px 15px; border-radius: 20px; font-size: 14px; border: 1px solid var(--border-wine);">${lang}</span>
                    </c:forEach>
                </div>
                
                <p style="margin-top: 20px;"><strong>Service Areas:</strong> ${scholar.serviceAreas != null ? scholar.serviceAreas : 'Not specified'}</p>
                
                <div style="margin-top: 20px; padding: 15px; background: rgba(114, 47, 55, 0.05); border-radius: 8px; border: 1px solid var(--wine-transparent);">
                    <p class="mb-2" style="color: var(--text-wine);"><strong>💡 Tip:</strong> Add service packages to allow customers to book your services. Click "Manage Services" above to get started.</p>
                </div>
            </div>
        </div>
        
        <!-- Quick Actions -->
        <div class="row g-4 mb-4">
            <div class="col-md-4">
                <div class="card astrologer-card text-center">
                    <div class="card-body">
                        <h3 style="color: var(--text-wine);">📞 Video Call</h3>
                        <p style="color: var(--wine-light);">Start or join video calls</p>
                        <a href="${pageContext.request.contextPath}/scholar/video-call" class="btn astrologer-btn">Video Call</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card astrologer-card text-center">
                    <div class="card-body">
                        <h3 style="color: var(--text-wine);">💬 Messages</h3>
                        <p style="color: var(--wine-light);">Chat with customers</p>
                        <c:if test="${not empty unreadMessages && unreadMessages.size() > 0}">
                            <span class="badge" style="background: #dc3545; color: white;">
                                ${unreadMessages.size()} new
                            </span>
                        </c:if>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card astrologer-card text-center">
                    <div class="card-body">
                        <h3 style="color: var(--text-wine);">📊 Earnings</h3>
                        <p style="color: var(--wine-light);">View your earnings</p>
                        <a href="${pageContext.request.contextPath}/scholar/earnings" class="btn astrologer-btn">View Earnings</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card astrologer-card text-center">
                    <div class="card-body">
                        <h3 style="color: var(--text-wine);">⭐ Reviews</h3>
                        <p style="color: var(--wine-light);">View customer reviews</p>
                        <a href="${pageContext.request.contextPath}/scholar/reviews" class="btn astrologer-btn">View Reviews</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card astrologer-card text-center">
                    <div class="card-body">
                        <h3 style="color: var(--text-wine);">📦 Services</h3>
                        <p style="color: var(--wine-light);">Manage your service packages</p>
                        <a href="${pageContext.request.contextPath}/scholar/service/list" class="btn astrologer-btn">Manage Services</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card astrologer-card text-center">
                    <div class="card-body">
                        <h3 style="color: var(--text-wine);">⚙️ Profile</h3>
                        <p style="color: var(--wine-light);">Edit your profile</p>
                        <a href="${pageContext.request.contextPath}/scholar/profile/edit" class="btn astrologer-btn">Edit Profile</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card astrologer-card text-center">
                    <div class="card-body">
                        <h3 style="color: var(--text-wine);">${scholar.isAvailable ? '✅ Available' : '❌ Unavailable'}</h3>
                        <p style="color: var(--wine-light);">Toggle availability</p>
                        <form method="post" action="${pageContext.request.contextPath}/scholar/availability" style="display: inline;">
                            <button type="submit" class="btn ${scholar.isAvailable ? 'btn-warning' : 'btn-success'}">
                                ${scholar.isAvailable ? 'Mark Unavailable' : 'Mark Available'}
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Bookings Section -->
        <div class="card astrologer-card">
            <div class="card-header" style="background: linear-gradient(135deg, var(--wine) 0%, var(--wine-dark) 100%); color: var(--text-cream);">
                <h2 class="card-title">My Bookings</h2>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${empty bookings || bookings.size() == 0}">
                        <p style="color: var(--wine-light);">No bookings found.</p>
                    </c:when>
                    <c:otherwise>
                        <div class="row g-3">
                            <c:forEach var="booking" items="${bookings}">
                                <div class="col-md-6">
                                    <div class="card astrologer-card">
                                        <div class="card-body">
                                            <h3 style="color: var(--text-wine);">${booking.customer.name}</h3>
                                            <p style="color: var(--wine-light);"><strong>Service Date:</strong> ${booking.serviceDate != null ? booking.serviceDate.toString().replace('T', ' ').substring(0, 16) : 'N/A'}</p>
                                            <p style="color: var(--wine-light);"><strong>Status:</strong> <span class="badge badge-${booking.status == 'CONFIRMED' ? 'approved' : booking.status == 'REJECTED' ? 'rejected' : 'pending'}">${booking.status}</span></p>
                                            <p style="color: var(--wine-light);"><strong>Amount:</strong> ₹${booking.totalAmount != null ? booking.totalAmount : 0}</p>
                                            <p style="color: var(--wine-light);"><strong>Service Type:</strong> ${booking.serviceType}</p>
                                            <c:if test="${not empty booking.serviceLocation}">
                                                <p style="color: var(--wine-light);"><strong>Location:</strong> ${booking.serviceLocation}</p>
                                            </c:if>
                                            
                                            <div class="d-flex gap-2 mt-3 flex-wrap">
                                                <c:if test="${booking.status == 'CONFIRMED'}">
                                                    <a href="${pageContext.request.contextPath}/scholar/chat?customerId=${booking.customer.id}&bookingId=${booking.id}" class="btn astrologer-btn">
                                                        💬 Chat
                                                    </a>
                                                    <c:if test="${booking.serviceType == 'VIDEO_CALL' && not empty booking.videoCallLink}">
                                                        <a href="${booking.videoCallLink}" target="_blank" class="btn astrologer-btn">
                                                            📹 Join Call
                                                        </a>
                                                    </c:if>
                                                </c:if>
                                                <c:if test="${booking.status == 'PENDING_CONFIRMATION'}">
                                                    <form method="post" action="${pageContext.request.contextPath}/scholar/booking/accept" style="display:inline;">
                                                        <input type="hidden" name="bookingId" value="${booking.id}">
                                                        <button type="submit" class="btn btn-success">Accept</button>
                                                    </form>
                                                    <form method="post" action="${pageContext.request.contextPath}/scholar/booking/reject" style="display:inline;">
                                                        <input type="hidden" name="bookingId" value="${booking.id}">
                                                        <button type="submit" class="btn btn-danger">Reject</button>
                                                    </form>
                                                </c:if>
                                                <c:if test="${booking.status == 'CONFIRMED'}">
                                                    <form method="post" action="${pageContext.request.contextPath}/scholar/booking/complete" style="display:inline;">
                                                        <input type="hidden" name="bookingId" value="${booking.id}">
                                                        <button type="submit" class="btn btn-primary">Mark Complete</button>
                                                    </form>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        
        <!-- Chat Conversations -->
        <div class="card astrologer-card" style="margin-top: 30px;">
            <div class="card-header" style="background: linear-gradient(135deg, var(--wine) 0%, var(--wine-dark) 100%); color: var(--text-cream);">
                <h2 class="card-title">Chat Conversations (Confirmed Bookings Only)</h2>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${empty customers || customers.size() == 0}">
                        <p style="color: var(--wine-light);">No confirmed bookings yet. Chat will be available after you accept bookings.</p>
                    </c:when>
                    <c:otherwise>
                        <div class="row g-3">
                            <c:forEach var="customer" items="${customers}">
                                <div class="col-md-6">
                                    <div class="card astrologer-card">
                                        <div class="card-body">
                                            <h4 style="color: var(--text-wine);">${customer.name}</h4>
                                            <p style="color: var(--wine-light);">${customer.email}</p>
                                            <a href="${pageContext.request.contextPath}/scholar/chat?customerId=${customer.id}" class="btn astrologer-btn">Open Chat</a>
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
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>