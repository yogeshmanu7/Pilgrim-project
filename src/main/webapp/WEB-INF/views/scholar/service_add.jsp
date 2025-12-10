<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Add New Service</title>
    
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
        body {
            background: #f4f7fc;
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
        
        .btn-submit {
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
        
        .btn-submit:hover {
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
    
    <h2 class="form-title">➕ Add New Service Package</h2>
    
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
    
    <form action="${pageContext.request.contextPath}/scholar/service/add" method="post">
        
        <div class="mb-3">
            <label class="form-label">Service Type *</label>
            <select class="form-control" name="serviceTypeStr" id="serviceTypeSelect" required>
                <option value="">-- Select Service Type --</option>
                <c:forEach var="serviceType" items="${serviceTypes}">
                    <option value="${serviceType.label}">${serviceType.label}</option>
                </c:forEach>
            </select>
            <small class="text-muted">Select the base service type from the predefined list</small>
        </div>
        
        <div class="mb-3">
            <label class="form-label">Package Template *</label>
            <select class="form-control" name="packageTemplate" id="packageTemplateSelect" required>
                <option value="">-- Select Package Template --</option>
                <option value="custom">Custom Package (Enter manually)</option>
            </select>
            <small class="text-muted">Select a predefined package template or choose custom</small>
        </div>
        
        <div class="mb-3" id="customPackageDiv" style="display: none;">
            <label class="form-label">Custom Package Name *</label>
            <input class="form-control" name="customName" placeholder="e.g., Ekachandi Hawan (2 Panditji + All Puja Samagries)" id="customNameInput">
            <small class="text-muted">Enter your custom package name with details</small>
        </div>
        
        <div class="mb-3">
            <label class="form-label">Description</label>
            <textarea class="form-control" name="description" rows="4" placeholder="Describe what this service includes, procedures, benefits, etc." id="descriptionInput"></textarea>
            <small class="text-muted">Provide details about the service, rituals included, duration, etc.</small>
        </div>
        
        <div class="mb-3">
            <label class="form-label">Package Price (₹) *</label>
            <input class="form-control" type="number" name="price" placeholder="11000" min="0" step="0.01" id="priceInput" required>
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
                    <option value="Mumbai">Mumbai</option>
                    <option value="Delhi">Delhi</option>
                    <option value="Bangalore">Bangalore</option>
                    <option value="Hyderabad">Hyderabad</option>
                    <option value="Chennai">Chennai</option>
                    <option value="Kolkata">Kolkata</option>
                    <option value="Pune">Pune</option>
                    <option value="Ahmedabad">Ahmedabad</option>
                    <option value="Jaipur">Jaipur</option>
                    <option value="Surat">Surat</option>
                </optgroup>
                <optgroup label="North India">
                    <option value="Lucknow">Lucknow</option>
                    <option value="Kanpur">Kanpur</option>
                    <option value="Nagpur">Nagpur</option>
                    <option value="Indore">Indore</option>
                    <option value="Thane">Thane</option>
                    <option value="Bhopal">Bhopal</option>
                    <option value="Visakhapatnam">Visakhapatnam</option>
                    <option value="Patna">Patna</option>
                    <option value="Vadodara">Vadodara</option>
                    <option value="Ghaziabad">Ghaziabad</option>
                    <option value="Ludhiana">Ludhiana</option>
                    <option value="Agra">Agra</option>
                    <option value="Nashik">Nashik</option>
                    <option value="Faridabad">Faridabad</option>
                    <option value="Meerut">Meerut</option>
                    <option value="Rajkot">Rajkot</option>
                    <option value="Varanasi">Varanasi</option>
                    <option value="Srinagar">Srinagar</option>
                    <option value="Amritsar">Amritsar</option>
                    <option value="Chandigarh">Chandigarh</option>
                </optgroup>
                <optgroup label="South India">
                    <option value="Coimbatore">Coimbatore</option>
                    <option value="Kochi">Kochi</option>
                    <option value="Mysore">Mysore</option>
                    <option value="Vijayawada">Vijayawada</option>
                    <option value="Madurai">Madurai</option>
                    <option value="Tiruchirappalli">Tiruchirappalli</option>
                    <option value="Salem">Salem</option>
                    <option value="Tirunelveli">Tirunelveli</option>
                    <option value="Thrissur">Thrissur</option>
                    <option value="Mangalore">Mangalore</option>
                    <option value="Hubli">Hubli</option>
                    <option value="Belgaum">Belgaum</option>
                    <option value="Gulbarga">Gulbarga</option>
                    <option value="Warangal">Warangal</option>
                    <option value="Guntur">Guntur</option>
                    <option value="Nellore">Nellore</option>
                    <option value="Kozhikode">Kozhikode</option>
                    <option value="Kollam">Kollam</option>
                    <option value="Thiruvananthapuram">Thiruvananthapuram</option>
                </optgroup>
                <optgroup label="East India">
                    <option value="Bhubaneswar">Bhubaneswar</option>
                    <option value="Cuttack">Cuttack</option>
                    <option value="Rourkela">Rourkela</option>
                    <option value="Durgapur">Durgapur</option>
                    <option value="Asansol">Asansol</option>
                    <option value="Siliguri">Siliguri</option>
                    <option value="Dhanbad">Dhanbad</option>
                    <option value="Jamshedpur">Jamshedpur</option>
                    <option value="Ranchi">Ranchi</option>
                    <option value="Guwahati">Guwahati</option>
                    <option value="Shillong">Shillong</option>
                    <option value="Imphal">Imphal</option>
                    <option value="Aizawl">Aizawl</option>
                </optgroup>
                <optgroup label="West India">
                    <option value="Nagpur">Nagpur</option>
                    <option value="Aurangabad">Aurangabad</option>
                    <option value="Solapur">Solapur</option>
                    <option value="Kolhapur">Kolhapur</option>
                    <option value="Sangli">Sangli</option>
                    <option value="Nanded">Nanded</option>
                    <option value="Jalgaon">Jalgaon</option>
                    <option value="Akola">Akola</option>
                    <option value="Latur">Latur</option>
                    <option value="Ahmednagar">Ahmednagar</option>
                    <option value="Panaji">Panaji</option>
                    <option value="Vasco da Gama">Vasco da Gama</option>
                </optgroup>
                <optgroup label="Central India">
                    <option value="Raipur">Raipur</option>
                    <option value="Bilaspur">Bilaspur</option>
                    <option value="Durg">Durg</option>
                    <option value="Jabalpur">Jabalpur</option>
                    <option value="Gwalior">Gwalior</option>
                    <option value="Ujjain">Ujjain</option>
                    <option value="Sagar">Sagar</option>
                    <option value="Ratlam">Ratlam</option>
                    <option value="Burhanpur">Burhanpur</option>
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
            
            // Initialize display
            updateLocationsDisplay();
        </script>
        
        <!-- Hidden fields for form submission -->
        <input type="hidden" name="name" id="hiddenNameInput">
        <input type="hidden" name="priceWithItems" id="hiddenPriceWithInput">
        <input type="hidden" name="priceWithoutItems" id="hiddenPriceWithoutInput">
        
        <button class="btn-submit" type="submit">💾 Save Service Package</button>
        
    </form>
    
    <a href="${pageContext.request.contextPath}/scholar/service/list" class="btn-back">← Back to My Services</a>
    <a href="${pageContext.request.contextPath}/scholar/dashboard" class="btn-back" style="margin-left: 10px;">🏠 Dashboard</a>
    
</div>

<script>
    // Package templates with name, description, and price
    const packageTemplates = {
        'Chandi Hawan': {
            packages: [
                {
                    name: 'Ekachandi Hawan (2 Panditji + All Puja Samagries)',
                    description: 'The Puja will be performed as per Vedic rituals by experienced scholars. It will be conducted at your location or a designated temple as per your preference.\n\nProcedure:\n• Swasti Vachanam\n• Mahasankalp\n• Ganpati Puja\n• Kalash Sthapan, Punyah Vachanam\n• 1 Chandi Path (Saptashati Parayan) & Hawan\n• Aarti & Prasad Distribution\n\nNote: We will bring the Puja Samagri such as Haldi, Abir, Gulal, Mango leaves, Tulsi, Darba, Kalash, Betel leaves, Betel nuts, Hawan sticks, Samidha, Hawan Kund, Dravya, Cloth, Ghee, etc.',
                    price: 11000
                },
                {
                    name: 'Ekachandi Hawan (3 Panditji + All Puja Samagries)',
                    description: 'The Puja will be performed by learned Pundit Ji as per Vedic rituals. Enhanced ceremony with 3 experienced pandits.\n\nProcedure:\n• Swasti Vachanam\n• Mahasankalp\n• Ganpati Puja\n• Kalash Sthapan, Punyah Vachanam\n• 1 Chandi Path (Saptashati Parayan) & Hawan\n• Aarti & Prasad Distribution',
                    price: 15000
                },
                {
                    name: 'Navchandi Hawan (3 Panditji + All Puja Samagries)',
                    description: 'Complete Navchandi Hawan ceremony with 3 experienced pandits and all puja samagries included.',
                    price: 20000
                }
            ]
        },
        'Ekachandi Hawan': {
            packages: [
                {
                    name: 'Ekachandi Hawan (2 Panditji + All Puja Samagries)',
                    description: 'Ekachandi Hawan performed by 2 experienced pandits with all puja samagries included.',
                    price: 11000
                },
                {
                    name: 'Ekachandi Hawan (3 Panditji + All Puja Samagries)',
                    description: 'Ekachandi Hawan performed by 3 experienced pandits with all puja samagries included.',
                    price: 15000
                }
            ]
        },
        'Navchandi Hawan': {
            packages: [
                {
                    name: 'Navchandi Hawan (3 Panditji + All Puja Samagries)',
                    description: 'Complete Navchandi Hawan ceremony with 3 experienced pandits.',
                    price: 20000
                }
            ]
        },
        'Satyanarayana Pooja': {
            packages: [
                {
                    name: 'Satyanarayana Pooja (2 Panditji + All Items)',
                    description: 'Satyanarayana Pooja performed as per Vedic rituals with all puja items included.',
                    price: 8000
                },
                {
                    name: 'Satyanarayana Pooja (1 Panditji + All Items)',
                    description: 'Satyanarayana Pooja performed by experienced pandit with all items.',
                    price: 5000
                }
            ]
        },
        'Ganapathi Homa': {
            packages: [
                {
                    name: 'Ganapathi Homa (1 Panditji + All Samagries)',
                    description: 'Ganapathi Homa ceremony with all required samagries included.',
                    price: 6000
                },
                {
                    name: 'Ganapathi Homa (2 Panditji + All Samagries)',
                    description: 'Ganapathi Homa ceremony with 2 pandits and all samagries.',
                    price: 9000
                }
            ]
        },
        'Grihapravesha': {
            packages: [
                {
                    name: 'Grihapravesha Pooja (2 Panditji + All Puja Items)',
                    description: 'Complete Grihapravesha ceremony with all puja items included.',
                    price: 12000
                }
            ]
        },
        'Rudrabhisheka': {
            packages: [
                {
                    name: 'Rudrabhisheka (3 Panditji + Complete Setup)',
                    description: 'Rudrabhisheka ceremony with 3 pandits and complete setup.',
                    price: 18000
                }
            ]
        },
        'Mahalaxmi Pooja': {
            packages: [
                {
                    name: 'Mahalaxmi Pooja (2 Panditji + All Samagries)',
                    description: 'Mahalaxmi Pooja for prosperity and wealth with all samagries.',
                    price: 10000
                }
            ]
        },
        'Shiv Pooja': {
            packages: [
                {
                    name: 'Shiv Pooja (1 Panditji + All Items)',
                    description: 'Shiv Pooja ceremony with all required items.',
                    price: 7000
                }
            ]
        },
        'Vishnu Pooja': {
            packages: [
                {
                    name: 'Vishnu Pooja (2 Panditji + Complete Setup)',
                    description: 'Vishnu Pooja ceremony with complete setup.',
                    price: 10000
                }
            ]
        },
        'Hanuman Pooja': {
            packages: [
                {
                    name: 'Hanuman Pooja (1 Panditji + All Samagries)',
                    description: 'Hanuman Pooja for strength and protection.',
                    price: 6000
                }
            ]
        },
        'Gayatri Hawan': {
            packages: [
                {
                    name: 'Gayatri Hawan (2 Panditji + All Puja Samagries)',
                    description: 'Gayatri Hawan ceremony with all puja samagries.',
                    price: 11000
                }
            ]
        },
        'Shanti Hawan': {
            packages: [
                {
                    name: 'Shanti Hawan (2 Panditji + All Items)',
                    description: 'Shanti Hawan for peace and harmony.',
                    price: 10000
                }
            ]
        },
        'Grah Shanti Pooja': {
            packages: [
                {
                    name: 'Grah Shanti Pooja (2 Panditji + All Samagries)',
                    description: 'Planetary peace ceremony to remove doshas.',
                    price: 12000
                }
            ]
        },
        'Bhoomi Pooja': {
            packages: [
                {
                    name: 'Bhoomi Pooja (2 Panditji + All Puja Items)',
                    description: 'Land blessing ceremony before construction.',
                    price: 10000
                }
            ]
        },
        'Vivah Pooja': {
            packages: [
                {
                    name: 'Vivah Pooja (3 Panditji + Complete Setup)',
                    description: 'Marriage ceremony with complete setup.',
                    price: 25000
                }
            ]
        },
        'Saraswati Pooja': {
            packages: [
                {
                    name: 'Saraswati Pooja (1 Panditji + All Samagries)',
                    description: 'Saraswati Pooja for knowledge and education.',
                    price: 6000
                }
            ]
        },
        'Business Pooja': {
            packages: [
                {
                    name: 'Business Pooja (2 Panditji + All Items)',
                    description: 'Business prosperity ceremony.',
                    price: 10000
                }
            ]
        },
        'Vehicle Pooja': {
            packages: [
                {
                    name: 'Vehicle Pooja (1 Panditji + All Samagries)',
                    description: 'Vehicle blessing ceremony for safety.',
                    price: 3000
                }
            ]
        }
    };
    
    // Populate package templates based on selected service type
    document.getElementById('serviceTypeSelect').addEventListener('change', function() {
        const selectedType = this.value;
        const packageSelect = document.getElementById('packageTemplateSelect');
        const customDiv = document.getElementById('customPackageDiv');
        const customInput = document.getElementById('customNameInput');
        const descriptionInput = document.getElementById('descriptionInput');
        const priceInput = document.getElementById('priceInput');
        
        // Clear previous options except first two
        while (packageSelect.options.length > 2) {
            packageSelect.remove(2);
        }
        
        // Hide custom div initially
        customDiv.style.display = 'none';
        customInput.required = false;
        
        // Clear fields
        customInput.value = '';
        descriptionInput.value = '';
        priceInput.value = '';
        
        if (selectedType && packageTemplates[selectedType]) {
            // Add package templates for this service type
            packageTemplates[selectedType].packages.forEach((pkg, index) => {
                const option = document.createElement('option');
                option.value = 'template_' + index;
                option.textContent = pkg.name + ' - ₹' + pkg.price.toLocaleString('en-IN');
                option.dataset.packageName = pkg.name;
                option.dataset.description = pkg.description;
                option.dataset.price = pkg.price;
                packageSelect.appendChild(option);
            });
        }
    });
    
    // Handle package template selection
    document.getElementById('packageTemplateSelect').addEventListener('change', function() {
        const selectedOption = this.options[this.selectedIndex];
        const customDiv = document.getElementById('customPackageDiv');
        const customInput = document.getElementById('customNameInput');
        const descriptionInput = document.getElementById('descriptionInput');
        const priceInput = document.getElementById('priceInput');
        
        if (this.value === 'custom') {
            // Show custom input
            customDiv.style.display = 'block';
            customInput.required = true;
            customInput.value = '';
            descriptionInput.value = '';
            priceInput.value = '';
        } else if (this.value && this.value.startsWith('template_')) {
            // Fill form with template data
            customDiv.style.display = 'none';
            customInput.required = false;
            customInput.value = selectedOption.dataset.packageName;
            descriptionInput.value = selectedOption.dataset.description;
            priceInput.value = selectedOption.dataset.price;
        } else {
            // Clear everything
            customDiv.style.display = 'none';
            customInput.required = false;
            customInput.value = '';
            descriptionInput.value = '';
            priceInput.value = '';
        }
    });
    
    // Handle form submission
    document.querySelector('form').addEventListener('submit', function(e) {
        const serviceSelect = document.getElementById('serviceTypeSelect');
        const packageSelect = document.getElementById('packageTemplateSelect');
        const customNameInput = document.getElementById('customNameInput');
        const priceInput = document.getElementById('priceInput');
        const hiddenNameInput = document.getElementById('hiddenNameInput');
        const hiddenPriceWithInput = document.getElementById('hiddenPriceWithInput');
        const hiddenPriceWithoutInput = document.getElementById('hiddenPriceWithoutInput');
        
        // Determine final service name
        let finalName = '';
        if (packageSelect.value === 'custom') {
            finalName = customNameInput.value.trim() || serviceSelect.value;
        } else if (packageSelect.value && packageSelect.value.startsWith('template_')) {
            finalName = customNameInput.value.trim();
        } else {
            finalName = serviceSelect.value;
        }
        
        // Set the name
        hiddenNameInput.value = finalName;
        
        // Set prices (using same price for both fields to maintain compatibility)
        const price = parseFloat(priceInput.value) || 0;
        hiddenPriceWithInput.value = price;
        hiddenPriceWithoutInput.value = price;
        
        // Disable original selects to prevent them from being submitted
        serviceSelect.disabled = true;
        packageSelect.disabled = true;
    });
</script>

</body>
</html>
