<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../includes/header.jsp"/>

<div class="container mt-4">
    <h2 class="mb-3">Booking Details</h2>

    <c:if test="${not empty booking}">
        <div class="card shadow-sm p-4">
            <p><strong>Booking ID:</strong> ${booking.id}</p>
            <p><strong>User:</strong> ${booking.user != null ? booking.user.fullName : 'N/A'}</p>
            
            <c:if test="${not empty booking.travelPackage}">
                <p><strong>Package:</strong> ${booking.travelPackage.packageName}</p>
            </c:if>
            <c:if test="${not empty booking.guide}">
                <p><strong>Guide:</strong> ${booking.guide.name}</p>
            </c:if>
            <c:if test="${not empty booking.transport}">
                <p><strong>Transport:</strong> ${booking.transport.type}</p>
            </c:if>
            
            <p><strong>Quantity:</strong> ${booking.quantity}</p>
            <p><strong>Amount:</strong> ₹${booking.amountPaid}</p>
            <p><strong>Status:</strong> ${booking.status}</p>

            <form action="${pageContext.request.contextPath}/pilgrim/travel/booking/agency/update/${booking.id}" method="post" class="mt-3">
                <div class="mb-3">
                    <label>Update Status</label>
                    <select name="status" class="form-select" required>
                        <option value="CONFIRMED" <c:if test="${booking.status == 'CONFIRMED'}">selected</c:if>>CONFIRMED</option>
                        <option value="CANCELLED_BY_AGENCY" <c:if test="${booking.status == 'CANCELLED_BY_AGENCY'}">selected</c:if>>CANCELLED_BY_AGENCY</option>
                        <option value="REFUND_INITIATED" <c:if test="${booking.status == 'REFUND_INITIATED'}">selected</c:if>>REFUND_INITIATED</option>
                        <option value="REFUND_COMPLETED" <c:if test="${booking.status == 'REFUND_COMPLETED'}">selected</c:if>>REFUND_COMPLETED</option>
                        <option value="COMPLETED" <c:if test="${booking.status == 'COMPLETED'}">selected</c:if>>COMPLETED</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">Update Status</button>
            </form>
        </div>
    </c:if>

    <div class="mt-3">
        <a href="${pageContext.request.contextPath}/pilgrim/travel/booking/agency/list" class="btn btn-secondary">⬅ Back to List</a>
    </div>
</div>

<jsp:include page="../includes/footer.jsp"/>

