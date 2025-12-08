package com.pilgrim.controller;

import com.pilgrim.entity.Scholar;
import com.pilgrim.entity.ScholarBooking;
import com.pilgrim.entity.ScholarChat;
import com.pilgrim.entity.User;
import com.pilgrim.enums.ScholarBookingStatus;
import com.pilgrim.enums.ScholarType;
import com.pilgrim.service.ScholarBookingService;
import com.pilgrim.service.ScholarChatService;
import com.pilgrim.service.ScholarPaymentService;
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

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.UUID;

@Controller
@RequestMapping("/scholar")
public class ScholarController {
    
    @Autowired
    private ScholarService scholarService;
    
    @Autowired
    private ScholarBookingService bookingService;
    
    @Autowired
    private ScholarChatService chatService;
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private com.pilgrim.repository.UserRepository userRepository;
    
    @Autowired
    private ScholarPaymentService paymentService;
    
    @Autowired
    private com.pilgrim.service.ScholarReviewService reviewService;
    
    @RequestMapping(value = "/dashboard", method = RequestMethod.GET)
    public String dashboard(HttpServletRequest request, HttpSession session, Model model) {
        User user = (User) session.getAttribute("userSession");
        if (user == null) {
            return "redirect:/scholar/login";
        }
        
        Scholar scholar = scholarService.findByUserId(user.getId());
        if (scholar == null) {
            return "redirect:/scholar/login";
        }
        
        User scholarUser = scholar.getUser();
        List<ScholarBooking> bookings = bookingService.findByScholar(scholar);
        
        // Get all unique customers who have CONFIRMED bookings with this scholar
        Set<User> customers = new HashSet<>();
        for (ScholarBooking booking : bookings) {
            if (booking.getStatus() == ScholarBookingStatus.CONFIRMED) {
                customers.add(booking.getCustomer());
            }
        }
        
        // Get unread messages
        List<ScholarChat> unreadMessages = chatService.getUnreadMessages(scholarUser);
        
        // Generate video call link if not exists
        if (scholar.getVideoCallLink() == null || scholar.getVideoCallLink().isEmpty()) {
            scholar.setVideoCallLink("https://meet.pilgrim.com/" + UUID.randomUUID().toString());
            scholarService.save(scholar);
        }
        
        // Initialize isAvailable if null
        if (scholar.getIsAvailable() == null) {
            scholar.setIsAvailable(true);
            scholarService.save(scholar);
        }
        
        model.addAttribute("scholar", scholar);
        model.addAttribute("bookings", bookings);
        model.addAttribute("customers", new ArrayList<>(customers));
        model.addAttribute("unreadMessages", unreadMessages);
        
        // Route to appropriate dashboard based on scholar type
        if (scholar.getType() == ScholarType.ASTROLOGER) {
            return "scholar/AstrologerDashboard";
        } else {
            return "scholar/ScholarDashboard";
        }
    }
    
    @RequestMapping(value = "/chat", method = RequestMethod.GET)
    public String showChat(@RequestParam Long customerId, @RequestParam(required = false) Long bookingId,
            HttpServletRequest request, HttpSession session, Model model) {
        User user = (User) session.getAttribute("userSession");
        if (user == null) {
            return "redirect:/scholar/login";
        }
        
        Scholar scholar = scholarService.findByUserId(user.getId());
        User customer = userRepository.findById(customerId).orElse(null);
        
        if (scholar == null || customer == null) {
            return "redirect:/scholar/dashboard";
        }
        
        // Validate that there is a confirmed booking between scholar and customer
        List<ScholarBooking> confirmedBookings = bookingService.findByScholar(scholar);
        boolean hasConfirmedBooking = false;
        ScholarBooking activeBooking = null;
        
        for (ScholarBooking booking : confirmedBookings) {
            if (booking.getCustomer().getId().equals(customerId) && 
                booking.getStatus() == ScholarBookingStatus.CONFIRMED) {
                hasConfirmedBooking = true;
                if (bookingId != null && booking.getId().equals(bookingId)) {
                    activeBooking = booking;
                } else if (activeBooking == null) {
                    activeBooking = booking;
                }
            }
        }
        
        if (!hasConfirmedBooking) {
            model.addAttribute("error", "Chat is only available for confirmed bookings. Please accept the booking first.");
            return "redirect:/scholar/dashboard";
        }
        
        List<ScholarChat> conversation = chatService.getConversation(scholar.getUser(), customer);
        
        model.addAttribute("scholar", scholar);
        model.addAttribute("customer", customer);
        model.addAttribute("messages", conversation);
        model.addAttribute("booking", activeBooking);
        
        return "scholar/chat";
    }
    
    @RequestMapping(value = "/chat/send", method = RequestMethod.POST)
    public String sendMessage(
            @RequestParam Long customerId,
            @RequestParam(required = false) Long bookingId,
            @RequestParam String message,
            HttpServletRequest request,
            HttpSession session) {
        
        User user = (User) session.getAttribute("userSession");
        if (user == null) {
            return "redirect:/scholar/login";
        }
        
        Scholar scholar = scholarService.findByUserId(user.getId());
        User customer = userRepository.findById(customerId).orElse(null);
        
        if (scholar == null || customer == null) {
            return "redirect:/scholar/dashboard";
        }
        
        // Validate confirmed booking
        List<ScholarBooking> confirmedBookings = bookingService.findByScholar(scholar);
        boolean hasConfirmedBooking = false;
        ScholarBooking booking = null;
        
        for (ScholarBooking b : confirmedBookings) {
            if (b.getCustomer().getId().equals(customerId) && 
                b.getStatus() == ScholarBookingStatus.CONFIRMED) {
                hasConfirmedBooking = true;
                if (bookingId != null && b.getId().equals(bookingId)) {
                    booking = b;
                    break;
                } else if (booking == null) {
                    booking = b;
                }
            }
        }
        
        if (!hasConfirmedBooking) {
            return "redirect:/scholar/dashboard";
        }
        
        chatService.sendMessage(scholar.getUser(), customer, booking, message);
        
        String contextPath = request.getContextPath();
        return "redirect:" + contextPath + "/scholar/chat?customerId=" + customerId + (bookingId != null ? "&bookingId=" + bookingId : "");
    }
    
    @RequestMapping(value = "/video-call", method = RequestMethod.GET)
    public String videoCall(@RequestParam(required = false) Long bookingId, HttpServletRequest request, HttpSession session, Model model) {
        User user = (User) session.getAttribute("userSession");
        if (user == null) {
            return "redirect:/scholar/login";
        }
        
        Scholar scholar = scholarService.findByUserId(user.getId());
        if (scholar == null) {
            return "redirect:/scholar/login";
        }
        
        ScholarBooking booking = null;
        if (bookingId != null) {
            booking = bookingService.findById(bookingId).orElse(null);
            // Validate booking is confirmed and belongs to this scholar
            if (booking == null || !booking.getScholar().getId().equals(scholar.getId()) ||
                booking.getStatus() != ScholarBookingStatus.CONFIRMED) {
                model.addAttribute("error", "Video call is only available for confirmed bookings.");
                return "redirect:/scholar/dashboard";
            }
        }
        
        String videoCallLink = booking != null && booking.getVideoCallLink() != null 
            ? booking.getVideoCallLink() 
            : scholar.getVideoCallLink();
        
        model.addAttribute("scholar", scholar);
        model.addAttribute("booking", booking);
        model.addAttribute("videoCallLink", videoCallLink);
        
        return "scholar/video-call";
    }
    
    @RequestMapping(value = "/booking/accept", method = RequestMethod.POST)
    public String acceptBooking(@RequestParam Long bookingId, HttpServletRequest request, HttpSession session) {
        bookingService.updateStatus(bookingId, ScholarBookingStatus.CONFIRMED);
        return "redirect:/scholar/dashboard";
    }
    
    @RequestMapping(value = "/booking/reject", method = RequestMethod.POST)
    public String rejectBooking(@RequestParam Long bookingId, HttpServletRequest request, HttpSession session) {
        bookingService.updateStatus(bookingId, ScholarBookingStatus.REJECTED);
        return "redirect:/scholar/dashboard";
    }
    
    @RequestMapping(value = "/booking/complete", method = RequestMethod.POST)
    public String completeBooking(@RequestParam Long bookingId, HttpServletRequest request, HttpSession session) {
        bookingService.updateStatus(bookingId, ScholarBookingStatus.COMPLETED);
        return "redirect:/scholar/dashboard";
    }
    
    @RequestMapping(value = "/earnings", method = RequestMethod.GET)
    public String earnings(HttpServletRequest request, HttpSession session, Model model) {
        User user = (User) session.getAttribute("userSession");
        if (user == null) {
            return "redirect:/scholar/login";
        }
        
        Scholar scholar = scholarService.findByUserId(user.getId());
        if (scholar == null) {
            return "redirect:/scholar/login";
        }
        
        List<com.pilgrim.entity.ScholarPayment> payments = paymentService.findByScholar(scholar);
        java.math.BigDecimal totalEarnings = paymentService.getTotalEarnings(scholar);
        java.math.BigDecimal pendingEarnings = paymentService.getPendingEarnings(scholar);
        
        model.addAttribute("scholar", scholar);
        model.addAttribute("payments", payments);
        model.addAttribute("totalEarnings", totalEarnings);
        model.addAttribute("pendingEarnings", pendingEarnings);
        
        return "scholar/earnings";
    }
    
    @RequestMapping(value = "/availability", method = RequestMethod.POST)
    public String toggleAvailability(HttpServletRequest request, HttpSession session) {
        User user = (User) session.getAttribute("userSession");
        if (user == null) {
            return "redirect:/scholar/login";
        }
        
        Scholar scholar = scholarService.findByUserId(user.getId());
        if (scholar != null) {
            scholar.setIsAvailable(scholar.getIsAvailable() == null || !scholar.getIsAvailable());
            scholarService.save(scholar);
        }
        
        return "redirect:/scholar/dashboard";
    }
    
    @RequestMapping(value = "/profile/edit", method = RequestMethod.GET)
    public String showProfileEdit(HttpServletRequest request, HttpSession session, Model model) {
        User user = (User) session.getAttribute("userSession");
        if (user == null) {
            return "redirect:/scholar/login";
        }
        
        Scholar scholar = scholarService.findByUserId(user.getId());
        if (scholar == null) {
            return "redirect:/scholar/login";
        }
        
        model.addAttribute("scholar", scholar);
        model.addAttribute("specializations", com.pilgrim.enums.ScholarSpecialization.values());
        
        return "scholar/edit-profile";
    }
    
    @RequestMapping(value = "/reviews", method = RequestMethod.GET)
    public String viewReviews(HttpServletRequest request, HttpSession session, Model model) {
        User user = (User) session.getAttribute("userSession");
        if (user == null) {
            return "redirect:/scholar/login";
        }
        
        Scholar scholar = scholarService.findByUserId(user.getId());
        if (scholar == null) {
            return "redirect:/scholar/login";
        }
        
        List<com.pilgrim.entity.ScholarReview> reviews = reviewService.findByScholar(scholar);
        model.addAttribute("scholar", scholar);
        model.addAttribute("reviews", reviews);
        
        return "scholar/reviews";
    }
    
    @RequestMapping(value = "/profile/edit", method = RequestMethod.POST)
    public String updateProfile(
            @RequestParam(required = false) Integer experienceYears,
            @RequestParam(required = false) String[] specializations,
            @RequestParam(required = false) String languages,
            @RequestParam(required = false) String serviceAreas,
            @RequestParam(required = false) Double basePrice,
            HttpServletRequest request,
            HttpSession session,
            Model model) {
        
        User user = (User) session.getAttribute("userSession");
        if (user == null) {
            return "redirect:/scholar/login";
        }
        
        Scholar scholar = scholarService.findByUserId(user.getId());
        if (scholar == null) {
            return "redirect:/scholar/login";
        }
        
        if (experienceYears != null) scholar.setExperienceYears(experienceYears);
        if (serviceAreas != null) scholar.setServiceAreas(serviceAreas);
        if (basePrice != null) scholar.setBasePrice(java.math.BigDecimal.valueOf(basePrice));
        
        if (specializations != null) {
            java.util.List<com.pilgrim.enums.ScholarSpecialization> specList = new java.util.ArrayList<>();
            for (String spec : specializations) {
                try {
                    specList.add(com.pilgrim.enums.ScholarSpecialization.valueOf(spec));
                } catch (IllegalArgumentException e) {
                    // Skip invalid
                }
            }
            scholar.setSpecializations(specList);
        }
        
        if (languages != null && !languages.trim().isEmpty()) {
            java.util.List<String> langList = new java.util.ArrayList<>();
            String[] langArray = languages.split(",");
            for (String lang : langArray) {
                langList.add(lang.trim());
            }
            scholar.setLanguages(langList);
        }
        
        scholarService.save(scholar);
        
        return "redirect:/scholar/dashboard";
    }
}

