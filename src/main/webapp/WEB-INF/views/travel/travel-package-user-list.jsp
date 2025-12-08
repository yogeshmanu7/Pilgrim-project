<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../includes/header.jsp"/>

<style>
  body { background: #fdfdfd; }
  .card-soft { border: none; border-radius: 14px; box-shadow: 0 6px 18px rgba(0,0,0,0.08); }
  .pill { border-radius: 999px; }
  .btn-primary { background: #1a237e; color: #fff; }
  .btn-primary:hover { background: #0d1654; color: #fff; }
  .btn-gold { background: #f9a825; color: #000; }
  .btn-gold:hover { background: #d68910; color: #fff; }
  .package-img { height: 180px; object-fit: cover; border-radius: 12px; }
  .section-title { color: #1a237e; font-weight: 700; }
</style>

<div class="container mt-4">
  <h3 class="section-title mb-3">🛕 Explore Pilgrim Packages</h3>

  <form action="${pageContext.request.contextPath}/pilgrim/travel/search" method="get" class="card-soft p-4 mb-4 bg-white">
    <div class="row g-3">
      <div class="col-md-3"><input type="text" name="keyword" class="form-control pill" placeholder="Search..."/></div>
      <div class="col-md-3"><input type="text" name="city" class="form-control pill" placeholder="City"/></div>
      <div class="col-md-3"><input type="text" name="state" class="form-control pill" placeholder="State"/></div>
      <div class="col-md-3 d-flex gap-2">
        <input type="number" name="min" class="form-control pill" placeholder="Min ₹"/>
        <input type="number" name="max" class="form-control pill" placeholder="Max ₹"/>
      </div>
      <div class="col-md-3">
        <button class="btn btn-primary pill w-100">Search</button>
      </div>
    </div>
  </form>

  <div class="row g-4">
    <c:forEach var="p" items="${packages}">
      <div class="col-md-4">
        <div class="card card-soft h-100">
          <c:choose>
            <c:when test="${not empty p.imagePaths}">
              <img src="${pageContext.request.contextPath}${p.imagePaths[0]}" class="package-img" alt="${p.packageName}"/>
            </c:when>
            <c:otherwise>
              <img src="${pageContext.request.contextPath}/resources/images/package-placeholder.jpg" class="package-img" alt="No image available"/>
            </c:otherwise>
          </c:choose>

          <div class="card-body">
            <h5 class="card-title">${p.packageName}</h5>
            <p class="text-muted">${p.city}, ${p.state}, ${p.country}</p>
            <p><strong>Price:</strong> ₹${p.price} • <strong>Duration:</strong> ${p.durationDays} days</p>
            <p class="small">${p.description}</p>
            <div class="d-grid gap-2">
              <a href="${pageContext.request.contextPath}/pilgrim/travel/view/${p.id}" 
                 class="btn btn-primary pill">View Details</a>

              <a href="${pageContext.request.contextPath}/pilgrim/travel/booking/user/create?packageId=${p.id}&quantity=1&amount=${p.price}" class="btn btn-gold pill">Book Now</a>
            </div>
          </div>
        </div>
      </div>
    </c:forEach>
  </div>

  <c:if test="${empty packages}">
    <div class="alert alert-info mt-3">No packages found. Try adjusting your filters.</div>
  </c:if>
</div>

<jsp:include page="../includes/footer.jsp"/>

