package com.pilgrim.controller;

import com.pilgrim.entity.Admin;
import com.pilgrim.entity.OtpVerification;
import com.pilgrim.service.AdminService;
import com.pilgrim.service.OtpService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/register")
public class AdminRegisterController {
    
    @Autowired
    private AdminService adminService;
    
    @Autowired
    private OtpService otpService;
    
    @RequestMapping(value = "/step1", method = RequestMethod.GET)
    public String showRegisterPage(HttpSession session) {
        if (session.getAttribute("adminSession") != null) {
            return "redirect:/admin/dashboard";
        }
        return "admin/AdminRegisterStep1";
    }
    
    @RequestMapping(value = "/step1", method = RequestMethod.POST)
    public String initiateRegistration(@RequestParam String name,
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
            
            if (adminService.existsByEmail(email)) {
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
            return "redirect:/admin/register/verify-otp";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/admin/register/step1";
        }
    }
    
    @RequestMapping(value = "/verify-otp", method = RequestMethod.GET)
    public String showOtpPage(HttpSession session) {
        if (session.getAttribute("regEmail") == null) {
            return "redirect:/admin/register/step1";
        }
        return "admin/AdminRegisterVerifyOtp";
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
            
            if (email == null) {
                throw new RuntimeException("Session expired. Please register again.");
            }
            
            Admin admin = adminService.completeRegistration(name, email, phone, password, otp);
            
            // Clear registration session data
            session.removeAttribute("regName");
            session.removeAttribute("regEmail");
            session.removeAttribute("regPhone");
            session.removeAttribute("regPassword");
            
            redirectAttributes.addFlashAttribute("success", "Registration successful! Please login.");
            return "redirect:/admin/login";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/admin/register/verify-otp";
        }
    }
    
    @RequestMapping(value = "/resend-otp", method = RequestMethod.POST)
    public String resendOtp(HttpSession session, RedirectAttributes redirectAttributes) {
        try {
            String email = (String) session.getAttribute("regEmail");
            
            if (email == null) {
                throw new RuntimeException("Session expired. Please register again.");
            }
            
            otpService.createAndSendOtp(email, OtpVerification.OtpType.REGISTRATION);
            
            redirectAttributes.addFlashAttribute("message", "OTP resent to your email.");
            return "redirect:/admin/register/verify-otp";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/admin/register/verify-otp";
        }
    }
}

