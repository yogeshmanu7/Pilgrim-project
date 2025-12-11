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
        }
        
        .bg-primary {
            background: linear-gradient(135deg, var(--wine) 0%, var(--wine-dark) 100%) !important;
            color: var(--text-cream) !important;
        }
        
        .card-title {
            color: var(--text-cream) !important;
        }
        
        .btn-success {
            background: linear-gradient(135deg, var(--wine) 0%, var(--wine-dark) 100%);
            border: none;
            color: var(--text-cream);
            font-weight: 600;
            border-radius: 8px;
        }
        
        .btn-success:hover {
            background: linear-gradient(135deg, var(--wine-dark) 0%, var(--wine) 100%);
            color: var(--text-cream);
            transform: translateY(-2px);
            box-shadow: var(--shadow-wine);
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
        
        .btn-outline-secondary {
            border: 2px solid var(--border-wine);
            color: var(--text-wine);
            border-radius: 8px;
        }
        
        .btn-outline-secondary:hover {
            background: var(--wine);
            color: var(--text-cream);
            border-color: var(--wine);
        }
        
        .bg-light {
            background: rgba(114, 47, 55, 0.05) !important;
            border: 2px solid var(--wine-transparent);
        }
        
        .text-success {
            color: var(--wine) !important;
        }
    </style>
</head>
<body>
    <!-- Background Pattern -->
    <div class="bg-pattern"></div>
    
    <div class="container mt-5">
        <div class="card shadow">
            <div class="card-header bg-primary">
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