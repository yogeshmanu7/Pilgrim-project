<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../includes/header.jsp"/>

<div class="container mt-4">
    <h2 class="mb-3">👤 Guide Details</h2>

    <div class="card shadow-sm p-4">
        <div class="row">
            <div class="col-md-4 text-center">
                <c:if test="${not empty guide.imagePath}">
                    <img src="${pageContext.request.contextPath}${guide.imagePath}" 
                         alt="Guide Image" class="img-fluid rounded mb-3"/>
                </c:if>
            </div>
            <div class="col-md-8">
                <p><strong>Name:</strong> ${guide.name}</p>
                <p><strong>Language:</strong> ${guide.language}</p>
                <p><strong>City:</strong> ${guide.city}</p>
                <p><strong>Temple:</strong> ${guide.temple}</p>
                <p><strong>Price:</strong> ₹${guide.price}</p>
                <p><strong>Description:</strong> ${guide.shortDescription}</p>
                <p><strong>Availability:</strong>
                    <c:choose>
                        <c:when test="${guide.available}">
                            <span class="badge bg-success">Available</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge bg-danger">Booked</span>
                        </c:otherwise>
                    </c:choose>
                </p>
            </div>
        </div>
    </div>

    <div class="mt-3">
        <a href="${pageContext.request.contextPath}/pilgrim/travel/agency/guides/list" class="btn btn-secondary">⬅ Back to List</a>
        <a href="${pageContext.request.contextPath}/pilgrim/travel/agency/guides/edit/${guide.id}" class="btn btn-primary">✏️ Edit</a>
    </div>
</div>

<jsp:include page="../includes/footer.jsp"/>

