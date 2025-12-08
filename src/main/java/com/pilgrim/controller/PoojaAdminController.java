package com.pilgrim.controller;

import com.pilgrim.entity.Admin;
import com.pilgrim.entity.PoojaOrder;
import com.pilgrim.entity.PoojaItem;
import com.pilgrim.entity.Vendor;
import com.pilgrim.service.PoojaAdminService;
import com.pilgrim.service.PoojaOrderService;
import com.pilgrim.service.PoojaItemService;
import com.pilgrim.service.PoojaVendorService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/pooja/admin")
public class PoojaAdminController {

    @Autowired
    private PoojaAdminService adminService;

    @Autowired
    private PoojaVendorService vendorService;

    @Autowired
    private PoojaItemService poojaItemService;

    @Autowired
    private PoojaOrderService orderService;

    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        model.addAttribute("admin", new Admin());
        return "pooja/admin/register";
    }

    @PostMapping("/register")
    public String register(@ModelAttribute Admin admin, Model model) {
        try {
            adminService.createAdmin(admin);
            model.addAttribute("success", "Admin registration successful! Please login.");
            return "pooja/admin/register";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "pooja/admin/register";
        }
    }

    @GetMapping("/login")
    public String showLoginForm() {
        return "pooja/admin/login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String email, @RequestParam String password,
                       HttpSession session, Model model) {
        try {
            var adminOpt = adminService.login(email, password);
            if (adminOpt.isPresent()) {
                session.setAttribute("poojaAdmin", adminOpt.get());
                return "redirect:/pooja/admin/dashboard";
            } else {
                model.addAttribute("error", "Invalid credentials");
                return "pooja/admin/login";
            }
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "pooja/admin/login";
        }
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        Admin admin = (Admin) session.getAttribute("poojaAdmin");
        if (admin == null) {
            return "redirect:/pooja/admin/login";
        }
        
        List<Vendor> pendingVendors = vendorService.getPendingVendors();
        List<PoojaItem> allItems = poojaItemService.getAllItems();
        List<PoojaOrder> allOrders = orderService.getAllOrders();
        
        model.addAttribute("pendingVendorsCount", pendingVendors.size());
        model.addAttribute("totalItems", allItems.size());
        model.addAttribute("totalOrders", allOrders.size());
        model.addAttribute("admin", admin);
        
        return "pooja/admin/dashboard";
    }

    @GetMapping("/vendors")
    public String listVendors(HttpSession session, Model model) {
        Admin admin = (Admin) session.getAttribute("poojaAdmin");
        if (admin == null) {
            return "redirect:/pooja/admin/login";
        }
        List<Vendor> vendors = vendorService.getAllVendors();
        model.addAttribute("vendors", vendors);
        return "pooja/admin/vendors";
    }

    @GetMapping("/vendors/pending")
    public String listPendingVendors(HttpSession session, Model model) {
        Admin admin = (Admin) session.getAttribute("poojaAdmin");
        if (admin == null) {
            return "redirect:/pooja/admin/login";
        }
        List<Vendor> pendingVendors = vendorService.getPendingVendors();
        model.addAttribute("vendors", pendingVendors);
        return "pooja/admin/pending-vendors";
    }

    @PostMapping("/vendors/approve/{id}")
    public String approveVendor(@PathVariable Long id, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("poojaAdmin");
        if (admin == null) {
            return "redirect:/pooja/admin/login";
        }
        vendorService.approveVendor(id);
        return "redirect:/pooja/admin/vendors/pending";
    }

    @PostMapping("/vendors/reject/{id}")
    public String rejectVendor(@PathVariable Long id, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("poojaAdmin");
        if (admin == null) {
            return "redirect:/pooja/admin/login";
        }
        vendorService.rejectVendor(id);
        return "redirect:/pooja/admin/vendors/pending";
    }

    @GetMapping("/items")
    public String listItems(HttpSession session, Model model) {
        Admin admin = (Admin) session.getAttribute("poojaAdmin");
        if (admin == null) {
            return "redirect:/pooja/admin/login";
        }
        List<PoojaItem> items = poojaItemService.getAllItems();
        model.addAttribute("items", items);
        return "pooja/admin/items";
    }

    @PostMapping("/items/block/{id}")
    public String blockItem(@PathVariable Long id, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("poojaAdmin");
        if (admin == null) {
            return "redirect:/pooja/admin/login";
        }
        var itemOpt = poojaItemService.getItemById(id);
        if (itemOpt.isPresent()) {
            PoojaItem item = itemOpt.get();
            item.setStatus(PoojaItem.ItemStatus.BLOCKED);
            poojaItemService.updateItem(id, item);
        }
        return "redirect:/pooja/admin/items";
    }

    @GetMapping("/orders")
    public String listOrders(HttpSession session, Model model) {
        Admin admin = (Admin) session.getAttribute("poojaAdmin");
        if (admin == null) {
            return "redirect:/pooja/admin/login";
        }
        List<PoojaOrder> orders = orderService.getAllOrders();
        model.addAttribute("orders", orders);
        return "pooja/admin/orders";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/pooja/admin/login";
    }
}

