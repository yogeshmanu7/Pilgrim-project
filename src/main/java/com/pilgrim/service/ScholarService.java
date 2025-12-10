package com.pilgrim.service;

import com.pilgrim.entity.Scholar;
import com.pilgrim.entity.User;
import com.pilgrim.enums.ScholarRegistrationStatus;
import com.pilgrim.enums.ScholarSpecialization;
import com.pilgrim.enums.ScholarType;
import com.pilgrim.repository.ScholarRepository;
import com.pilgrim.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class ScholarService {
    
    @Autowired
    private ScholarRepository scholarRepository;
    
    @Autowired
    private UserRepository userRepository;
    
    public Scholar createScholar(User user, ScholarType type) {
        Scholar scholar = new Scholar();
        scholar.setUser(user);
        scholar.setType(type);
        scholar.setStatus(ScholarRegistrationStatus.BASIC_REGISTERED);
        return scholarRepository.save(scholar);
    }
    
    public Scholar updateScholarDetails(Long scholarId, Integer experienceYears, 
            List<ScholarSpecialization> specializations, List<String> languages, 
            String serviceAreas, BigDecimal basePrice, String idProofPath, 
            String certificatesPath, String profilePhotoPath) {
        Scholar scholar = scholarRepository.findById(scholarId)
            .orElseThrow(() -> new RuntimeException("Scholar not found"));
        
        scholar.setExperienceYears(experienceYears);
        scholar.setSpecializations(specializations);
        scholar.setLanguages(languages);
        scholar.setServiceAreas(serviceAreas);
        scholar.setBasePrice(basePrice);
        scholar.setIdProofPath(idProofPath);
        scholar.setCertificatesPath(certificatesPath);
        scholar.setProfilePhotoPath(profilePhotoPath);
        scholar.setStatus(ScholarRegistrationStatus.PENDING_APPROVAL);
        
        return scholarRepository.save(scholar);
    }
    
    public List<Scholar> findByType(ScholarType type) {
        return scholarRepository.findByTypeAndStatus(type, ScholarRegistrationStatus.APPROVED);
    }
    
    public List<Scholar> findAvailableByType(ScholarType type) {
        return scholarRepository.findByTypeAndStatusAndIsAvailable(
            type, ScholarRegistrationStatus.APPROVED, true);
    }
    
    public List<Scholar> findByStatus(ScholarRegistrationStatus status) {
        return scholarRepository.findByStatus(status);
    }
    
    public Optional<Scholar> findById(Long id) {
        return scholarRepository.findById(id);
    }
    
    public Scholar findByUserId(Long userId) {
        return scholarRepository.findByUser_Id(userId);
    }
    
    public Scholar updateStatus(Long scholarId, ScholarRegistrationStatus status, String rejectionReason) {
        Scholar scholar = scholarRepository.findById(scholarId)
            .orElseThrow(() -> new RuntimeException("Scholar not found"));
        scholar.setStatus(status);
        if (rejectionReason != null) {
            scholar.setRejectionReason(rejectionReason);
        }
        
        // When admin approves a scholar, automatically verify the associated user account
        if (status == ScholarRegistrationStatus.APPROVED) {
            User user = scholar.getUser();
            if (user != null && !user.isVerified()) {
                user.setVerified(true);
                userRepository.save(user);
            }
        }
        
        return scholarRepository.save(scholar);
    }
    
    public Scholar save(Scholar scholar) {
        return scholarRepository.save(scholar);
    }
    
    public void updateRating(Long scholarId) {
        Scholar scholar = scholarRepository.findById(scholarId)
            .orElseThrow(() -> new RuntimeException("Scholar not found"));
        // Rating calculation will be done in ScholarReviewService
    }
    
    public List<Scholar> findAll() {
        return scholarRepository.findAll();
    }
    
    public long count() {
        return scholarRepository.count();
    }
}

