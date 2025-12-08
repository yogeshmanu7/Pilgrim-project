<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../includes/header.jsp"/>

<style>
  .card-soft { border: none; border-radius: 14px; box-shadow: 0 6px 18px rgba(0,0,0,0.08); }
  .pill { border-radius: 999px; }
  .star { color: #f9a825; font-size: 1.2rem; }
  .comment { font-style: italic; color: #444; }
  .rating-img { max-height: 120px; border-radius: 8px; margin: 4px; }
</style>

<div class="container mt-4">
  <h3 class="text-primary mb-4">
    ⭐ User Ratings for 
    <c:choose>
      <c:when test="${not empty package}">Package: ${package.packageName}</c:when>
      <c:when test="${not empty guide}">Guide: ${guide.name}</c:when>
      <c:otherwise>Transport: ${transport.type} - ${transport.city}</c:otherwise>
    </c:choose>
  </h3>

  <c:forEach var="r" items="${ratings}">
    <div class="card card-soft p-3 mb-3">
      <div>
        <c:forEach begin="1" end="${r.stars}" var="i">
          <span class="star">★</span>
        </c:forEach>
        <c:forEach begin="1" end="${5 - r.stars}" var="i">
          <span class="star" style="color:#ccc;">★</span>
        </c:forEach>
      </div>

      <p class="comment mt-2">"${r.comment}"</p>
      <small class="text-muted">By ${r.user != null ? r.user.fullName : 'Anonymous'}</small>

      <c:if test="${not empty r.imagePaths}">
        <div class="mt-3">
          <c:forEach var="img" items="${r.imagePaths}">
            <img src="${pageContext.request.contextPath}${img}" class="rating-img"/>
          </c:forEach>
        </div>
      </c:if>
    </div>
  </c:forEach>

  <c:if test="${empty ratings}">
    <div class="alert alert-info">No ratings yet. Be the first to share your experience!</div>
  </c:if>
</div>

<jsp:include page="../includes/footer.jsp"/>

