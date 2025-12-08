package com.pilgrim.service;

import com.pilgrim.entity.User;
import com.pilgrim.entity.Admin;
import com.pilgrim.entity.OtpVerification;
import com.pilgrim.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.time.LocalDateTime;
import java.util.Base64;
import java.util.Optional;

@Service
public class UserService {
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private AuditLogService auditLogService;
    
    @Autowired
    private OtpService otpService;
    
    @Autowired
    private EmailService emailService;
    
    public Page<User> getAllUsers(Pageable pageable) {
        return userRepository.findAll(pageable);
    }
    
    public Page<User> getActiveUsers(Pageable pageable) {
        return userRepository.findByIsActiveTrue(pageable);
    }
    
    public Page<User> getBlockedUsers(Pageable pageable) {
        return userRepository.findByIsBlockedTrue(pageable);
    }
    
    public Optional<User> getUserById(Long id) {
        return userRepository.findById(id);
    }
    
    public Page<User> searchUsers(String keyword, Pageable pageable) {
        return userRepository.searchUsers(keyword, pageable);
    }
    
    @Transactional
    public User updateUser(Long id, User userData, Admin admin) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("User not found"));
        
        user.setName(userData.getName());
        user.setPhone(userData.getPhone());
        user.setAddress(userData.getAddress());
        user.setCity(userData.getCity());
        user.setState(userData.getState());
        user.setPinCode(userData.getPinCode());
        
        user = userRepository.save(user);
        
        auditLogService.logAction(admin.getId(), admin.getName(), admin.getEmail(),
                "UPDATE", "User", user.getId(), user.getName(),
                "User updated", null, null, null, null);
        
        return user;
    }
    
    @Transactional
    public User blockUser(Long id, String reason, Admin admin) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("User not found"));
        
        user.setBlocked(true);
        user.setBlockedReason(reason);
        user = userRepository.save(user);
        
        auditLogService.logAction(admin.getId(), admin.getName(), admin.getEmail(),
                "BLOCK", "User", user.getId(), user.getName(),
                "User blocked: " + reason, null, null, null, null);
        
        return user;
    }
    
    @Transactional
    public User unblockUser(Long id, Admin admin) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("User not found"));
        
        user.setBlocked(false);
        user.setBlockedReason(null);
        user = userRepository.save(user);
        
        auditLogService.logAction(admin.getId(), admin.getName(), admin.getEmail(),
                "UNBLOCK", "User", user.getId(), user.getName(),
                "User unblocked", null, null, null, null);
        
        return user;
    }
    
    public long countActiveUsers() {
        return userRepository.countByIsActiveTrue();
    }
    
    // User Authentication Methods
    public boolean existsByEmail(String email) {
        return userRepository.existsByEmail(email);
    }
    
    public String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes());
            return Base64.getEncoder().encodeToString(hash);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }
    
    @Transactional
    public String initiateRegistration(String name, String email, String phone, String password) {
        if (existsByEmail(email)) {
            throw new RuntimeException("Email already registered");
        }
        
        // Store registration data temporarily (in real app, use cache or session)
        // For now, we'll create user directly after OTP verification
        otpService.createAndSendOtp(email, OtpVerification.OtpType.REGISTRATION);
        return "OTP sent to email";
    }
    
    @Transactional
    public User completeRegistration(String name, String email, String phone, String password, String otp) {
        if (!otpService.verifyOtp(email, otp, OtpVerification.OtpType.REGISTRATION)) {
            throw new RuntimeException("Invalid or expired OTP");
        }
        
        if (existsByEmail(email)) {
            throw new RuntimeException("Email already registered");
        }
        
        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPhone(phone);
        user.setPassword(hashPassword(password));
        user.setVerified(true);
        user.setActive(true);
        user.setCreatedAt(LocalDateTime.now());
        user.setUpdatedAt(LocalDateTime.now());
        
        user = userRepository.save(user);
        
        otpService.cleanupOtp(email);
        emailService.sendWelcomeEmail(email, name);
        
        return user;
    }
    
    public User login(String email, String password) {
        Optional<User> optionalUser = userRepository.findByEmail(email);
        
        if (optionalUser.isEmpty()) {
            throw new RuntimeException("Invalid email or password");
        }
        
        User user = optionalUser.get();
        
        if (!user.isActive()) {
            throw new RuntimeException("Account is deactivated");
        }
        
        if (user.isBlocked()) {
            throw new RuntimeException("Account is blocked: " + user.getBlockedReason());
        }
        
        if (!user.isVerified()) {
            throw new RuntimeException("Account is not verified. Please verify your email first.");
        }
        
        if (!user.getPassword().equals(hashPassword(password))) {
            throw new RuntimeException("Invalid email or password");
        }
        
        user.setLastLogin(LocalDateTime.now());
        userRepository.save(user);
        
        return user;
    }
    
    public Optional<User> findByEmail(String email) {
        return userRepository.findByEmail(email);
    }
    
    // Simple update method for user self-updates (without Admin requirement)
    @Transactional
    public User updateUser(User user) {
        user.setUpdatedAt(LocalDateTime.now());
        return userRepository.save(user);
    }
}

