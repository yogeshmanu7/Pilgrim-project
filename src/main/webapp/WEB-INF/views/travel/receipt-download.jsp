<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../includes/header.jsp"/>

<style>
  body { background: #fdfdfd; }
  .receipt-card { border: 2px solid #1a237e; border-radius: 14px; padding: 20px; background: #fff; }
  .receipt-header { background: #1a237e; color: #fff; padding: 15px; border-radius: 10px 10px 0 0; }
  .receipt-footer { background: #f9a825; color: #000; padding: 10px; border-radius: 0 0 10px 10px; text-align: center; }
  .pill { border-radius: 999px; }
  .btn-primary { background: #1a237e; color: #fff; }
  .btn-primary:hover { background: #0d1654; color: #fff; }
  .btn-gold { background: #f9a825; color: #000; }
  .btn-gold:hover { background: #d68910; color: #fff; }
</style>

<div class="container mt-4">
  <div class="receipt-card">
    <div class="receipt-header text-center">
      <h3>🧾 GlobalPiligrim Travel Booking Receipt</h3>
      <p class="mb-0">Thank you for booking with GlobalPiligrim</p>
    </div>

    <div class="p-4">
      <h5 class="text-primary">Booking Details</h5>
      <p><strong>Booking ID:</strong> ${booking.id}</p>
      <p><strong>User:</strong> ${booking.user != null ? booking.user.fullName : 'N/A'} (${booking.user != null ? booking.user.email : 'N/A'})</p>

      <c:choose>
        <c:when test="${not empty booking.travelPackage}">
          <p><strong>Package:</strong> ${booking.travelPackage.packageName}</p>
        </c:when>
        <c:when test="${not empty booking.guide}">
          <p><strong>Guide:</strong> ${booking.guide.name} (${booking.guide.language})</p>
          <p><strong>City:</strong> ${booking.guide.city}</p>
        </c:when>
        <c:otherwise>
          <p><strong>Transport:</strong> ${booking.transport.type} - ${booking.transport.city}</p>
          <p><strong>Driver:</strong> ${booking.transport.driverName} (${booking.transport.driverMobile})</p>
        </c:otherwise>
      </c:choose>

      <p><strong>Quantity:</strong> ${booking.quantity}</p>
      <p><strong>Amount Paid:</strong> ₹${booking.amountPaid}</p>
      <p><strong>Status:</strong> ${booking.status}</p>
      <p><strong>Booking Date:</strong> ${booking.bookedAt}</p>

      <c:if test="${not empty booking.passengerNames}">
        <h5 class="text-primary mt-3">Passenger Details</h5>
        <c:forEach var="name" items="${booking.passengerNames}" varStatus="status">
          <p>Passenger ${status.index + 1}: ${name}, Age: ${booking.passengerAges[status.index]}</p>
        </c:forEach>
      </c:if>

      <c:if test="${not empty booking.paymentId}">
        <h5 class="text-primary mt-3">Payment Info</h5>
        <p><strong>Payment ID:</strong> ${booking.paymentId}</p>
        <p><strong>Order ID:</strong> ${booking.paymentOrderId}</p>
        <p><strong>Signature:</strong> ${booking.paymentSignature}</p>
      </c:if>
    </div>

    <div class="receipt-footer">
      <p class="mb-1">GlobalPiligrim • Inclusive journeys across all faiths</p>
      <button onclick="window.print()" class="btn btn-primary pill">Print Receipt</button>
      <a href="${pageContext.request.contextPath}/pilgrim/travel/packages" class="btn btn-gold pill">Back to Packages</a>
    </div>
  </div>
</div>

<jsp:include page="../includes/footer.jsp"/>

