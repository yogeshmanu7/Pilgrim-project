package com.pilgrim.controller;

import com.pilgrim.entity.*;
import com.pilgrim.service.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/admin/settings")
public class SettingsController {
    
    @Autowired
    private AppSettingsService appSettingsService;
    
    @RequestMapping(value = "", method = RequestMethod.GET)
    public String showSettings(Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) return "redirect:/admin/login";
        
        List<AppSettings> settings = appSettingsService.getAllSettings();
        
        model.addAttribute("settings", settings);
        model.addAttribute("admin", admin);
        return "admin/settings/list";
    }
    
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public String updateSetting(@RequestParam String key,
                                @RequestParam String value,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        try {
            Admin admin = (Admin) session.getAttribute("adminSession");
            if (admin == null) return "redirect:/admin/login";
            
            appSettingsService.updateSetting(key, value, admin);
            redirectAttributes.addFlashAttribute("success", "Setting updated successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/settings";
    }
    
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String addSetting(@ModelAttribute AppSettings setting,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {
        try {
            Admin admin = (Admin) session.getAttribute("adminSession");
            if (admin == null) return "redirect:/admin/login";
            
            appSettingsService.createSetting(setting, admin);
            redirectAttributes.addFlashAttribute("success", "Setting added successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/settings";
    }
}
