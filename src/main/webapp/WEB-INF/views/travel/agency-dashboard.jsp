<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../includes/header.jsp"/>

<div class="container mt-4">
    <h2 class="mb-3">Agency Dashboard</h2>

    <c:if test="${not empty agency}">
        <div class="card shadow-sm mb-4">
            <div class="card-body">
                <h4 class="card-title">Welcome, <b>${agency.travelsName}</b></h4>
                <p class="card-text">
                    Status: 
                    <span class="badge 
                        <c:choose>
                            <c:when test="${agency.approvalStatus == 'APPROVED'}">bg-success</c:when>
                            <c:when test="${agency.approvalStatus == 'PENDING'}">bg-warning</c:when>
                            <c:otherwise>bg-danger</c:otherwise>
                        </c:choose>">
                        ${agency.approvalStatus}
                    </span>
                </p>
            </div>
        </div>

        <div class="row">
        <div class="col-md-6 mb-3">
            <a href="${pageContext.request.contextPath}/pilgrim/travel/agency/package/list"
   class="list-group-item list-group-item-action shadow-sm">
   📦 Manage Travel Packages
</a>
            </div>
            <div class="col-md-6 mb-3">
                <a href="${pageContext.request.contextPath}/pilgrim/travel/agency/transport/list" 
                   class="list-group-item list-group-item-action shadow-sm">
                   🚍 Manage Transport
                </a>
            </div>
            <div class="col-md-6 mb-3">
                <a href="${pageContext.request.contextPath}/pilgrim/travel/agency/guides/list" 
                   class="list-group-item list-group-item-action shadow-sm">
                   🧑‍🏫 Manage Guides
                </a>
            </div>
            <div class="col-md-6 mb-3">
                <a href="${pageContext.request.contextPath}/pilgrim/travel/booking/agency/list"
   class="list-group-item list-group-item-action shadow-sm">
   📑 View Bookings
</a>
            </div>
        </div>
    </c:if>

    <div class="mt-4">
        <a href="${pageContext.request.contextPath}/pilgrim/travel/agency/logout" class="btn btn-danger">Logout</a>
    </div>
</div>

<jsp:include page="../includes/footer.jsp"/>

