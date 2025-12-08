package com.pilgrim.controller;

import com.pilgrim.entity.*;
import com.pilgrim.service.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/users")
public class UserController {
    
    @Autowired
    private UserService userService;
    
    @RequestMapping(value = "", method = RequestMethod.GET)
    public String listUsers(@RequestParam(defaultValue = "0") int page,
                            @RequestParam(defaultValue = "10") int size,
                            @RequestParam(required = false) String search,
                            @RequestParam(required = false) String filter,
                            Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) return "redirect:/admin/login";
        
        Pageable pageable = PageRequest.of(page, size, Sort.by("createdAt").descending());
        Page<User> users;
        
        if (search != null && !search.isEmpty()) {
            users = userService.searchUsers(search, pageable);
            model.addAttribute("search", search);
        } else if ("blocked".equals(filter)) {
            users = userService.getBlockedUsers(pageable);
            model.addAttribute("filter", filter);
        } else {
            users = userService.getAllUsers(pageable);
        }
        
        model.addAttribute("users", users);
        model.addAttribute("admin", admin);
        return "admin/users/list";
    }
    
    @RequestMapping(value = "/view/{id}", method = RequestMethod.GET)
    public String viewUser(@PathVariable Long id, Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) return "redirect:/admin/login";
        
        User user = userService.getUserById(id)
                .orElseThrow(() -> new RuntimeException("User not found"));
        
        model.addAttribute("user", user);
        model.addAttribute("admin", admin);
        return "admin/users/view";
    }
    
    @RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
    public String showEditForm(@PathVariable Long id, Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) return "redirect:/admin/login";
        
        User user = userService.getUserById(id)
                .orElseThrow(() -> new RuntimeException("User not found"));
        
        model.addAttribute("user", user);
        model.addAttribute("admin", admin);
        return "admin/users/edit";
    }
    
    @RequestMapping(value = "/update/{id}", method = RequestMethod.POST)
    public String updateUser(@PathVariable Long id,
                             @ModelAttribute User userData,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {
        try {
            Admin admin = (Admin) session.getAttribute("adminSession");
            if (admin == null) return "redirect:/admin/login";
            
            userService.updateUser(id, userData, admin);
            redirectAttributes.addFlashAttribute("success", "User updated successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/users";
    }
    
    @RequestMapping(value = "/block/{id}", method = RequestMethod.POST)
    public String blockUser(@PathVariable Long id,
                            @RequestParam String reason,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {
        try {
            Admin admin = (Admin) session.getAttribute("adminSession");
            if (admin == null) return "redirect:/admin/login";
            
            userService.blockUser(id, reason, admin);
            redirectAttributes.addFlashAttribute("success", "User blocked successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/users";
    }
    
    @RequestMapping(value = "/unblock/{id}", method = RequestMethod.POST)
    public String unblockUser(@PathVariable Long id,
                              HttpSession session,
                              RedirectAttributes redirectAttributes) {
        try {
            Admin admin = (Admin) session.getAttribute("adminSession");
            if (admin == null) return "redirect:/admin/login";
            
            userService.unblockUser(id, admin);
            redirectAttributes.addFlashAttribute("success", "User unblocked successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/users";
    }
}
