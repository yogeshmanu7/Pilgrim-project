<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Spiritual Scholar Dashboard - GlobalPiligrim</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
    .scholar-theme {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    }
    .scholar-card {
        border-left: 4px solid #667eea;
        box-shadow: 0 4px 15px rgba(102, 126, 234, 0.2);
    }
    .scholar-btn {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        border: none;
        color: white;
    }
    .scholar-btn:hover {
        background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(102, 126, 234, 0.3);
    }
</style>
</head>
<body>
<main>
    <div class="scholar-theme" style="padding: 40px 0; margin-bottom: 30px;">
        <div class="container">
            <h1 style="color: white; margin: 0; font-size: 36px;">📿 Spiritual Scholar Dashboard</h1>
            <p style="color: rgba(255,255,255,0.9); margin-top: 10px; font-size: 18px;">Welcome, ${scholar.user.name}</p>
        </div>
    </div>
    
    <div class="container">
        <!-- Profile Section -->
        <div class="card scholar-card" style="margin-bottom: 30px;">
            <div style="display: flex; align-items: center; gap: 20px;">
                <div>
                    <c:choose>
                        <c:when test="${not empty scholar.profilePhotoPath}">
                            <img src="${pageContext.request.contextPath}/uploads/${scholar.profilePhotoPath}" alt="Profile Photo" 
                                 style="width: 150px; height: 150px; border-radius: 50%; object-fit: cover; border: 3px solid #667eea;">
                        </c:when>
                        <c:otherwise>
                            <div style="width: 150px; height: 150px; border-radius: 50%; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); display: flex; align-items: center; justify-content: center; color: white; font-size: 48px;">
                                ${scholar.user.name.charAt(0)}
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div style="flex: 1;">
                    <h2 style="color: #667eea;">${scholar.user.name}</h2>
                    <p><strong>Type:</strong> <span style="color: #667eea;">${scholar.type == 'ASTROLOGER' ? 'Astrologer' : 'Spiritual Scholar'}</span></p>
                    <p><strong>Experience:</strong> ${scholar.experienceYears != null ? scholar.experienceYears : 0} years</p>
                    <p><strong>Rating:</strong> ${scholar.rating != null ? scholar.rating : 0} ⭐ (${scholar.totalReviews != null ? scholar.totalReviews : 0} reviews)</p>
                    <p><strong>Base Price:</strong> ₹${scholar.basePrice != null ? scholar.basePrice : 0}</p>
                    <p><strong>Status:</strong> <span class="badge badge-${scholar.status == 'APPROVED' ? 'approved' : scholar.status == 'REJECTED' ? 'rejected' : 'pending'}">${scholar.status}</span></p>
                </div>
            </div>
        </div>
        
        <!-- Services Section -->
        <div class="card scholar-card" style="margin-bottom: 30px;">
            <div class="card-header" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white;">
                <h2 class="card-title">My Spiritual Services</h2>
            </div>
            <div class="card-body">
                <h3>Specializations:</h3>
                <div style="display: flex; flex-wrap: wrap; gap: 10px; margin-top: 10px;">
                    <c:forEach var="spec" items="${scholar.specializations}">
                        <span style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 5px 15px; border-radius: 20px; font-size: 14px;">${spec}</span>
                    </c:forEach>
                </div>
                
                <h3 style="margin-top: 20px;">Languages:</h3>
                <div style="display: flex; flex-wrap: wrap; gap: 10px; margin-top: 10px;">
                    <c:forEach var="lang" items="${scholar.languages}">
                        <span style="background: #764ba2; color: white; padding: 5px 15px; border-radius: 20px; font-size: 14px;">${lang}</span>
                    </c:forEach>
                </div>
                
                <p style="margin-top: 20px;"><strong>Service Areas:</strong> ${scholar.serviceAreas != null ? scholar.serviceAreas : 'Not specified'}</p>
            </div>
        </div>
        
        <!-- Quick Actions -->
        <div class="row g-4 mb-4">
            <div class="col-md-4">
                <div class="card scholar-card text-center">
                    <div class="card-body">
                        <h3 style="color: #667eea;">📞 Video Call</h3>
                        <p>Start or join video calls</p>
                        <a href="${pageContext.request.contextPath}/scholar/video-call" class="btn scholar-btn">Video Call</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card scholar-card text-center">
                    <div class="card-body">
                        <h3 style="color: #667eea;">💬 Messages</h3>
                        <p>Chat with customers</p>
                        <c:if test="${not empty unreadMessages && unreadMessages.size() > 0}">
                            <span class="badge bg-danger">
                                ${unreadMessages.size()} new
                            </span>
                        </c:if>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card scholar-card text-center">
                    <div class="card-body">
                        <h3 style="color: #667eea;">📊 Earnings</h3>
                        <p>View your earnings</p>
                        <a href="${pageContext.request.contextPath}/scholar/earnings" class="btn scholar-btn">View Earnings</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card scholar-card text-center">
                    <div class="card-body">
                        <h3 style="color: #667eea;">⭐ Reviews</h3>
                        <p>View customer reviews</p>
                        <a href="${pageContext.request.contextPath}/scholar/reviews" class="btn scholar-btn">View Reviews</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card scholar-card text-center">
                    <div class="card-body">
                        <h3 style="color: #667eea;">⚙️ Profile</h3>
                        <p>Edit your profile</p>
                        <a href="${pageContext.request.contextPath}/scholar/profile/edit" class="btn scholar-btn">Edit Profile</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card scholar-card text-center">
                    <div class="card-body">
                        <h3 style="color: #667eea;">${scholar.isAvailable ? '✅ Available' : '❌ Unavailable'}</h3>
                        <p>Toggle availability</p>
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
        <div class="card scholar-card">
            <div class="card-header" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white;">
                <h2 class="card-title">My Bookings</h2>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${empty bookings || bookings.size() == 0}">
                        <p>No bookings found.</p>
                    </c:when>
                    <c:otherwise>
                        <div class="row g-3">
                            <c:forEach var="booking" items="${bookings}">
                                <div class="col-md-6">
                                    <div class="card scholar-card">
                                        <div class="card-body">
                                            <h3 style="color: #667eea;">${booking.customer.name}</h3>
                                            <p><strong>Service Date:</strong> ${booking.serviceDate != null ? booking.serviceDate.toString().replace('T', ' ').substring(0, 16) : 'N/A'}</p>
                                            <p><strong>Status:</strong> <span class="badge badge-${booking.status == 'CONFIRMED' ? 'approved' : booking.status == 'REJECTED' ? 'rejected' : 'pending'}">${booking.status}</span></p>
                                            <p><strong>Amount:</strong> ₹${booking.totalAmount != null ? booking.totalAmount : 0}</p>
                                            <p><strong>Service Type:</strong> ${booking.serviceType}</p>
                                            <c:if test="${not empty booking.serviceLocation}">
                                                <p><strong>Location:</strong> ${booking.serviceLocation}</p>
                                            </c:if>
                                            
                                            <div class="d-flex gap-2 mt-3 flex-wrap">
                                                <c:if test="${booking.status == 'CONFIRMED'}">
                                                    <a href="${pageContext.request.contextPath}/scholar/chat?customerId=${booking.customer.id}&bookingId=${booking.id}" class="btn scholar-btn">
                                                        💬 Chat
                                                    </a>
                                                    <c:if test="${booking.serviceType == 'VIDEO_CALL' && not empty booking.videoCallLink}">
                                                        <a href="${booking.videoCallLink}" target="_blank" class="btn scholar-btn">
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
        <div class="card scholar-card" style="margin-top: 30px;">
            <div class="card-header" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white;">
                <h2 class="card-title">Chat Conversations (Confirmed Bookings Only)</h2>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${empty customers || customers.size() == 0}">
                        <p>No confirmed bookings yet. Chat will be available after you accept bookings.</p>
                    </c:when>
                    <c:otherwise>
                        <div class="row g-3">
                            <c:forEach var="customer" items="${customers}">
                                <div class="col-md-6">
                                    <div class="card scholar-card">
                                        <div class="card-body">
                                            <h4 style="color: #667eea;">${customer.name}</h4>
                                            <p>${customer.email}</p>
                                            <a href="${pageContext.request.contextPath}/scholar/chat?customerId=${customer.id}" class="btn scholar-btn">Open Chat</a>
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

