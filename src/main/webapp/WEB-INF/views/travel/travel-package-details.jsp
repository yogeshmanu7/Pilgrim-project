<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../includes/header.jsp"/>

<div class="container mt-4">
    <h2>Travel Package Details</h2>

    <p><strong>Name:</strong> ${travelPackage.packageName}</p>
    <p><strong>Description:</strong> ${travelPackage.description}</p>
    <p><strong>Country:</strong> ${travelPackage.country}</p>
    <p><strong>State:</strong> ${travelPackage.state}</p>
    <p><strong>City:</strong> ${travelPackage.city}</p>
    <p><strong>Price:</strong> ${travelPackage.price}</p>
    <p><strong>Duration (days):</strong> ${travelPackage.durationDays}</p>
    <p><strong>Travel Type:</strong> ${travelPackage.travelType}</p>

    <div class="mb-3">
        <label class="form-label">Images</label><br>
        <c:forEach var="img" items="${travelPackage.imagePaths}">
            <img src="${pageContext.request.contextPath}${img}" alt="Package Image" width="150" class="img-thumbnail me-2 mb-2"/>
        </c:forEach>
    </div>

    <a href="${pageContext.request.contextPath}/pilgrim/travel/agency/package/list" class="btn btn-secondary">Back to List</a>
</div>

<jsp:include page="../includes/footer.jsp"/>

