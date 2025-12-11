package com.pilgrim.controller;

import com.pilgrim.entity.ScholarBooking;
import com.pilgrim.entity.ScholarPayment;
import com.pilgrim.entity.User;
import com.pilgrim.service.ScholarBookingService;
import com.pilgrim.service.ScholarPaymentService;
import com.pilgrim.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import com.razorpay.Order;
import com.razorpay.RazorpayClient;
import com.razorpay.RazorpayException;

import java.math.BigDecimal;
import java.util.List;

@Controller
@RequestMapping("/customer/scholar/payment")
public class ScholarPaymentController {
    
    @Autowired
    private ScholarPaymentService paymentService;
    
    @Autowired
    private ScholarBookingService bookingService;
    
    @Autowired
    private UserService userService;
    
    @Value("${razorpay.key.id}")
    private String razorpayKeyId;
    
    @Value("${razorpay.key.secret}")
    private String razorpayKeySecret;
    
    @RequestMapping(value = "/initiate", method = RequestMethod.GET)
    public String showPaymentPage(
            @RequestParam Long bookingId,
            HttpServletRequest request,
            HttpSession session,
            Model model) {
        
        String contextPath = request.getContextPath();
        model.addAttribute("contextPath", contextPath);
        
        User user = (User) session.getAttribute("userSession");
        if (user == null) {
            return "redirect:/login";
        }
        
        ScholarBooking booking = bookingService.findById(bookingId).orElse(null);
        if (booking == null) {
            model.addAttribute("error", "Booking not found");
            return "redirect:/customer/scholar/dashboard";
        }
        
        if (!booking.getCustomer().getId().equals(user.getId())) {
            model.addAttribute("error", "Unauthorized access to booking");
            return "redirect:/customer/scholar/dashboard";
        }
        
        if (booking.getTotalAmount() == null || booking.getTotalAmount().compareTo(BigDecimal.ZERO) <= 0) {
            model.addAttribute("error", "Invalid booking amount");
            return "redirect:/customer/scholar/dashboard";
        }
        
        try {
            // Check if payment already exists (it should be created when booking is created)
            ScholarPayment payment = paymentService.findByBooking(booking);
            if (payment == null) {
                // If payment doesn't exist, create it
                payment = paymentService.createPayment(booking, booking.getTotalAmount());
            }
            
            // Validate Razorpay keys
            if (razorpayKeyId == null || razorpayKeyId.isEmpty() || 
                razorpayKeySecret == null || razorpayKeySecret.isEmpty()) {
                model.addAttribute("error", "Payment gateway configuration error. Please contact support.");
                return "redirect:/customer/scholar/dashboard";
            }
            
            // Initialize Razorpay client
            RazorpayClient razorpay = new RazorpayClient(razorpayKeyId, razorpayKeySecret);
            JSONObject orderRequest = new JSONObject();
            int amountInPaise = booking.getTotalAmount().multiply(new BigDecimal("100")).intValue();
            orderRequest.put("amount", amountInPaise);
            orderRequest.put("currency", "INR");
            orderRequest.put("receipt", "booking_" + bookingId);
            JSONObject notes = new JSONObject();
            notes.put("booking_id", bookingId.toString());
            orderRequest.put("notes", notes);
            
            Order order = razorpay.orders.create(orderRequest);
            
            model.addAttribute("orderId", order.get("id"));
            model.addAttribute("amount", amountInPaise);
            model.addAttribute("currency", "INR");
            model.addAttribute("keyId", razorpayKeyId);
            model.addAttribute("booking", booking);
            model.addAttribute("payment", payment);
            
            return "customer/scholars/payment";
        } catch (RazorpayException e) {
            e.printStackTrace();
            model.addAttribute("error", "Payment initialization failed: " + e.getMessage());
            return "redirect:/customer/scholar/dashboard";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "An error occurred: " + e.getMessage());
            return "redirect:/customer/scholar/dashboard";
        }
    }
    
    @RequestMapping(value = "/success", method = RequestMethod.POST)
    public String paymentSuccess(
            @RequestParam String razorpay_order_id,
            @RequestParam String razorpay_payment_id,
            @RequestParam String razorpay_signature,
            @RequestParam Long bookingId,
            HttpServletRequest request,
            HttpSession session,
            Model model) {
        
        String contextPath = request.getContextPath();
        model.addAttribute("contextPath", contextPath);
        
        try {
            ScholarPayment payment = paymentService.findByBooking(bookingService.findById(bookingId).orElse(null));
            if (payment != null) {
                paymentService.processPayment(payment.getId(), razorpay_payment_id);
            }
            
            model.addAttribute("message", "Payment successful! Your booking is now confirmed.");
            return "customer/scholars/payment-success";
        } catch (Exception e) {
            model.addAttribute("error", "Payment verification failed");
            return "customer/scholars/payment-failure";
        }
    }
    
    @RequestMapping(value = "/history", method = RequestMethod.GET)
    public String paymentHistory(HttpServletRequest request, HttpSession session, Model model) {
        String contextPath = request.getContextPath();
        model.addAttribute("contextPath", contextPath);
        
        User user = (User) session.getAttribute("userSession");
        if (user == null) {
            return "redirect:/login";
        }
        
        // Get payments for user's bookings
        List<ScholarBooking> userBookings = bookingService.findByCustomer(user);
        List<ScholarPayment> payments = new java.util.ArrayList<>();
        for (ScholarBooking booking : userBookings) {
            ScholarPayment payment = paymentService.findByBooking(booking);
            if (payment != null) {
                payments.add(payment);
            }
        }
        model.addAttribute("payments", payments);
        
        return "customer/scholars/payment-history";
    }
}

