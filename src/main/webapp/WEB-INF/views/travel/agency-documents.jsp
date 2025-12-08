<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Travel Agency Documents Upload</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body class="bg-light">

    <jsp:include page="../includes/header.jsp" />

    <main class="container bg-white p-4 rounded shadow-sm mt-4">
        <h4 class="mb-4 text-primary">Upload Required Documents</h4>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/pilgrim/travel/agency/documents" 
              method="post" enctype="multipart/form-data" class="mt-3">

            <input type="hidden" name="agencyId" value="${agencyId}"/>

            <div class="mb-3">
                <label class="form-label fw-bold">Cancelled Cheque *</label>
                <input type="file" name="cancelledCheque" class="form-control" required/>
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold">PAN Card *</label>
                <input type="file" name="panCard" class="form-control" required/>
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold">GSTIN Certificate *</label>
                <input type="file" name="gstCertificate" class="form-control" required/>
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold">MSME Document</label>
                <input type="file" name="msmeDoc" class="form-control"/>
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold">ID Proof *</label>
                <input type="file" name="idProof" class="form-control" required/>
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold">COI Document *</label>
                <input type="file" name="coiDoc" class="form-control" required/>
            </div>

            <div class="form-check mb-3">
                <input class="form-check-input" type="checkbox" name="declaration" required/>
                <label class="form-check-label">
                    I hereby declare that the above details are correct and complete.
                </label>
            </div>

            <div class="d-flex justify-content-between mt-4">
                <a href="${pageContext.request.contextPath}/pilgrim/travel/agency/gst-details" class="btn btn-secondary">← Back</a>
                <button type="submit" class="btn btn-success">Submit → Success</button>
            </div>
        </form>
    </main>

    <jsp:include page="../includes/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

