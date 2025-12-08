<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Scholars - GlobalPiligrim</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        .user-theme {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            padding: 40px 0;
            margin-bottom: 30px;
        }
        .user-card {
            border-left: 4px solid #11998e;
            box-shadow: 0 4px 15px rgba(17, 153, 142, 0.2);
        }
        .user-btn {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            border: none;
            color: white;
        }
        .user-btn:hover {
            background: linear-gradient(135deg, #38ef7d 0%, #11998e 100%);
            color: white;
        }
    </style>
</head>
<body>
    <div class="user-theme">
        <div class="container">
            <h1 class="text-white mb-0" style="font-size: 36px;">🔍 Search Scholars</h1>
        </div>
    </div>
    
    <div class="container">
        <div class="card user-card mb-4">
            <div class="card-body">
                <form method="get" action="${pageContext.request.contextPath}/customer/scholar/search">
                    <div class="row g-3">
                        <div class="col-md-3">
                            <label class="form-label">Type</label>
                            <select name="type" class="form-select">
                                <option value="">All Types</option>
                                <option value="SPIRITUAL_SCHOLAR" ${searchType == 'SPIRITUAL_SCHOLAR' ? 'selected' : ''}>Spiritual Scholar</option>
                                <option value="ASTROLOGER" ${searchType == 'ASTROLOGER' ? 'selected' : ''}>Astrologer</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Location</label>
                            <input type="text" name="location" value="${searchLocation != null ? searchLocation : ''}" 
                                   placeholder="Enter location" class="form-control">
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Min Price</label>
                            <input type="number" name="minPrice" value="${minPrice != null ? minPrice : ''}" 
                                   placeholder="Min" class="form-control">
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Max Price</label>
                            <input type="number" name="maxPrice" value="${maxPrice != null ? maxPrice : ''}" 
                                   placeholder="Max" class="form-control">
                        </div>
                    </div>
                    <button type="submit" class="btn user-btn mt-3">Search</button>
                </form>
            </div>
        </div>
        
        <div class="row g-4">
            <c:forEach var="scholar" items="${scholars}">
                <div class="col-md-4">
                    <div class="card user-card h-100">
                        <c:choose>
                            <c:when test="${not empty scholar.profilePhotoPath}">
                                <img src="${pageContext.request.contextPath}/uploads/${scholar.profilePhotoPath}" 
                                     alt="Profile" class="card-img-top" style="height: 200px; object-fit: cover;">
                            </c:when>
                            <c:otherwise>
                                <div class="bg-success text-white d-flex align-items-center justify-content-center" 
                                     style="height: 200px; font-size: 48px;">
                                    ${scholar.user.name.charAt(0)}
                                </div>
                            </c:otherwise>
                        </c:choose>
                        <div class="card-body">
                            <h5 class="text-success">${scholar.user.name}</h5>
                            <p class="mb-1"><strong>Type:</strong> ${scholar.type == 'ASTROLOGER' ? 'Astrologer' : 'Spiritual Scholar'}</p>
                            <p class="mb-1"><strong>Rating:</strong> ${scholar.rating != null ? scholar.rating : 0} ⭐ (${scholar.totalReviews != null ? scholar.totalReviews : 0} reviews)</p>
                            <p class="mb-1"><strong>Price:</strong> ₹<fmt:formatNumber value="${scholar.basePrice != null ? scholar.basePrice : 0}" pattern="#,##,##0.00"/></p>
                            <p class="mb-3"><strong>Experience:</strong> ${scholar.experienceYears != null ? scholar.experienceYears : 0} years</p>
                            <a href="${pageContext.request.contextPath}/customer/scholar/book?scholarId=${scholar.id}" 
                               class="btn user-btn w-100">Book Now</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

