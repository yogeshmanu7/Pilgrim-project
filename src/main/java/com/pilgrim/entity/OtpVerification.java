package com.pilgrim.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "otp_verifications")
public class OtpVerification {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(nullable = false)
    private String email;
    
    @Column(nullable = false)
    private String otp;
    
    @Column(name = "otp_type")
    @Enumerated(EnumType.STRING)
    private OtpType otpType;
    
    @Column(name = "is_verified")
    private boolean isVerified = false;
    
    @Column(name = "attempts")
    private int attempts = 0;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    @Column(name = "expires_at")
    private LocalDateTime expiresAt;
    
    public enum OtpType {
        REGISTRATION, PASSWORD_RESET, LOGIN
    }
    
    public OtpVerification() {}
    
    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getOtp() { return otp; }
    public void setOtp(String otp) { this.otp = otp; }
    
    public OtpType getOtpType() { return otpType; }
    public void setOtpType(OtpType otpType) { this.otpType = otpType; }
    
    public boolean isVerified() { return isVerified; }
    public void setVerified(boolean isVerified) { this.isVerified = isVerified; }
    
    public int getAttempts() { return attempts; }
    public void setAttempts(int attempts) { this.attempts = attempts; }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    
    public LocalDateTime getExpiresAt() { return expiresAt; }
    public void setExpiresAt(LocalDateTime expiresAt) { this.expiresAt = expiresAt; }
    
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        expiresAt = LocalDateTime.now().plusMinutes(10);
    }
    
    public boolean isExpired() {
        return LocalDateTime.now().isAfter(expiresAt);
    }
    
    // Builder pattern
    public static OtpVerificationBuilder builder() {
        return new OtpVerificationBuilder();
    }
    
    public static class OtpVerificationBuilder {
        private String email;
        private String otp;
        private OtpType otpType;
        
        public OtpVerificationBuilder email(String email) {
            this.email = email;
            return this;
        }
        
        public OtpVerificationBuilder otp(String otp) {
            this.otp = otp;
            return this;
        }
        
        public OtpVerificationBuilder otpType(OtpType otpType) {
            this.otpType = otpType;
            return this;
        }
        
        public OtpVerification build() {
            OtpVerification otpVerification = new OtpVerification();
            otpVerification.setEmail(this.email);
            otpVerification.setOtp(this.otp);
            otpVerification.setOtpType(this.otpType);
            return otpVerification;
        }
    }
}
