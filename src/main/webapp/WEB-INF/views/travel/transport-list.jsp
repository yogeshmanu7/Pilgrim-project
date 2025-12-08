<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../includes/header.jsp"/>

<div class="container mt-4">
    <h2>Transport List</h2>

    <form action="${pageContext.request.contextPath}/pilgrim/travel/agency/transport/list" method="get" class="mb-3">
        <div class="row">
            <div class="col-md-4">
                <select name="type" class="form-control" onchange="this.form.submit()">
                    <option value="">-- All Types --</option>
                    <option value="BUS" ${selectedType == 'BUS' ? 'selected' : ''}>Bus</option>
                    <option value="CAR" ${selectedType == 'CAR' ? 'selected' : ''}>Car</option>
                    <option value="AUTO" ${selectedType == 'AUTO' ? 'selected' : ''}>Auto</option>
                    <option value="BIKE" ${selectedType == 'BIKE' ? 'selected' : ''}>Bike</option>
                    <option value="SCOOTY" ${selectedType == 'SCOOTY' ? 'selected' : ''}>Scooty</option>
                </select>
            </div>
        </div>
    </form>

    <div class="alert alert-info">
        <strong>Totals:</strong>
        Buses: ${totalBuses} |
        Cars: ${totalCars} |
        Autos: ${totalAutos} |
        Bikes: ${totalBikes} |
        Scooties: ${totalScooties}
    </div>

    <a href="${pageContext.request.contextPath}/pilgrim/travel/agency/transport/add" class="btn btn-success mb-3">
        + Add New Transport
    </a>

    <table class="table table-bordered table-striped">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Type</th>
                <th>City</th>
                <th>Temple</th>
                <th>Vehicle Number</th>
                <th>Capacity</th>
                <th>Driver</th>
                <th>Availability</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="t" items="${transports}">
                <tr>
                    <td>${t.id}</td>
                    <td>${t.type}</td>
                    <td>${t.city}</td>
                    <td>${t.temple}</td>
                    <td>${t.vehicleNumber}</td>
                    <td>${t.capacity}</td>
                    <td>${t.driverName} (${t.driverMobile})</td>
                    <td>
                        <c:choose>
                            <c:when test="${t.available}">
                                <span class="badge bg-success">Available</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-danger">Booked</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <a href="${pageContext.request.contextPath}/pilgrim/travel/agency/transport/details/${t.id}" 
                           class="btn btn-info btn-sm">View</a>
                        <a href="${pageContext.request.contextPath}/pilgrim/travel/agency/transport/edit/${t.id}" 
                           class="btn btn-primary btn-sm">Edit</a>
                        <a href="${pageContext.request.contextPath}/pilgrim/travel/agency/transport/delete/${t.id}" 
                           class="btn btn-danger btn-sm"
                           onclick="return confirm('Are you sure you want to delete this transport?');">Delete</a>

                        <c:if test="${t.available}">
                            <form action="${pageContext.request.contextPath}/pilgrim/travel/agency/transport/book/${t.id}" 
                                  method="post" style="display:inline;">
                                <button type="submit" class="btn btn-warning btn-sm">Book</button>
                            </form>
                        </c:if>
                        <c:if test="${!t.available}">
                            <form action="${pageContext.request.contextPath}/pilgrim/travel/agency/transport/release/${t.id}" 
                                  method="post" style="display:inline;">
                                <button type="submit" class="btn btn-success btn-sm">Release</button>
                            </form>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<jsp:include page="../includes/footer.jsp"/>

