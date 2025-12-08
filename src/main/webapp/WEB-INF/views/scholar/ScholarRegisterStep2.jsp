<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Scholar Registration - Step 2 - GlobalPiligrim</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 40px 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card mx-auto" style="max-width: 800px;">
            <div class="card-body p-4">
                <div class="text-center mb-4 text-muted">
                    <strong>Step 2 of 2: Professional Details</strong>
                </div>
                <h1 class="text-center text-primary mb-4">Complete Your Profile</h1>
                
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>
                
                <form method="post" action="${pageContext.request.contextPath}/scholar/register/step2" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label class="form-label">Type *</label>
                        <select name="type" class="form-select" required>
                            <option value="">Select Type</option>
                            <option value="SPIRITUAL_SCHOLAR">Spiritual Scholar</option>
                            <option value="ASTROLOGER">Astrologer</option>
                        </select>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Experience (Years) *</label>
                        <input type="number" name="experienceYears" min="0" class="form-control" required>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Specializations *</label>
                        <div class="row g-2">
                            <c:forEach var="spec" items="${specializations}">
                                <div class="col-md-6">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="specializations" value="${spec}" id="spec_${spec}">
                                        <label class="form-check-label" for="spec_${spec}">${spec}</label>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Languages (comma separated) *</label>
                        <input type="text" name="languages" placeholder="Hindi, English, Sanskrit" class="form-control" required>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Service Areas / Location *</label>
                        <textarea name="serviceAreas" rows="3" class="form-control" required></textarea>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Base Price (per session/ritual) *</label>
                        <input type="number" name="basePrice" step="0.01" min="0" class="form-control" required>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">ID Proof Upload *</label>
                        <input type="file" name="idProof" accept="image/*,.pdf" class="form-control" required>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Certificates Upload *</label>
                        <input type="file" name="certificates" accept="image/*,.pdf" class="form-control" required>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Profile Photo *</label>
                        <input type="file" name="profilePhoto" accept="image/*" class="form-control" required>
                    </div>
                    
                    <button type="submit" class="btn btn-primary w-100">Submit for Verification</button>
                </form>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

