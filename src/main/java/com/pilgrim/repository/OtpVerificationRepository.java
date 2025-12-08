package com.pilgrim.repository;

import com.pilgrim.entity.OtpVerification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface OtpVerificationRepository extends JpaRepository<OtpVerification, Long> {
    
    Optional<OtpVerification> findByEmailAndOtpAndIsVerifiedFalse(String email, String otp);
    
    Optional<OtpVerification> findTopByEmailAndOtpTypeOrderByCreatedAtDesc(String email, OtpVerification.OtpType otpType);
    
    void deleteByEmail(String email);
}

