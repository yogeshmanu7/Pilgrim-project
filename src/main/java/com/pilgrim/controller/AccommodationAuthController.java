package com.pilgrim.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pilgrim.entity.AccommodationUser;
import com.pilgrim.service.AccommodationOTPService;
import com.pilgrim.service.AccommodationUserService;
import com.pilgrim.enums.AccommodationUserRole;

import jakarta.servlet.http.HttpSession;

@Controller
public class AccommodationAuthController {
	
	@Autowired
	private AccommodationUserService userService;
	
	@Autowired
	private AccommodationOTPService otpService;
	
	@Value("${admin.registration.key:ADMIN_SECRET_2024}")
	private String adminRegistrationKey;
	
	@GetMapping("/accommodation/signup")
	public String signupPage() {
		return "accommodation/signup";
	}
	
	@PostMapping("/accommodation/signup")
	public String signup(@RequestParam String fullName, @RequestParam String username,
			@RequestParam String email, @RequestParam String phoneNumber,
			@RequestParam String password, @RequestParam String confirmPassword,
			@RequestParam(required = false, defaultValue = "PILGRIM") String userRole,
			RedirectAttributes redirectAttributes) {
		
		if (!password.equals(confirmPassword)) {
			redirectAttributes.addFlashAttribute("error", "Passwords do not match");
			return "redirect:/accommodation/signup";
		}
		
		if (userService.existsByEmail(email)) {
			redirectAttributes.addFlashAttribute("error", "Email already exists");
			return "redirect:/accommodation/signup";
		}
		
		if (userService.existsByUsername(username)) {
			redirectAttributes.addFlashAttribute("error", "Username already exists");
			return "redirect:/accommodation/signup";
		}
		
		AccommodationUserRole role;
		try {
			role = AccommodationUserRole.valueOf(userRole);
		} catch (IllegalArgumentException e) {
			role = AccommodationUserRole.PILGRIM;
		}
		
		AccommodationUser user = userService.registerUser(fullName, username, email, phoneNumber, password, role);
		otpService.generateAndSendOTP(email);
		
		redirectAttributes.addFlashAttribute("email", email);
		redirectAttributes.addFlashAttribute("userId", user.getId());
		return "redirect:/accommodation/verify-otp";
	}
	
	@GetMapping("/accommodation/verify-otp")
	public String verifyOTPPage(Model model) {
		return "accommodation/verify-otp";
	}
	
	@PostMapping("/accommodation/verify-otp")
	public String verifyOTP(@RequestParam String email, @RequestParam String otpCode,
			HttpSession session, RedirectAttributes redirectAttributes) {
		
		if (otpService.verifyOTP(email, otpCode)) {
			userService.findByEmail(email).ifPresent(user -> {
				userService.verifyEmail(user.getId());
				session.setAttribute("accommodationUserId", user.getId());
				session.setAttribute("accommodationUserRole", user.getRole().toString());
				session.setAttribute("accommodationUsername", user.getUsername());
				session.setAttribute("accommodationUserFullName", user.getFullName());
			});
			
			var userOpt = userService.findByEmail(email);
			if (userOpt.isPresent()) {
				AccommodationUser user = userOpt.get();
				redirectAttributes.addFlashAttribute("success", "Email verified successfully! Welcome to GlobalPiligrim.");
				
				if (user.getRole() == AccommodationUserRole.ADMIN) {
					return "redirect:/accommodation/admin/dashboard";
				} else if (user.getRole() == AccommodationUserRole.PROPERTY_OWNER) {
					return "redirect:/accommodation/user/search";
				} else {
					return "redirect:/accommodation/user/search";
				}
			}
			
			redirectAttributes.addFlashAttribute("success", "Email verified successfully! Please sign in to continue.");
			return "redirect:/accommodation/signin";
		} else {
			redirectAttributes.addFlashAttribute("error", "Invalid or expired OTP");
			redirectAttributes.addFlashAttribute("email", email);
			return "redirect:/accommodation/verify-otp";
		}
	}
	
	@GetMapping("/accommodation/signin")
	public String signinPage() {
		return "accommodation/signin";
	}
	
	@PostMapping("/accommodation/signin")
	public String signin(@RequestParam String emailOrUsername, @RequestParam String password,
			HttpSession session, RedirectAttributes redirectAttributes) {
		
		var userOpt = userService.authenticateUser(emailOrUsername, password);
		if (userOpt.isPresent()) {
			AccommodationUser user = userOpt.get();
			session.setAttribute("accommodationUserId", user.getId());
			session.setAttribute("accommodationUserRole", user.getRole().toString());
			session.setAttribute("accommodationUsername", user.getUsername());
			session.setAttribute("accommodationUserFullName", user.getFullName());
			
			if (user.getRole() == AccommodationUserRole.ADMIN) {
				return "redirect:/accommodation/admin/dashboard";
			} else if (user.getRole() == AccommodationUserRole.PROPERTY_OWNER) {
				return "redirect:/accommodation/user/search";
			} else {
				return "redirect:/accommodation/user/search";
			}
		} else {
			redirectAttributes.addFlashAttribute("error", "Invalid credentials or email not verified");
			return "redirect:/accommodation/signin";
		}
	}
	
	@GetMapping("/accommodation/admin/signup")
	public String adminSignupPage() {
		return "accommodation/admin-signup";
	}
	
	@PostMapping("/accommodation/admin/signup")
	public String adminSignup(@RequestParam String fullName, @RequestParam String username,
			@RequestParam String email, @RequestParam String phoneNumber,
			@RequestParam String password, @RequestParam String confirmPassword,
			@RequestParam String adminKey,
			RedirectAttributes redirectAttributes) {
		
		if (!adminKey.equals(adminRegistrationKey)) {
			redirectAttributes.addFlashAttribute("error", "Invalid admin key");
			return "redirect:/accommodation/admin/signup";
		}
		
		if (!password.equals(confirmPassword)) {
			redirectAttributes.addFlashAttribute("error", "Passwords do not match");
			return "redirect:/accommodation/admin/signup";
		}
		
		if (userService.existsByEmail(email)) {
			redirectAttributes.addFlashAttribute("error", "Email already exists");
			return "redirect:/accommodation/admin/signup";
		}
		
		if (userService.existsByUsername(username)) {
			redirectAttributes.addFlashAttribute("error", "Username already exists");
			return "redirect:/accommodation/admin/signup";
		}
		
		userService.registerAdmin(fullName, username, email, phoneNumber, password);
		redirectAttributes.addFlashAttribute("success", "Admin account created successfully! Please sign in.");
		return "redirect:/accommodation/signin";
	}
	
	@GetMapping("/accommodation/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("accommodationUserId");
		session.removeAttribute("accommodationUserRole");
		session.removeAttribute("accommodationUsername");
		session.removeAttribute("accommodationUserFullName");
		return "redirect:/accommodation";
	}
}

