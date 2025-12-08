<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../includes/header.jsp"/>

<div class="container mt-4">
  <h3 class="text-primary">💳 Payment Status</h3>

  <c:if test="${not empty booking}">
    <p><strong>Booking ID:</strong> ${booking.id}</p>
    <p><strong>Status:</strong> ${booking.status}</p>
    <p><strong>Amount Paid:</strong> ₹${booking.amountPaid}</p>

    <c:if test="${not empty booking.paymentId}">
      <p><strong>Payment ID:</strong> ${booking.paymentId}</p>
      <p><strong>Order ID:</strong> ${booking.paymentOrderId}</p>
      <p><strong>Signature:</strong> ${booking.paymentSignature}</p>
    </c:if>
  </c:if>

  <c:if test="${empty booking}">
    <div class="alert alert-warning">No booking found in session.</div>
  </c:if>
</div>

<jsp:include page="../includes/footer.jsp"/>

