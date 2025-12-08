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
            background: #f5f5f5;
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
            color: #667eea;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .form-container {
            background: white;
            border-radius: 15px;
            padding: 40px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .upload-area {
            border: 3px dashed #667eea;
            border-radius: 15px;
            padding: 60px;
            text-align: center;
            margin-bottom: 30px;
            cursor: pointer;
            transition: all 0.3s;
        }
        .upload-area:hover {
            background: #f0f4ff;
        }
        .upload-area i {
            font-size: 4rem;
            color: #667eea;
            margin-bottom: 20px;
        }
        .photo-categories {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }
        .category-item {
            padding: 20px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            text-align: center;
        }
        .category-item label {
            display: block;
            margin-bottom: 10px;
            font-weight: 500;
        }
        .category-item input[type="file"] {
            width: 100%;
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
            background: red;
            color: white;
            border: none;
            border-radius: 50%;
            width: 25px;
            height: 25px;
            cursor: pointer;
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
        }
        .btn-primary {
            background: #667eea;
            color: white;
        }
        .btn-secondary {
            background: #e0e0e0;
            color: #333;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="step-header">
            <div class="step-indicator">📸 STEP 5/8 — ADD PHOTOS</div>
            <h1><i class="fas fa-camera"></i> Add Photos</h1>
            <p style="color: #666; margin-top: 10px;">Minimum required: 3 photos</p>
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
                <a href="/pilgrim/accommodation/property/listing/step4" class="btn btn-secondary">Back</a>
                <button type="submit" class="btn btn-primary">Next Step <i class="fas fa-arrow-right"></i></button>
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

