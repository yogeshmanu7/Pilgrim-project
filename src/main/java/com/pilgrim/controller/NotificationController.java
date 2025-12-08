package com.pilgrim.controller;

import com.pilgrim.entity.*;
import com.pilgrim.service.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/notifications")
public class NotificationController {
    
    @Autowired
    private NotificationService notificationService;
    
    @RequestMapping(value = "", method = RequestMethod.GET)
    public String listNotifications(@RequestParam(defaultValue = "0") int page,
                                    @RequestParam(defaultValue = "10") int size,
                                    Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) return "redirect:/admin/login";
        
        Pageable pageable = PageRequest.of(page, size);
        Page<Notification> notifications = notificationService.getAllNotifications(pageable);
        
        model.addAttribute("notifications", notifications);
        model.addAttribute("admin", admin);
        return "admin/notifications/list";
    }
    
    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String showCreateForm(Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) return "redirect:/admin/login";
        
        model.addAttribute("notification", new Notification());
        model.addAttribute("types", Notification.NotificationType.values());
        model.addAttribute("audiences", Notification.TargetAudience.values());
        model.addAttribute("admin", admin);
        return "admin/notifications/form";
    }
    
    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public String saveNotification(@ModelAttribute Notification notification,
                                   HttpSession session,
                                   RedirectAttributes redirectAttributes) {
        try {
            Admin admin = (Admin) session.getAttribute("adminSession");
            if (admin == null) return "redirect:/admin/login";
            
            notificationService.createNotification(notification, admin);
            redirectAttributes.addFlashAttribute("success", "Notification created successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/notifications";
    }
    
    @RequestMapping(value = "/{id}/send", method = RequestMethod.POST)
    public String sendNotification(@PathVariable Long id,
                                   HttpSession session,
                                   RedirectAttributes redirectAttributes) {
        try {
            Admin admin = (Admin) session.getAttribute("adminSession");
            if (admin == null) return "redirect:/admin/login";
            
            notificationService.sendNotification(id, admin);
            redirectAttributes.addFlashAttribute("success", "Notification sent successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/notifications";
    }
    
    @RequestMapping(value = "/{id}/delete", method = RequestMethod.POST)
    public String deleteNotification(@PathVariable Long id,
                                     HttpSession session,
                                     RedirectAttributes redirectAttributes) {
        try {
            Admin admin = (Admin) session.getAttribute("adminSession");
            if (admin == null) return "redirect:/admin/login";
            
            notificationService.deleteNotification(id, admin);
            redirectAttributes.addFlashAttribute("success", "Notification deleted successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/notifications";
    }
}
