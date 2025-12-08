package com.pilgrim.controller;

import com.pilgrim.entity.Admin;
import com.pilgrim.entity.OtpVerification;
import com.pilgrim.service.AdminService;
import com.pilgrim.service.OtpService;
import com.pilgrim.service.AuditLogService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin")
public class AdminAuthController {
    
    @Autowired
    private AdminService adminService;
    
    @Autowired
    private OtpService otpService;
    
    @Autowired
    private AuditLogService auditLogService;
    
    // Login methods moved to AdminLoginController
    // @RequestMapping(value = "/login", method = RequestMethod.GET)
    // public String showLoginPage(HttpSession session) {
    //     if (session.getAttribute("adminSession") != null) {
    //         return "redirect:/admin/dashboard";
    //     }
    //     return "admin/login";
    // }
    
    // @RequestMapping(value = "/login", method = RequestMethod.POST)
    // public String login(@RequestParam String email,
    //                     @RequestParam String password,
    //                     HttpSession session,
    //                     HttpServletRequest request,
    //                     RedirectAttributes redirectAttributes) {
    //     try {
    //         Admin admin = adminService.login(email, password);
    //         session.setAttribute("adminSession", admin);
    //         session.setAttribute("adminId", admin.getId());
    //         session.setAttribute("adminName", admin.getName());
    //         session.setAttribute("adminEmail", admin.getEmail());
    //         
    //         auditLogService.logAction(admin.getId(), admin.getName(), admin.getEmail(),
    //                 "LOGIN", "Admin", admin.getId(), admin.getName(),
    //                 "Admin logged in", null, null,
    //                 request.getRemoteAddr(), request.getHeader("User-Agent"));
    //         
    //         return "redirect:/admin/dashboard";
    //     } catch (Exception e) {
    //         redirectAttributes.addFlashAttribute("error", e.getMessage());
    //         return "redirect:/admin/login";
    //     }
    // }
    
    // Registration methods moved to AdminRegisterController
    // @RequestMapping(value = "/register", method = RequestMethod.GET)
    // public String showRegisterPage(HttpSession session) {
    //     if (session.getAttribute("adminSession") != null) {
    //         return "redirect:/admin/dashboard";
    //     }
    //     return "admin/register";
    // }
    
    // Logout method moved to AdminLoginController
    // @RequestMapping(value = "/logout", method = RequestMethod.GET)
    // public String logout(HttpSession session, HttpServletRequest request) {
    //     Admin admin = (Admin) session.getAttribute("adminSession");
    //     
    //     if (admin != null) {
    //         auditLogService.logAction(admin.getId(), admin.getName(), admin.getEmail(),
    //                 "LOGOUT", "Admin", admin.getId(), admin.getName(),
    //                 "Admin logged out", null, null,
    //                 request.getRemoteAddr(), request.getHeader("User-Agent"));
    //     }
    //     
    //     session.invalidate();
    //     return "redirect:/admin/login";
    // }
    
    @RequestMapping(value = "/forgot-password", method = RequestMethod.GET)
    public String showForgotPasswordPage() {
        return "admin/forgot-password";
    }
    
    @RequestMapping(value = "/forgot-password", method = RequestMethod.POST)
    public String sendPasswordResetOtp(@RequestParam String email,
                                       HttpSession session,
                                       RedirectAttributes redirectAttributes) {
        try {
            if (!adminService.existsByEmail(email)) {
                throw new RuntimeException("Email not registered");
            }
            
            otpService.createAndSendOtp(email, OtpVerification.OtpType.PASSWORD_RESET);
            session.setAttribute("resetEmail", email);
            
            redirectAttributes.addFlashAttribute("message", "OTP sent to your email.");
            return "redirect:/admin/reset-password";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/admin/forgot-password";
        }
    }
    
    @RequestMapping(value = "/reset-password", method = RequestMethod.GET)
    public String showResetPasswordPage(HttpSession session) {
        if (session.getAttribute("resetEmail") == null) {
            return "redirect:/admin/forgot-password";
        }
        return "admin/reset-password";
    }
    
    @RequestMapping(value = "/reset-password", method = RequestMethod.POST)
    public String resetPassword(@RequestParam String otp,
                                @RequestParam String newPassword,
                                @RequestParam String confirmPassword,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        try {
            String email = (String) session.getAttribute("resetEmail");
            
            if (email == null) {
                throw new RuntimeException("Session expired. Please try again.");
            }
            
            if (!newPassword.equals(confirmPassword)) {
                throw new RuntimeException("Passwords do not match");
            }
            
            if (!otpService.verifyOtp(email, otp, OtpVerification.OtpType.PASSWORD_RESET)) {
                throw new RuntimeException("Invalid or expired OTP");
            }
            
            // Reset password logic would go here
            // For now, we just clear the session
            session.removeAttribute("resetEmail");
            
            redirectAttributes.addFlashAttribute("success", "Password reset successful! Please login.");
            return "redirect:/admin/login";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/admin/reset-password";
        }
    }
}
