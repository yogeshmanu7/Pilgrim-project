<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<jsp:include page="../../includes/header.jsp"/>

<div class="container mt-4">
<div class="card">
    <h2><i class="fas fa-bus me-2"></i>All Transport Options</h2>
    
    <c:if test="${not empty transports}">
        <div class="table-responsive">
            <table class="table table-hover">
                <thead class="table-light">
                    <tr>
                        <th>ID</th>
                        <th>Vehicle Number</th>
                        <th>Agency</th>
                        <th>Type</th>
                        <th>City</th>
                        <th>Temple</th>
                        <th>Price/Trip</th>
                        <th>Available</th>
                        <th>Created At</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="transport" items="${transports}">
                        <tr>
                            <td>${transport.id}</td>
                            <td><strong>${transport.vehicleNumber}</strong></td>
                            <td>${transport.agency.travelsName}</td>
                            <td><span class="badge bg-info">${transport.type}</span></td>
                            <td>${transport.city}</td>
                            <td>${transport.temple}</td>
                            <td><strong>₹<fmt:formatNumber value="${transport.pricePerTrip}" pattern="#,##,##0.00"/></strong></td>
                            <td>
                                <c:choose>
                                    <c:when test="${transport.available}">
                                        <span class="badge bg-success">Available</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-danger">Not Available</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td><fmt:formatDate value="${transport.createdAt}" pattern="dd-MM-yyyy HH:mm" /></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>
    <c:if test="${empty transports}">
        <div class="alert alert-info">
            <i class="fas fa-info-circle me-2"></i>No transport options found.
        </div>
    </c:if>
</div>
</div>

<jsp:include page="../../includes/footer.jsp"/>

