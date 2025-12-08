<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../includes/header.jsp"/>

<div class="container mt-5">
  <div class="text-center mb-4">
    <h2 class="text-primary">Passenger & Contact Details</h2>
    <p class="text-muted">Please provide your contact information and booking details to continue.</p>
  </div>

  <div class="card shadow-sm mb-4">
    <div class="card-body">
      <h5 class="card-title text-gold">Booking Summary</h5>

      <c:if test="${not empty booking.travelPackage}">
        <input type="hidden" name="travelPackage.id" value="${booking.travelPackage.id}"/>
        <p><strong>Package:</strong> ${booking.travelPackage.packageName}</p>
      </c:if>

      <c:if test="${not empty booking.transport}">
        <input type="hidden" name="transport.id" value="${booking.transport.id}"/>
        <p><strong>Transport:</strong> ${booking.transport.type} - ${booking.transport.city}</p>
        <p><strong>Driver:</strong> ${booking.transport.driverName} (${booking.transport.driverMobile})</p>
      </c:if>

      <c:if test="${not empty booking.guide}">
        <input type="hidden" name="guide.id" value="${booking.guide.id}"/>
        <p><strong>Guide:</strong> ${booking.guide.name} - ${booking.guide.city}</p>
        <p><strong>Language:</strong> ${booking.guide.language}</p>
      </c:if>

      <p><strong>Quantity:</strong> ${booking.quantity}</p>
      <p><strong>Total Amount:</strong> ₹${booking.amountPaid}</p>
    </div>
  </div>

  <form action="${pageContext.request.contextPath}/pilgrim/travel/booking/user/payment" method="post" class="needs-validation" novalidate>
    <input type="hidden" name="quantity" value="${booking.quantity}"/>
    <input type="hidden" name="amountPaid" value="${booking.amountPaid}"/>

    <div class="card shadow-sm mb-4">
      <div class="card-body">
        <h5 class="card-title text-primary">Contact Information</h5>
        <div class="row">
          <div class="col-md-6 mb-3">
            <label class="form-label">Full Name</label>
            <input type="text" name="userName" class="form-control" required/>
          </div>
          <div class="col-md-6 mb-3">
            <label class="form-label">Mobile</label>
            <input type="text" name="mobile" class="form-control" required/>
          </div>
          <div class="col-md-6 mb-3">
            <label class="form-label">Email</label>
            <input type="email" name="email" class="form-control" required/>
          </div>
          <div class="col-md-6 mb-3">
            <label class="form-label">Address</label>
            <textarea name="address" class="form-control" rows="2" required></textarea>
          </div>
        </div>
      </div>
    </div>

    <c:if test="${not empty booking.travelPackage}">
      <div class="card shadow-sm mb-4">
        <div class="card-body">
          <h5 class="card-title text-primary">Passenger Details</h5>
          <c:forEach var="i" begin="1" end="${booking.quantity}">
            <div class="border rounded p-3 mb-3 bg-light">
              <h6 class="text-gold">Passenger ${i}</h6>
              <div class="row">
                <div class="col-md-6 mb-3">
                  <label class="form-label">Passenger Name</label>
                  <input type="text" name="passengerNames" class="form-control" required/>
                </div>
                <div class="col-md-6 mb-3">
                  <label class="form-label">Age</label>
                  <input type="number" name="passengerAges" class="form-control" required/>
                </div>
              </div>
            </div>
          </c:forEach>
        </div>
      </div>
    </c:if>

    <div class="text-center">
      <button type="submit" class="btn btn-success btn-lg px-5">Proceed to Payment</button>
      <a href="${pageContext.request.contextPath}/pilgrim/travel/packages" class="btn btn-secondary btn-lg px-5 ms-3">Cancel</a>
    </div>
  </form>
</div>

<jsp:include page="../includes/footer.jsp"/>

