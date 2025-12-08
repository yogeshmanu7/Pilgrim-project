package com.pilgrim.controller;

import com.pilgrim.entity.TravelAgency;
import com.pilgrim.entity.TravelBooking;
import com.pilgrim.entity.TravelPackage;
import com.pilgrim.entity.Transport;
import com.pilgrim.entity.Guide;
import com.pilgrim.enums.TravelBookingStatus;
import com.pilgrim.service.TravelBookingService;
import com.pilgrim.service.TravelPackageService;
import com.pilgrim.service.TransportService;
import com.pilgrim.service.GuideService;
import com.pilgrim.service.EmailService;
import com.razorpay.Order;
import com.razorpay.RazorpayClient;
import org.json.JSONObject;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/pilgrim/travel/booking")
public class TravelBookingController {

    @Autowired private TravelPackageService packageService;
    @Autowired private TransportService transportService;
    @Autowired private GuideService guideService;
    @Autowired private TravelBookingService bookingService;
    @Autowired private EmailService emailService;

    @Value("${razorpay.key.id}")
    private String razorpayKeyId;
    @Value("${razorpay.key.secret}")
    private String razorpayKeySecret;

    @GetMapping("/user/create")
    public String showPackageBookingForm(@RequestParam Long packageId,
                                         @RequestParam int quantity,
                                         @RequestParam double amount,
                                         Model model,
                                         HttpSession session) {
        TravelPackage pack = packageService.getPackageById(packageId);
        if (pack == null) {
            model.addAttribute("error", "Package not found!");
            return "travel/travel-package-user-list";
        }
        TravelBooking booking = new TravelBooking();
        booking.setTravelPackage(pack);
        booking.setQuantity(quantity);
        booking.setAmountPaid(amount);
        session.setAttribute("booking", booking);
        model.addAttribute("booking", booking);
        return "travel/booking-create";
    }

    @GetMapping("/user/transport/create")
    public String showTransportBookingForm(@RequestParam Long transportId,
                                           @RequestParam int quantity,
                                           @RequestParam double amount,
                                           Model model,
                                           HttpSession session) {
        Transport transport = transportService.getTransportById(transportId);
        if (transport == null) {
            model.addAttribute("error", "Transport option not found!");
            return "travel/transport-list";
        }
        TravelBooking booking = new TravelBooking();
        booking.setTransport(transport);
        booking.setQuantity(quantity);
        booking.setAmountPaid(amount);
        session.setAttribute("booking", booking);
        model.addAttribute("booking", booking);
        return "travel/booking-create";
    }

    @GetMapping("/user/guide/create")
    public String showGuideBookingForm(@RequestParam Long guideId,
                                       @RequestParam int quantity,
                                       @RequestParam double amount,
                                       Model model,
                                       HttpSession session) {
        Guide guide = guideService.getGuideById(guideId);
        if (guide == null) {
            model.addAttribute("error", "Guide not found!");
            return "travel/guide-list";
        }
        TravelBooking booking = new TravelBooking();
        booking.setGuide(guide);
        booking.setQuantity(quantity);
        booking.setAmountPaid(amount);
        session.setAttribute("booking", booking);
        model.addAttribute("booking", booking);
        return "travel/booking-create";
    }

    @PostMapping("/user/details")
    public String showBookingDetails(@ModelAttribute("booking") TravelBooking booking,
                                     Model model,
                                     HttpSession session) {
        session.setAttribute("booking", booking);
        model.addAttribute("booking", booking);
        return "travel/booking-details";
    }

    @PostMapping("/user/payment")
    public String showPaymentPage(@ModelAttribute("booking") TravelBooking booking,
                                  @RequestParam String userName,
                                  @RequestParam String mobile,
                                  @RequestParam String email,
                                  @RequestParam String address,
                                  @RequestParam List<String> passengerNames,
                                  @RequestParam List<Integer> passengerAges,
                                  Model model,
                                  HttpSession session) throws Exception {
        booking.setPassengerNames(passengerNames);
        booking.setPassengerAges(passengerAges);

        RazorpayClient client = new RazorpayClient(razorpayKeyId, razorpayKeySecret);
        JSONObject orderRequest = new JSONObject();
        orderRequest.put("amount", (int)(booking.getAmountPaid() * 100));
        orderRequest.put("currency", "INR");
        orderRequest.put("payment_capture", 1);
        Order order = client.orders.create(orderRequest);

        session.setAttribute("booking", booking);

        model.addAttribute("booking", booking);
        model.addAttribute("userName", userName);
        model.addAttribute("mobile", mobile);
        model.addAttribute("email", email);
        model.addAttribute("address", address);
        model.addAttribute("orderId", order.get("id"));
        model.addAttribute("razorpayKey", razorpayKeyId);

        return "travel/booking-payment";
    }

    @PostMapping("/user/confirm")
    @ResponseBody
    public String confirmPayment(@RequestBody Map<String, Object> payload, HttpSession session) {
        String paymentId = (String) payload.get("razorpay_payment_id");
        String email = (String) payload.get("email");

        TravelBooking booking = (TravelBooking) session.getAttribute("booking");
        if (booking != null) {
            booking.setStatus(TravelBookingStatus.CONFIRMED);
            booking.setBookedAt(LocalDateTime.now());
            booking.setPaymentId(paymentId);
            bookingService.saveBooking(booking);
            emailService.sendBookingConfirmation(email, booking);
        }
        return "success";
    }

    @GetMapping("/user/success")
    public String bookingSuccess(HttpSession session, Model model) {
        TravelBooking booking = (TravelBooking) session.getAttribute("booking");
        model.addAttribute("booking", booking);
        return "travel/travel-booking-success";
    }

    @GetMapping("/status/{id}")
    public String bookingStatus(@PathVariable Long id, Model model) {
        TravelBooking booking = bookingService.getBookingById(id);
        if (booking == null) {
            model.addAttribute("error", "Booking not found!");
            return "travel/travel-package-user-list";
        }
        model.addAttribute("booking", booking);
        return "travel/user-booking-status";
    }

    @GetMapping("/status")
    public String bookingStatusFromSession(HttpSession session, Model model) {
        TravelBooking booking = (TravelBooking) session.getAttribute("booking");
        if (booking == null) {
            model.addAttribute("error", "No booking found in session!");
            return "travel/travel-package-user-list";
        }
        model.addAttribute("booking", booking);
        return "travel/user-booking-status";
    }

    @GetMapping("/user/receipt/{id}")
    public String bookingReceipt(@PathVariable Long id, Model model) {
        TravelBooking booking = bookingService.getBookingById(id);
        if (booking == null) {
            model.addAttribute("error", "Booking not found!");
            return "travel/travel-package-user-list";
        }
        model.addAttribute("booking", booking);
        return "travel/receipt-download";
    }

    @GetMapping("/user/payment/status")
    public String paymentStatus(HttpSession session, Model model) {
        TravelBooking booking = (TravelBooking) session.getAttribute("booking");
        if (booking == null) {
            model.addAttribute("error", "No booking found!");
            return "travel/travel-package-user-list";
        }
        model.addAttribute("booking", booking);
        return "travel/payment-status";
    }

    @GetMapping("/agency/list")
    public String listBookings(Model model, HttpSession session) {
        TravelAgency agency = (TravelAgency) session.getAttribute("agency");
        if (agency == null) {
            return "redirect:/pilgrim/travel/agency/login";
        }
        model.addAttribute("bookings", bookingService.findByAgency(agency));
        return "travel/booking-list-agency";
    }

    @GetMapping("/agency/details/{id}")
    public String viewBookingDetails(@PathVariable Long id, Model model, HttpSession session) {
        TravelAgency agency = (TravelAgency) session.getAttribute("agency");
        if (agency == null) {
            return "redirect:/pilgrim/travel/agency/login";
        }
        TravelBooking booking = bookingService.getBookingById(id);
        if (booking == null) {
            return "redirect:/pilgrim/travel/booking/agency/list";
        }
        model.addAttribute("booking", booking);
        return "travel/booking-details-agency";
    }

    @PostMapping("/agency/update/{id}")
    public String updateBookingStatus(@PathVariable Long id,
                                      @RequestParam TravelBookingStatus status,
                                      HttpSession session) {
        TravelAgency agency = (TravelAgency) session.getAttribute("agency");
        if (agency == null) {
            return "redirect:/pilgrim/travel/agency/login";
        }

        TravelBooking booking = bookingService.getBookingById(id);
        if (booking != null) {
            booking.setStatus(status);
            if (status == TravelBookingStatus.CANCELLED_BY_AGENCY) {
                booking.setCancelledAt(LocalDateTime.now());
            }
            if (status == TravelBookingStatus.REFUND_INITIATED) {
                booking.setRefundInitiatedAt(LocalDateTime.now());
            }
            if (status == TravelBookingStatus.REFUND_COMPLETED) {
                booking.setRefundedAt(LocalDateTime.now());
            }
            if (status == TravelBookingStatus.COMPLETED) {
                booking.setCompletedAt(LocalDateTime.now());
            }
            bookingService.saveBooking(booking);
        }

        return "redirect:/pilgrim/travel/booking/agency/list";
    }
}

