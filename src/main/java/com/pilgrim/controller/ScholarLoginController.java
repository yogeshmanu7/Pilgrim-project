package com.pilgrim.controller;

import com.pilgrim.entity.Scholar;
import com.pilgrim.entity.User;
import com.pilgrim.enums.ScholarRegistrationStatus;
import com.pilgrim.service.ScholarService;
import com.pilgrim.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/scholar")
public class ScholarLoginController {
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private ScholarService scholarService;
    
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String showLogin(HttpSession session) {
        if (session.getAttribute("userId") != null) {
            Scholar scholar = scholarService.findByUserId((Long) session.getAttribute("userId"));
            if (scholar != null) {
                return "redirect:/scholar/dashboard";
            }
        }
        return "scholar/ScholarLogin";
    }
    
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String processLogin(
            @RequestParam String email,
            @RequestParam String password,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        
        try {
            User user = userService.login(email, password);
            
            // Check if user is a scholar
            Scholar scholar = scholarService.findByUserId(user.getId());
            if (scholar == null) {
                redirectAttributes.addFlashAttribute("error", "This account is not registered as a scholar. Please use the regular user login.");
                return "redirect:/scholar/login";
            }
            
            // Check if scholar is approved
            if (scholar.getStatus() != ScholarRegistrationStatus.APPROVED) {
                redirectAttributes.addFlashAttribute("error", "Your scholar account is pending admin approval. Please wait for approval.");
                return "redirect:/scholar/login";
            }
            
            // Set session attributes
            session.setAttribute("userSession", user);
            session.setAttribute("userId", user.getId());
            session.setAttribute("userName", user.getName());
            session.setAttribute("userEmail", user.getEmail());
            session.setAttribute("scholarId", scholar.getId());
            
            return "redirect:/scholar/dashboard";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/scholar/login";
        }
    }
    
    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/scholar/login";
    }
}

