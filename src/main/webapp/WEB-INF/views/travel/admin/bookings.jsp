<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<jsp:include page="../../includes/header.jsp"/>

<div class="container mt-4">
<div class="card">
    <h2><i class="fas fa-calendar-check me-2"></i>All Travel Bookings</h2>
    
    <c:if test="${not empty bookings}">
        <div class="table-responsive">
            <table class="table table-hover">
                <thead class="table-light">
                    <tr>
                        <th>ID</th>
                        <th>User</th>
                        <th>Package</th>
                        <th>Agency</th>
                        <th>Quantity</th>
                        <th>Amount Paid</th>
                        <th>Status</th>
                        <th>Travel Dates</th>
                        <th>Created At</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="booking" items="${bookings}">
                        <tr>
                            <td>${booking.id}</td>
                            <td>${booking.user.name}<br><small class="text-muted">${booking.user.email}</small></td>
                            <td><strong>${booking.travelPackage.packageName}</strong></td>
                            <td>${booking.travelPackage.agency.travelsName}</td>
                            <td>${booking.quantity}</td>
                            <td><strong>₹<fmt:formatNumber value="${booking.amountPaid}" pattern="#,##,##0.00"/></strong></td>
                            <td>
                                <c:choose>
                                    <c:when test="${booking.status == 'BOOKED' || booking.status == 'CONFIRMED'}">
                                        <span class="badge bg-success">${booking.status}</span>
                                    </c:when>
                                    <c:when test="${booking.status == 'CANCELLED' || booking.status == 'CANCELLED_BY_USER' || booking.status == 'CANCELLED_BY_AGENCY'}">
                                        <span class="badge bg-danger">${booking.status}</span>
                                    </c:when>
                                    <c:when test="${booking.status == 'PENDING_PAYMENT'}">
                                        <span class="badge bg-warning">${booking.status}</span>
                                    </c:when>
                                    <c:when test="${booking.status == 'REFUNDED' || booking.status == 'REFUND_COMPLETED'}">
                                        <span class="badge bg-info">${booking.status}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary">${booking.status}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <fmt:formatDate value="${booking.travelStartDate}" pattern="dd-MM-yyyy" /> 
                                to 
                                <fmt:formatDate value="${booking.travelEndDate}" pattern="dd-MM-yyyy" />
                            </td>
                            <td><fmt:formatDate value="${booking.createdAt}" pattern="dd-MM-yyyy HH:mm" /></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>
    <c:if test="${empty bookings}">
        <div class="alert alert-info">
            <i class="fas fa-info-circle me-2"></i>No travel bookings found.
        </div>
    </c:if>
</div>
</div>

<jsp:include page="../../includes/footer.jsp"/>

