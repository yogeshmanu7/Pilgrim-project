<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reviews - GlobalPiligrim</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        .scholar-theme {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 40px 0;
            margin-bottom: 30px;
        }
        .scholar-card {
            border-left: 4px solid #667eea;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.2);
        }
    </style>
</head>
<body>
    <div class="scholar-theme">
        <div class="container">
            <h1 class="text-white mb-0" style="font-size: 36px;">⭐ Reviews</h1>
            <p class="text-white mt-2" style="opacity: 0.9; font-size: 18px;">${scholar.user.name}</p>
        </div>
    </div>
    
    <div class="container">
        <div class="card scholar-card">
            <div class="card-header bg-primary text-white">
                <h2 class="card-title mb-0">Customer Reviews</h2>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${empty reviews || reviews.size() == 0}">
                        <p class="text-center text-muted">No reviews yet.</p>
                    </c:when>
                    <c:otherwise>
                        <div class="row g-3">
                            <c:forEach var="review" items="${reviews}">
                                <div class="col-12">
                                    <div class="card scholar-card">
                                        <div class="card-body">
                                            <h5 class="text-primary">${review.customer.name}</h5>
                                            <div class="mb-2">
                                                <c:forEach var="i" begin="1" end="5">
                                                    <i class="fas fa-star ${i <= review.rating ? 'text-warning' : 'text-secondary'}"></i>
                                                </c:forEach>
                                            </div>
                                            <c:if test="${not empty review.comment}">
                                                <p class="mb-2">${review.comment}</p>
                                            </c:if>
                                            <p class="text-muted small mb-0">
                                                ${review.createdAt != null ? review.createdAt.toString().replace('T', ' ').substring(0, 16) : 'N/A'}
                                            </p>
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

