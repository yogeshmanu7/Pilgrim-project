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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/admin/vendors")
public class VendorController {
    
    @Autowired
    private VendorService vendorService;
    
    @RequestMapping(value = "", method = RequestMethod.GET)
    public String listVendors(@RequestParam(defaultValue = "0") int page,
                              @RequestParam(defaultValue = "10") int size,
                              @RequestParam(required = false) String status,
                              Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) return "redirect:/admin/login";
        
        Pageable pageable = PageRequest.of(page, size, Sort.by("createdAt").descending());
        Page<Vendor> vendors;
        
        if (status != null && !status.isEmpty()) {
            vendors = vendorService.getVendorsByStatus(Vendor.VendorStatus.valueOf(status), pageable);
            model.addAttribute("selectedStatus", status);
        } else {
            vendors = vendorService.getAllVendors(pageable);
        }
        
        model.addAttribute("vendors", vendors);
        model.addAttribute("statuses", Vendor.VendorStatus.values());
        model.addAttribute("pendingCount", vendorService.countByStatus(Vendor.VendorStatus.PENDING));
        model.addAttribute("admin", admin);
        return "admin/vendors/list";
    }
    
    @RequestMapping(value = "/view/{id}", method = RequestMethod.GET)
    public String viewVendor(@PathVariable Long id, Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) return "redirect:/admin/login";
        
        Vendor vendor = vendorService.getVendorById(id)
                .orElseThrow(() -> new RuntimeException("Vendor not found"));
        
        model.addAttribute("vendor", vendor);
        model.addAttribute("admin", admin);
        return "admin/vendors/view";
    }
    
    @RequestMapping(value = "/approve/{id}", method = RequestMethod.POST)
    public String approveVendor(@PathVariable Long id,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        try {
            Admin admin = (Admin) session.getAttribute("adminSession");
            if (admin == null) return "redirect:/admin/login";
            
            vendorService.approveVendor(id, admin);
            redirectAttributes.addFlashAttribute("success", "Vendor approved successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/vendors";
    }
    
    @RequestMapping(value = "/reject/{id}", method = RequestMethod.POST)
    public String rejectVendor(@PathVariable Long id,
                               @RequestParam String reason,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        try {
            Admin admin = (Admin) session.getAttribute("adminSession");
            if (admin == null) return "redirect:/admin/login";
            
            vendorService.rejectVendor(id, reason, admin);
            redirectAttributes.addFlashAttribute("success", "Vendor rejected");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/vendors";
    }
    
    
    @RequestMapping(value = "/remove/{id}", method = RequestMethod.POST)
    public String removeVendor(@PathVariable Long id,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        try {
            Admin admin = (Admin) session.getAttribute("adminSession");
            if (admin == null) return "redirect:/admin/login";
            
            vendorService.removeVendor(id, admin);
            redirectAttributes.addFlashAttribute("success", "Vendor removed successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/vendors";
    }
}
