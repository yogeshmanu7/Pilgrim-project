package com.pilgrim.controller;

import com.pilgrim.entity.*;
import com.pilgrim.service.*;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.math.BigDecimal;

@Controller
@RequestMapping("/pilgrim/temple/donation")
@RequiredArgsConstructor
public class TempleDonationController {
    
    private final TempleDonationService donationService;
    private final TempleService templeService;
    private final com.pilgrim.service.UserService userService;
    
    // Explicit constructor to ensure dependencies are injected
    public TempleDonationController(TempleDonationService donationService, TempleService templeService,
                                    com.pilgrim.service.UserService userService) {
        this.donationService = donationService;
        this.templeService = templeService;
        this.userService = userService;
    }
    
    @GetMapping("/{templeId}")
    public String donationPage(@PathVariable Long templeId, Model model) {
        Temple temple = templeService.findById(templeId)
                .orElseThrow(() -> new RuntimeException("Temple not found"));
        
        model.addAttribute("temple", temple);
        model.addAttribute("donationTypes", TempleDonation.DonationType.values());
        return "donation/form";
    }
    
    @PostMapping("/{templeId}")
    public String makeDonation(@PathVariable Long templeId,
                              @RequestParam String donorName,
                              @RequestParam(required = false) String donorEmail,
                              @RequestParam(required = false) String donorPhone,
                              @RequestParam(required = false) String donorAddress,
                              @RequestParam(required = false) String donorPanNumber,
                              @RequestParam TempleDonation.DonationType donationType,
                              @RequestParam BigDecimal amount,
                              @RequestParam(required = false) String purpose,
                              @RequestParam(required = false) String inMemoryOf,
                              @RequestParam(required = false, defaultValue = "false") boolean isAnonymous,
                              @RequestParam(required = false, defaultValue = "true") boolean receiptRequired,
                              @RequestParam(required = false, defaultValue = "false") boolean is80GApplicable,
                              @RequestParam(required = false) String notes,
                              Authentication authentication,
                              RedirectAttributes redirectAttributes) {
        try {
            Temple temple = templeService.findById(templeId)
                    .orElseThrow(() -> new RuntimeException("Temple not found"));
            
            User user = null;
            if (authentication != null) {
                user = userService.findByEmail(authentication.getName()).orElse(null);
            }
            
            TempleDonation donation = TempleDonation.builder()
                    .user(user)
                    .temple(temple)
                    .donorName(donorName)
                    .donorEmail(donorEmail)
                    .donorPhone(donorPhone)
                    .donorAddress(donorAddress)
                    .donorPanNumber(donorPanNumber)
                    .donationType(donationType)
                    .amount(amount)
                    .purpose(purpose)
                    .inMemoryOf(inMemoryOf)
                    .isAnonymous(isAnonymous)
                    .receiptRequired(receiptRequired)
                    .is80GApplicable(is80GApplicable)
                    .notes(notes)
                    .build();
            
            TempleDonation savedDonation = donationService.createDonation(donation);
            redirectAttributes.addFlashAttribute("success", "Donation recorded! Reference Number: " + savedDonation.getDonationNumber());
            return "redirect:/pilgrim/temple/donation/success/" + savedDonation.getId();
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Donation failed: " + e.getMessage());
            return "redirect:/pilgrim/temple/donation/" + templeId;
        }
    }
    
    @GetMapping("/success/{donationId}")
    public String donationSuccess(@PathVariable Long donationId, Model model) {
        TempleDonation donation = donationService.findById(donationId)
                .orElseThrow(() -> new RuntimeException("Donation not found"));
        
        model.addAttribute("donation", donation);
        return "donation/success";
    }
}

