<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book ${scholar.user.name} - GlobalPiligrim</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>
    <div class="container mt-5">
        <div class="card mx-auto" style="max-width: 600px;">
            <div class="card-header bg-primary text-white">
                <h2 class="card-title mb-0">Book ${scholar.user.name}</h2>
            </div>
            <div class="card-body">
                <form method="post" action="${pageContext.request.contextPath}/customer/scholar/book">
                    <input type="hidden" name="scholarId" value="${scholar.id}">
                    
                    <div class="mb-3">
                        <label class="form-label">Service Type *</label>
                        <select name="serviceType" class="form-select" required>
                            <option value="ONSITE">Onsite</option>
                            <option value="VIDEO_CALL">Video Call</option>
                            <option value="OFFLINE">Offline</option>
                        </select>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Service Date & Time *</label>
                        <input type="datetime-local" name="serviceDate" class="form-control" required>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Service Location</label>
                        <c:choose>
                            <c:when test="${not empty availableLocations && availableLocations.size() > 0}">
                                <select name="serviceLocation" class="form-select">
                                    <option value="">-- Select Location --</option>
                                    <c:forEach var="location" items="${availableLocations}">
                                        <option value="${location}">${location}</option>
                                    </c:forEach>
                                </select>
                                <small class="text-muted">Select from available service locations</small>
                            </c:when>
                            <c:otherwise>
                        <input type="text" name="serviceLocation" placeholder="Enter service location" class="form-control">
                                <small class="text-muted">No predefined locations available. Please enter manually.</small>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Service Description *</label>
                        <textarea name="serviceDescription" rows="5" required placeholder="Describe your service requirements" class="form-control"></textarea>
                    </div>
                    
                    <button type="submit" class="btn btn-primary w-100">Next</button>
                </form>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

