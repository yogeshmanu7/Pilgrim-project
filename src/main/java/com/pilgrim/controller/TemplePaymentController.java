package com.pilgrim.controller;

import com.pilgrim.entity.*;
import com.pilgrim.enums.PaymentStatus;
import com.pilgrim.service.*;
import lombok.RequiredArgsConstructor;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/pilgrim/temple/payment")
@RequiredArgsConstructor
public class TemplePaymentController {
    
    private final RazorpayService razorpayService;
    private final DarshanService darshanService;
    private final TemplePoojaService poojaService;
    private final PrasadhamService prasadhamService;
    private final TourGuideService tourGuideService;
    private final com.pilgrim.service.UserService userService;
    
    @Value("${razorpay.key.id}")
    private String razorpayKeyId;
    
    // Explicit constructor to ensure dependencies are injected
    public TemplePaymentController(RazorpayService razorpayService, DarshanService darshanService,
                                   TemplePoojaService poojaService, PrasadhamService prasadhamService,
                                   TourGuideService tourGuideService, com.pilgrim.service.UserService userService) {
        this.razorpayService = razorpayService;
        this.darshanService = darshanService;
        this.poojaService = poojaService;
        this.prasadhamService = prasadhamService;
        this.tourGuideService = tourGuideService;
        this.userService = userService;
    }
    
    // ============ DARSHAN BOOKING PAYMENT ============
    
    @PostMapping("/darshan/{bookingId}/create-order")
    @ResponseBody
    public Map<String, Object> createDarshanPaymentOrder(@PathVariable Long bookingId,
                                                         Authentication authentication) {
        Map<String, Object> response = new HashMap<>();
        try {
            User user = userService.findByEmail(authentication.getName())
                    .orElseThrow(() -> new RuntimeException("User not found"));
            
            DarshanBooking booking = darshanService.findBookingById(bookingId)
                    .orElseThrow(() -> new RuntimeException("Booking not found"));
            
            if (!booking.getUser().getId().equals(user.getId())) {
                response.put("success", false);
                response.put("error", "Unauthorized access");
                return response;
            }
            
            if (booking.getPaymentStatus() == PaymentStatus.PAID) {
                response.put("success", false);
                response.put("error", "Payment already completed");
                return response;
            }
            
            BigDecimal amount = booking.getTotalAmount() != null ? booking.getTotalAmount() : BigDecimal.ZERO;
            
            if (amount.compareTo(BigDecimal.ZERO) == 0) {
                darshanService.updatePaymentStatus(bookingId, PaymentStatus.PAID, "FREE_BOOKING");
                response.put("success", true);
                response.put("message", "Free booking confirmed");
                return response;
            }
            
            JSONObject notes = new JSONObject();
            notes.put("booking_id", bookingId);
            notes.put("booking_number", booking.getBookingNumber());
            notes.put("type", "darshan");
            
            JSONObject order = razorpayService.createOrder(amount, "INR", booking.getBookingNumber(), notes);
            
            response.put("success", true);
            response.put("orderId", order.get("id"));
            response.put("amount", order.get("amount"));
            response.put("currency", order.get("currency"));
            response.put("key", razorpayKeyId);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("error", e.getMessage() != null ? e.getMessage() : "Failed to create payment order. Please try again.");
        }
        return response;
    }
    
    @PostMapping("/darshan/{bookingId}/verify")
    public String verifyDarshanPayment(@PathVariable Long bookingId,
                                      @RequestParam String razorpay_order_id,
                                      @RequestParam String razorpay_payment_id,
                                      @RequestParam String razorpay_signature,
                                      Authentication authentication,
                                      RedirectAttributes redirectAttributes) {
        try {
            User user = userService.findByEmail(authentication.getName())
                    .orElseThrow(() -> new RuntimeException("User not found"));
            
            DarshanBooking booking = darshanService.findBookingById(bookingId)
                    .orElseThrow(() -> new RuntimeException("Booking not found"));
            
            if (!booking.getUser().getId().equals(user.getId())) {
                redirectAttributes.addFlashAttribute("error", "Unauthorized access");
                return "redirect:/pilgrim/temple/user/bookings";
            }
            
            if (razorpayService.verifyPaymentSignature(razorpay_order_id, razorpay_payment_id, razorpay_signature)) {
                darshanService.updatePaymentStatus(bookingId, PaymentStatus.PAID, razorpay_payment_id);
                redirectAttributes.addFlashAttribute("success", "Payment successful! Your booking is confirmed.");
            } else {
                darshanService.updatePaymentStatus(bookingId, PaymentStatus.FAILED, razorpay_payment_id);
                redirectAttributes.addFlashAttribute("error", "Payment verification failed. Please contact support.");
            }
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Payment verification error: " + e.getMessage());
        }
        
        return "redirect:/pilgrim/temple/user/bookings/darshan/" + bookingId;
    }
    
    // ============ POOJA BOOKING PAYMENT ============
    
    @PostMapping("/pooja/{bookingId}/create-order")
    @ResponseBody
    public Map<String, Object> createPoojaPaymentOrder(@PathVariable Long bookingId,
                                                       Authentication authentication) {
        Map<String, Object> response = new HashMap<>();
        try {
            User user = userService.findByEmail(authentication.getName())
                    .orElseThrow(() -> new RuntimeException("User not found"));
            
            PoojaBooking booking = poojaService.findBookingById(bookingId)
                    .orElseThrow(() -> new RuntimeException("Booking not found"));
            
            if (!booking.getUser().getId().equals(user.getId())) {
                response.put("success", false);
                response.put("error", "Unauthorized access");
                return response;
            }
            
            if (booking.getPaymentStatus() == PaymentStatus.PAID) {
                response.put("success", false);
                response.put("error", "Payment already completed");
                return response;
            }
            
            BigDecimal amount = booking.getAmount() != null ? booking.getAmount() : BigDecimal.ZERO;
            
            if (amount.compareTo(BigDecimal.ZERO) == 0) {
                poojaService.updatePaymentStatus(bookingId, PaymentStatus.PAID, "FREE_BOOKING");
                response.put("success", true);
                response.put("message", "Free booking confirmed");
                return response;
            }
            
            JSONObject notes = new JSONObject();
            notes.put("booking_id", bookingId);
            notes.put("booking_number", booking.getBookingNumber());
            notes.put("type", "pooja");
            
            JSONObject order = razorpayService.createOrder(amount, "INR", booking.getBookingNumber(), notes);
            
            response.put("success", true);
            response.put("orderId", order.get("id"));
            response.put("amount", order.get("amount"));
            response.put("currency", order.get("currency"));
            response.put("key", razorpayKeyId);
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("error", e.getMessage());
        }
        return response;
    }
    
    @PostMapping("/pooja/{bookingId}/verify")
    public String verifyPoojaPayment(@PathVariable Long bookingId,
                                    @RequestParam String razorpay_order_id,
                                    @RequestParam String razorpay_payment_id,
                                    @RequestParam String razorpay_signature,
                                    Authentication authentication,
                                    RedirectAttributes redirectAttributes) {
        try {
            User user = userService.findByEmail(authentication.getName())
                    .orElseThrow(() -> new RuntimeException("User not found"));
            
            PoojaBooking booking = poojaService.findBookingById(bookingId)
                    .orElseThrow(() -> new RuntimeException("Booking not found"));
            
            if (!booking.getUser().getId().equals(user.getId())) {
                redirectAttributes.addFlashAttribute("error", "Unauthorized access");
                return "redirect:/pilgrim/temple/user/bookings";
            }
            
            if (razorpayService.verifyPaymentSignature(razorpay_order_id, razorpay_payment_id, razorpay_signature)) {
                poojaService.updatePaymentStatus(bookingId, PaymentStatus.PAID, razorpay_payment_id);
                redirectAttributes.addFlashAttribute("success", "Payment successful! Your booking is confirmed.");
            } else {
                poojaService.updatePaymentStatus(bookingId, PaymentStatus.FAILED, razorpay_payment_id);
                redirectAttributes.addFlashAttribute("error", "Payment verification failed. Please contact support.");
            }
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Payment verification error: " + e.getMessage());
        }
        
        return "redirect:/pilgrim/temple/user/bookings/pooja/" + bookingId;
    }
    
    // ============ PRASADHAM ORDER PAYMENT ============
    
    @PostMapping("/prasadham/{orderId}/create-order")
    @ResponseBody
    public Map<String, Object> createPrasadhamPaymentOrder(@PathVariable Long orderId,
                                                           Authentication authentication) {
        Map<String, Object> response = new HashMap<>();
        try {
            User user = userService.findByEmail(authentication.getName())
                    .orElseThrow(() -> new RuntimeException("User not found"));
            
            PrasadhamOrder order = prasadhamService.findOrderById(orderId)
                    .orElseThrow(() -> new RuntimeException("Order not found"));
            
            if (!order.getUser().getId().equals(user.getId())) {
                response.put("success", false);
                response.put("error", "Unauthorized access");
                return response;
            }
            
            if (order.getPaymentStatus() == PaymentStatus.PAID) {
                response.put("success", false);
                response.put("error", "Payment already completed");
                return response;
            }
            
            BigDecimal amount = order.getTotalAmount() != null ? order.getTotalAmount() : BigDecimal.ZERO;
            
            if (amount.compareTo(BigDecimal.ZERO) == 0) {
                prasadhamService.updatePaymentStatus(orderId, PaymentStatus.PAID, "FREE_ORDER");
                response.put("success", true);
                response.put("message", "Free order confirmed");
                return response;
            }
            
            JSONObject notes = new JSONObject();
            notes.put("order_id", orderId);
            notes.put("order_number", order.getOrderNumber());
            notes.put("type", "prasadham");
            
            JSONObject razorpayOrder = razorpayService.createOrder(amount, "INR", order.getOrderNumber(), notes);
            
            response.put("success", true);
            response.put("orderId", razorpayOrder.get("id"));
            response.put("amount", razorpayOrder.get("amount"));
            response.put("currency", razorpayOrder.get("currency"));
            response.put("key", razorpayKeyId);
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("error", e.getMessage());
        }
        return response;
    }
    
    @PostMapping("/prasadham/{orderId}/verify")
    public String verifyPrasadhamPayment(@PathVariable Long orderId,
                                         @RequestParam String razorpay_order_id,
                                         @RequestParam String razorpay_payment_id,
                                         @RequestParam String razorpay_signature,
                                         Authentication authentication,
                                         RedirectAttributes redirectAttributes) {
        try {
            User user = userService.findByEmail(authentication.getName())
                    .orElseThrow(() -> new RuntimeException("User not found"));
            
            PrasadhamOrder order = prasadhamService.findOrderById(orderId)
                    .orElseThrow(() -> new RuntimeException("Order not found"));
            
            if (!order.getUser().getId().equals(user.getId())) {
                redirectAttributes.addFlashAttribute("error", "Unauthorized access");
                return "redirect:/pilgrim/temple/user/orders";
            }
            
            if (razorpayService.verifyPaymentSignature(razorpay_order_id, razorpay_payment_id, razorpay_signature)) {
                prasadhamService.updatePaymentStatus(orderId, PaymentStatus.PAID, razorpay_payment_id);
                redirectAttributes.addFlashAttribute("success", "Payment successful! Your order is confirmed.");
            } else {
                prasadhamService.updatePaymentStatus(orderId, PaymentStatus.FAILED, razorpay_payment_id);
                redirectAttributes.addFlashAttribute("error", "Payment verification failed. Please contact support.");
            }
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Payment verification error: " + e.getMessage());
        }
        
        return "redirect:/pilgrim/temple/user/orders/prasadham/" + orderId;
    }
    
    // ============ TOUR BOOKING PAYMENT ============
    
    @PostMapping("/tour/{bookingId}/create-order")
    @ResponseBody
    public Map<String, Object> createTourPaymentOrder(@PathVariable Long bookingId,
                                                      Authentication authentication) {
        Map<String, Object> response = new HashMap<>();
        try {
            User user = userService.findByEmail(authentication.getName())
                    .orElseThrow(() -> new RuntimeException("User not found"));
            
            TourBooking booking = tourGuideService.findBookingById(bookingId)
                    .orElseThrow(() -> new RuntimeException("Booking not found"));
            
            if (!booking.getUser().getId().equals(user.getId())) {
                response.put("success", false);
                response.put("error", "Unauthorized access");
                return response;
            }
            
            if (booking.getPaymentStatus() == PaymentStatus.PAID) {
                response.put("success", false);
                response.put("error", "Payment already completed");
                return response;
            }
            
            BigDecimal amount = booking.getTotalAmount() != null ? booking.getTotalAmount() : BigDecimal.ZERO;
            
            if (amount.compareTo(BigDecimal.ZERO) == 0) {
                tourGuideService.updatePaymentStatus(bookingId, PaymentStatus.PAID, "FREE_BOOKING");
                response.put("success", true);
                response.put("message", "Free booking confirmed");
                return response;
            }
            
            JSONObject notes = new JSONObject();
            notes.put("booking_id", bookingId);
            notes.put("booking_number", booking.getBookingNumber());
            notes.put("type", "tour");
            
            JSONObject order = razorpayService.createOrder(amount, "INR", booking.getBookingNumber(), notes);
            
            response.put("success", true);
            response.put("orderId", order.get("id"));
            response.put("amount", order.get("amount"));
            response.put("currency", order.get("currency"));
            response.put("key", razorpayKeyId);
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("error", e.getMessage());
        }
        return response;
    }
    
    @PostMapping("/tour/{bookingId}/verify")
    public String verifyTourPayment(@PathVariable Long bookingId,
                                   @RequestParam String razorpay_order_id,
                                   @RequestParam String razorpay_payment_id,
                                   @RequestParam String razorpay_signature,
                                   Authentication authentication,
                                   RedirectAttributes redirectAttributes) {
        try {
            User user = userService.findByEmail(authentication.getName())
                    .orElseThrow(() -> new RuntimeException("User not found"));
            
            TourBooking booking = tourGuideService.findBookingById(bookingId)
                    .orElseThrow(() -> new RuntimeException("Booking not found"));
            
            if (!booking.getUser().getId().equals(user.getId())) {
                redirectAttributes.addFlashAttribute("error", "Unauthorized access");
                return "redirect:/pilgrim/temple/user/bookings";
            }
            
            if (razorpayService.verifyPaymentSignature(razorpay_order_id, razorpay_payment_id, razorpay_signature)) {
                tourGuideService.updatePaymentStatus(bookingId, PaymentStatus.PAID, razorpay_payment_id);
                redirectAttributes.addFlashAttribute("success", "Payment successful! Your booking is confirmed.");
            } else {
                tourGuideService.updatePaymentStatus(bookingId, PaymentStatus.FAILED, razorpay_payment_id);
                redirectAttributes.addFlashAttribute("error", "Payment verification failed. Please contact support.");
            }
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Payment verification error: " + e.getMessage());
        }
        
        return "redirect:/pilgrim/temple/user/bookings/tour/" + bookingId;
    }
}

