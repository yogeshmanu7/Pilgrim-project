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
  .package-img { width: 100%; height: 250px; object-fit: cover; border-radius: 12px; margin-bottom: 10px; }
  .section-title { color: #1a237e; font-weight: 700; }
</style>

<div class="container mt-4">
  <div class="card card-soft p-4 mb-4">
    <h3 class="section-title">${pack.packageName}</h3>
    <p class="text-muted">${pack.city}, ${pack.state}, ${pack.country}</p>
    <p>${pack.description}</p>
    <p><strong>Price:</strong> ₹${pack.price} • <strong>Duration:</strong> ${pack.durationDays} days</p>
    <p><strong>Type:</strong> ${pack.travelType}</p>
  </div>

  <div class="card card-soft p-4 mb-4">
    <h4 class="section-title">📸 Package Images</h4>
    <div class="row">
      <c:forEach var="img" items="${pack.imagePaths}">
        <div class="col-md-4 mb-3">
          <img src="${pageContext.request.contextPath}${img}" class="package-img" alt="${pack.packageName}"/>
        </div>
      </c:forEach>
      <c:if test="${empty pack.imagePaths}">
        <div class="alert alert-info">No images available for this package.</div>
      </c:if>
    </div>
  </div>

  <div class="card card-soft p-4 text-center">
    <div class="d-flex justify-content-center gap-3">
      <a href="${pageContext.request.contextPath}/pilgrim/travel/booking/user/create?packageId=${pack.id}&quantity=1&amount=${pack.price}" 
         class="btn btn-primary pill px-4">Book Now</a>
      <a href="${pageContext.request.contextPath}/pilgrim/travel/rating/package/${pack.id}/list" 
         class="btn btn-gold pill px-4">View Ratings</a>
    </div>
  </div>
</div>

<jsp:include page="../includes/footer.jsp"/>

