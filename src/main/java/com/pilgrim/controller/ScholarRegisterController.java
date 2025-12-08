package com.pilgrim.controller;

import com.pilgrim.entity.Scholar;
import com.pilgrim.entity.User;
import com.pilgrim.enums.ScholarRegistrationStatus;
import com.pilgrim.enums.ScholarSpecialization;
import com.pilgrim.enums.ScholarType;
import com.pilgrim.service.ScholarService;
import com.pilgrim.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/scholar/register")
public class ScholarRegisterController {
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private ScholarService scholarService;
    
    @Autowired
    private com.pilgrim.repository.UserRepository userRepository;
    
    @Value("${file.upload.directory:C:/pilgrim-uploads/}")
    private String uploadDirectory;
    
    @RequestMapping(value = "/step1", method = RequestMethod.GET)
    public String showRegistrationStep1(Model model) {
        return "scholar/ScholarRegisterStep1";
    }
    
    @RequestMapping(value = "/step1", method = RequestMethod.POST)
    public String processRegistrationStep1(
            @RequestParam String name,
            @RequestParam String email,
            @RequestParam String phone,
            @RequestParam String password,
            @RequestParam String confirmPassword,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        
        try {
            // Validation
            if (!password.equals(confirmPassword)) {
                redirectAttributes.addFlashAttribute("error", "Passwords do not match");
                return "redirect:/scholar/register/step1";
            }
            
            if (userService.existsByEmail(email)) {
                redirectAttributes.addFlashAttribute("error", "Email already exists");
                return "redirect:/scholar/register/step1";
            }
            
            // Create user first (using GlobalPilgrim's user creation)
            User user = new User();
            user.setName(name);
            user.setEmail(email);
            user.setPhone(phone);
            user.setPassword(userService.hashPassword(password));
            user.setVerified(false);
            user.setActive(true);
            user.setCreatedAt(java.time.LocalDateTime.now());
            user.setUpdatedAt(java.time.LocalDateTime.now());
            user = userRepository.save(user);
            
            // Create basic scholar record
            Scholar scholar = scholarService.createScholar(user, ScholarType.SPIRITUAL_SCHOLAR); // Default, will be updated in step 2
            
            // Store in session
            session.setAttribute("scholarRegUserId", user.getId());
            session.setAttribute("scholarRegScholarId", scholar.getId());
            
            return "redirect:/scholar/register/step2";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/scholar/register/step1";
        }
    }
    
    @RequestMapping(value = "/step2", method = RequestMethod.GET)
    public String showRegistrationStep2(HttpSession session, Model model) {
        Long scholarId = (Long) session.getAttribute("scholarRegScholarId");
        if (scholarId == null) {
            return "redirect:/scholar/register/step1";
        }
        
        model.addAttribute("specializations", ScholarSpecialization.values());
        model.addAttribute("scholarTypes", ScholarType.values());
        return "scholar/ScholarRegisterStep2";
    }
    
    @RequestMapping(value = "/step2", method = RequestMethod.POST)
    public String processRegistrationStep2(
            @RequestParam String type,
            @RequestParam Integer experienceYears,
            @RequestParam(required = false) String[] specializations,
            @RequestParam(required = false) String languages,
            @RequestParam String serviceAreas,
            @RequestParam Double basePrice,
            @RequestParam MultipartFile idProof,
            @RequestParam MultipartFile certificates,
            @RequestParam MultipartFile profilePhoto,
            HttpSession session,
            RedirectAttributes redirectAttributes) throws IOException {
        
        Long scholarId = (Long) session.getAttribute("scholarRegScholarId");
        if (scholarId == null) {
            return "redirect:/scholar/register/step1";
        }
        
        try {
            // Convert string type to ScholarType enum
            ScholarType scholarType;
            try {
                scholarType = ScholarType.valueOf(type.toUpperCase().trim());
            } catch (IllegalArgumentException e) {
                redirectAttributes.addFlashAttribute("error", "Invalid scholar type selected");
                return "redirect:/scholar/register/step2";
            }
            
            // Create upload directory if it doesn't exist
            File uploadDir = new File(uploadDirectory);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            
            // Save files
            String idProofPath = saveFile(idProof, "idproof_" + scholarId);
            String certificatesPath = saveFile(certificates, "certificates_" + scholarId);
            String profilePhotoPath = saveFile(profilePhoto, "profile_" + scholarId);
            
            // Convert specializations
            List<ScholarSpecialization> specList = new ArrayList<>();
            if (specializations != null) {
                for (String spec : specializations) {
                    try {
                        specList.add(ScholarSpecialization.valueOf(spec));
                    } catch (IllegalArgumentException e) {
                        // Skip invalid specialization
                    }
                }
            }
            
            // Convert languages (comma-separated string to list)
            List<String> langList = new ArrayList<>();
            if (languages != null && !languages.trim().isEmpty()) {
                String[] langArray = languages.split(",");
                for (String lang : langArray) {
                    langList.add(lang.trim());
                }
            }
            
            // Update scholar details including type
            Scholar scholar = scholarService.findById(scholarId).orElse(null);
            if (scholar == null) {
                return "redirect:/scholar/register/step1";
            }
            
            // Set the type explicitly
            scholar.setType(scholarType);
            scholar.setExperienceYears(experienceYears);
            scholar.setSpecializations(specList);
            scholar.setLanguages(langList);
            scholar.setServiceAreas(serviceAreas);
            scholar.setBasePrice(java.math.BigDecimal.valueOf(basePrice));
            scholar.setIdProofPath(idProofPath);
            scholar.setCertificatesPath(certificatesPath);
            scholar.setProfilePhotoPath(profilePhotoPath);
            scholar.setStatus(ScholarRegistrationStatus.PENDING_APPROVAL);
            
            // Save
            scholarService.save(scholar);
            
            // Clear session
            session.removeAttribute("scholarRegScholarId");
            session.removeAttribute("scholarRegUserId");
            
            redirectAttributes.addFlashAttribute("success", "Registration successful! Your application is pending admin approval.");
            return "redirect:/scholar/register/success";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/scholar/register/step2";
        }
    }
    
    @RequestMapping(value = "/success", method = RequestMethod.GET)
    public String showSuccess() {
        return "scholar/ScholarRegisterSuccess";
    }
    
    private String saveFile(MultipartFile file, String prefix) throws IOException {
        if (file == null || file.isEmpty()) {
            return null;
        }
        
        String originalFilename = file.getOriginalFilename();
        String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
        String filename = prefix + "_" + System.currentTimeMillis() + extension;
        Path path = Paths.get(uploadDirectory + filename);
        Files.copy(file.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
        return filename;
    }
}

