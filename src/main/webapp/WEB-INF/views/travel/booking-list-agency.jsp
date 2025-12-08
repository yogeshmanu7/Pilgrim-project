<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../includes/header.jsp"/>

<div class="container mt-4">
    <h2 class="mb-3">📑 Agency Bookings</h2>

    <c:if test="${empty bookings}">
        <div class="alert alert-info">
            No bookings found for your agency yet.
        </div>
    </c:if>

    <c:if test="${not empty bookings}">
        <div class="table-responsive shadow-sm">
            <table class="table table-striped table-hover">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>User</th>
                        <th>Package/Guide/Transport</th>
                        <th>Quantity</th>
                        <th>Amount</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="b" items="${bookings}">
                        <tr>
                            <td>${b.id}</td>
                            <td>${b.user != null ? b.user.fullName : 'N/A'}</td>
                            <td>
                                <c:if test="${b.travelPackage != null}">
                                    ${b.travelPackage.packageName}
                                </c:if>
                                <c:if test="${b.guide != null}">
                                    Guide: ${b.guide.name}
                                </c:if>
                                <c:if test="${b.transport != null}">
                                    Transport: ${b.transport.type}
                                </c:if>
                            </td>
                            <td>${b.quantity}</td>
                            <td>₹ ${b.amountPaid}</td>
                            <td>
                                <span class="badge 
                                    <c:choose>
                                        <c:when test="${b.status == 'CONFIRMED'}">bg-success</c:when>
                                        <c:when test="${b.status == 'PENDING_PAYMENT'}">bg-warning</c:when>
                                        <c:when test="${b.status == 'CANCELLED'}">bg-danger</c:when>
                                        <c:otherwise>bg-secondary</c:otherwise>
                                    </c:choose>">
                                    ${b.status}
                                </span>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/pilgrim/travel/booking/agency/details/${b.id}" 
                                   class="btn btn-sm btn-primary">View</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>

    <div class="mt-4">
        <a href="${pageContext.request.contextPath}/pilgrim/travel/agency/dashboard" class="btn btn-secondary">⬅ Back to Dashboard</a>
    </div>
</div>

<jsp:include page="../includes/footer.jsp"/>

