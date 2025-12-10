<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Available Spiritual Scholars - GlobalPiligrim</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 40px 0;
        }

        .page-header {
            text-align: center;
            color: white;
            margin-bottom: 50px;
            padding: 0 20px;
        }

        .page-header h1 {
            font-size: 3rem;
            font-weight: 700;
            margin-bottom: 15px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
        }

        .page-header p {
            font-size: 1.2rem;
            opacity: 0.95;
        }

        .scholar-card {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            transition: all 0.3s ease;
            height: 100%;
            display: flex;
            flex-direction: column;
            position: relative;
        }

        .scholar-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.3);
        }

        .scholar-image-container {
            height: 220px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .scholar-image {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            border: 5px solid white;
            object-fit: cover;
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
        }

        .scholar-initial {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 48px;
            font-weight: bold;
            color: #667eea;
            border: 5px solid white;
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
        }

        .scholar-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            background: rgba(255,255,255,0.95);
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            color: #667eea;
            box-shadow: 0 2px 8px rgba(0,0,0,0.2);
        }

        .scholar-card-body {
            padding: 25px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .scholar-name {
            font-size: 1.5rem;
            font-weight: 700;
            color: #333;
            margin-bottom: 10px;
            text-align: center;
        }

        .scholar-specialization {
            text-align: center;
            margin-bottom: 20px;
        }

        .specialization-badge {
            display: inline-block;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 5px 15px;
            border-radius: 15px;
            font-size: 12px;
            font-weight: 600;
            margin: 3px;
        }

        .scholar-info {
            flex-grow: 1;
        }

        .info-item {
            display: flex;
            align-items: center;
            margin-bottom: 12px;
            color: #555;
        }

        .info-item i {
            width: 30px;
            color: #667eea;
            font-size: 18px;
        }

        .info-item span {
            flex: 1;
            font-size: 14px;
        }

        .info-item strong {
            color: #333;
            margin-right: 5px;
        }

        .rating-display {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .stars {
            color: #ffc107;
            font-size: 16px;
        }

        .rating-value {
            font-weight: 600;
            color: #333;
        }

        .reviews-count {
            color: #666;
            font-size: 13px;
            margin-left: 5px;
        }

        .price-display {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 12px;
            border-radius: 10px;
            text-align: center;
            margin: 15px 0;
        }

        .price-label {
            font-size: 12px;
            opacity: 0.9;
            margin-bottom: 5px;
        }

        .price-amount {
            font-size: 1.8rem;
            font-weight: 700;
        }

        .book-btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 14px 30px;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            width: 100%;
            transition: all 0.3s ease;
            text-decoration: none;
            display: block;
            text-align: center;
        }

        .book-btn:hover {
            background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
            transform: scale(1.02);
            color: white;
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .empty-state {
            background: white;
            border-radius: 20px;
            padding: 60px 40px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            max-width: 600px;
            margin: 0 auto;
        }

        .empty-state i {
            font-size: 5rem;
            color: #667eea;
            margin-bottom: 20px;
        }

        .empty-state h3 {
            color: #333;
            margin-bottom: 15px;
        }

        .empty-state p {
            color: #666;
            font-size: 1.1rem;
        }

        @media (max-width: 768px) {
            .page-header h1 {
                font-size: 2rem;
            }

            .page-header p {
                font-size: 1rem;
            }

            .scholar-card {
                margin-bottom: 30px;
            }
        }

        .container-custom {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }
    </style>
</head>
<body>
    <div class="container-custom">
        <div class="page-header">
            <h1><i class="fas fa-user-graduate me-3"></i>Available Spiritual Scholars</h1>
            <p>Connect with experienced spiritual guides for your religious ceremonies</p>
        </div>

        <c:choose>
            <c:when test="${empty scholars || scholars.size() == 0}">
                <div class="empty-state">
                    <i class="fas fa-search"></i>
                    <h3>No Scholars Available</h3>
                    <p>We're currently updating our scholar directory. Please check back later to find spiritual guides for your ceremonies.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row g-4">
                    <c:forEach var="scholar" items="${scholars}">
                        <div class="col-lg-4 col-md-6 col-sm-12">
                            <div class="scholar-card">
                                <!-- Scholar Image/Initial -->
                                <div class="scholar-image-container">
                                    <c:choose>
                                        <c:when test="${not empty scholar.profilePhotoPath}">
                                            <img src="${pageContext.request.contextPath}${scholar.profilePhotoPath}" 
                                                 alt="${scholar.user.name}" 
                                                 class="scholar-image"
                                                 onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                                            <div class="scholar-initial" style="display: none;">
                                                ${fn:substring(scholar.user.name, 0, 1)}
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="scholar-initial">
                                                ${fn:substring(scholar.user.name, 0, 1)}
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                    
                                    <!-- Scholar Type Badge -->
                                    <c:if test="${not empty scholar.type}">
                                        <span class="scholar-badge">
                                            <i class="fas fa-star me-1"></i>${scholar.type}
                                        </span>
                                    </c:if>
                                </div>

                                <div class="scholar-card-body">
                                    <!-- Scholar Name -->
                                    <h3 class="scholar-name">${scholar.user.name}</h3>

                                    <!-- Specializations -->
                                    <c:if test="${not empty scholar.specializations}">
                                        <div class="scholar-specialization">
                                            <c:forEach var="spec" items="${scholar.specializations}" varStatus="status">
                                                <c:if test="${status.index < 3}">
                                                    <span class="specialization-badge">${spec}</span>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </c:if>

                                    <!-- Scholar Information -->
                                    <div class="scholar-info">
                                        <div class="info-item">
                                            <i class="fas fa-briefcase"></i>
                                            <span>
                                                <strong>Experience:</strong> 
                                                ${scholar.experienceYears != null ? scholar.experienceYears : 0} years
                                            </span>
                                        </div>

                                        <div class="info-item">
                                            <i class="fas fa-star"></i>
                                            <span>
                                                <strong>Rating:</strong>
                                                <div class="rating-display">
                                                    <c:set var="rating" value="${scholar.rating != null ? scholar.rating : 0}"/>
                                                    <c:set var="fullStars" value="${rating.intValue()}"/>
                                                    <c:forEach begin="1" end="5" var="i">
                                                        <c:choose>
                                                            <c:when test="${i <= fullStars}">
                                                                <i class="fas fa-star stars"></i>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <i class="far fa-star stars" style="color: #ddd;"></i>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:forEach>
                                                    <span class="rating-value">${rating}</span>
                                                    <span class="reviews-count">(${scholar.totalReviews != null ? scholar.totalReviews : 0} reviews)</span>
                                                </div>
                                            </span>
                                        </div>

                                        <c:if test="${not empty scholar.serviceAreas}">
                                            <div class="info-item">
                                                <i class="fas fa-map-marker-alt"></i>
                                                <span>
                                                    <strong>Service Areas:</strong> 
                                                    ${fn:substring(scholar.serviceAreas, 0, 30)}${fn:length(scholar.serviceAreas) > 30 ? '...' : ''}
                                                </span>
                                            </div>
                                        </c:if>
                                    </div>

                                    <!-- Price Display -->
                                    <div class="price-display">
                                        <div class="price-label">Starting from</div>
                                        <div class="price-amount">
                                            ₹<fmt:formatNumber value="${scholar.basePrice != null ? scholar.basePrice : 0}" pattern="#,##0"/>
                                        </div>
                                    </div>

                                    <!-- Book Button -->
                                    <a href="${pageContext.request.contextPath}/customer/scholar/book?scholarId=${scholar.id}" 
                                       class="book-btn">
                                        <i class="fas fa-calendar-check me-2"></i>Book Now
                                    </a>
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
