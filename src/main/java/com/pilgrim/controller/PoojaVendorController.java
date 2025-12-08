package com.pilgrim.controller;

import com.pilgrim.entity.PoojaItem;
import com.pilgrim.entity.Vendor;
import com.pilgrim.service.PoojaItemService;
import com.pilgrim.service.PoojaVendorService;
import com.pilgrim.service.FileStorageService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Controller
@RequestMapping("/pooja/vendor")
public class PoojaVendorController {

    @Autowired
    private PoojaVendorService vendorService;

    @Autowired
    private PoojaItemService poojaItemService;

    @Autowired
    private FileStorageService fileStorageService;

    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        model.addAttribute("vendor", new Vendor());
        return "pooja/vendor/register";
    }

    @PostMapping("/register")
    public String register(@ModelAttribute Vendor vendor, Model model) {
        try {
            vendorService.registerVendor(vendor);
            model.addAttribute("success", "Registration successful! Please wait for admin approval.");
            return "pooja/vendor/register";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "pooja/vendor/register";
        }
    }

    @GetMapping("/login")
    public String showLoginForm() {
        return "pooja/vendor/login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String email, @RequestParam String password,
                       HttpSession session, Model model) {
        try {
            var vendorOpt = vendorService.login(email, password);
            if (vendorOpt.isPresent()) {
                session.setAttribute("poojaVendor", vendorOpt.get());
                return "redirect:/pooja/vendor/dashboard";
            } else {
                model.addAttribute("error", "Invalid credentials or account not approved");
                return "pooja/vendor/login";
            }
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "pooja/vendor/login";
        }
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        Vendor vendor = (Vendor) session.getAttribute("poojaVendor");
        if (vendor == null) {
            return "redirect:/pooja/vendor/login";
        }
        List<PoojaItem> items = poojaItemService.getVendorItems(vendor.getId());
        model.addAttribute("vendor", vendor);
        model.addAttribute("items", items);
        return "pooja/vendor/dashboard";
    }

    @GetMapping("/profile")
    public String showProfile(HttpSession session, Model model) {
        Vendor vendor = (Vendor) session.getAttribute("poojaVendor");
        if (vendor == null) {
            return "redirect:/pooja/vendor/login";
        }
        model.addAttribute("vendor", vendor);
        return "pooja/vendor/profile";
    }

    @PostMapping("/profile/update")
    public String updateProfile(@ModelAttribute Vendor vendorDetails, HttpSession session) {
        Vendor vendor = (Vendor) session.getAttribute("poojaVendor");
        if (vendor == null) {
            return "redirect:/pooja/vendor/login";
        }
        Vendor updated = vendorService.updateVendor(vendor.getId(), vendorDetails);
        session.setAttribute("poojaVendor", updated);
        return "redirect:/pooja/vendor/profile";
    }

    @GetMapping("/change-password")
    public String showChangePassword() {
        return "pooja/vendor/change-password";
    }

    @PostMapping("/change-password")
    public String changePassword(@RequestParam String oldPassword, @RequestParam String newPassword,
                                HttpSession session, Model model) {
        Vendor vendor = (Vendor) session.getAttribute("poojaVendor");
        if (vendor == null) {
            return "redirect:/pooja/vendor/login";
        }
        try {
            Vendor updated = vendorService.changePassword(vendor.getId(), oldPassword, newPassword);
            session.setAttribute("poojaVendor", updated);
            model.addAttribute("success", "Password changed successfully");
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
        }
        return "pooja/vendor/change-password";
    }

    @GetMapping("/items")
    public String listItems(HttpSession session, Model model) {
        Vendor vendor = (Vendor) session.getAttribute("poojaVendor");
        if (vendor == null) {
            return "redirect:/pooja/vendor/login";
        }
        List<PoojaItem> items = poojaItemService.getVendorItems(vendor.getId());
        model.addAttribute("items", items);
        return "pooja/vendor/items";
    }

    @GetMapping("/items/add")
    public String showAddItemForm(Model model) {
        model.addAttribute("item", new PoojaItem());
        return "pooja/vendor/add-item";
    }

    @PostMapping("/items/add")
    public String addItem(@ModelAttribute PoojaItem item, @RequestParam("imageFile") MultipartFile imageFile,
                         HttpSession session, Model model) {
        Vendor vendor = (Vendor) session.getAttribute("poojaVendor");
        if (vendor == null) {
            return "redirect:/pooja/vendor/login";
        }
        try {
            if (!imageFile.isEmpty()) {
                String imagePath = fileStorageService.storeFile(imageFile, "pooja-items");
                item.setImagePath("/uploads/" + imagePath);
            }
            if (item.getDeliveryStates() == null || item.getDeliveryStates().isEmpty()) {
                item.setDeliveryStates("Karnataka,Bangalore");
            }
            poojaItemService.addItem(vendor.getId(), item);
            return "redirect:/pooja/vendor/items";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "pooja/vendor/add-item";
        }
    }

    @GetMapping("/items/edit/{id}")
    public String showEditItemForm(@PathVariable Long id, HttpSession session, Model model) {
        Vendor vendor = (Vendor) session.getAttribute("poojaVendor");
        if (vendor == null) {
            return "redirect:/pooja/vendor/login";
        }
        var itemOpt = poojaItemService.getItemById(id);
        if (itemOpt.isPresent() && itemOpt.get().getVendor().getId().equals(vendor.getId())) {
            model.addAttribute("item", itemOpt.get());
            return "pooja/vendor/edit-item";
        }
        return "redirect:/pooja/vendor/items";
    }

    @PostMapping("/items/edit/{id}")
    public String updateItem(@PathVariable Long id, @ModelAttribute PoojaItem itemDetails,
                            @RequestParam(value = "imageFile", required = false) MultipartFile imageFile,
                            HttpSession session, Model model) {
        Vendor vendor = (Vendor) session.getAttribute("poojaVendor");
        if (vendor == null) {
            return "redirect:/pooja/vendor/login";
        }
        try {
            if (imageFile != null && !imageFile.isEmpty()) {
                String imagePath = fileStorageService.storeFile(imageFile, "pooja-items");
                itemDetails.setImagePath("/uploads/" + imagePath);
            }
            if (itemDetails.getDeliveryStates() == null || itemDetails.getDeliveryStates().isEmpty()) {
                itemDetails.setDeliveryStates("Karnataka,Bangalore");
            }
            poojaItemService.updateItem(id, itemDetails);
            return "redirect:/pooja/vendor/items";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "pooja/vendor/edit-item";
        }
    }

    @GetMapping("/items/delete/{id}")
    public String deleteItem(@PathVariable Long id, HttpSession session) {
        Vendor vendor = (Vendor) session.getAttribute("poojaVendor");
        if (vendor == null) {
            return "redirect:/pooja/vendor/login";
        }
        poojaItemService.deleteItem(id);
        return "redirect:/pooja/vendor/items";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/pooja/vendor/login";
    }
}

