package com.pilgrim.util;

import java.io.IOException;
import java.nio.file.*;
import org.springframework.web.multipart.MultipartFile;

public class FileUploadUtil {

    private static final String UPLOAD_DIR = "uploads/travel/";

    public static String saveFile(MultipartFile file) {

        try {
            if (file == null || file.isEmpty()) {
                return null;
            }

            String originalName = file.getOriginalFilename();
            if (originalName == null) {
                originalName = "file";
            }

            String fileName = System.currentTimeMillis() + "_" + originalName.replace(" ", "_");

            Path uploadPath = Paths.get(UPLOAD_DIR);
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }

            Path filePath = uploadPath.resolve(fileName);
            Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

            return "/" + UPLOAD_DIR + fileName;

        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }
}

