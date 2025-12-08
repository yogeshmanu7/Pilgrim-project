<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../includes/header.jsp"/>

<style>
  .card-soft { border: none; border-radius: 14px; box-shadow: 0 6px 18px rgba(0,0,0,0.08); }
  .pill { border-radius: 999px; }
  .btn-primary { background: #1a237e; color: #fff; }
  .btn-primary:hover { background: #0d1654; color: #fff; }
  .btn-gold { background: #f9a825; color: #000; }
  .btn-gold:hover { background: #d68910; color: #fff; }
</style>

<div class="container mt-4">
  <h3 class="text-primary mb-3">📌 Booking Status</h3>

  <c:if test="${not empty booking}">
    <div class="card card-soft p-4">
      <h5>
        <c:choose>
          <c:when test="${not empty booking.travelPackage}">${booking.travelPackage.packageName}</c:when>
          <c:when test="${not empty booking.guide}">Guide: ${booking.guide.name}</c:when>
          <c:otherwise>Transport: ${booking.transport.type}</c:otherwise>
        </c:choose>
      </h5>

      <p>Qty: ${booking.quantity} • Amount: ₹${booking.amountPaid}</p>

      <p>
        <strong>Status:</strong> ${booking.status}<br/>
        <c:if test="${not empty booking.bookedAt}">Booked at: ${booking.bookedAt}</c:if><br/>
        <c:if test="${not empty booking.cancelledAt}">Cancelled at: ${booking.cancelledAt}</c:if><br/>
        <c:if test="${not empty booking.refundInitiatedAt}">Refund initiated: ${booking.refundInitiatedAt}</c:if><br/>
        <c:if test="${not empty booking.refundedAt}">Refund completed: ${booking.refundedAt}</c:if><br/>
        <c:if test="${not empty booking.completedAt}">Completed: ${booking.completedAt}</c:if>
      </p>

      <c:if test="${not empty booking.cancellationReason}">
        <p><strong>Cancellation reason:</strong> ${booking.cancellationReason}</p>
      </c:if>
      <c:if test="${not empty booking.refundReason}">
        <p><strong>Refund reason:</strong> ${booking.refundReason}</p>
      </c:if>

      <div class="d-flex gap-2 mt-3">
        <a href="${pageContext.request.contextPath}/pilgrim/travel/booking/user/receipt/${booking.id}" class="btn btn-gold pill">Download Receipt</a>
        <a href="${pageContext.request.contextPath}/pilgrim/travel/packages" class="btn btn-outline-secondary pill">Back to Packages</a>
      </div>
    </div>
  </c:if>

  <c:if test="${empty booking}">
    <div class="alert alert-danger">No booking details available.</div>
  </c:if>
</div>

<jsp:include page="../includes/footer.jsp"/>

