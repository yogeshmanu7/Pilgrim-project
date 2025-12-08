package com.pilgrim.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.pilgrim.entity.AccommodationOTP;

@Repository
public interface AccommodationOTPRepository extends JpaRepository<AccommodationOTP, Long> {
	@Query("SELECT o FROM AccommodationOTP o WHERE o.email = :email AND o.used = false AND o.expiresAt > CURRENT_TIMESTAMP ORDER BY o.createdAt DESC")
	Optional<AccommodationOTP> findLatestValidOTPByEmail(@Param("email") String email);
	
	Optional<AccommodationOTP> findByEmailAndOtpCodeAndUsedFalse(String email, String otpCode);
}

