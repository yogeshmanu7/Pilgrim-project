<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Video Call - GlobalPiligrim</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>
    <div class="container mt-5">
        <div class="card shadow">
            <div class="card-header bg-primary text-white">
                <h2 class="card-title mb-0">Video Call</h2>
            </div>
            <div class="card-body text-center p-5">
                <c:if test="${not empty booking}">
                    <h3>Call with ${booking.customer.name}</h3>
                    <p><strong>Service Date:</strong> ${booking.serviceDate != null ? booking.serviceDate.toString().replace('T', ' ').substring(0, 16) : 'N/A'}</p>
                    <p><strong>Service Type:</strong> ${booking.serviceType}</p>
                </c:if>
                
                <div class="my-5">
                    <div class="bg-primary rounded d-flex align-items-center justify-content-center mx-auto" 
                         style="width: 300px; height: 200px;">
                        <i class="fas fa-video text-white" style="font-size: 64px;"></i>
                    </div>
                </div>
                
                <div class="my-5">
                    <h3>Video Call Link</h3>
                    <div class="bg-light p-3 rounded mb-3">
                        <p class="mb-0 text-break">${videoCallLink}</p>
                    </div>
                    <a href="${videoCallLink}" target="_blank" class="btn btn-success me-2">
                        <i class="fas fa-video me-2"></i>Join Video Call
                    </a>
                    <button onclick="copyLink()" class="btn btn-secondary">
                        <i class="fas fa-copy me-2"></i>Copy Link
                    </button>
                </div>
                
                <div class="my-4">
                    <h4>Call Features:</h4>
                    <ul class="list-unstyled text-start d-inline-block">
                        <li><i class="fas fa-check text-success me-2"></i>Screen sharing for Kundali/Horoscope viewing</li>
                        <li><i class="fas fa-check text-success me-2"></i>Chat during call</li>
                        <li><i class="fas fa-check text-success me-2"></i>Timer for session management</li>
                        <li><i class="fas fa-check text-success me-2"></i>End session button</li>
                    </ul>
                </div>
                
                <c:if test="${not empty booking}">
                    <div class="mt-4">
                        <a href="${pageContext.request.contextPath}/scholar/chat?customerId=${booking.customer.id}&bookingId=${booking.id}" 
                           class="btn btn-outline-secondary">
                            <i class="fas fa-comments me-2"></i>Open Chat
                        </a>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function copyLink() {
            var link = "${videoCallLink}";
            navigator.clipboard.writeText(link).then(function() {
                alert("Link copied to clipboard!");
            });
        }
    </script>
</body>
</html>

