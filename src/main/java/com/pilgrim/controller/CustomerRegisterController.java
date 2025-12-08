package com.pilgrim.controller;

import com.pilgrim.entity.User;
import com.pilgrim.entity.OtpVerification;
import com.pilgrim.service.UserService;
import com.pilgrim.service.OtpService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/customer/register")
public class CustomerRegisterController {
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private OtpService otpService;
    
    @RequestMapping(value = "/step1", method = RequestMethod.GET)
    public String showSignupPage(HttpSession session) {
        if (session.getAttribute("userSession") != null) {
            return "redirect:/customer/scholar/dashboard";
        }
        return "customer/CustomerRegisterStep1";
    }
    
    @RequestMapping(value = "/step1", method = RequestMethod.POST)
    public String signup(@RequestParam String name,
                        @RequestParam String email,
                        @RequestParam String phone,
                        @RequestParam String password,
                        @RequestParam String confirmPassword,
                        HttpSession session,
                        RedirectAttributes redirectAttributes) {
        try {
            if (!password.equals(confirmPassword)) {
                throw new RuntimeException("Passwords do not match");
            }
            
            if (userService.existsByEmail(email)) {
                throw new RuntimeException("Email already registered");
            }
            
            // Store registration data in session for OTP verification
            session.setAttribute("regName", name);
            session.setAttribute("regEmail", email);
            session.setAttribute("regPhone", phone);
            session.setAttribute("regPassword", password);
            
            // Generate and send OTP
            otpService.createAndSendOtp(email, OtpVerification.OtpType.REGISTRATION);
            
            redirectAttributes.addFlashAttribute("message", "OTP sent to your email. Please verify.");
            return "redirect:/customer/register/verify-otp";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/customer/register/step1";
        }
    }
    
    @RequestMapping(value = "/verify-otp", method = RequestMethod.GET)
    public String showOtpPage(HttpSession session) {
        if (session.getAttribute("regEmail") == null) {
            return "redirect:/customer/register/step1";
        }
        return "customer/CustomerRegisterVerifyOtp";
    }
    
    @RequestMapping(value = "/verify-otp", method = RequestMethod.POST)
    public String verifyOtp(@RequestParam String otp,
                           HttpSession session,
                           RedirectAttributes redirectAttributes) {
        try {
            String name = (String) session.getAttribute("regName");
            String email = (String) session.getAttribute("regEmail");
            String phone = (String) session.getAttribute("regPhone");
            String password = (String) session.getAttribute("regPassword");
            
            if (name == null || email == null || phone == null || password == null) {
                throw new RuntimeException("Session expired. Please register again.");
            }
            
            User user = userService.completeRegistration(name, email, phone, password, otp);
            
            // Clear session data
            session.removeAttribute("regName");
            session.removeAttribute("regEmail");
            session.removeAttribute("regPhone");
            session.removeAttribute("regPassword");
            
            // Set user session
            session.setAttribute("userSession", user);
            session.setAttribute("userId", user.getId());
            session.setAttribute("userName", user.getName());
            session.setAttribute("userEmail", user.getEmail());
            
            redirectAttributes.addFlashAttribute("success", "Registration successful! Welcome to GlobalPiligrim.");
            return "redirect:/customer/scholar/dashboard";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/customer/register/verify-otp";
        }
    }
    
    @RequestMapping(value = "/resend-otp", method = RequestMethod.POST)
    public String resendOtp(HttpSession session, RedirectAttributes redirectAttributes) {
        try {
            String email = (String) session.getAttribute("regEmail");
            if (email == null) {
                throw new RuntimeException("Session expired");
            }
            
            otpService.createAndSendOtp(email, OtpVerification.OtpType.REGISTRATION);
            redirectAttributes.addFlashAttribute("message", "OTP resent to your email");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/customer/register/verify-otp";
    }
}

