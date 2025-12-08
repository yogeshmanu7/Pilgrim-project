<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../includes/header.jsp"/>

<div class="container mt-4">
    <h2>Edit Travel Package</h2>

    <form action="${pageContext.request.contextPath}/pilgrim/travel/agency/package/edit/${travelPackage.id}" 
          method="post" enctype="multipart/form-data">

        <input type="hidden" name="id" value="${travelPackage.id}"/>

        <div class="mb-3">
            <label for="packageName" class="form-label">Package Name</label>
            <input type="text" class="form-control" id="packageName" name="packageName"
                   value="${travelPackage.packageName}" required>
        </div>

        <div class="mb-3">
            <label for="description" class="form-label">Description</label>
            <textarea class="form-control" id="description" name="description" rows="3" required>${travelPackage.description}</textarea>
        </div>

        <div class="row">
            <div class="col-md-4 mb-3">
                <label for="country" class="form-label">Country</label>
                <input type="text" class="form-control" id="country" name="country"
                       value="${travelPackage.country}">
            </div>
            <div class="col-md-4 mb-3">
                <label for="state" class="form-label">State</label>
                <input type="text" class="form-control" id="state" name="state"
                       value="${travelPackage.state}">
            </div>
            <div class="col-md-4 mb-3">
                <label for="city" class="form-label">City</label>
                <input type="text" class="form-control" id="city" name="city"
                       value="${travelPackage.city}">
            </div>
        </div>

        <div class="row">
            <div class="col-md-6 mb-3">
                <label for="price" class="form-label">Price</label>
                <input type="number" step="0.01" class="form-control" id="price" name="price"
                       value="${travelPackage.price}">
            </div>
            <div class="col-md-6 mb-3">
                <label for="durationDays" class="form-label">Duration (Days)</label>
                <input type="number" class="form-control" id="durationDays" name="durationDays"
                       value="${travelPackage.durationDays}">
            </div>
        </div>

        <div class="mb-3">
            <label for="travelType" class="form-label">Travel Type</label>
            <select class="form-select" id="travelType" name="travelType" required>
                <c:forEach var="type" items="${travelTypes}">
                    <option value="${type}" 
                        <c:if test="${travelPackage.travelType == type}">selected</c:if>>
                        ${type}
                    </option>
                </c:forEach>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Existing Images</label><br>
            <c:forEach var="img" items="${travelPackage.imagePaths}">
                <img src="${pageContext.request.contextPath}${img}" alt="Package Image" width="100" class="img-thumbnail me-2 mb-2"/>
            </c:forEach>
        </div>

       <div class="mb-3" id="imageUploadContainer">
    <label class="form-label">Upload New Images (up to 5 by default)</label>

    <input type="file" name="images" class="form-control mb-2" accept="image/*"/>
    <input type="file" name="images" class="form-control mb-2" accept="image/*"/>
    <input type="file" name="images" class="form-control mb-2" accept="image/*"/>
    <input type="file" name="images" class="form-control mb-2" accept="image/*"/>
    <input type="file" name="images" class="form-control mb-2" accept="image/*"/>

    <div class="form-text">You can upload up to 5 images by default. Click below to add more.</div>

    <button type="button" class="btn btn-secondary mt-2" onclick="addImageField()">+ Add More Image</button>
</div>

        <div class="form-check mb-3">
            <input type="checkbox" name="replaceImages" value="true" class="form-check-input" id="replaceImages">
            <label class="form-check-label" for="replaceImages">Replace existing images</label>
        </div>

        <button type="submit" class="btn btn-primary">Update Package</button>
    </form>
</div>
<script>
    function addImageField() {
        const container = document.getElementById("imageUploadContainer");
        const newInput = document.createElement("input");
        newInput.type = "file";
        newInput.name = "images";
        newInput.className = "form-control mb-2";
        newInput.accept = "image/*";
        container.insertBefore(newInput, container.lastElementChild); 
    }
</script>

<jsp:include page="../includes/footer.jsp"/>

