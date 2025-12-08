<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile - GlobalPiligrim</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        .scholar-card {
            border-left: 4px solid #667eea;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.2);
        }
        .scholar-btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            color: white;
        }
        .scholar-btn:hover {
            background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
            color: white;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="card scholar-card mx-auto" style="max-width: 800px;">
            <div class="card-header bg-primary text-white">
                <h2 class="card-title mb-0">Edit Profile</h2>
            </div>
            <div class="card-body p-4">
                <form method="post" action="${pageContext.request.contextPath}/scholar/profile/edit">
                    <div class="mb-3">
                        <label class="form-label">Experience (Years)</label>
                        <input type="number" name="experienceYears" value="${scholar.experienceYears != null ? scholar.experienceYears : 0}" 
                               min="0" class="form-control">
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Specializations</label>
                        <div class="row g-2">
                            <c:forEach var="spec" items="${specializations}">
                                <div class="col-md-6">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="specializations" value="${spec}" 
                                               id="spec_${spec}" ${scholar.specializations != null && scholar.specializations.contains(spec) ? 'checked' : ''}>
                                        <label class="form-check-label" for="spec_${spec}">${spec}</label>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Languages (comma separated)</label>
                        <input type="text" name="languages" 
                               value="${scholar.languages != null ? String.join(', ', scholar.languages) : ''}" 
                               placeholder="Hindi, English, Sanskrit" class="form-control">
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Service Areas / Location</label>
                        <textarea name="serviceAreas" rows="3" class="form-control">${scholar.serviceAreas != null ? scholar.serviceAreas : ''}</textarea>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Base Price (per session/ritual)</label>
                        <input type="number" name="basePrice" value="${scholar.basePrice != null ? scholar.basePrice : 0}" 
                               step="0.01" min="0" class="form-control">
                    </div>
                    
                    <button type="submit" class="btn scholar-btn w-100">Update Profile</button>
                </form>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

