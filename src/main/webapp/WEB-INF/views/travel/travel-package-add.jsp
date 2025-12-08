<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../includes/header.jsp"/>

<div class="container mt-4">
    <h2>Add Travel Package</h2>
    <form action="${pageContext.request.contextPath}/pilgrim/travel/agency/package/add" 
          method="post" enctype="multipart/form-data">

        <div class="mb-3">
            <label>Name</label>
            <input type="text" name="packageName" class="form-control" required/>
        </div>

        <div class="mb-3">
            <label>Description</label>
            <textarea name="description" class="form-control"></textarea>
        </div>

        <div class="mb-3">
            <label>Country</label>
            <input type="text" name="country" class="form-control"/>
        </div>

        <div class="mb-3">
            <label>State</label>
            <input type="text" name="state" class="form-control"/>
        </div>

        <div class="mb-3">
            <label>City</label>
            <input type="text" name="city" class="form-control"/>
        </div>

        <div class="mb-3">
            <label>Price</label>
            <input type="number" step="0.01" name="price" class="form-control"/>
        </div>

        <div class="mb-3">
            <label>Duration (days)</label>
            <input type="number" name="durationDays" class="form-control"/>
        </div>

        <div class="mb-3">
            <label>Travel Type</label>
            <select name="travelType" class="form-select" required>
                <option value="ONE_DAY">One Day</option>
                <option value="MULTI_DAY">Multi Day</option>
                <option value="CITY_TOUR">City Tour</option>
                <option value="TEMPLE_ONLY">Temple Only</option>
            </select>
        </div>

    <div class="mb-3" id="imageUploadContainer">
    <label class="form-label">Upload Images (up to 5 by default)</label>

    <input type="file" name="images" class="form-control mb-2" accept="image/*"/>
    <input type="file" name="images" class="form-control mb-2" accept="image/*"/>
    <input type="file" name="images" class="form-control mb-2" accept="image/*"/>
    <input type="file" name="images" class="form-control mb-2" accept="image/*"/>
    <input type="file" name="images" class="form-control mb-2" accept="image/*"/>

    <div class="form-text">You can upload up to 5 images by default. Click below to add more.</div>

    <button type="button" class="btn btn-secondary mt-2" onclick="addImageField()">+ Add More Image</button>
</div>

        <button type="submit" class="btn btn-success">Save Package</button>
    </form>
</div>

<script>
    function limitFiles(input, max) {
        if (input.files.length > max) {
            alert("You can only upload up to " + max + " images in one field.");
            input.value = "";
        }
    }

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

