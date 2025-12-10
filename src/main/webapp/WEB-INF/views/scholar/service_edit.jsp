<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Service</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: #eef2f7;
            font-family: 'Segoe UI', sans-serif;
            padding: 20px;
        }

        .form-container {
            max-width: 700px;
            margin: 0 auto;
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }

        .form-title {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 25px;
            color: #333;
            text-align: center;
        }

        .form-label {
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
        }

        .form-control {
            border-radius: 6px;
            border: 1px solid #ddd;
            padding: 10px 15px;
        }

        .form-control:focus {
            border-color: #ff7f27;
            box-shadow: 0 0 0 0.2rem rgba(255, 127, 39, 0.25);
        }

        .btn-update {
            background: #ff7f27;
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 600;
            width: 100%;
            margin-top: 10px;
        }

        .btn-update:hover {
            background: #e86e20;
            color: white;
        }

        .btn-back {
            background: #6c757d;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            text-decoration: none;
            display: inline-block;
            margin-top: 15px;
        }

        .btn-back:hover {
            background: #5a6268;
            color: white;
        }

        .alert {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
    </style>
</head>

<body>

<div class="form-container">
    
    <h2 class="form-title">✏️ Edit Service Package</h2>
    
    <!-- Success/Error Messages -->
    <c:if test="${not empty success}">
        <div class="alert alert-success">
            ${success}
        </div>
    </c:if>
    
    <c:if test="${not empty error}">
        <div class="alert alert-danger">
            ${error}
        </div>
    </c:if>
    
    <form action="${pageContext.request.contextPath}/scholar/service/edit" method="post">
        
        <input type="hidden" name="id" value="${service.id}">
        
        <div class="mb-3">
            <label class="form-label">Service Type</label>
            <select class="form-control" name="serviceTypeStr" id="serviceTypeSelect">
                <option value="">-- Select Service Type --</option>
                <c:forEach var="serviceType" items="${serviceTypes}">
                    <option value="${serviceType.label}" ${service.serviceType != null && service.serviceType.label == serviceType.label ? 'selected' : ''}>
                        ${serviceType.label}
                    </option>
                </c:forEach>
            </select>
            <small class="text-muted">Select the base service type from the predefined list</small>
        </div>
        
        <div class="mb-3">
            <label class="form-label">Service Name *</label>
            <input class="form-control" name="name" value="${service.name}" required>
            <small class="text-muted">Name of the service package</small>
        </div>

        <div class="mb-3">
            <label class="form-label">Description</label>
            <textarea class="form-control" name="description" rows="4" placeholder="Describe what this service includes, procedures, benefits, etc.">${service.description}</textarea>
            <small class="text-muted">Provide details about the service, rituals included, duration, etc.</small>
        </div>

        <div class="mb-3">
            <label class="form-label">Package Price (₹) *</label>
            <input class="form-control" type="number" name="price" 
                   value="${service.priceWithItems != null ? service.priceWithItems : service.priceWithoutItems}" 
                   min="0" step="0.01" required>
            <small class="text-muted">Total price for this package</small>
        </div>
        
        <div class="mb-3">
            <label class="form-label">Service Locations *</label>
            
            <!-- Selected Locations Display (Text Field with Tags) -->
            <div class="form-control" id="selectedLocationsDisplay" style="min-height: 50px; padding: 8px; display: flex; flex-wrap: wrap; gap: 5px; align-items: center; background: #f8f9fa; border: 1px solid #ddd; border-radius: 6px;">
                <span class="text-muted" id="noLocationsText" style="color: #999;">No locations selected. Select from dropdown below.</span>
            </div>
            
            <!-- Hidden input to store selected locations for form submission -->
            <input type="hidden" name="locations" id="locationsHiddenInput">
            
            <!-- Location Dropdown -->
            <select class="form-control mt-2" id="locationsSelect" style="height: auto;">
                <option value="">-- Select a location to add --</option>
                <optgroup label="Major Cities">
                    <c:set var="city" value="Mumbai"/>
                    <option value="Mumbai" <c:if test="${not empty service.locations && service.locations.contains(city)}">selected</c:if>>Mumbai</option>
                    <c:set var="city" value="Delhi"/>
                    <option value="Delhi" <c:if test="${not empty service.locations && service.locations.contains(city)}">selected</c:if>>Delhi</option>
                    <c:set var="city" value="Bangalore"/>
                    <option value="Bangalore" <c:if test="${not empty service.locations && service.locations.contains(city)}">selected</c:if>>Bangalore</option>
                    <c:set var="city" value="Hyderabad"/>
                    <option value="Hyderabad" <c:if test="${not empty service.locations && service.locations.contains(city)}">selected</c:if>>Hyderabad</option>
                    <c:set var="city" value="Chennai"/>
                    <option value="Chennai" <c:if test="${not empty service.locations && service.locations.contains(city)}">selected</c:if>>Chennai</option>
                    <c:set var="city" value="Kolkata"/>
                    <option value="Kolkata" <c:if test="${not empty service.locations && service.locations.contains(city)}">selected</c:if>>Kolkata</option>
                    <c:set var="city" value="Pune"/>
                    <option value="Pune" <c:if test="${not empty service.locations && service.locations.contains(city)}">selected</c:if>>Pune</option>
                    <c:set var="city" value="Ahmedabad"/>
                    <option value="Ahmedabad" <c:if test="${not empty service.locations && service.locations.contains(city)}">selected</c:if>>Ahmedabad</option>
                    <c:set var="city" value="Jaipur"/>
                    <option value="Jaipur" <c:if test="${not empty service.locations && service.locations.contains(city)}">selected</c:if>>Jaipur</option>
                    <c:set var="city" value="Surat"/>
                    <option value="Surat" <c:if test="${not empty service.locations && service.locations.contains(city)}">selected</c:if>>Surat</option>
                </optgroup>
                <optgroup label="North India">
                    <option value="Lucknow" ${fn:contains(service.locations, 'Lucknow') ? 'selected' : ''}>Lucknow</option>
                    <option value="Kanpur" ${fn:contains(service.locations, 'Kanpur') ? 'selected' : ''}>Kanpur</option>
                    <option value="Nagpur" ${fn:contains(service.locations, 'Nagpur') ? 'selected' : ''}>Nagpur</option>
                    <option value="Indore" ${fn:contains(service.locations, 'Indore') ? 'selected' : ''}>Indore</option>
                    <option value="Thane" ${fn:contains(service.locations, 'Thane') ? 'selected' : ''}>Thane</option>
                    <option value="Bhopal" ${fn:contains(service.locations, 'Bhopal') ? 'selected' : ''}>Bhopal</option>
                    <option value="Visakhapatnam" ${fn:contains(service.locations, 'Visakhapatnam') ? 'selected' : ''}>Visakhapatnam</option>
                    <option value="Patna" ${fn:contains(service.locations, 'Patna') ? 'selected' : ''}>Patna</option>
                    <option value="Vadodara" ${fn:contains(service.locations, 'Vadodara') ? 'selected' : ''}>Vadodara</option>
                    <option value="Ghaziabad" ${fn:contains(service.locations, 'Ghaziabad') ? 'selected' : ''}>Ghaziabad</option>
                    <option value="Ludhiana" ${fn:contains(service.locations, 'Ludhiana') ? 'selected' : ''}>Ludhiana</option>
                    <option value="Agra" ${fn:contains(service.locations, 'Agra') ? 'selected' : ''}>Agra</option>
                    <option value="Nashik" ${fn:contains(service.locations, 'Nashik') ? 'selected' : ''}>Nashik</option>
                    <option value="Faridabad" ${fn:contains(service.locations, 'Faridabad') ? 'selected' : ''}>Faridabad</option>
                    <option value="Meerut" ${fn:contains(service.locations, 'Meerut') ? 'selected' : ''}>Meerut</option>
                    <option value="Rajkot" ${fn:contains(service.locations, 'Rajkot') ? 'selected' : ''}>Rajkot</option>
                    <option value="Varanasi" ${fn:contains(service.locations, 'Varanasi') ? 'selected' : ''}>Varanasi</option>
                    <option value="Srinagar" ${fn:contains(service.locations, 'Srinagar') ? 'selected' : ''}>Srinagar</option>
                    <option value="Amritsar" ${fn:contains(service.locations, 'Amritsar') ? 'selected' : ''}>Amritsar</option>
                    <option value="Chandigarh" ${fn:contains(service.locations, 'Chandigarh') ? 'selected' : ''}>Chandigarh</option>
                </optgroup>
                <optgroup label="South India">
                    <option value="Coimbatore" ${fn:contains(service.locations, 'Coimbatore') ? 'selected' : ''}>Coimbatore</option>
                    <option value="Kochi" ${fn:contains(service.locations, 'Kochi') ? 'selected' : ''}>Kochi</option>
                    <option value="Mysore" ${fn:contains(service.locations, 'Mysore') ? 'selected' : ''}>Mysore</option>
                    <option value="Vijayawada" ${fn:contains(service.locations, 'Vijayawada') ? 'selected' : ''}>Vijayawada</option>
                    <option value="Madurai" ${fn:contains(service.locations, 'Madurai') ? 'selected' : ''}>Madurai</option>
                    <option value="Tiruchirappalli" ${fn:contains(service.locations, 'Tiruchirappalli') ? 'selected' : ''}>Tiruchirappalli</option>
                    <option value="Salem" ${fn:contains(service.locations, 'Salem') ? 'selected' : ''}>Salem</option>
                    <option value="Tirunelveli" ${fn:contains(service.locations, 'Tirunelveli') ? 'selected' : ''}>Tirunelveli</option>
                    <option value="Thrissur" ${fn:contains(service.locations, 'Thrissur') ? 'selected' : ''}>Thrissur</option>
                    <option value="Mangalore" ${fn:contains(service.locations, 'Mangalore') ? 'selected' : ''}>Mangalore</option>
                    <option value="Hubli" ${fn:contains(service.locations, 'Hubli') ? 'selected' : ''}>Hubli</option>
                    <option value="Belgaum" ${fn:contains(service.locations, 'Belgaum') ? 'selected' : ''}>Belgaum</option>
                    <option value="Gulbarga" ${fn:contains(service.locations, 'Gulbarga') ? 'selected' : ''}>Gulbarga</option>
                    <option value="Warangal" ${fn:contains(service.locations, 'Warangal') ? 'selected' : ''}>Warangal</option>
                    <option value="Guntur" ${fn:contains(service.locations, 'Guntur') ? 'selected' : ''}>Guntur</option>
                    <option value="Nellore" ${fn:contains(service.locations, 'Nellore') ? 'selected' : ''}>Nellore</option>
                    <option value="Kozhikode" ${fn:contains(service.locations, 'Kozhikode') ? 'selected' : ''}>Kozhikode</option>
                    <option value="Kollam" ${fn:contains(service.locations, 'Kollam') ? 'selected' : ''}>Kollam</option>
                    <option value="Thiruvananthapuram" ${fn:contains(service.locations, 'Thiruvananthapuram') ? 'selected' : ''}>Thiruvananthapuram</option>
                </optgroup>
                <optgroup label="East India">
                    <option value="Bhubaneswar" ${fn:contains(service.locations, 'Bhubaneswar') ? 'selected' : ''}>Bhubaneswar</option>
                    <option value="Cuttack" ${fn:contains(service.locations, 'Cuttack') ? 'selected' : ''}>Cuttack</option>
                    <option value="Rourkela" ${fn:contains(service.locations, 'Rourkela') ? 'selected' : ''}>Rourkela</option>
                    <option value="Durgapur" ${fn:contains(service.locations, 'Durgapur') ? 'selected' : ''}>Durgapur</option>
                    <option value="Asansol" ${fn:contains(service.locations, 'Asansol') ? 'selected' : ''}>Asansol</option>
                    <option value="Siliguri" ${fn:contains(service.locations, 'Siliguri') ? 'selected' : ''}>Siliguri</option>
                    <option value="Dhanbad" ${fn:contains(service.locations, 'Dhanbad') ? 'selected' : ''}>Dhanbad</option>
                    <option value="Jamshedpur" ${fn:contains(service.locations, 'Jamshedpur') ? 'selected' : ''}>Jamshedpur</option>
                    <option value="Ranchi" ${fn:contains(service.locations, 'Ranchi') ? 'selected' : ''}>Ranchi</option>
                    <option value="Guwahati" ${fn:contains(service.locations, 'Guwahati') ? 'selected' : ''}>Guwahati</option>
                    <option value="Shillong" ${fn:contains(service.locations, 'Shillong') ? 'selected' : ''}>Shillong</option>
                    <option value="Imphal" ${fn:contains(service.locations, 'Imphal') ? 'selected' : ''}>Imphal</option>
                    <option value="Aizawl" ${fn:contains(service.locations, 'Aizawl') ? 'selected' : ''}>Aizawl</option>
                </optgroup>
                <optgroup label="West India">
                    <option value="Aurangabad" ${fn:contains(service.locations, 'Aurangabad') ? 'selected' : ''}>Aurangabad</option>
                    <option value="Solapur" ${fn:contains(service.locations, 'Solapur') ? 'selected' : ''}>Solapur</option>
                    <option value="Kolhapur" ${fn:contains(service.locations, 'Kolhapur') ? 'selected' : ''}>Kolhapur</option>
                    <option value="Sangli" ${fn:contains(service.locations, 'Sangli') ? 'selected' : ''}>Sangli</option>
                    <option value="Nanded" ${fn:contains(service.locations, 'Nanded') ? 'selected' : ''}>Nanded</option>
                    <option value="Jalgaon" ${fn:contains(service.locations, 'Jalgaon') ? 'selected' : ''}>Jalgaon</option>
                    <option value="Akola" ${fn:contains(service.locations, 'Akola') ? 'selected' : ''}>Akola</option>
                    <option value="Latur" ${fn:contains(service.locations, 'Latur') ? 'selected' : ''}>Latur</option>
                    <option value="Ahmednagar" ${fn:contains(service.locations, 'Ahmednagar') ? 'selected' : ''}>Ahmednagar</option>
                    <option value="Panaji" ${fn:contains(service.locations, 'Panaji') ? 'selected' : ''}>Panaji</option>
                    <option value="Vasco da Gama" ${fn:contains(service.locations, 'Vasco da Gama') ? 'selected' : ''}>Vasco da Gama</option>
                </optgroup>
                <optgroup label="Central India">
                    <option value="Raipur" ${fn:contains(service.locations, 'Raipur') ? 'selected' : ''}>Raipur</option>
                    <option value="Bilaspur" ${fn:contains(service.locations, 'Bilaspur') ? 'selected' : ''}>Bilaspur</option>
                    <option value="Durg" ${fn:contains(service.locations, 'Durg') ? 'selected' : ''}>Durg</option>
                    <option value="Jabalpur" ${fn:contains(service.locations, 'Jabalpur') ? 'selected' : ''}>Jabalpur</option>
                    <option value="Gwalior" ${fn:contains(service.locations, 'Gwalior') ? 'selected' : ''}>Gwalior</option>
                    <option value="Ujjain" ${fn:contains(service.locations, 'Ujjain') ? 'selected' : ''}>Ujjain</option>
                    <option value="Sagar" ${fn:contains(service.locations, 'Sagar') ? 'selected' : ''}>Sagar</option>
                    <option value="Ratlam" ${fn:contains(service.locations, 'Ratlam') ? 'selected' : ''}>Ratlam</option>
                    <option value="Burhanpur" ${fn:contains(service.locations, 'Burhanpur') ? 'selected' : ''}>Burhanpur</option>
                </optgroup>
            </select>
            <small class="text-muted">Select locations from the dropdown above. Selected locations will appear as tags above.</small>
        </div>
        
        <style>
            .location-tag {
                display: inline-flex;
                align-items: center;
                background: #667eea;
                color: white;
                padding: 5px 12px;
                border-radius: 20px;
                font-size: 14px;
                margin: 2px;
            }
            .location-tag .remove-btn {
                margin-left: 8px;
                cursor: pointer;
                font-weight: bold;
                font-size: 16px;
                line-height: 1;
            }
            .location-tag .remove-btn:hover {
                color: #ffcccc;
            }
        </style>
        
        <script>
            let selectedLocations = [];
            
            // Initialize with existing locations
            <c:if test="${not empty service.locations}">
                <c:forEach var="loc" items="${service.locations}">
                    selectedLocations.push('${loc}');
                </c:forEach>
            </c:if>
            
            document.getElementById('locationsSelect').addEventListener('change', function() {
                const selectedValue = this.value;
                if (selectedValue && !selectedLocations.includes(selectedValue)) {
                    selectedLocations.push(selectedValue);
                    updateLocationsDisplay();
                    updateHiddenInput();
                }
                // Reset dropdown
                this.value = '';
            });
            
            function removeLocation(location) {
                selectedLocations = selectedLocations.filter(loc => loc !== location);
                updateLocationsDisplay();
                updateHiddenInput();
            }
            
            function updateLocationsDisplay() {
                const displayDiv = document.getElementById('selectedLocationsDisplay');
                const noLocationsText = document.getElementById('noLocationsText');
                
                displayDiv.innerHTML = '';
                
                if (selectedLocations.length === 0) {
                    const noText = document.createElement('span');
                    noText.className = 'text-muted';
                    noText.id = 'noLocationsText';
                    noText.style.color = '#999';
                    noText.textContent = 'No locations selected. Select from dropdown below.';
                    displayDiv.appendChild(noText);
                } else {
                    selectedLocations.forEach(location => {
                        const tag = document.createElement('span');
                        tag.className = 'location-tag';
                        tag.innerHTML = location + '<span class="remove-btn" onclick="removeLocation(\'' + location.replace(/'/g, "\\'") + '\')">×</span>';
                        displayDiv.appendChild(tag);
                    });
                }
            }
            
            function updateHiddenInput() {
                // Remove all existing location inputs except the main hidden input
                const existingInputs = document.querySelectorAll('input[name="locations"]');
                existingInputs.forEach(input => {
                    if (input.id !== 'locationsHiddenInput') {
                        input.remove();
                    }
                });
                
                // Create hidden inputs for each selected location
                selectedLocations.forEach(location => {
                    const input = document.createElement('input');
                    input.type = 'hidden';
                    input.name = 'locations';
                    input.value = location;
                    document.getElementById('locationsHiddenInput').parentNode.appendChild(input);
                });
            }
            
            // Initialize display on page load
            updateLocationsDisplay();
            updateHiddenInput();
        </script>
        
        <div class="mb-3">
            <div class="form-check form-switch">
                <input class="form-check-input" type="checkbox" id="isActive" name="isActive" 
                       ${service.isActive ? 'checked' : ''} value="true">
                <label class="form-check-label" for="isActive">
                    Active Service
                </label>
            </div>
            <small class="text-muted">Inactive services will not be visible to customers</small>
        </div>

        <button class="btn-update" type="submit">💾 Update Service Package</button>

    </form>

    <a href="${pageContext.request.contextPath}/scholar/service/list" class="btn-back">← Back to My Services</a>
    <a href="${pageContext.request.contextPath}/scholar/dashboard" class="btn-back" style="margin-left: 10px;">🏠 Dashboard</a>

</div>

</body>
</html>
