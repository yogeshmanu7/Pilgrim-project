package com.pilgrim.controller;

import com.pilgrim.entity.Scholar;
import com.pilgrim.entity.ScholarBooking;
import com.pilgrim.entity.ScholarChat;
import com.pilgrim.entity.User;
import com.pilgrim.enums.ScholarBookingStatus;
import com.pilgrim.enums.ScholarRegistrationStatus;
import com.pilgrim.enums.ScholarServiceType;
import com.pilgrim.service.ScholarBookingService;
import com.pilgrim.service.ScholarChatService;
import com.pilgrim.service.ScholarService;
import com.pilgrim.repository.UserRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/customer/scholar")
public class ScholarCustomerController {
    
    @Autowired
    private ScholarService scholarService;
    
    @Autowired
    private ScholarBookingService bookingService;
    
    @Autowired
    private ScholarChatService chatService;
    
    @Autowired
    private UserRepository userRepository;
    
    @RequestMapping(value = "/dashboard", method = RequestMethod.GET)
    public String dashboard(HttpSession session, Model model) {
        User user = (User) session.getAttribute("userSession");
        if (user == null) {
            return "redirect:/customer/login";
        }
        
        List<ScholarBooking> bookings = bookingService.findByCustomer(user);
        model.addAttribute("bookings", bookings);
        model.addAttribute("user", user);
        
        // Get all approved and available scholars for booking
        List<Scholar> allScholars = scholarService.findByStatus(ScholarRegistrationStatus.APPROVED);
        List<Scholar> availableScholars = new ArrayList<>();
        
        for (Scholar scholar : allScholars) {
            // Filter by availability
            if (scholar.getIsAvailable() != null && scholar.getIsAvailable()) {
                availableScholars.add(scholar);
            }
        }
        
        model.addAttribute("scholars", availableScholars);
        
        return "customer/scholars/UserDashboard";
    }
    
    @RequestMapping(value = "/book", method = RequestMethod.GET)
    public String showBookingForm(@RequestParam Long scholarId, HttpSession session, Model model) {
        User user = (User) session.getAttribute("userSession");
        if (user == null) {
            return "redirect:/customer/login";
        }
        
        Scholar scholar = scholarService.findById(scholarId).orElse(null);
        if (scholar == null) {
            return "redirect:/";
        }
        
        model.addAttribute("scholar", scholar);
        return "customer/scholars/booking-form";
    }
    
    @RequestMapping(value = "/book", method = RequestMethod.POST)
    public String processBooking(
            @RequestParam Long scholarId,
            @RequestParam ScholarServiceType serviceType,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime serviceDate,
            @RequestParam(required = false) String serviceLocation,
            @RequestParam String serviceDescription,
            HttpSession session,
            Model model) {
        
        User user = (User) session.getAttribute("userSession");
        if (user == null) {
            return "redirect:/customer/login";
        }
        
        Scholar scholar = scholarService.findById(scholarId).orElse(null);
        
        if (scholar == null) {
            model.addAttribute("error", "Invalid request");
            return "customer/scholars/booking-form";
        }
        
        BigDecimal totalAmount = scholar.getBasePrice();
        ScholarBooking booking = bookingService.createBooking(
            user, scholar, serviceType, serviceDate, serviceLocation, 
            serviceDescription, totalAmount);
        
        // Redirect to payment page instead of dashboard
        return "redirect:/customer/scholar/payment/initiate?bookingId=" + booking.getId();
    }
    
    @RequestMapping(value = "/chat", method = RequestMethod.GET)
    public String showChat(@RequestParam Long scholarId, @RequestParam(required = false) Long bookingId, 
            HttpSession session, Model model) {
        User user = (User) session.getAttribute("userSession");
        if (user == null) {
            return "redirect:/customer/login";
        }
        
        Scholar scholar = scholarService.findById(scholarId).orElse(null);
        
        if (scholar == null) {
            return "redirect:/customer/scholar/dashboard";
        }
        
        // Validate that there is a confirmed booking
        List<ScholarBooking> customerBookings = bookingService.findByCustomer(user);
        boolean hasConfirmedBooking = false;
        ScholarBooking activeBooking = null;
        
        for (ScholarBooking booking : customerBookings) {
            if (booking.getScholar().getId().equals(scholarId) && 
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
            model.addAttribute("error", "Chat is only available for confirmed bookings. Please wait for the scholar to accept your booking.");
            return "redirect:/customer/scholar/dashboard";
        }
        
        List<ScholarChat> conversation = chatService.getConversation(user, scholar.getUser());
        
        model.addAttribute("user", user);
        model.addAttribute("scholar", scholar);
        model.addAttribute("messages", conversation);
        model.addAttribute("booking", activeBooking);
        
        return "customer/scholars/chat";
    }
    
    @RequestMapping(value = "/chat/send", method = RequestMethod.POST)
    public String sendMessage(
            @RequestParam Long scholarId,
            @RequestParam(required = false) Long bookingId,
            @RequestParam String message,
            HttpSession session) {
        
        User user = (User) session.getAttribute("userSession");
        if (user == null) {
            return "redirect:/customer/login";
        }
        
        Scholar scholar = scholarService.findById(scholarId).orElse(null);
        
        if (scholar == null) {
            return "redirect:/customer/scholar/dashboard";
        }
        
        // Validate confirmed booking
        List<ScholarBooking> customerBookings = bookingService.findByCustomer(user);
        boolean hasConfirmedBooking = false;
        ScholarBooking booking = null;
        
        for (ScholarBooking b : customerBookings) {
            if (b.getScholar().getId().equals(scholarId) && 
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
            return "redirect:/customer/scholar/dashboard";
        }
        
        chatService.sendMessage(user, scholar.getUser(), booking, message);
        
        return "redirect:/customer/scholar/chat?scholarId=" + scholarId + (bookingId != null ? "&bookingId=" + bookingId : "");
    }
    
    @RequestMapping(value = "/video-call", method = RequestMethod.GET)
    public String videoCall(@RequestParam Long bookingId, HttpSession session, Model model) {
        User user = (User) session.getAttribute("userSession");
        if (user == null) {
            return "redirect:/customer/login";
        }
        
        ScholarBooking booking = bookingService.findById(bookingId).orElse(null);
        if (booking == null || !booking.getCustomer().getId().equals(user.getId())) {
            return "redirect:/customer/scholar/dashboard";
        }
        
        // Validate booking is confirmed
        if (booking.getStatus() != ScholarBookingStatus.CONFIRMED) {
            model.addAttribute("error", "Video call is only available for confirmed bookings. Please wait for the scholar to accept your booking.");
            return "redirect:/customer/scholar/dashboard";
        }
        
        String videoCallLink = booking.getVideoCallLink();
        if (videoCallLink == null || videoCallLink.isEmpty()) {
            videoCallLink = booking.getScholar().getVideoCallLink();
        }
        
        model.addAttribute("booking", booking);
        model.addAttribute("scholar", booking.getScholar());
        model.addAttribute("videoCallLink", videoCallLink);
        
        return "customer/scholars/video-call";
    }
    
    @RequestMapping(value = "/booking/cancel", method = RequestMethod.POST)
    public String cancelBooking(
            @RequestParam Long bookingId,
            @RequestParam(required = false) String reason,
            HttpSession session) {
        
        User user = (User) session.getAttribute("userSession");
        if (user == null) {
            return "redirect:/customer/login";
        }
        
        ScholarBooking booking = bookingService.findById(bookingId).orElse(null);
        if (booking == null || !booking.getCustomer().getId().equals(user.getId())) {
            return "redirect:/customer/scholar/dashboard";
        }
        
        bookingService.cancelBooking(bookingId, reason != null ? reason : "Cancelled by customer");
        return "redirect:/customer/scholar/dashboard";
    }
    
    @RequestMapping(value = "/booking/reschedule", method = RequestMethod.POST)
    public String rescheduleBooking(
            @RequestParam Long bookingId,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime newServiceDate,
            HttpSession session) {
        
        User user = (User) session.getAttribute("userSession");
        if (user == null) {
            return "redirect:/customer/login";
        }
        
        ScholarBooking booking = bookingService.findById(bookingId).orElse(null);
        if (booking == null || !booking.getCustomer().getId().equals(user.getId())) {
            return "redirect:/customer/scholar/dashboard";
        }
        
        bookingService.rescheduleBooking(bookingId, newServiceDate);
        return "redirect:/customer/scholar/dashboard";
    }
    
    @RequestMapping(value = "/search", method = RequestMethod.GET)
    public String searchScholars(
            @RequestParam(required = false) String type,
            @RequestParam(required = false) String specialization,
            @RequestParam(required = false) String location,
            @RequestParam(required = false) Double minPrice,
            @RequestParam(required = false) Double maxPrice,
            Model model) {
        
        // Get all approved and available scholars
        List<Scholar> allScholars = scholarService.findByStatus(ScholarRegistrationStatus.APPROVED);
        List<Scholar> filteredScholars = new ArrayList<>();
        
        for (Scholar scholar : allScholars) {
            // Filter by availability
            if (scholar.getIsAvailable() == null || !scholar.getIsAvailable()) {
                continue;
            }
            
            // Filter by type
            if (type != null && !type.isEmpty()) {
                try {
                    com.pilgrim.enums.ScholarType searchType = com.pilgrim.enums.ScholarType.valueOf(type);
                    if (scholar.getType() != searchType) {
                        continue;
                    }
                } catch (IllegalArgumentException e) {
                    // Invalid type, skip
                }
            }
            
            // Filter by price
            if (minPrice != null && scholar.getBasePrice().compareTo(BigDecimal.valueOf(minPrice)) < 0) {
                continue;
            }
            if (maxPrice != null && scholar.getBasePrice().compareTo(BigDecimal.valueOf(maxPrice)) > 0) {
                continue;
            }
            
            // Filter by location (service areas)
            if (location != null && !location.isEmpty()) {
                if (scholar.getServiceAreas() == null || 
                    !scholar.getServiceAreas().toLowerCase().contains(location.toLowerCase())) {
                    continue;
                }
            }
            
            filteredScholars.add(scholar);
        }
        
        model.addAttribute("scholars", filteredScholars);
        model.addAttribute("searchType", type);
        model.addAttribute("searchSpecialization", specialization);
        model.addAttribute("searchLocation", location);
        model.addAttribute("minPrice", minPrice);
        model.addAttribute("maxPrice", maxPrice);
        
        return "customer/scholars/search-scholars";
    }
}

