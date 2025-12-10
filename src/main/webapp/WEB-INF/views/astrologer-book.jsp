<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Available Astrologers - GlobalPiligrim</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>
    <div class="container mt-5">
        <h1 class="mb-4">Available Astrologers</h1>
        <c:choose>
            <c:when test="${empty scholars || scholars.size() == 0}">
                <div class="alert alert-info">
                    <i class="fas fa-info-circle me-2"></i>No astrologers available at the moment. Please check back later.
                </div>
            </c:when>
            <c:otherwise>
                <div class="row g-4">
                    <c:forEach var="scholar" items="${scholars}">
                        <div class="col-md-4">
                            <div class="card h-100 shadow-sm">
                                <div class="card-body">
                                    <h5 class="card-title">${scholar.user.name}</h5>
                                    <p class="mb-1"><strong>Experience:</strong> ${scholar.experienceYears != null ? scholar.experienceYears : 0} years</p>
                                    <p class="mb-1"><strong>Price:</strong> ₹<fmt:formatNumber value="${scholar.basePrice != null ? scholar.basePrice : 0}" pattern="#,##,##0.00"/></p>
                                    <p class="mb-1"><strong>Rating:</strong> ${scholar.rating != null ? scholar.rating : 0} ⭐</p>
                                    <p class="mb-3"><strong>Reviews:</strong> ${scholar.totalReviews != null ? scholar.totalReviews : 0}</p>
                                    <a href="${pageContext.request.contextPath}/customer/scholar/book?scholarId=${scholar.id}" 
                                       class="btn btn-secondary w-100">Book Now</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

