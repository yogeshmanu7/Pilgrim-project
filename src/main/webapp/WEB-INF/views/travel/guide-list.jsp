<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../includes/header.jsp"/>

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2 class="mb-0">Manage Guides</h2>
        <a href="${pageContext.request.contextPath}/pilgrim/travel/agency/guides/add" 
           class="btn btn-success">
           ➕ Add New Guide
        </a>
    </div>

    <form action="${pageContext.request.contextPath}/pilgrim/travel/agency/guides/list" method="get" class="mb-4">
        <div class="input-group">
            <input type="text" name="search" class="form-control" placeholder="Search guides by name, city, temple..."/>
            <button class="btn btn-primary" type="submit">Search</button>
        </div>
    </form>

    <div class="card shadow-sm">
        <div class="card-body p-0">
            <table class="table table-hover mb-0">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Image</th>
                        <th>Name</th>
                        <th>Language</th>
                        <th>City</th>
                        <th>Temple</th>
                        <th>Price</th>
                        <th>Availability</th>
                        <th style="width: 220px;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="g" items="${guides}">
                        <tr>
                            <td>${g.id}</td>
                            <td>
                                <c:if test="${not empty g.imagePath}">
                                    <img src="${pageContext.request.contextPath}${g.imagePath}" 
                                         alt="Guide Image" width="60" height="60" 
                                         class="rounded-circle border"/>
                                </c:if>
                            </td>
                            <td>
                                <strong>${g.name}</strong><br>
                                <small class="text-muted">${g.shortDescription}</small>
                            </td>
                            <td><span class="badge bg-info">${g.language}</span></td>
                            <td>${g.city}</td>
                            <td>${g.temple}</td>
                            <td>₹${g.price}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${g.available}">
                                        <span class="badge bg-success">Available</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-danger">Booked</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <div class="btn-group" role="group">
                                    <a href="${pageContext.request.contextPath}/pilgrim/travel/agency/guides/details/${g.id}" 
                                       class="btn btn-sm btn-info">View</a>
                                    <a href="${pageContext.request.contextPath}/pilgrim/travel/agency/guides/edit/${g.id}" 
                                       class="btn btn-sm btn-primary">Edit</a>
                                    <a href="${pageContext.request.contextPath}/pilgrim/travel/agency/guides/delete/${g.id}" 
                                       class="btn btn-sm btn-danger"
                                       onclick="return confirm('Delete this guide?');">Delete</a>
                                </div>
                                <div class="mt-2">
                                    <c:if test="${g.available}">
                                        <form action="${pageContext.request.contextPath}/pilgrim/travel/agency/guides/book/${g.id}" 
                                              method="post" style="display:inline;">
                                            <button type="submit" class="btn btn-sm btn-warning">Book</button>
                                        </form>
                                    </c:if>
                                    <c:if test="${!g.available}">
                                        <form action="${pageContext.request.contextPath}/pilgrim/travel/agency/guides/release/${g.id}" 
                                              method="post" style="display:inline;">
                                            <button type="submit" class="btn btn-sm btn-success">Release</button>
                                        </form>
                                    </c:if>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<jsp:include page="../includes/footer.jsp"/>

