<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chat with ${scholar.user.name} - GlobalPiligrim</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        body {
            background: #f8f9fa;
            padding-top: 20px;
        }
        .chat-container {
            height: 80vh;
            display: grid;
            grid-template-columns: 300px 1fr;
            gap: 20px;
        }
        .chat-sidebar {
            background: white;
            border-radius: 10px;
            padding: 20px;
            overflow-y: auto;
        }
        .chat-messages {
            background: white;
            border-radius: 10px;
            display: flex;
            flex-direction: column;
            height: 100%;
        }
        .messages-area {
            flex: 1;
            overflow-y: auto;
            padding: 20px;
            background: #f8f9fa;
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
            background: #667eea;
            color: white;
        }
        .message.received .message-bubble {
            background: white;
            color: #333;
        }
        .message-time {
            font-size: 11px;
            opacity: 0.7;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="chat-container">
            <!-- Chat Sidebar -->
            <div class="chat-sidebar">
                <h5>Conversations</h5>
                <hr>
                <div class="d-flex align-items-center gap-2 p-2 bg-info bg-opacity-10 rounded mb-2">
                    <div class="rounded-circle bg-info text-white d-flex align-items-center justify-content-center" 
                         style="width: 40px; height: 40px;">
                        ${customer.name.charAt(0)}
                    </div>
                    <div>
                        <strong>${customer.name}</strong>
                        <p class="mb-0 small text-muted">You</p>
                    </div>
                </div>
                <div class="d-flex align-items-center gap-2 p-2 bg-light rounded">
                    <c:choose>
                        <c:when test="${not empty scholar.profilePhotoPath}">
                            <img src="${pageContext.request.contextPath}/uploads/${scholar.profilePhotoPath}" 
                                 alt="Profile" class="rounded-circle" style="width: 40px; height: 40px; object-fit: cover;">
                        </c:when>
                        <c:otherwise>
                            <div class="rounded-circle bg-primary text-white d-flex align-items-center justify-content-center" 
                                 style="width: 40px; height: 40px;">
                                ${scholar.user.name.charAt(0)}
                            </div>
                        </c:otherwise>
                    </c:choose>
                    <div>
                        <strong>${scholar.user.name}</strong>
                        <p class="mb-0 small text-muted">Scholar</p>
                    </div>
                </div>
            </div>
            
            <!-- Chat Messages -->
            <div class="chat-messages">
                <div class="card-header border-bottom p-3">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h5 class="mb-0">${scholar.user.name}</h5>
                            <p class="mb-0 small text-muted">${scholar.user.email}</p>
                        </div>
                        <c:if test="${not empty booking && booking.serviceType == 'VIDEO_CALL' && not empty booking.videoCallLink}">
                            <a href="${pageContext.request.contextPath}/customer/scholar/video-call?bookingId=${booking.id}" 
                               class="btn btn-success btn-sm">
                                📹 Video Call
                            </a>
                        </c:if>
                    </div>
                </div>
                
                <div id="chatMessages" class="messages-area">
                    <c:forEach var="message" items="${messages}">
                        <div class="message ${message.sender.id == customer.id ? 'sent' : 'received'}">
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
                    <form method="post" action="${pageContext.request.contextPath}/customer/scholar/chat/send" id="chatForm">
                        <input type="hidden" name="scholarId" value="${scholar.id}">
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

