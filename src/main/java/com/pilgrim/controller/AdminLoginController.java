package com.pilgrim.controller;

import com.pilgrim.entity.Admin;
import com.pilgrim.service.AdminService;
import com.pilgrim.service.AuditLogService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin")
public class AdminLoginController {
    
    @Autowired
    private AdminService adminService;
    
    @Autowired
    private AuditLogService auditLogService;
    
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String showLoginPage(HttpSession session) {
        if (session.getAttribute("adminSession") != null) {
            return "redirect:/admin/dashboard";
        }
        return "admin/AdminLogin";
    }
    
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(@RequestParam String email,
                        @RequestParam String password,
                        HttpSession session,
                        HttpServletRequest request,
                        RedirectAttributes redirectAttributes) {
        try {
            Admin admin = adminService.login(email, password);
            session.setAttribute("adminSession", admin);
            session.setAttribute("adminId", admin.getId());
            session.setAttribute("adminName", admin.getName());
            session.setAttribute("adminEmail", admin.getEmail());
            
            auditLogService.logAction(admin.getId(), admin.getName(), admin.getEmail(),
                    "LOGIN", "Admin", admin.getId(), admin.getName(),
                    "Admin logged in", null, null,
                    request.getRemoteAddr(), request.getHeader("User-Agent"));
            
            return "redirect:/admin/dashboard";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/admin/login";
        }
    }
    
    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(HttpSession session, HttpServletRequest request) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        
        if (admin != null) {
            auditLogService.logAction(admin.getId(), admin.getName(), admin.getEmail(),
                    "LOGOUT", "Admin", admin.getId(), admin.getName(),
                    "Admin logged out", null, null,
                    request.getRemoteAddr(), request.getHeader("User-Agent"));
        }
        
        session.invalidate();
        return "redirect:/admin/login";
    }
}

