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
</head>
<body>
    <div class="container mt-4">
        <div class="card">
            <div class="card-header bg-primary text-white">
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

