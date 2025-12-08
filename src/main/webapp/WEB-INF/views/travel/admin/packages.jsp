<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<jsp:include page="../../includes/header.jsp"/>

<div class="container mt-4">
<div class="card">
    <h2><i class="fas fa-suitcase me-2"></i>All Travel Packages</h2>
    
    <c:if test="${not empty packages}">
        <div class="table-responsive">
            <table class="table table-hover">
                <thead class="table-light">
                    <tr>
                        <th>ID</th>
                        <th>Package Name</th>
                        <th>Agency</th>
                        <th>Type</th>
                        <th>City</th>
                        <th>State</th>
                        <th>Price</th>
                        <th>Duration</th>
                        <th>Created At</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="pkg" items="${packages}">
                        <tr>
                            <td>${pkg.id}</td>
                            <td><strong>${pkg.packageName}</strong></td>
                            <td>${pkg.agency.travelsName}</td>
                            <td><span class="badge bg-info">${pkg.travelType}</span></td>
                            <td>${pkg.city}</td>
                            <td>${pkg.state}</td>
                            <td><strong>₹<fmt:formatNumber value="${pkg.price}" pattern="#,##,##0.00"/></strong></td>
                            <td>${pkg.duration} days</td>
                            <td><fmt:formatDate value="${pkg.createdAt}" pattern="dd-MM-yyyy HH:mm" /></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>
    <c:if test="${empty packages}">
        <div class="alert alert-info">
            <i class="fas fa-info-circle me-2"></i>No travel packages found.
        </div>
    </c:if>
</div>
</div>

<jsp:include page="../../includes/footer.jsp"/>

