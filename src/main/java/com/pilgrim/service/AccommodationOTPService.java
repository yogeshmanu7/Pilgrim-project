package com.pilgrim.service;

import java.util.Optional;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pilgrim.entity.AccommodationOTP;
import com.pilgrim.repository.AccommodationOTPRepository;

@Service
public class AccommodationOTPService {
	
	@Autowired
	private AccommodationOTPRepository otpRepository;
	
	@Autowired
	private AccommodationEmailService emailService;
	
	private static final int OTP_LENGTH = 6;
	private static final Random random = new Random();
	
	@Transactional
	public String generateAndSendOTP(String email) {
		String otpCode = generateOTP();
		
		AccommodationOTP otp = new AccommodationOTP();
		otp.setEmail(email);
		otp.setOtpCode(otpCode);
		otpRepository.save(otp);
		
		emailService.sendOTPEmail(email, otpCode);
		
		return otpCode;
	}
	
	public boolean verifyOTP(String email, String otpCode) {
		Optional<AccommodationOTP> otpOpt = otpRepository.findByEmailAndOtpCodeAndUsedFalse(email, otpCode);
		
		if (otpOpt.isPresent()) {
			AccommodationOTP otp = otpOpt.get();
			if (otp.getExpiresAt().isAfter(java.time.LocalDateTime.now())) {
				otp.setUsed(true);
				otpRepository.save(otp);
				return true;
			}
		}
		
		return false;
	}
	
	private String generateOTP() {
		StringBuilder otp = new StringBuilder();
		for (int i = 0; i < OTP_LENGTH; i++) {
			otp.append(random.nextInt(10));
		}
		return otp.toString();
	}
}

