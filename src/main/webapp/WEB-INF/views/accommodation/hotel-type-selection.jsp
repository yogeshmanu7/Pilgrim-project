<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select Hotel Type - GlobalPiligrim Accommodation</title>
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
            max-width: 1000px;
            margin: 0 auto;
        }
        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 40px;
            font-size: 2rem;
        }
        .section {
            background: white;
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .section h2 {
            color: #667eea;
            margin-bottom: 20px;
            font-size: 1.5rem;
        }
        .options-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 15px;
        }
        .option-item {
            padding: 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
            text-align: center;
        }
        .option-item:hover {
            border-color: #667eea;
            background: #f0f4ff;
        }
        .option-item input[type="radio"] {
            margin-right: 8px;
        }
        .custom-input {
            margin-top: 20px;
            padding: 15px;
            border: 2px dashed #667eea;
            border-radius: 8px;
            text-align: center;
        }
        .custom-input input {
            width: 100%;
            padding: 10px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            margin-top: 10px;
        }
        .btn-continue {
            text-align: center;
            margin-top: 30px;
        }
        .btn-continue button {
            padding: 15px 40px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1.1rem;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1><i class="fas fa-hotel"></i> Which hotel-type property best fits your place?</h1>
        
        <form method="post" action="/pilgrim/accommodation/property/select-hotel-type">
            <div class="section">
                <h2>Most Common</h2>
                <div class="options-grid">
                    <label class="option-item">
                        <input type="radio" name="hotelType" value="HOTEL"> Hotel
                    </label>
                    <label class="option-item">
                        <input type="radio" name="hotelType" value="GUEST_HOUSE"> Guest House
                    </label>
                    <label class="option-item">
                        <input type="radio" name="hotelType" value="SERVICED_APARTMENT"> Serviced Apartment
                    </label>
                    <label class="option-item">
                        <input type="radio" name="hotelType" value="RESORT"> Resort
                    </label>
                    <label class="option-item">
                        <input type="radio" name="hotelType" value="HOSTEL"> Hostel
                    </label>
                </div>
            </div>
            
            <div class="section">
                <h2>Others</h2>
                <div class="options-grid">
                    <label class="option-item">
                        <input type="radio" name="hotelType" value="BED_BREAKFAST"> Bed & Breakfast
                    </label>
                    <label class="option-item">
                        <input type="radio" name="hotelType" value="CAPSULE_HOTEL"> Capsule Hotel
                    </label>
                    <label class="option-item">
                        <input type="radio" name="hotelType" value="CRUISE"> Cruise
                    </label>
                    <label class="option-item">
                        <input type="radio" name="hotelType" value="INN"> Inn
                    </label>
                    <label class="option-item">
                        <input type="radio" name="hotelType" value="LODGE"> Lodge
                    </label>
                    <label class="option-item">
                        <input type="radio" name="hotelType" value="LOVE_HOTEL"> Love Hotel
                    </label>
                    <label class="option-item">
                        <input type="radio" name="hotelType" value="MOTEL"> Motel
                    </label>
                    <label class="option-item">
                        <input type="radio" name="hotelType" value="RYOKAN"> Ryokan
                    </label>
                    <label class="option-item">
                        <input type="radio" name="hotelType" value="RIAD"> Riad
                    </label>
                </div>
            </div>
            
            <div class="custom-input">
                <label>
                    <input type="radio" name="hotelType" value="CUSTOM" id="customRadio">
                    <strong><i class="fas fa-plus-circle"></i> I don't see my property type</strong>
                </label>
                <input type="text" name="customType" id="customInput" placeholder="Enter custom property type" style="display: none;">
            </div>
            
            <div class="btn-continue">
                <button type="submit">Continue <i class="fas fa-arrow-right"></i></button>
            </div>
        </form>
    </div>
    
    <script>
        document.getElementById('customRadio').addEventListener('change', function() {
            document.getElementById('customInput').style.display = this.checked ? 'block' : 'none';
            if (this.checked) {
                document.getElementById('customInput').required = true;
            }
        });
    </script>
</body>
</html>

