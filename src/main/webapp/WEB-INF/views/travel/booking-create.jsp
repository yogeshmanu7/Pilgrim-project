<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../includes/header.jsp"/>

<div class="container mt-4">
  <h3>Confirm Your Booking</h3>

  <form action="${pageContext.request.contextPath}/pilgrim/travel/booking/user/details" method="post">
    
    <c:if test="${not empty booking.travelPackage}">
      <input type="hidden" name="travelPackage.id" value="${booking.travelPackage.id}"/>
      <p><strong>Package:</strong> ${booking.travelPackage.packageName}</p>
      <div class="mb-3">
        <label>Quantity (Number of Persons)</label>
        <input type="number" name="quantity" value="${booking.quantity}" min="1" 
               class="form-control" onchange="updateAmount(this.value, ${booking.travelPackage.price})"/>
      </div>
    </c:if>

    <c:if test="${not empty booking.transport}">
      <input type="hidden" name="transport.id" value="${booking.transport.id}"/>
      <p><strong>Transport:</strong> ${booking.transport.type} - ${booking.transport.city}</p>
      <div class="mb-3">
        <label>Quantity (Number of Vehicles)</label>
        <input type="number" name="quantity" value="${booking.quantity}" min="1" 
               class="form-control" onchange="updateAmount(this.value, ${booking.transport.pricePerDay})"/>
      </div>
    </c:if>

    <c:if test="${not empty booking.guide}">
      <input type="hidden" name="guide.id" value="${booking.guide.id}"/>
      <p><strong>Guide:</strong> ${booking.guide.name} - ${booking.guide.city}</p>
      <div class="mb-3">
        <label>Quantity (Number of Days)</label>
        <input type="number" name="quantity" value="${booking.quantity}" min="1" 
               class="form-control" onchange="updateAmount(this.value, ${booking.guide.price})"/>
      </div>
    </c:if>

    <div class="mb-3">
      <label>Total Amount</label>
      <input type="text" id="amountPaid" name="amountPaid" value="${booking.amountPaid}" readonly class="form-control"/>
    </div>

    <button type="submit" class="btn btn-primary">Proceed to Details</button>
    <a href="${pageContext.request.contextPath}/pilgrim/travel/packages" class="btn btn-secondary">Cancel</a>
  </form>
</div>

<script>
  function updateAmount(quantity, price) {
    document.getElementById("amountPaid").value = (quantity * price).toFixed(2);
  }
</script>

<jsp:include page="../includes/footer.jsp"/>

