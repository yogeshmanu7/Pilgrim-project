<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../includes/header.jsp"/>

<div class="container mt-4">
    <h2 class="mb-3">➕ Add New Guide</h2>

    <form action="${pageContext.request.contextPath}/pilgrim/travel/agency/guides/add" 
          method="post" enctype="multipart/form-data" class="card shadow-sm p-4">

        <div class="mb-3">
            <label class="form-label">Name</label>
            <input type="text" name="name" class="form-control" required/>
        </div>

        <div class="mb-3">
            <label class="form-label">Language</label>
            <select name="language" class="form-select" required>
                <c:forEach var="lang" items="${languages}">
                    <option value="${lang}">${lang}</option>
                </c:forEach>
            </select>
        </div>

        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="form-label">City</label>
                <input type="text" name="city" class="form-control"/>
            </div>
            <div class="col-md-6 mb-3">
                <label class="form-label">Temple</label>
                <input type="text" name="temple" class="form-control"/>
            </div>
        </div>

        <div class="mb-3">
            <label class="form-label">Price (₹)</label>
            <input type="number" step="0.01" name="price" class="form-control" required/>
        </div>

        <div class="mb-3">
            <label class="form-label">Short Description</label>
            <textarea name="shortDescription" class="form-control" rows="3"></textarea>
        </div>

        <div class="mb-3">
            <label class="form-label">Guide Image</label>
            <input type="file" name="imageFile" class="form-control" accept="image/*"/>
        </div>

        <button type="submit" class="btn btn-primary">Save Guide</button>
        <a href="${pageContext.request.contextPath}/pilgrim/travel/agency/guides/list" class="btn btn-secondary">Cancel</a>
    </form>
</div>

<jsp:include page="../includes/footer.jsp"/>

