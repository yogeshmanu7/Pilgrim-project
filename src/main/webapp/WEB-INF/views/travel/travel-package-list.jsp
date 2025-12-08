<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../includes/header.jsp"/>

<div class="container mt-4">
    <h2>Travel Packages</h2>
    <a href="${pageContext.request.contextPath}/pilgrim/travel/agency/package/add" class="btn btn-primary mb-3">
        ➕ Add New Package
    </a>

    <table class="table table-bordered table-hover shadow-sm">
        <thead class="table-dark">
            <tr>
                <th>Images</th>
                <th>Name</th>
                <th>City</th>
                <th>Price</th>
                <th>Duration</th>
                <th>Type</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="pkg" items="${packages}">
                <tr>
                    <td>
                        <c:if test="${not empty pkg.imagePaths}">
                            <c:forEach var="img" items="${pkg.imagePaths}">
                                <img src="${pageContext.request.contextPath}${img}" alt="Package Image" width="80" height="60"
                                     class="img-thumbnail me-1 mb-1"/>
                            </c:forEach>
                        </c:if>
                    </td>
                    <td>${pkg.packageName}</td>
                    <td>${pkg.city}</td>
                    <td>₹ ${pkg.price}</td>
                    <td>${pkg.durationDays} days</td>
                    <td>${pkg.travelType}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/pilgrim/travel/agency/package/details/${pkg.id}" 
                           class="btn btn-info btn-sm">View</a>
                        <a href="${pageContext.request.contextPath}/pilgrim/travel/agency/package/edit/${pkg.id}" 
                           class="btn btn-warning btn-sm">Edit</a>
                        <a href="${pageContext.request.contextPath}/pilgrim/travel/agency/package/delete/${pkg.id}" 
                           class="btn btn-danger btn-sm"
                           onclick="return confirm('Are you sure you want to delete this package?');">
                           Delete
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<jsp:include page="../includes/footer.jsp"/>

