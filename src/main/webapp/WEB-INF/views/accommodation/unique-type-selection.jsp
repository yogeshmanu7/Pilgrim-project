<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select Unique Type - GlobalPiligrim Accommodation</title>
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
        <h1><i class="fas fa-star"></i> Which unique-type property best fits your place?</h1>
        
        <form method="post" action="/pilgrim/accommodation/property/select-unique-type">
            <div class="section">
                <div class="options-grid">
                    <label class="option-item">
                        <input type="radio" name="uniqueType" value="CAPSULE_HOTEL"> Capsule Hotel
                    </label>
                    <label class="option-item">
                        <input type="radio" name="uniqueType" value="CASTLE"> Castle
                    </label>
                    <label class="option-item">
                        <input type="radio" name="uniqueType" value="CAVE_HOUSE"> Cave House
                    </label>
                    <label class="option-item">
                        <input type="radio" name="uniqueType" value="CRUISE"> Cruise
                    </label>
                    <label class="option-item">
                        <input type="radio" name="uniqueType" value="DOME_HOUSE"> Dome House
                    </label>
                    <label class="option-item">
                        <input type="radio" name="uniqueType" value="FARMSTAY"> Farmstay
                    </label>
                    <label class="option-item">
                        <input type="radio" name="uniqueType" value="HAVELI"> Haveli
                    </label>
                    <label class="option-item">
                        <input type="radio" name="uniqueType" value="HOLIDAY_PARK_CARAVAN_PARK"> Holiday Park / Caravan Park
                    </label>
                    <label class="option-item">
                        <input type="radio" name="uniqueType" value="HOUSEBOAT"> Houseboat
                    </label>
                    <label class="option-item">
                        <input type="radio" name="uniqueType" value="IGLOO"> Igloo
                    </label>
                    <label class="option-item">
                        <input type="radio" name="uniqueType" value="MACHIYA"> Machiya
                    </label>
                    <label class="option-item">
                        <input type="radio" name="uniqueType" value="RYOKAN"> Ryokan
                    </label>
                    <label class="option-item">
                        <input type="radio" name="uniqueType" value="TENT"> Tent
                    </label>
                    <label class="option-item">
                        <input type="radio" name="uniqueType" value="TIPI"> Tipi
                    </label>
                    <label class="option-item">
                        <input type="radio" name="uniqueType" value="TREEHOUSE"> Treehouse
                    </label>
                    <label class="option-item">
                        <input type="radio" name="uniqueType" value="YURT"> Yurt
                    </label>
                </div>
            </div>
            
            <div class="custom-input">
                <label>
                    <input type="radio" name="uniqueType" value="CUSTOM" id="customRadio">
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

