<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select Home Type - GlobalPiligrim Accommodation</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f5f5;
            padding: 40px 20px;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
        h1 {
            color: #333;
            margin-bottom: 40px;
            font-size: 1.8rem;
            font-weight: 600;
        }
        .section {
            margin-bottom: 40px;
        }
        .section-title {
            color: #333;
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 20px;
        }
        .options-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
        }
        .option-card {
            background: white;
            border: 2px solid #e0e0e0;
            border-radius: 12px;
            padding: 20px;
            cursor: pointer;
            transition: all 0.3s;
            position: relative;
        }
        .option-card:hover {
            border-color: #667eea;
            box-shadow: 0 2px 8px rgba(102, 126, 234, 0.2);
        }
        .option-card.selected {
            border-color: #667eea;
            border-width: 3px;
            background: #f8f9ff;
        }
        .option-card input[type="radio"] {
            position: absolute;
            top: 15px;
            right: 15px;
            width: 20px;
            height: 20px;
            cursor: pointer;
        }
        .option-card .icon {
            font-size: 2.5rem;
            color: #667eea;
            margin-bottom: 15px;
        }
        .option-card .name {
            font-size: 1.1rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 10px;
        }
        .option-card .description {
            font-size: 0.9rem;
            color: #666;
            line-height: 1.5;
        }
        .custom-link {
            margin-top: 30px;
            text-align: center;
        }
        .custom-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        .custom-input {
            margin-top: 20px;
            padding: 20px;
            background: white;
            border: 2px dashed #667eea;
            border-radius: 12px;
            display: none;
        }
        .custom-input.active {
            display: block;
        }
        .custom-input input {
            width: 100%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            margin-top: 10px;
            font-size: 1rem;
        }
        .btn-group {
            display: flex;
            justify-content: space-between;
            margin-top: 40px;
            padding: 0 20px;
        }
        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            cursor: pointer;
            font-weight: 500;
        }
        .btn-back {
            background: #f5f5f5;
            color: #333;
        }
        .btn-next {
            background: #667eea;
            color: white;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Which home-type property best fits your place?</h1>
        
        <form method="post" action="/pilgrim/accommodation/property/select-home-type" id="homeTypeForm">
            <div class="section">
                <div class="section-title">Most common home-type property</div>
                <div class="options-grid">
                    <div class="option-card" onclick="selectHomeType('APARTMENT_FLAT')">
                        <input type="radio" name="homeType" value="APARTMENT_FLAT" id="apartment">
                        <div class="icon"><i class="fas fa-building"></i></div>
                        <div class="name">Apartment/Flat</div>
                        <div class="description">Self-contained accommodation unit within a building of similar units.</div>
                    </div>
                    
                    <div class="option-card" onclick="selectHomeType('ENTIRE_HOUSE')">
                        <input type="radio" name="homeType" value="ENTIRE_HOUSE" id="house">
                        <div class="icon"><i class="fas fa-home"></i></div>
                        <div class="name">Entire House</div>
                        <div class="description">Independently hosted, freestanding house with a private entrance.</div>
                    </div>
                    
                    <div class="option-card" onclick="selectHomeType('VILLA')">
                        <input type="radio" name="homeType" value="VILLA" id="villa">
                        <div class="icon"><i class="fas fa-monument"></i></div>
                        <div class="name">Villa</div>
                        <div class="description">Freestanding luxury vacation house with local decor and atmosphere.</div>
                    </div>
                    
                    <div class="option-card" onclick="selectHomeType('BUNGALOW')">
                        <input type="radio" name="homeType" value="BUNGALOW" id="bungalow">
                        <div class="icon"><i class="fas fa-house"></i></div>
                        <div class="name">Bungalow</div>
                        <div class="description">Basic freestanding accommodation unit in a tropical environment.</div>
                    </div>
                    
                    <div class="option-card" onclick="selectHomeType('HOMESTAY')">
                        <input type="radio" name="homeType" value="HOMESTAY" id="homestay">
                        <div class="icon"><i class="fas fa-heart"></i></div>
                        <div class="name">Homestay</div>
                        <div class="description">Rented room within house shared with host, with shared facilities.</div>
                    </div>
                </div>
            </div>
            
            <div class="section">
                <div class="section-title">Others home-type property</div>
                <div class="options-grid">
                    <div class="option-card" onclick="selectHomeType('BED_BREAKFAST')">
                        <input type="radio" name="homeType" value="BED_BREAKFAST">
                        <div class="icon"><i class="fas fa-bed"></i></div>
                        <div class="name">Bed & Breakfast</div>
                        <div class="description">Small lodging that offers overnight stays and breakfast.</div>
                    </div>
                    
                    <div class="option-card" onclick="selectHomeType('CABIN')">
                        <input type="radio" name="homeType" value="CABIN">
                        <div class="icon"><i class="fas fa-tree"></i></div>
                        <div class="name">Cabin</div>
                        <div class="description">Freestanding rustic box frame or A-frame vacation house in nature.</div>
                    </div>
                    
                    <div class="option-card" onclick="selectHomeType('CHALET')">
                        <input type="radio" name="homeType" value="CHALET">
                        <div class="icon"><i class="fas fa-mountain"></i></div>
                        <div class="name">Chalet</div>
                        <div class="description">Freestanding vacation house in an alpine environment.</div>
                    </div>
                    
                    <div class="option-card" onclick="selectHomeType('COUNTRY_HOUSE')">
                        <input type="radio" name="homeType" value="COUNTRY_HOUSE">
                        <div class="icon"><i class="fas fa-tree"></i></div>
                        <div class="name">Country House</div>
                        <div class="description">Private home or estate in a rural environment and rustic atmosphere.</div>
                    </div>
                    
                    <div class="option-card" onclick="selectHomeType('FARM_STAY')">
                        <input type="radio" name="homeType" value="FARM_STAY">
                        <div class="icon"><i class="fas fa-tractor"></i></div>
                        <div class="name">Farm stay</div>
                        <div class="description">Room or unit within a working farm or ranch with shared facilities.</div>
                    </div>
                    
                    <div class="option-card" onclick="selectHomeType('GUEST_HOUSE')">
                        <input type="radio" name="homeType" value="GUEST_HOUSE">
                        <div class="icon"><i class="fas fa-home"></i></div>
                        <div class="name">Guest House</div>
                        <div class="description">A small, separate house that shares land with a larger residence.</div>
                    </div>
                    
                    <div class="option-card" onclick="selectHomeType('HAVELI')">
                        <input type="radio" name="homeType" value="HAVELI">
                        <div class="icon"><i class="fas fa-archway"></i></div>
                        <div class="name">Haveli</div>
                        <div class="description">Traditional South Asian freestanding house or townhouse.</div>
                    </div>
                    
                    <div class="option-card" onclick="selectHomeType('LOFT')">
                        <input type="radio" name="homeType" value="LOFT">
                        <div class="icon"><i class="fas fa-warehouse"></i></div>
                        <div class="name">Loft</div>
                        <div class="description">Vacation house with vaulted ceilings and open-plan interior.</div>
                    </div>
                    
                    <div class="option-card" onclick="selectHomeType('MACHIYA')">
                        <input type="radio" name="homeType" value="MACHIYA">
                        <div class="icon"><i class="fas fa-torii-gate"></i></div>
                        <div class="name">Machiya</div>
                        <div class="description">Traditional Japanese wooden townhouse.</div>
                    </div>
                    
                    <div class="option-card" onclick="selectHomeType('PENSION')">
                        <input type="radio" name="homeType" value="PENSION">
                        <div class="icon"><i class="fas fa-home"></i></div>
                        <div class="name">Pension</div>
                        <div class="description">South Korean-style rental cottage or guesthouse.</div>
                    </div>
                    
                    <div class="option-card" onclick="selectHomeType('RIAD')">
                        <input type="radio" name="homeType" value="RIAD">
                        <div class="icon"><i class="fas fa-mosque"></i></div>
                        <div class="name">Riad</div>
                        <div class="description">Traditional Moroccan home with rooms sharing a central courtyard.</div>
                    </div>
                    
                    <div class="option-card" onclick="selectHomeType('TOWNHOUSE')">
                        <input type="radio" name="homeType" value="TOWNHOUSE">
                        <div class="icon"><i class="fas fa-city"></i></div>
                        <div class="name">Townhouse</div>
                        <div class="description">An urban vacation house attached to other houses on both sides.</div>
                    </div>
                    
                    <div class="option-card" onclick="selectHomeType('TREEHOUSE')">
                        <input type="radio" name="homeType" value="TREEHOUSE">
                        <div class="icon"><i class="fas fa-tree"></i></div>
                        <div class="name">Treehouse</div>
                        <div class="description">Accommodation unit within or supported by trees.</div>
                    </div>
                    
                    <div class="option-card" onclick="selectHomeType('YURT')">
                        <input type="radio" name="homeType" value="YURT">
                        <div class="icon"><i class="fas fa-campground"></i></div>
                        <div class="name">Yurt</div>
                        <div class="description">A circular tent traditionally used by nomadic groups in East Asia.</div>
                    </div>
                </div>
            </div>
            
            <div class="custom-link">
                <a href="#" onclick="showCustomInput(); return false;">
                    <i class="fas fa-info-circle"></i> I don't see my property type on the list
                </a>
            </div>
            
            <div class="custom-input" id="customInput">
                <label style="font-weight: 600; color: #333;">Enter your custom property type:</label>
                <input type="text" name="customType" placeholder="Enter custom property type">
            </div>
            
            <div class="btn-group">
                <button type="button" class="btn btn-back" onclick="window.history.back()">Back</button>
                <button type="submit" class="btn btn-next">Next</button>
            </div>
        </form>
    </div>
    
    <script>
        function selectHomeType(type) {
            if (type === 'CUSTOM') {
                document.getElementById('customInput').classList.add('active');
                document.querySelector('input[name="customType"]').required = true;
                // Uncheck all other radios
                document.querySelectorAll('input[name="homeType"]').forEach(radio => {
                    if (radio.value !== 'CUSTOM') {
                        radio.checked = false;
                        radio.closest('.option-card')?.classList.remove('selected');
                    }
                });
            } else {
                document.getElementById('customInput').classList.remove('active');
                document.querySelector('input[name="customType"]').required = false;
                // Uncheck custom
                document.querySelectorAll('input[name="homeType"]').forEach(radio => {
                    if (radio.value === 'CUSTOM') {
                        radio.checked = false;
                    }
                });
            }
            
            // Check selected radio
            document.querySelector('input[value="' + type + '"]').checked = true;
            
            // Update visual selection
            document.querySelectorAll('.option-card').forEach(card => {
                card.classList.remove('selected');
            });
            
            const selectedCard = document.querySelector('input[value="' + type + '"]')?.closest('.option-card');
            if (selectedCard) {
                selectedCard.classList.add('selected');
            }
        }
        
        function showCustomInput() {
            selectHomeType('CUSTOM');
            // Add a hidden radio for custom
            if (!document.querySelector('input[value="CUSTOM"]')) {
                const form = document.getElementById('homeTypeForm');
                const hiddenRadio = document.createElement('input');
                hiddenRadio.type = 'radio';
                hiddenRadio.name = 'homeType';
                hiddenRadio.value = 'CUSTOM';
                hiddenRadio.id = 'customRadio';
                hiddenRadio.style.display = 'none';
                form.appendChild(hiddenRadio);
            }
            document.getElementById('customRadio').checked = true;
        }
        
        // Form validation
        document.getElementById('homeTypeForm').addEventListener('submit', function(e) {
            const selected = document.querySelector('input[name="homeType"]:checked');
            if (!selected) {
                e.preventDefault();
                alert('Please select a property type before continuing');
                return false;
            }
        });
    </script>
</body>
</html>

