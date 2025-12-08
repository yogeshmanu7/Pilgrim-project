<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../includes/header.jsp"/>

<div class="container mt-4">
    <h2 class="mb-4">Edit Transport</h2>

    <form action="${pageContext.request.contextPath}/pilgrim/travel/agency/transport/edit/${transport.id}" 
          method="post" enctype="multipart/form-data">

        <div class="card mb-4">
            <div class="card-header bg-dark text-white">Transport Info</div>
            <div class="card-body">
                <div class="mb-3">
                    <label>Transport Type</label>
                    <select name="type" class="form-select" required>
                        <option value="BUS" <c:if test="${transport.type == 'BUS'}">selected</c:if>>BUS</option>
                        <option value="CAR" <c:if test="${transport.type == 'CAR'}">selected</c:if>>CAR</option>
                        <option value="AUTO" <c:if test="${transport.type == 'AUTO'}">selected</c:if>>AUTO</option>
                        <option value="BIKE" <c:if test="${transport.type == 'BIKE'}">selected</c:if>>BIKE</option>
                        <option value="SCOOTY" <c:if test="${transport.type == 'SCOOTY'}">selected</c:if>>SCOOTY</option>
                    </select>
                </div>
                <div class="mb-3"><label>City</label><input type="text" name="city" class="form-control" value="${transport.city}" required/></div>
                <div class="mb-3"><label>Temple</label><input type="text" name="temple" class="form-control" value="${transport.temple}"/></div>
                <div class="mb-3"><label>Sitting Capacity</label><input type="number" name="capacity" class="form-control" value="${transport.capacity}" required/></div>

                <div class="mb-3">
                    <label>Vehicle Number</label>
                    <input type="text" name="vehicleNumber" class="form-control" 
                           value="${transport.vehicleNumber}" required/>
                </div>

                <div class="row">
                    <div class="col-md-3 mb-3"><label>Price Per Hour</label><input type="number" step="0.01" name="pricePerHour" class="form-control" value="${transport.pricePerHour}"/></div>
                    <div class="col-md-3 mb-3"><label>Price Per Day</label><input type="number" step="0.01" name="pricePerDay" class="form-control" value="${transport.pricePerDay}"/></div>
                    <div class="col-md-3 mb-3"><label>Temple Sightseeing Price</label><input type="number" step="0.01" name="priceTempleSight" class="form-control" value="${transport.priceTempleSight}"/></div>
                    <div class="col-md-3 mb-3"><label>Price Per Trip</label><input type="number" step="0.01" name="pricePerTrip" class="form-control" value="${transport.pricePerTrip}"/></div>
                </div>
            </div>
        </div>

        <div class="card mb-4">
            <div class="card-header bg-dark text-white">Vehicle Images</div>
            <div class="card-body">
                <c:if test="${not empty transport.vehicleImagePaths}">
                    <h6>Existing Images</h6>
                    <div class="d-flex flex-wrap mb-3">
                        <c:forEach var="img" items="${transport.vehicleImagePaths}">
                            <img src="${pageContext.request.contextPath}${img}" 
                                 alt="Vehicle Image" width="120" class="img-thumbnail me-2 mb-2"/>
                        </c:forEach>
                    </div>
                </c:if>

                <label>Upload New Images</label>
                <div id="vehicleImageContainer">
                    <input type="file" name="vehicleImages" class="form-control mb-2" accept="image/*"/>
                </div>
                <button type="button" class="btn btn-secondary mt-2" onclick="addVehicleImageField()">+ Add More Image</button>
            </div>
        </div>

        <div class="card mb-4">
            <div class="card-header bg-dark text-white">Driver Info</div>
            <div class="card-body">
                <div class="mb-3"><label>Driver Name</label><input type="text" name="driverName" class="form-control" value="${transport.driverName}" required/></div>
                <div class="mb-3"><label>Driver Mobile</label><input type="text" name="driverMobile" class="form-control" value="${transport.driverMobile}" required/></div>
                <div class="mb-3">
                    <label>Driver Image</label><br>
                    <c:if test="${not empty transport.driverImagePath}">
                        <img src="${pageContext.request.contextPath}${transport.driverImagePath}" 
                             width="120" class="img-thumbnail mb-2"/>
                    </c:if>
                    <input type="file" name="driverImagePath" class="form-control" accept="image/*"/>
                </div>
            </div>
        </div>

        <button type="submit" class="btn btn-primary">Update Transport</button>
        <a href="${pageContext.request.contextPath}/pilgrim/travel/agency/transport/list" class="btn btn-secondary">Cancel</a>
    </form>
</div>

<script>
function addVehicleImageField() {
    const container = document.getElementById("vehicleImageContainer");
    const newInput = document.createElement("input");
    newInput.type = "file";
    newInput.name = "vehicleImages";
    newInput.className = "form-control mb-2";
    newInput.accept = "image/*";
    container.appendChild(newInput);
}
</script>

<jsp:include page="../includes/footer.jsp"/>

