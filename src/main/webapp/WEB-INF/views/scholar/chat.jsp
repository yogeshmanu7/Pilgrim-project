<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chat with ${customer.name} - GlobalPiligrim</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
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
            padding-top: 20px;
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
        
        .container-fluid {
            position: relative;
            z-index: 1;
        }
        
        .chat-container {
            height: 80vh;
            display: grid;
            grid-template-columns: 300px 1fr;
            gap: 20px;
        }
        .chat-sidebar {
            background: white;
            border-radius: 12px;
            padding: 20px;
            overflow-y: auto;
            border: 2px solid var(--border-wine);
            box-shadow: var(--shadow-wine);
        }
        .chat-messages {
            background: white;
            border-radius: 12px;
            display: flex;
            flex-direction: column;
            height: 100%;
            border: 2px solid var(--border-wine);
            box-shadow: var(--shadow-wine);
        }
        .messages-area {
            flex: 1;
            overflow-y: auto;
            padding: 20px;
            background: var(--dutch-white);
        }
        .message {
            margin-bottom: 15px;
            display: flex;
        }
        .message.sent {
            justify-content: flex-end;
        }
        .message.received {
            justify-content: flex-start;
        }
        .message-bubble {
            max-width: 70%;
            padding: 10px 15px;
            border-radius: 15px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .message.sent .message-bubble {
            background: linear-gradient(135deg, var(--wine) 0%, var(--wine-dark) 100%);
            color: var(--text-cream);
        }
        .message.received .message-bubble {
            background: white;
            color: var(--text-wine);
            border: 1px solid var(--border-wine);
        }
        .message-time {
            font-size: 11px;
            opacity: 0.7;
            margin-top: 5px;
        }
        
        /* Card header styling */
        .card-header {
            background: linear-gradient(135deg, var(--wine) 0%, var(--wine-dark) 100%);
            color: var(--text-cream);
            border-bottom: 2px solid var(--border-wine);
        }
        
        .text-muted {
            color: var(--wine-light) !important;
        }
        
        .bg-light {
            background: rgba(114, 47, 55, 0.1) !important;
            border: 1px solid var(--wine-transparent);
        }
        
        .bg-info.bg-opacity-10 {
            background: rgba(114, 47, 55, 0.15) !important;
            border: 1px solid var(--wine-transparent);
        }
        
        .rounded-circle.bg-primary {
            background: var(--wine) !important;
        }
        
        .rounded-circle.bg-info {
            background: var(--wine-dark) !important;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, var(--wine) 0%, var(--wine-dark) 100%);
            border: none;
            color: var(--text-cream);
            font-weight: 600;
            border-radius: 8px;
        }
        
        .btn-primary:hover {
            background: linear-gradient(135deg, var(--wine-dark) 0%, var(--wine) 100%);
            box-shadow: var(--shadow-wine);
            color: var(--text-cream);
        }
        
        .form-control {
            border: 2px solid var(--border-wine);
            border-radius: 8px;
            color: var(--text-wine);
        }
        
        .form-control:focus {
            border-color: var(--wine);
            box-shadow: 0 0 0 3px var(--wine-transparent);
            color: var(--text-wine);
        }
        
        h5, strong {
            color: var(--text-wine);
        }
        
        hr {
            border-color: var(--border-wine);
        }
        
        .border-top, .border-bottom {
            border-color: var(--border-wine) !important;
        }
    </style>
</head>
<body>
    <!-- Background Pattern -->
    <div class="bg-pattern"></div>
    
    <div class="container-fluid">
        <div class="chat-container">
            <!-- Chat Sidebar -->
            <div class="chat-sidebar">
                <h5>Conversations</h5>
                <hr>
                <div class="d-flex align-items-center gap-2 p-2 bg-light rounded mb-2">
                    <c:choose>
                        <c:when test="${not empty scholar.profilePhotoPath}">
                            <img src="${pageContext.request.contextPath}/uploads/${scholar.profilePhotoPath}" 
                                 alt="Profile" class="rounded-circle" style="width: 40px; height: 40px; object-fit: cover; border: 2px solid var(--border-wine);">
                        </c:when>
                        <c:otherwise>
                            <div class="rounded-circle d-flex align-items-center justify-content-center" 
                                 style="width: 40px; height: 40px; background: linear-gradient(135deg, var(--wine) 0%, var(--wine-dark) 100%); color: var(--text-cream);">
                                ${scholar.user.name.charAt(0)}
                            </div>
                        </c:otherwise>
                    </c:choose>
                    <div>
                        <strong>${scholar.user.name}</strong>
                        <p class="mb-0 small text-muted">You</p>
                    </div>
                </div>
                <div class="d-flex align-items-center gap-2 p-2 bg-info bg-opacity-10 rounded">
                    <div class="rounded-circle d-flex align-items-center justify-content-center" 
                         style="width: 40px; height: 40px; background: linear-gradient(135deg, var(--wine-dark) 0%, var(--wine) 100%); color: var(--text-cream);">
                        ${customer.name.charAt(0)}
                    </div>
                    <div>
                        <strong>${customer.name}</strong>
                        <p class="mb-0 small text-muted">Customer</p>
                    </div>
                </div>
            </div>
            
            <!-- Chat Messages -->
            <div class="chat-messages">
                <div class="card-header border-bottom p-3">
                    <h5 class="mb-0">${customer.name}</h5>
                    <p class="mb-0 small text-muted">${customer.email}</p>
                </div>
                
                <div id="chatMessages" class="messages-area">
                    <c:forEach var="message" items="${messages}">
                        <div class="message ${message.sender.id == scholar.user.id ? 'sent' : 'received'}">
                            <div class="message-bubble">
                                <p class="mb-0">${message.message}</p>
                                <p class="message-time mb-0">
                                    ${message.createdAt != null ? message.createdAt.toString().substring(11, 16) : 'N/A'}
                                </p>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                
                <div class="border-top p-3">
                    <form method="post" action="${pageContext.request.contextPath}/scholar/chat/send" id="chatForm">
                        <input type="hidden" name="customerId" value="${customer.id}">
                        <c:if test="${not empty booking}">
                            <input type="hidden" name="bookingId" value="${booking.id}">
                        </c:if>
                        <div class="d-flex gap-2">
                            <input type="text" name="message" placeholder="Type your message..." required 
                                   class="form-control" id="messageInput">
                            <button type="submit" class="btn btn-primary">Send</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        window.onload = function() {
            var chatMessages = document.getElementById('chatMessages');
            chatMessages.scrollTop = chatMessages.scrollHeight;
        };
        
        setInterval(function() {
            location.reload();
        }, 5000);
    </script>
</body>
</html>