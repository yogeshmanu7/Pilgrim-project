<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Step 5/8 - Add Photos - GlobalPiligrim Accommodation</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #EFDFBB; /* Dutch White */
            padding: 40px 20px;
        }
        .container {
            max-width: 1000px;
            margin: 0 auto;
        }
        .step-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .step-indicator {
            color: #722F37; /* Wine */
            font-weight: bold;
            margin-bottom: 10px;
        }
        .form-container {
            background: #EFDFBB; /* Dutch White */
            border: 2px solid #722F37; /* Wine */
            border-radius: 15px;
            padding: 40px;
            box-shadow: 0 4px 15px rgba(114, 47, 55, 0.1); /* Wine with opacity */
        }
        .upload-area {
            border: 3px dashed #722F37; /* Wine */
            border-radius: 15px;
            padding: 60px;
            text-align: center;
            margin-bottom: 30px;
            cursor: pointer;
            transition: all 0.3s;
            background: rgba(239, 223, 187, 0.5); /* Dutch White with opacity */
        }
        .upload-area:hover {
            background: rgba(114, 47, 55, 0.05); /* Wine with opacity */
        }
        .upload-area i {
            font-size: 4rem;
            color: #722F37; /* Wine */
            margin-bottom: 20px;
        }
        .upload-area h3 {
            color: #722F37; /* Wine */
            margin-bottom: 10px;
        }
        .upload-area p {
            color: #722F37; /* Wine */
            opacity: 0.8;
        }
        .photo-categories {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }
        .category-item {
            padding: 20px;
            border: 2px solid #722F37; /* Wine */
            border-radius: 8px;
            text-align: center;
            background: #EFDFBB; /* Dutch White */
            transition: all 0.3s ease;
        }
        .category-item:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(114, 47, 55, 0.1); /* Wine with opacity */
        }
        .category-item label {
            display: block;
            margin-bottom: 10px;
            font-weight: 500;
            color: #722F37; /* Wine */
        }
        .category-item label i {
            color: #722F37; /* Wine */
            margin-right: 8px;
        }
        .category-item input[type="file"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #722F37; /* Wine */
            border-radius: 4px;
            background: rgba(255, 255, 255, 0.9);
            cursor: pointer;
        }
        .preview-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
            gap: 15px;
            margin-top: 20px;
        }
        .preview-item {
            position: relative;
            border-radius: 8px;
            overflow: hidden;
            border: 2px solid #722F37; /* Wine */
        }
        .preview-item img {
            width: 100%;
            height: 150px;
            object-fit: cover;
        }
        .preview-item .remove {
            position: absolute;
            top: 5px;
            right: 5px;
            background: #722F37; /* Wine */
            color: #EFDFBB; /* Dutch White */
            border: none;
            border-radius: 50%;
            width: 25px;
            height: 25px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s ease;
        }
        .preview-item .remove:hover {
            background: #5a2530; /* Darker Wine */
            transform: scale(1.1);
        }
        .btn-group {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
        }
        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .btn-primary {
            background: #722F37; /* Wine */
            color: #EFDFBB; /* Dutch White */
            border: 2px solid #722F37; /* Wine */
        }
        .btn-primary:hover {
            background: #5a2530; /* Darker Wine */
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(114, 47, 55, 0.2); /* Wine with opacity */
        }
        .btn-secondary {
            background: #EFDFBB; /* Dutch White */
            color: #722F37; /* Wine */
            border: 2px solid #722F37; /* Wine */
        }
        .btn-secondary:hover {
            background: #722F37; /* Wine */
            color: #EFDFBB; /* Dutch White */
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(114, 47, 55, 0.2); /* Wine with opacity */
        }
        
        /* Progress Indicator */
        .progress-container {
            display: flex;
            justify-content: center;
            margin-bottom: 30px;
            position: relative;
        }
        .progress-steps {
            display: flex;
            align-items: center;
            gap: 8px;
            position: relative;
            z-index: 2;
        }
        .step {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            background: #EFDFBB; /* Dutch White */
            border: 2px solid #722F37; /* Wine */
            color: #722F37; /* Wine */
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 14px;
            transition: all 0.3s ease;
        }
        .step.active {
            background: #722F37; /* Wine */
            color: #EFDFBB; /* Dutch White */
            transform: scale(1.1);
        }
        .step.completed {
            background: #722F37; /* Wine */
            color: #EFDFBB; /* Dutch White */
        }
        .step-line {
            position: absolute;
            top: 50%;
            left: 15%;
            right: 15%;
            height: 2px;
            background: #722F37; /* Wine */
            opacity: 0.3;
            transform: translateY(-50%);
            z-index: 1;
        }
        
        /* Minimum photo requirement note */
        .min-requirement {
            color: #722F37; /* Wine */
            margin-top: 10px;
            font-style: italic;
            opacity: 0.8;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Progress Indicator -->
        <div class="progress-container">
            <div class="step-line"></div>
            <div class="progress-steps">
                <div class="step completed">1</div>
                <div class="step completed">2</div>
                <div class="step completed">3</div>
                <div class="step completed">4</div>
                <div class="step active">5</div>
                <div class="step">6</div>
                <div class="step">7</div>
                <div class="step">8</div>
            </div>
        </div>
        
        <div class="step-header">
            <div class="step-indicator">📸 STEP 5/8 — ADD PHOTOS</div>
            <h1><i class="fas fa-camera"></i> Add Photos</h1>
            <p class="min-requirement">Minimum required: 3 photos</p>
        </div>
        
        <form method="post" action="/pilgrim/accommodation/property/listing/step5" enctype="multipart/form-data" class="form-container">
            <div class="upload-area" onclick="document.getElementById('fileInput').click()">
                <i class="fas fa-cloud-upload-alt"></i>
                <h3>Drag & Drop or Click to Upload</h3>
                <p>Upload photos of your property</p>
                <input type="file" id="fileInput" name="photos" multiple accept="image/*" style="display: none;" onchange="handleFiles(this.files)">
            </div>
            
            <div class="photo-categories">
                <div class="category-item">
                    <label><i class="fas fa-bed"></i> Bedroom</label>
                    <input type="file" name="bedroomPhotos" accept="image/*" multiple>
                </div>
                
                <div class="category-item">
                    <label><i class="fas fa-bath"></i> Bathroom</label>
                    <input type="file" name="bathroomPhotos" accept="image/*" multiple>
                </div>
                
                <div class="category-item">
                    <label><i class="fas fa-door-open"></i> Lobby / Entrance</label>
                    <input type="file" name="lobbyPhotos" accept="image/*" multiple>
                </div>
                
                <div class="category-item">
                    <label><i class="fas fa-mountain"></i> Outdoor View</label>
                    <input type="file" name="outdoorPhotos" accept="image/*" multiple>
                </div>
                
                <div class="category-item">
                    <label><i class="fas fa-swimming-pool"></i> Facilities</label>
                    <input type="file" name="facilityPhotos" accept="image/*" multiple>
                </div>
                
                <div class="category-item">
                    <label><i class="fas fa-building"></i> Property Overview</label>
                    <input type="file" name="overviewPhotos" accept="image/*" multiple>
                </div>
            </div>
            
            <div class="preview-grid" id="previewGrid"></div>
            
            <div class="btn-group">
                <a href="/pilgrim/accommodation/property/listing/step4" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Back
                </a>
                <button type="submit" class="btn btn-primary">
                    Next Step <i class="fas fa-arrow-right"></i>
                </button>
            </div>
        </form>
    </div>
    
    <script>
        function handleFiles(files) {
            const previewGrid = document.getElementById('previewGrid');
            previewGrid.innerHTML = '';
            
            Array.from(files).forEach((file, index) => {
                const reader = new FileReader();
                reader.onload = function(e) {
                    const previewItem = document.createElement('div');
                    previewItem.className = 'preview-item';
                    previewItem.innerHTML = `
                        <img src="${e.target.result}" alt="Preview">
                        <button type="button" class="remove" onclick="removePreview(this)">×</button>
                    `;
                    previewGrid.appendChild(previewItem);
                };
                reader.readAsDataURL(file);
            });
        }
        
        function removePreview(button) {
            button.parentElement.remove();
        }
    </script>
</body>
</html>