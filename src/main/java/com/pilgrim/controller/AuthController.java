package com.pilgrim.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pilgrim.entity.User;
import com.pilgrim.entity.OtpVerification;
import com.pilgrim.service.OtpService;
import com.pilgrim.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
public class AuthController {

    @Autowired
    private UserService userService;

    @Autowired
    private OtpService otpService;

    // ===== REGISTER PAGE =====
    @GetMapping("/register")
    public ModelAndView register() {
        return new ModelAndView("user-register", "user", new User());
    }

    // ===== SAVE USER & SEND OTP =====
    @PostMapping("/save-user")
    public String saveUser(@ModelAttribute User user, HttpSession session, RedirectAttributes redirectAttributes) {
        try {
            // Check if user already exists
            if (userService.existsByEmail(user.getEmail())) {
                redirectAttributes.addFlashAttribute("error", "Email already registered!");
                return "redirect:/register";
            }

            // Store user data in session for later use
            session.setAttribute("pendingUser", user);
            
            // Send OTP using existing OtpService
            otpService.createAndSendOtp(user.getEmail(), OtpVerification.OtpType.REGISTRATION);

            session.setAttribute("email", user.getEmail());
            redirectAttributes.addFlashAttribute("message", "OTP sent to your email. Please verify to complete registration.");

            return "redirect:/otp-verify";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Registration failed: " + e.getMessage());
            return "redirect:/register";
        }
    }

    // ===== OTP PAGE =====
    @GetMapping("/otp-verify")
    public String otpPage() {
        return "otp-verify";
    }

    // ===== VERIFY OTP =====
    @PostMapping("/verify-otp")
    public String verifyOtp(@RequestParam String otp, HttpSession session, RedirectAttributes redirectAttributes) {
        String email = (String) session.getAttribute("email");
        User pendingUser = (User) session.getAttribute("pendingUser");

        if (otp == null || email == null || pendingUser == null) {
            redirectAttributes.addFlashAttribute("error", "Session expired. Please register again.");
            return "redirect:/register";
        }

        if (otpService.verifyOtp(email, otp, OtpVerification.OtpType.REGISTRATION)) {
            try {
                // Complete registration using existing UserService method
                User savedUser = userService.completeRegistration(
                    pendingUser.getName(),
                    pendingUser.getEmail(),
                    pendingUser.getPhone() != null ? pendingUser.getPhone() : "",
                    pendingUser.getPassword(),
                    otp
                );

                session.removeAttribute("pendingUser");
                redirectAttributes.addFlashAttribute("message", "Registration successful! Please login.");
                return "redirect:/login";
            } catch (Exception e) {
                redirectAttributes.addFlashAttribute("error", "Registration failed: " + e.getMessage());
                return "redirect:/register";
            }
        }

        redirectAttributes.addFlashAttribute("error", "Invalid OTP!");
        return "redirect:/otp-verify";
    }

    // ===== LOGIN PAGE =====
    @GetMapping("/login")
    public String login() {
        return "user-login";
    }

    // ===== LOGIN USER =====
    @PostMapping("/login-user")
    public String loginUser(@RequestParam String email,
                            @RequestParam String password,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {
        try {
            User user = userService.login(email, password);

            if (user != null) {
                session.setAttribute("user", user);
                session.setAttribute("userSession", user);
                redirectAttributes.addFlashAttribute("message", "Login successful!");
                return "redirect:/home";
            }

            redirectAttributes.addFlashAttribute("error", "Invalid credentials!");
            return "redirect:/login";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/login";
        }
    }

    // ===== LOGOUT =====
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}

