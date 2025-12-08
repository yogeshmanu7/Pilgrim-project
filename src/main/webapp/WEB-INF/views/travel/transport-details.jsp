<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../includes/header.jsp"/>

<div class="container mt-4">
    <h2>Transport Details</h2>

    <p><strong>Type:</strong> ${transport.type}</p>
    <p><strong>City:</strong> ${transport.city}</p>
    <p><strong>Temple:</strong> ${transport.temple}</p>
    <p><strong>Vehicle Number:</strong> ${transport.vehicleNumber}</p>
    <p><strong>Capacity:</strong> ${transport.capacity}</p>

    <p><strong>Price Per Hour:</strong> ₹${transport.pricePerHour}</p>
    <p><strong>Price Per Day:</strong> ₹${transport.pricePerDay}</p>
    <p><strong>Temple Sightseeing Price:</strong> ₹${transport.priceTempleSight}</p>
    <p><strong>Price Per Trip:</strong> ₹${transport.pricePerTrip}</p>

    <c:if test="${not empty transport.vehicleImagePaths}">
        <h5>Vehicle Images</h5>
        <div class="d-flex flex-wrap">
            <c:forEach var="img" items="${transport.vehicleImagePaths}">
                <img src="${pageContext.request.contextPath}${img}" 
                     alt="Vehicle Image" width="150" class="img-thumbnail me-2 mb-2"/>
            </c:forEach>
        </div>
    </c:if>

    <p><strong>Driver Name:</strong> ${transport.driverName}</p>
    <p><strong>Driver Mobile:</strong> ${transport.driverMobile}</p>
    <c:if test="${not empty transport.driverImagePath}">
        <p><strong>Driver Image:</strong><br>
           <img src="${pageContext.request.contextPath}${transport.driverImagePath}" 
                width="120" class="img-thumbnail"/>
        </p>
    </c:if>

    <p><strong>Available:</strong> 
        <c:choose>
            <c:when test="${transport.available}"><span class="badge bg-success">Yes</span></c:when>
            <c:otherwise><span class="badge bg-danger">No</span></c:otherwise>
        </c:choose>
    </p>

    <a href="${pageContext.request.contextPath}/pilgrim/travel/agency/transport/list" class="btn btn-secondary">Back to List</a>
    <a href="${pageContext.request.contextPath}/pilgrim/travel/agency/transport/edit/${transport.id}" class="btn btn-primary">Edit</a>
</div>

<jsp:include page="../includes/footer.jsp"/>

