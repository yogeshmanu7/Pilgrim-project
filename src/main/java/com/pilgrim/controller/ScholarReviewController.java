package com.pilgrim.controller;

import com.pilgrim.entity.Scholar;
import com.pilgrim.entity.ScholarBooking;
import com.pilgrim.entity.ScholarReview;
import com.pilgrim.entity.User;
import com.pilgrim.enums.ScholarBookingStatus;
import com.pilgrim.service.ScholarBookingService;
import com.pilgrim.service.ScholarReviewService;
import com.pilgrim.service.ScholarService;
import com.pilgrim.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/customer/scholar/review")
public class ScholarReviewController {
    
    @Autowired
    private ScholarReviewService reviewService;
    
    @Autowired
    private ScholarBookingService bookingService;
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private ScholarService scholarService;
    
    @RequestMapping(value = "/submit", method = RequestMethod.GET)
    public String showReviewForm(
            @RequestParam Long bookingId,
            HttpServletRequest request,
            HttpSession session,
            Model model) {
        
        String contextPath = request.getContextPath();
        model.addAttribute("contextPath", contextPath);
        
        User user = (User) session.getAttribute("userSession");
        if (user == null) {
            return "redirect:/customer/login";
        }
        
        ScholarBooking booking = bookingService.findById(bookingId).orElse(null);
        if (booking == null || !booking.getCustomer().getId().equals(user.getId())) {
            return "redirect:/customer/scholar/dashboard";
        }
        
        // Check if booking is completed
        if (booking.getStatus() != ScholarBookingStatus.COMPLETED) {
            model.addAttribute("error", "You can only review completed bookings");
            return "redirect:/customer/scholar/dashboard";
        }
        
        // Check if review already exists
        if (reviewService.hasReviewed(booking)) {
            ScholarReview existingReview = reviewService.findByBooking(booking);
            model.addAttribute("review", existingReview);
            model.addAttribute("editMode", true);
        }
        
        model.addAttribute("booking", booking);
        model.addAttribute("scholar", booking.getScholar());
        
        return "customer/scholars/review-form";
    }
    
    @RequestMapping(value = "/submit", method = RequestMethod.POST)
    public String submitReview(
            @RequestParam Long bookingId,
            @RequestParam Integer rating,
            @RequestParam(required = false) String comment,
            HttpServletRequest request,
            HttpSession session,
            Model model) {
        
        String contextPath = request.getContextPath();
        model.addAttribute("contextPath", contextPath);
        
        User customer = (User) session.getAttribute("userSession");
        ScholarBooking booking = bookingService.findById(bookingId).orElse(null);
        
        if (customer == null || booking == null || !booking.getCustomer().getId().equals(customer.getId())) {
            return "redirect:/customer/scholar/dashboard";
        }
        
        try {
            if (reviewService.hasReviewed(booking)) {
                ScholarReview existingReview = reviewService.findByBooking(booking);
                reviewService.updateReview(existingReview.getId(), rating, comment);
                model.addAttribute("message", "Review updated successfully!");
            } else {
                reviewService.createReview(customer, booking.getScholar(), booking, rating, comment);
                model.addAttribute("message", "Review submitted successfully!");
            }
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("booking", booking);
            model.addAttribute("scholar", booking.getScholar());
            return "customer/scholars/review-form";
        }
        
        return "redirect:/customer/scholar/dashboard";
    }
    
    @RequestMapping(value = "/scholar", method = RequestMethod.GET)
    public String viewScholarReviews(
            @RequestParam Long scholarId,
            HttpServletRequest request,
            Model model) {
        
        String contextPath = request.getContextPath();
        model.addAttribute("contextPath", contextPath);
        
        Scholar scholar = scholarService.findById(scholarId).orElse(null);
        if (scholar == null) {
            return "redirect:/";
        }
        
        List<ScholarReview> reviews = reviewService.findByScholar(scholar);
        model.addAttribute("scholar", scholar);
        model.addAttribute("reviews", reviews);
        
        return "customer/scholars/reviews";
    }
}

