<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../../includes/header.jsp"/>

<div class="container mt-4">

    <h3 class="mb-3">Pending Travel Agency Approvals</h3>

    <c:if test="${empty pendingAgencies}">
        <div class="alert alert-warning">No pending agencies found.</div>
    </c:if>

    <c:if test="${not empty pendingAgencies}">
        <table class="table table-bordered">
            <thead class="table-light">
            <tr>
                <th>ID</th>
                <th>Agency Name</th>
                <th>Email</th>
                <th>Mobile</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="a" items="${pendingAgencies}">
                <tr>
                    <td>${a.id}</td>
                    <td>${a.travelsName}</td>
                    <td>${a.email}</td>
                    <td>${a.mobile}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/admin/travel/agencies/view/${a.id}"
                           class="btn btn-info btn-sm">View</a>

                        <form action="${pageContext.request.contextPath}/admin/travel/agencies/approve/${a.id}" method="post" style="display:inline;">
                            <button type="submit" class="btn btn-success btn-sm">Approve</button>
                        </form>

                        <form action="${pageContext.request.contextPath}/admin/travel/agencies/reject/${a.id}" method="post" style="display:inline;">
                            <button type="submit" class="btn btn-danger btn-sm"
                                    onclick="return confirm('Reject this agency?')">Reject</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>

</div>

<jsp:include page="../../includes/footer.jsp"/>

