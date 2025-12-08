package com.pilgrim.controller;

import com.pilgrim.entity.*;
import com.pilgrim.service.*;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/pilgrim/temple/user")
@RequiredArgsConstructor
public class TempleUserController {
    
    private final com.pilgrim.service.UserService userService;
    private final DarshanService darshanService;
    private final TemplePoojaService poojaService;
    private final PrasadhamService prasadhamService;
    private final TourGuideService tourGuideService;
    private final TempleDonationService donationService;
    
    // Explicit constructor to ensure dependencies are injected
    public TempleUserController(com.pilgrim.service.UserService userService, DarshanService darshanService,
                                 TemplePoojaService poojaService, PrasadhamService prasadhamService,
                                 TourGuideService tourGuideService, TempleDonationService donationService) {
        this.userService = userService;
        this.darshanService = darshanService;
        this.poojaService = poojaService;
        this.prasadhamService = prasadhamService;
        this.tourGuideService = tourGuideService;
        this.donationService = donationService;
    }
    
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        String userEmail = (String) session.getAttribute("userEmail");
        if (userEmail == null) {
            return "redirect:/login";
        }
        User user = userService.findByEmail(userEmail)
                .orElseThrow(() -> new RuntimeException("User not found"));
        
        model.addAttribute("user", user);
        model.addAttribute("darshanBookings", darshanService.findBookingsByUser(user));
        model.addAttribute("poojaBookings", poojaService.findBookingsByUser(user));
        model.addAttribute("prasadhamOrders", prasadhamService.findOrdersByUser(user));
        model.addAttribute("tourBookings", tourGuideService.findBookingsByUser(user));
        model.addAttribute("donations", donationService.findByUser(user));
        
        return "user/dashboard";
    }
    
    @GetMapping("/profile")
    public String profile(HttpSession session, Model model) {
        String userEmail = (String) session.getAttribute("userEmail");
        if (userEmail == null) {
            return "redirect:/login";
        }
        User user = userService.findByEmail(userEmail)
                .orElseThrow(() -> new RuntimeException("User not found"));
        
        model.addAttribute("user", user);
        return "user/profile";
    }
    
    @PostMapping("/profile")
    public String updateProfile(@ModelAttribute User updatedUser,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        try {
            String userEmail = (String) session.getAttribute("userEmail");
            if (userEmail == null) {
                redirectAttributes.addFlashAttribute("error", "Please login to update profile");
                return "redirect:/login";
            }
            User user = userService.findByEmail(userEmail)
                    .orElseThrow(() -> new RuntimeException("User not found"));
            
            user.setName(updatedUser.getName());
            user.setPhone(updatedUser.getPhone());
            user.setAddress(updatedUser.getAddress());
            user.setCity(updatedUser.getCity());
            user.setState(updatedUser.getState());
            user.setPincode(updatedUser.getPincode());
            
            userService.updateUser(user);
            redirectAttributes.addFlashAttribute("success", "Profile updated successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Update failed: " + e.getMessage());
        }
        
        return "redirect:/pilgrim/temple/user/profile";
    }
    
    @GetMapping("/bookings")
    public String allBookings(HttpSession session, Model model) {
        String userEmail = (String) session.getAttribute("userEmail");
        if (userEmail == null) {
            return "redirect:/login";
        }
        User user = userService.findByEmail(userEmail)
                .orElseThrow(() -> new RuntimeException("User not found"));
        
        model.addAttribute("darshanBookings", darshanService.findBookingsByUser(user));
        model.addAttribute("poojaBookings", poojaService.findBookingsByUser(user));
        model.addAttribute("tourBookings", tourGuideService.findBookingsByUser(user));
        
        return "user/bookings";
    }
    
    @GetMapping("/bookings/darshan/{id}")
    public String viewDarshanBooking(@PathVariable Long id, Model model) {
        DarshanBooking booking = darshanService.findBookingById(id)
                .orElseThrow(() -> new RuntimeException("Booking not found"));
        
        model.addAttribute("booking", booking);
        return "user/booking-details/darshan";
    }
    
    @GetMapping("/bookings/pooja/{id}")
    public String viewPoojaBooking(@PathVariable Long id, Model model) {
        PoojaBooking booking = poojaService.findBookingById(id)
                .orElseThrow(() -> new RuntimeException("Booking not found"));
        
        model.addAttribute("booking", booking);
        return "user/booking-details/pooja";
    }
    
    @GetMapping("/bookings/tour/{id}")
    public String viewTourBooking(@PathVariable Long id, Model model) {
        TourBooking booking = tourGuideService.findBookingById(id)
                .orElseThrow(() -> new RuntimeException("Booking not found"));
        
        model.addAttribute("booking", booking);
        return "user/booking-details/tour";
    }
    
    @GetMapping("/orders")
    public String allOrders(HttpSession session, Model model) {
        String userEmail = (String) session.getAttribute("userEmail");
        if (userEmail == null) {
            return "redirect:/login";
        }
        User user = userService.findByEmail(userEmail)
                .orElseThrow(() -> new RuntimeException("User not found"));
        
        model.addAttribute("prasadhamOrders", prasadhamService.findOrdersByUser(user));
        return "user/orders";
    }
    
    @GetMapping("/orders/prasadham/{id}")
    public String viewPrasadhamOrder(@PathVariable Long id, Model model) {
        PrasadhamOrder order = prasadhamService.findOrderById(id)
                .orElseThrow(() -> new RuntimeException("Order not found"));
        
        model.addAttribute("order", order);
        return "user/order-details/prasadham";
    }
    
    @GetMapping("/donations")
    public String allDonations(HttpSession session, Model model) {
        String userEmail = (String) session.getAttribute("userEmail");
        if (userEmail == null) {
            return "redirect:/login";
        }
        User user = userService.findByEmail(userEmail)
                .orElseThrow(() -> new RuntimeException("User not found"));
        
        model.addAttribute("donations", donationService.findByUser(user));
        return "user/donations";
    }
    
    @PostMapping("/bookings/darshan/{id}/cancel")
    public String cancelDarshanBooking(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            darshanService.cancelBooking(id);
            redirectAttributes.addFlashAttribute("success", "Booking cancelled successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Cancellation failed: " + e.getMessage());
        }
        return "redirect:/pilgrim/temple/user/bookings";
    }
    
    @PostMapping("/bookings/pooja/{id}/cancel")
    public String cancelPoojaBooking(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            poojaService.cancelBooking(id);
            redirectAttributes.addFlashAttribute("success", "Booking cancelled successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Cancellation failed: " + e.getMessage());
        }
        return "redirect:/pilgrim/temple/user/bookings";
    }
    
    @PostMapping("/bookings/tour/{id}/cancel")
    public String cancelTourBooking(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            tourGuideService.cancelBooking(id);
            redirectAttributes.addFlashAttribute("success", "Booking cancelled successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Cancellation failed: " + e.getMessage());
        }
        return "redirect:/pilgrim/temple/user/bookings";
    }
    
    @PostMapping("/orders/prasadham/{id}/cancel")
    public String cancelPrasadhamOrder(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            prasadhamService.cancelOrder(id);
            redirectAttributes.addFlashAttribute("success", "Order cancelled successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Cancellation failed: " + e.getMessage());
        }
        return "redirect:/pilgrim/temple/user/orders";
    }
}

