package com.pilgrim.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

@Service
public class FileStorageService {
    
    @Value("${file.upload.directory:C:/pilgrim-uploads/}")
    private String uploadDirectory;
    
    public String storeFile(MultipartFile file, String subDirectory) throws IOException {
        String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
        
        Path uploadPath = Paths.get(uploadDirectory, subDirectory);
        
        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }
        
        Path filePath = uploadPath.resolve(fileName);
        Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
        
        return subDirectory + "/" + fileName;
    }
    
    public String storeProductImage(MultipartFile file) throws IOException {
        return storeFile(file, "products");
    }
    
    public String storeProfileImage(MultipartFile file) throws IOException {
        return storeFile(file, "profiles");
    }
    
    public String storeDocument(MultipartFile file) throws IOException {
        return storeFile(file, "documents");
    }
    
    public void deleteFile(String filePath) throws IOException {
        Path path = Paths.get(uploadDirectory, filePath);
        Files.deleteIfExists(path);
    }
    
    public Path getFilePath(String filePath) {
        return Paths.get(uploadDirectory, filePath);
    }
}

