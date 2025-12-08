<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../includes/header.jsp"/>

<div class="container mt-4">
    <h2 class="mb-4">Add Transport</h2>

    <form action="${pageContext.request.contextPath}/pilgrim/travel/agency/transport/add" 
          method="post" enctype="multipart/form-data">

        <div class="card mb-4">
            <div class="card-header bg-dark text-white">Transport Info</div>
            <div class="card-body">
                <div class="mb-3">
                    <label>Transport Type</label>
                    <select name="type" class="form-select" required>
                        <option value="BUS">BUS</option>
                        <option value="CAR">CAR</option>
                        <option value="AUTO">AUTO</option>
                        <option value="BIKE">BIKE</option>
                        <option value="SCOOTY">SCOOTY</option>
                    </select>
                </div>
                <div class="mb-3"><label>City</label><input type="text" name="city" class="form-control" required/></div>
                <div class="mb-3"><label>Temple (optional)</label><input type="text" name="temple" class="form-control"/></div>
                <div class="mb-3"><label>Sitting Capacity</label><input type="number" name="capacity" class="form-control" min="1" required/></div>
                <div class="row">
                    <div class="col-md-3 mb-3"><label>Price Per Hour</label><input type="number" step="0.01" name="pricePerHour" class="form-control"/></div>
                    <div class="col-md-3 mb-3"><label>Price Per Day</label><input type="number" step="0.01" name="pricePerDay" class="form-control"/></div>
                    <div class="col-md-3 mb-3"><label>Temple Sightseeing Price</label><input type="number" step="0.01" name="priceTempleSight" class="form-control"/></div>
                    <div class="col-md-3 mb-3"><label>Price Per Trip</label><input type="number" step="0.01" name="pricePerTrip" class="form-control"/></div>
                </div>
            </div>
        </div>

        <div class="card mb-4">
            <div class="card-header bg-dark text-white">Vehicle Details</div>
            <div class="card-body">
                <div class="mb-3"><label>Vehicle Number</label><input type="text" name="vehicleNumber" class="form-control" required/></div>

                <div class="mb-3">
                    <label>Vehicle Images</label>
                    <div id="vehicleImageContainer">
                        <input type="file" name="vehicleImages" class="form-control mb-2" accept="image/*"/>
                    </div>
                    <button type="button" class="btn btn-secondary mt-2" onclick="addVehicleImageField()">+ Add More Image</button>
                </div>

                <div class="row mb-2">
                    <div class="col-md-6"><label>Driver Name</label><input type="text" name="driverName" class="form-control" required/></div>
                    <div class="col-md-6"><label>Driver Mobile</label><input type="text" name="driverMobile" class="form-control" required/></div>
                </div>
                <div class="mb-2"><label>Driver Image</label><input type="file" name="driverImagePath" class="form-control" accept="image/*" required/></div>
            </div>
        </div>

        <button type="submit" class="btn btn-success">Save Transport</button>
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

