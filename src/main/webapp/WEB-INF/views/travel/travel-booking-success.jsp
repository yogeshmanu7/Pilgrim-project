<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../includes/header.jsp"/>

<div class="container mt-5 text-center">
    <div class="step-card p-4">

        <h3 class="text-success">Booking Successful!</h3>

        <c:if test="${not empty booking.travelPackage}">
            <p>Your package <strong>${booking.travelPackage.packageName}</strong> has been booked successfully.</p>
        </c:if>

        <c:if test="${not empty booking.transport}">
            <p>Your transport <strong>${booking.transport.type}</strong> in ${booking.transport.city} has been booked successfully.</p>
        </c:if>

        <c:if test="${not empty booking.guide}">
            <p>Your guide <strong>${booking.guide.name}</strong> (${booking.guide.language}) has been booked successfully.</p>
        </c:if>

        <p><strong>Booking ID:</strong> ${booking.id}</p>
        <p><strong>Total Amount Paid:</strong> ₹${booking.amountPaid}</p>

        <a href="${pageContext.request.contextPath}/pilgrim/travel/booking/status/${booking.id}"
           class="btn btn-primary mt-3">View Booking Status</a>
        <a href="${pageContext.request.contextPath}/pilgrim/travel/packages"
           class="btn btn-secondary mt-3">Back to Packages</a>
    </div>
</div>

<jsp:include page="../includes/footer.jsp"/>

