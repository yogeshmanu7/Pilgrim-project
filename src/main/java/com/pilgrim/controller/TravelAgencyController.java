package com.pilgrim.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.pilgrim.entity.*;
import com.pilgrim.enums.*;
import com.pilgrim.service.OtpService;
import com.pilgrim.service.TravelAgencyService;
import com.pilgrim.util.FileUploadUtil;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/pilgrim/travel/agency")
public class TravelAgencyController {

    @Autowired private TravelAgencyService agencyService;
    @Autowired private OtpService otpService;

    @GetMapping("/register")
    public String showRegister() {
        return "travel/agency-register";
    }

    @PostMapping("/register")
    public String register(@RequestParam String email,
                           @RequestParam String mobile,
                           @RequestParam String password,
                           HttpSession session,
                           Model model) {

        String otp = otpService.sendOtp(email);

        session.setAttribute("pendingEmail", email);
        session.setAttribute("pendingMobile", mobile);
        session.setAttribute("pendingPassword", password);

        model.addAttribute("email", email);
        return "travel/agency-otp-verify";
    }

    @PostMapping("/verify-otp")
    public String verifyOtp(@RequestParam String email,
                            @RequestParam String otp,
                            HttpSession session,
                            Model model) {

        boolean valid = otpService.verifyOtp(email, otp);

        if (!valid) {
            model.addAttribute("error", "Invalid OTP");
            model.addAttribute("email", email);
            return "travel/agency-otp-verify";
        }

        TravelAgency existing = agencyService.findByEmail(email);
        if (existing != null) {
            session.setAttribute("agencyId", existing.getId());
            return "redirect:/pilgrim/travel/agency/personal-details";
        }

        TravelAgency agency = new TravelAgency();
        agency.setEmail((String) session.getAttribute("pendingEmail"));
        agency.setMobile((String) session.getAttribute("pendingMobile"));
        agency.setPassword((String) session.getAttribute("pendingPassword"));
        agency.setApprovalStatus(ApprovalStatus.PENDING);
        agency.setActive(false);

        agencyService.saveAgency(agency);

        session.setAttribute("agencyId", agency.getId());
        return "redirect:/pilgrim/travel/agency/personal-details";
    }

    @GetMapping("/personal-details")
    public String personalPage(HttpSession session, Model model) {
        model.addAttribute("agencyId", session.getAttribute("agencyId"));
        model.addAttribute("businessOptions", BusinessBackground.values());
        model.addAttribute("msmeOptions", YesNo.values());
        return "travel/agency-personal-details";
    }

    @PostMapping("/personal-details")
    public String savePersonal(@ModelAttribute TravelAgencyPersonal personal, HttpSession session) {
        personal.setAgencyId((Long) session.getAttribute("agencyId"));
        agencyService.savePersonalDetails(personal);
        return "redirect:/pilgrim/travel/agency/bank-details";
    }

    @GetMapping("/bank-details")
    public String bankPage(HttpSession session, Model model) {
        model.addAttribute("agencyId", session.getAttribute("agencyId"));
        model.addAttribute("accountTypes", BankAccountType.values());
        return "travel/agency-bank-details";
    }

    @PostMapping("/bank-details")
    public String saveBank(@ModelAttribute TravelAgencyBank bank, HttpSession session) {
        bank.setAgencyId((Long) session.getAttribute("agencyId"));
        agencyService.saveBankDetails(bank);
        return "redirect:/pilgrim/travel/agency/gst-details";
    }

    @GetMapping("/gst-details")
    public String gstPage(HttpSession session, Model model) {
        model.addAttribute("agencyId", session.getAttribute("agencyId"));
        model.addAttribute("headOfficeOptions", YesNo.values());
        model.addAttribute("gstStatuses", YesNo.values());
        return "travel/agency-gst-details";
    }

    @PostMapping("/gst-details")
    public String saveGst(@ModelAttribute TravelAgencyGST gst, HttpSession session) {
        gst.setAgencyId((Long) session.getAttribute("agencyId"));
        agencyService.saveGstDetails(gst);
        return "redirect:/pilgrim/travel/agency/documents";
    }

    @GetMapping("/documents")
    public String documentsPage(HttpSession session, Model model) {
        model.addAttribute("agencyId", session.getAttribute("agencyId"));
        return "travel/agency-documents";
    }

    @PostMapping("/documents")
    public String saveDocuments(@RequestParam("cancelledCheque") MultipartFile cancelledCheque,
                                @RequestParam("panCard") MultipartFile panCard,
                                @RequestParam("gstCertificate") MultipartFile gstCertificate,
                                @RequestParam(value = "msmeDoc", required = false) MultipartFile msmeDoc,
                                @RequestParam("idProof") MultipartFile idProof,
                                @RequestParam("coiDoc") MultipartFile coiDoc,
                                @RequestParam(value = "declaration", required = false) String declaration,
                                HttpSession session,
                                Model model) {
        try {
            Long agencyId = (Long) session.getAttribute("agencyId");

            TravelAgencyDocuments docs = agencyService.findDocumentsByAgencyId(agencyId);
            if (docs == null) {
                docs = new TravelAgencyDocuments();
                docs.setAgencyId(agencyId);
            }

            if (cancelledCheque != null && !cancelledCheque.isEmpty()) {
                docs.setCancelledCheque(FileUploadUtil.saveFile(cancelledCheque));
            }
            if (panCard != null && !panCard.isEmpty()) {
                docs.setPanCard(FileUploadUtil.saveFile(panCard));
            }
            if (gstCertificate != null && !gstCertificate.isEmpty()) {
                docs.setGstCertificate(FileUploadUtil.saveFile(gstCertificate));
            }
            if (msmeDoc != null && !msmeDoc.isEmpty()) {
                docs.setMsmeDoc(FileUploadUtil.saveFile(msmeDoc));
            }
            if (idProof != null && !idProof.isEmpty()) {
                docs.setIdProof(FileUploadUtil.saveFile(idProof));
            }
            if (coiDoc != null && !coiDoc.isEmpty()) {
                docs.setCoiDoc(FileUploadUtil.saveFile(coiDoc));
            }

            docs.setDeclaration(declaration != null);

            agencyService.saveDocuments(docs);

            return "redirect:/pilgrim/travel/agency/success";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Document upload failed: " + e.getMessage());
            return "travel/agency-documents";
        }
    }

    @GetMapping("/login")
    public String showLogin() {
        return "travel/agency-login";
    }

    @PostMapping("/login")
    public String doLogin(@RequestParam String emailOrMobile,
                          @RequestParam String password,
                          HttpSession session,
                          Model model) {
        TravelAgency agency = agencyService.login(emailOrMobile, password);

        if (agency == null) {
            model.addAttribute("error", "Invalid credentials.");
            return "travel/agency-login";
        }

        if (!Boolean.TRUE.equals(agency.getActive())) {
            session.setAttribute("agencyId", agency.getId());
            return "redirect:/pilgrim/travel/agency/personal-details";
        }

        session.setAttribute("agency", agency);
        return "redirect:/pilgrim/travel/agency/dashboard";
    }

    @GetMapping("/forgot-password")
    public String showForgot() {
        return "travel/agency-forgot-password";
    }

    @PostMapping("/forgot-password/send-otp")
    public String sendForgotOtp(@RequestParam String email, HttpSession session, Model model) {
        TravelAgency agency = agencyService.findByEmail(email);
        if (agency == null) {
            model.addAttribute("error", "No agency found with this email.");
            return "travel/agency-forgot-password";
        }

        String otp = otpService.sendOtp(email);
        session.setAttribute("forgotEmail", email);
        session.setAttribute("forgotOtp", otp);

        model.addAttribute("email", email);
        return "travel/agency-reset-password";
    }

    @PostMapping("/forgot-password/verify")
    public String verifyForgotOtp(@RequestParam String email,
                                  @RequestParam String otp,
                                  @RequestParam String newPassword,
                                  HttpSession session,
                                  Model model) {

        String sessionOtp = (String) session.getAttribute("forgotOtp");
        String sessionEmail = (String) session.getAttribute("forgotEmail");

        if (!email.equals(sessionEmail) || !otpService.verifyOtp(email, otp)) {
            model.addAttribute("error", "Invalid OTP.");
            model.addAttribute("email", email);
            return "travel/agency-reset-password";
        }

        boolean success = agencyService.resetPassword(email, newPassword);
        if (!success) {
            model.addAttribute("error", "Password reset failed.");
            return "travel/agency-reset-password";
        }

        otpService.sendEmail(email, "Password Reset Successful",
                "Your password has been updated successfully. Please login with your new password.");

        model.addAttribute("success", "Password updated. Please login.");
        return "travel/agency-login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/pilgrim/travel/agency/login";
    }

    @GetMapping("/success")
    public String successPage() {
        return "travel/agency-success";
    }
}

