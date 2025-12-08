package com.pilgrim.controller;

import com.pilgrim.entity.Admin;
import com.pilgrim.entity.Scholar;
import com.pilgrim.entity.ScholarBooking;
import com.pilgrim.entity.ScholarPayment;
import com.pilgrim.entity.ScholarReview;
import com.pilgrim.enums.ScholarRegistrationStatus;
import com.pilgrim.service.ScholarBookingService;
import com.pilgrim.service.ScholarPaymentService;
import com.pilgrim.service.ScholarReviewService;
import com.pilgrim.service.ScholarService;
import com.pilgrim.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.math.BigDecimal;
import java.util.List;

@Controller
@RequestMapping("/admin/scholars")
public class ScholarAdminController {
    
    @Autowired
    private ScholarService scholarService;
    
    @Autowired
    private ScholarBookingService bookingService;
    
    @Autowired
    private ScholarPaymentService paymentService;
    
    @Autowired
    private ScholarReviewService reviewService;
    
    @Autowired
    private UserService userService;
    
    @RequestMapping(value = "", method = RequestMethod.GET)
    public String manageScholars(HttpSession session, Model model) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        List<Scholar> scholars = scholarService.findAll();
        model.addAttribute("scholars", scholars);
        model.addAttribute("admin", admin);
        
        return "admin/scholars/list";
    }
    
    @RequestMapping(value = "/approve", method = RequestMethod.POST)
    public String approveScholar(@RequestParam Long scholarId, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        scholarService.updateStatus(scholarId, ScholarRegistrationStatus.APPROVED, null);
        return "redirect:/admin/scholars";
    }
    
    @RequestMapping(value = "/reject", method = RequestMethod.POST)
    public String rejectScholar(
            @RequestParam Long scholarId,
            @RequestParam String rejectionReason,
            HttpSession session) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        scholarService.updateStatus(scholarId, ScholarRegistrationStatus.REJECTED, rejectionReason);
        return "redirect:/admin/scholars";
    }
    
    @RequestMapping(value = "/hold", method = RequestMethod.POST)
    public String holdScholar(@RequestParam Long scholarId, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        scholarService.updateStatus(scholarId, ScholarRegistrationStatus.ON_HOLD, null);
        return "redirect:/admin/scholars";
    }
    
    @RequestMapping(value = "/bookings", method = RequestMethod.GET)
    public String manageBookings(HttpSession session, Model model) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        List<ScholarBooking> bookings = bookingService.findAll();
        model.addAttribute("bookings", bookings);
        model.addAttribute("admin", admin);
        
        return "admin/scholars/bookings";
    }
    
    @RequestMapping(value = "/bookings/view/{id}", method = RequestMethod.GET)
    public String viewBooking(@PathVariable Long id, HttpSession session, Model model) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        ScholarBooking booking = bookingService.findById(id).orElse(null);
        if (booking == null) {
            return "redirect:/admin/scholars/bookings";
        }
        
        model.addAttribute("booking", booking);
        model.addAttribute("admin", admin);
        
        return "admin/scholars/booking-details";
    }
    
    @RequestMapping(value = "/payments/settle", method = RequestMethod.GET)
    public String showPaymentSettlements(HttpSession session, Model model) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        List<com.pilgrim.entity.ScholarPayment> pendingPayments = paymentService.findPendingSettlements();
        model.addAttribute("pendingPayments", pendingPayments);
        model.addAttribute("admin", admin);
        
        return "admin/scholars/payment-settlements";
    }
    
    @RequestMapping(value = "/payments/settle", method = RequestMethod.POST)
    public String settlePayment(@RequestParam Long paymentId, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        paymentService.settlePayment(paymentId);
        return "redirect:/admin/scholars/payments/settle";
    }
    
    @RequestMapping(value = "/view/{id}", method = RequestMethod.GET)
    public String viewScholar(@PathVariable Long id, HttpSession session, Model model) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        Scholar scholar = scholarService.findById(id).orElse(null);
        if (scholar == null) {
            return "redirect:/admin/scholars";
        }
        
        // Get scholar statistics
        List<ScholarBooking> bookings = bookingService.findByScholar(scholar);
        List<ScholarPayment> payments = paymentService.findByScholar(scholar);
        List<ScholarReview> reviews = reviewService.findByScholar(scholar);
        
        // Calculate statistics
        long totalBookings = bookings.size();
        long confirmedBookings = bookings.stream()
            .filter(b -> b.getStatus().toString().equals("CONFIRMED"))
            .count();
        long completedBookings = bookings.stream()
            .filter(b -> b.getStatus().toString().equals("COMPLETED"))
            .count();
        
        BigDecimal totalRevenue = payments.stream()
            .filter(p -> p.getStatus().toString().equals("PAID"))
            .map(ScholarPayment::getAmount)
            .reduce(BigDecimal.ZERO, BigDecimal::add);
        
        BigDecimal totalSettled = payments.stream()
            .filter(p -> p.getStatus().toString().equals("SETTLED"))
            .map(ScholarPayment::getScholarAmount)
            .reduce(BigDecimal.ZERO, BigDecimal::add);
        
        BigDecimal pendingSettlement = payments.stream()
            .filter(p -> p.getStatus().toString().equals("PAID") && 
                        (p.getSettlementDate() == null))
            .map(ScholarPayment::getScholarAmount)
            .reduce(BigDecimal.ZERO, BigDecimal::add);
        
        model.addAttribute("scholar", scholar);
        model.addAttribute("bookings", bookings);
        model.addAttribute("payments", payments);
        model.addAttribute("reviews", reviews);
        model.addAttribute("totalBookings", totalBookings);
        model.addAttribute("confirmedBookings", confirmedBookings);
        model.addAttribute("completedBookings", completedBookings);
        model.addAttribute("totalRevenue", totalRevenue);
        model.addAttribute("totalSettled", totalSettled);
        model.addAttribute("pendingSettlement", pendingSettlement);
        model.addAttribute("admin", admin);
        
        return "admin/scholars/view";
    }
    
    @RequestMapping(value = "/payments", method = RequestMethod.GET)
    public String viewAllPayments(HttpSession session, Model model) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        List<ScholarPayment> payments = paymentService.findAll();
        model.addAttribute("payments", payments);
        model.addAttribute("admin", admin);
        
        return "admin/scholars/payments";
    }
    
    @RequestMapping(value = "/reviews", method = RequestMethod.GET)
    public String viewAllReviews(HttpSession session, Model model) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        List<ScholarReview> reviews = reviewService.findAll();
        model.addAttribute("reviews", reviews);
        model.addAttribute("admin", admin);
        
        return "admin/scholars/reviews";
    }
    
    @RequestMapping(value = "/{scholarId}/bookings", method = RequestMethod.GET)
    public String viewScholarBookings(@PathVariable Long scholarId, HttpSession session, Model model) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        Scholar scholar = scholarService.findById(scholarId).orElse(null);
        if (scholar == null) {
            return "redirect:/admin/scholars";
        }
        
        List<ScholarBooking> bookings = bookingService.findByScholar(scholar);
        model.addAttribute("scholar", scholar);
        model.addAttribute("bookings", bookings);
        model.addAttribute("admin", admin);
        
        return "admin/scholars/scholar-bookings";
    }
    
    @RequestMapping(value = "/{scholarId}/payments", method = RequestMethod.GET)
    public String viewScholarPayments(@PathVariable Long scholarId, HttpSession session, Model model) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        Scholar scholar = scholarService.findById(scholarId).orElse(null);
        if (scholar == null) {
            return "redirect:/admin/scholars";
        }
        
        List<ScholarPayment> payments = paymentService.findByScholar(scholar);
        
        // Calculate total revenue
        BigDecimal totalRevenue = payments.stream()
            .filter(p -> p.getStatus().toString().equals("PAID"))
            .map(ScholarPayment::getAmount)
            .reduce(BigDecimal.ZERO, BigDecimal::add);
        
        model.addAttribute("scholar", scholar);
        model.addAttribute("payments", payments);
        model.addAttribute("totalRevenue", totalRevenue);
        model.addAttribute("admin", admin);
        
        return "admin/scholars/scholar-payments";
    }
    
    @RequestMapping(value = "/{scholarId}/reviews", method = RequestMethod.GET)
    public String viewScholarReviews(@PathVariable Long scholarId, HttpSession session, Model model) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        Scholar scholar = scholarService.findById(scholarId).orElse(null);
        if (scholar == null) {
            return "redirect:/admin/scholars";
        }
        
        List<ScholarReview> reviews = reviewService.findByScholar(scholar);
        model.addAttribute("scholar", scholar);
        model.addAttribute("reviews", reviews);
        model.addAttribute("admin", admin);
        
        return "admin/scholars/scholar-reviews";
    }
}

