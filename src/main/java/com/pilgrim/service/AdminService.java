package com.pilgrim.service;

import com.pilgrim.entity.Admin;
import com.pilgrim.entity.OtpVerification;
import com.pilgrim.repository.AdminRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.time.LocalDateTime;
import java.util.Base64;
import java.util.Optional;

@Service
public class AdminService {
    
    @Autowired
    private AdminRepository adminRepository;
    
    @Autowired
    private OtpService otpService;
    
    @Autowired
    private EmailService emailService;
    
    @Autowired
    private AuditLogService auditLogService;
    
    public boolean existsByEmail(String email) {
        return adminRepository.existsByEmail(email);
    }
    
    public String initiateRegistration(String name, String email, String phone, String password) {
        if (existsByEmail(email)) {
            throw new RuntimeException("Email already registered");
        }
        return otpService.createAndSendOtp(email, OtpVerification.OtpType.REGISTRATION);
    }
    
    @Transactional
    public Admin completeRegistration(String name, String email, String phone, String password, String otp) {
        if (!otpService.verifyOtp(email, otp, OtpVerification.OtpType.REGISTRATION)) {
            throw new RuntimeException("Invalid or expired OTP");
        }
        
        Admin admin = Admin.builder()
                .name(name)
                .email(email)
                .phone(phone)
                .password(hashPassword(password))
                .isVerified(true)
                .isActive(true)
                .build();
        
        admin = adminRepository.save(admin);
        
        otpService.cleanupOtp(email);
        emailService.sendWelcomeEmail(email, name);
        
        auditLogService.logAction(admin.getId(), admin.getName(), admin.getEmail(),
                "CREATE", "Admin", admin.getId(), admin.getName(),
                "Admin registered successfully", null, null, null, null);
        
        return admin;
    }
    
    public Admin login(String email, String password) {
        Optional<Admin> optionalAdmin = adminRepository.findByEmail(email);
        
        if (optionalAdmin.isEmpty()) {
            throw new RuntimeException("Invalid email or password");
        }
        
        Admin admin = optionalAdmin.get();
        
        if (!admin.isActive()) {
            throw new RuntimeException("Account is deactivated");
        }
        
        if (!admin.getPassword().equals(hashPassword(password))) {
            throw new RuntimeException("Invalid email or password");
        }
        
        admin.setLastLogin(LocalDateTime.now());
        adminRepository.save(admin);
        
        return admin;
    }
    
    public Optional<Admin> findByEmail(String email) {
        return adminRepository.findByEmail(email);
    }
    
    public Optional<Admin> findById(Long id) {
        return adminRepository.findById(id);
    }
    
    @Transactional
    public Admin updateProfile(Long adminId, String name, String phone) {
        Admin admin = adminRepository.findById(adminId)
                .orElseThrow(() -> new RuntimeException("Admin not found"));
        
        String oldValue = "Name: " + admin.getName() + ", Phone: " + admin.getPhone();
        
        admin.setName(name);
        admin.setPhone(phone);
        admin = adminRepository.save(admin);
        
        String newValue = "Name: " + admin.getName() + ", Phone: " + admin.getPhone();
        
        auditLogService.logAction(adminId, admin.getName(), admin.getEmail(),
                "UPDATE", "Admin", adminId, admin.getName(),
                "Admin profile updated", oldValue, newValue, null, null);
        
        return admin;
    }
    
    @Transactional
    public void changePassword(Long adminId, String oldPassword, String newPassword) {
        Admin admin = adminRepository.findById(adminId)
                .orElseThrow(() -> new RuntimeException("Admin not found"));
        
        if (!admin.getPassword().equals(hashPassword(oldPassword))) {
            throw new RuntimeException("Current password is incorrect");
        }
        
        admin.setPassword(hashPassword(newPassword));
        adminRepository.save(admin);
        
        auditLogService.logAction(adminId, admin.getName(), admin.getEmail(),
                "UPDATE", "Admin", adminId, admin.getName(),
                "Password changed", null, null, null, null);
    }
    
    @Transactional
    public void updateProfileImage(Long adminId, String imagePath) {
        Admin admin = adminRepository.findById(adminId)
                .orElseThrow(() -> new RuntimeException("Admin not found"));
        
        admin.setProfileImage(imagePath);
        adminRepository.save(admin);
    }
    
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes());
            return Base64.getEncoder().encodeToString(hash);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Password hashing failed", e);
        }
    }
}

