package com.pilgrim.service;

import com.pilgrim.entity.OtpVerification;
import com.pilgrim.repository.OtpVerificationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.security.SecureRandom;
import java.util.Optional;

@Service
public class OtpService {
    
    @Autowired
    private OtpVerificationRepository otpRepository;
    
    @Autowired
    private EmailService emailService;
    
    private static final SecureRandom random = new SecureRandom();
    
    public String generateOtp() {
        int otp = 100000 + random.nextInt(900000);
        return String.valueOf(otp);
    }
    
    @Transactional
    public String createAndSendOtp(String email, OtpVerification.OtpType otpType) {
        String otp = generateOtp();
        
        OtpVerification otpVerification = OtpVerification.builder()
                .email(email)
                .otp(otp)
                .otpType(otpType)
                .build();
        
        otpRepository.save(otpVerification);
        
        String purpose = switch (otpType) {
            case REGISTRATION -> "Registration";
            case PASSWORD_RESET -> "Password Reset";
            case LOGIN -> "Login";
        };
        
        emailService.sendOtpEmail(email, otp, purpose);
        
        return otp;
    }
    
    public boolean verifyOtp(String email, String otp, OtpVerification.OtpType otpType) {
        Optional<OtpVerification> optionalOtp = otpRepository
                .findTopByEmailAndOtpTypeOrderByCreatedAtDesc(email, otpType);
        
        if (optionalOtp.isEmpty()) {
            return false;
        }
        
        OtpVerification otpVerification = optionalOtp.get();
        
        if (otpVerification.isExpired()) {
            return false;
        }
        
        if (otpVerification.getAttempts() >= 3) {
            return false;
        }
        
        if (!otpVerification.getOtp().equals(otp)) {
            otpVerification.setAttempts(otpVerification.getAttempts() + 1);
            otpRepository.save(otpVerification);
            return false;
        }
        
        otpVerification.setVerified(true);
        otpRepository.save(otpVerification);
        return true;
    }
    
    public boolean isOtpVerified(String email, OtpVerification.OtpType otpType) {
        Optional<OtpVerification> optionalOtp = otpRepository
                .findTopByEmailAndOtpTypeOrderByCreatedAtDesc(email, otpType);
        
        return optionalOtp.map(OtpVerification::isVerified).orElse(false);
    }
    
    @Transactional
    public void cleanupOtp(String email) {
        otpRepository.deleteByEmail(email);
    }
    
    // Convenience methods for travel module (without OtpType)
    public String sendOtp(String email) {
        return createAndSendOtp(email, OtpVerification.OtpType.REGISTRATION);
    }
    
    public boolean verifyOtp(String email, String otp) {
        return verifyOtp(email, otp, OtpVerification.OtpType.REGISTRATION);
    }
    
    public void sendEmail(String to, String subject, String body) {
        emailService.sendEmail(to, subject, body);
    }
}

