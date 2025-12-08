package com.pilgrim.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pilgrim.entity.AccommodationUser;
import com.pilgrim.repository.AccommodationUserRepository;
import com.pilgrim.enums.AccommodationUserRole;

@Service
public class AccommodationUserService {
	
	@Autowired
	private AccommodationUserRepository userRepository;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Transactional
	public AccommodationUser registerUser(String fullName, String username, String email, String phoneNumber, String password, AccommodationUserRole role) {
		AccommodationUser user = new AccommodationUser();
		user.setFullName(fullName);
		user.setUsername(username);
		user.setEmail(email);
		user.setPhoneNumber(phoneNumber);
		user.setPassword(passwordEncoder.encode(password));
		user.setEmailVerified(false);
		user.setRole(role);
		
		// Split fullName into firstName and lastName
		if (fullName != null && !fullName.trim().isEmpty()) {
			String[] nameParts = fullName.trim().split("\\s+", 2);
			if (nameParts.length > 0) {
				user.setFirstName(nameParts[0]);
			}
			if (nameParts.length > 1) {
				user.setLastName(nameParts[1]);
			} else {
				user.setLastName("");
			}
		}
		
		return userRepository.save(user);
	}
	
	@Transactional
	public AccommodationUser registerAdmin(String fullName, String username, String email, String phoneNumber, String password) {
		AccommodationUser user = new AccommodationUser();
		user.setFullName(fullName);
		user.setUsername(username);
		user.setEmail(email);
		user.setPhoneNumber(phoneNumber);
		user.setPassword(passwordEncoder.encode(password));
		user.setEmailVerified(true);
		user.setRole(AccommodationUserRole.ADMIN);
		
		if (fullName != null && !fullName.trim().isEmpty()) {
			String[] nameParts = fullName.trim().split("\\s+", 2);
			if (nameParts.length > 0) {
				user.setFirstName(nameParts[0]);
			}
			if (nameParts.length > 1) {
				user.setLastName(nameParts[1]);
			} else {
				user.setLastName("");
			}
		}
		
		return userRepository.save(user);
	}
	
	@Transactional
	public void verifyEmail(Long userId) {
		Optional<AccommodationUser> userOpt = userRepository.findById(userId);
		if (userOpt.isPresent()) {
			AccommodationUser user = userOpt.get();
			user.setEmailVerified(true);
			userRepository.save(user);
		}
	}
	
	public Optional<AccommodationUser> authenticateUser(String emailOrUsername, String password) {
		Optional<AccommodationUser> userOpt = userRepository.findByEmailOrUsername(emailOrUsername, emailOrUsername);
		
		if (userOpt.isPresent()) {
			AccommodationUser user = userOpt.get();
			if (passwordEncoder.matches(password, user.getPassword())) {
				if (user.getRole() == AccommodationUserRole.ADMIN || user.getEmailVerified()) {
					return Optional.of(user);
				}
			}
		}
		
		return Optional.empty();
	}
	
	public Optional<AccommodationUser> findByEmail(String email) {
		return userRepository.findByEmail(email);
	}
	
	public Optional<AccommodationUser> findById(Long id) {
		return userRepository.findById(id);
	}
	
	public boolean existsByEmail(String email) {
		return userRepository.existsByEmail(email);
	}
	
	public boolean existsByUsername(String username) {
		return userRepository.existsByUsername(username);
	}
	
	@Transactional
	public AccommodationUser updateProfileDetails(Long userId, String firstName, String lastName, String nationality, 
			java.time.LocalDate dateOfBirth, String residenceCountry, String residenceState, 
			String residenceCity, String preferredLanguage, String countryCode, 
			String contactPhoneNumber, String contactEmail) {
		Optional<AccommodationUser> userOpt = userRepository.findById(userId);
		if (userOpt.isPresent()) {
			AccommodationUser user = userOpt.get();
			user.setFirstName(firstName);
			user.setLastName(lastName);
			user.setNationality(nationality);
			user.setDateOfBirth(dateOfBirth);
			user.setResidenceCountry(residenceCountry);
			user.setResidenceState(residenceState);
			user.setResidenceCity(residenceCity);
			user.setPreferredLanguage(preferredLanguage);
			user.setCountryCode(countryCode);
			user.setContactPhoneNumber(contactPhoneNumber);
			user.setContactEmail(contactEmail);
			user.setUpdatedAt(java.time.LocalDateTime.now());
			return userRepository.save(user);
		}
		return null;
	}
}

