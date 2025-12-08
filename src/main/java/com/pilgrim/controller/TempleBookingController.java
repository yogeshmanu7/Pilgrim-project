package com.pilgrim.controller;

import com.pilgrim.entity.*;
import com.pilgrim.enums.BookingStatus;
import com.pilgrim.enums.PaymentStatus;
import com.pilgrim.service.*;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/pilgrim/temple/booking")
@RequiredArgsConstructor
public class TempleBookingController {
    
    private final DarshanService darshanService;
    private final TemplePoojaService poojaService;
    private final PrasadhamService prasadhamService;
    private final TourGuideService tourGuideService;
    private final com.pilgrim.service.UserService userService;
    
    // Explicit constructor to ensure dependencies are injected
    public TempleBookingController(DarshanService darshanService, TemplePoojaService poojaService,
                                   PrasadhamService prasadhamService, TourGuideService tourGuideService,
                                   com.pilgrim.service.UserService userService) {
        this.darshanService = darshanService;
        this.poojaService = poojaService;
        this.prasadhamService = prasadhamService;
        this.tourGuideService = tourGuideService;
        this.userService = userService;
    }
    
    // ============ DARSHAN BOOKING ============
    
    @GetMapping("/darshan/{darshanId}")
    public String darshanBookingPage(@PathVariable Long darshanId, Model model) {
        Darshan darshan = darshanService.findById(darshanId)
                .orElseThrow(() -> new RuntimeException("Darshan not found"));
        
        LocalDate today = LocalDate.now();
        LocalDate minDate = today;
        LocalDate maxDate = today.plusDays(30);
        
        if (darshan.getBookingStartDate() != null) {
            minDate = darshan.getBookingStartDate().isAfter(today) ? darshan.getBookingStartDate() : today;
        }
        if (darshan.getBookingEndDate() != null) {
            maxDate = darshan.getBookingEndDate();
        }
        
        Integer availableSeats = darshan.getMaxBookingsPerSlot() != null ? 
            darshanService.getAvailableSlots(darshan, today) : null;
        
        model.addAttribute("darshan", darshan);
        model.addAttribute("temple", darshan.getTemple());
        model.addAttribute("minDate", minDate);
        model.addAttribute("maxDate", maxDate);
        model.addAttribute("maxSeats", darshan.getMaxBookingsPerSlot());
        model.addAttribute("availableSeatsToday", availableSeats);
        model.addAttribute("bookingStartDate", darshan.getBookingStartDate());
        model.addAttribute("bookingEndDate", darshan.getBookingEndDate());
        return "booking/darshan";
    }
    
    @GetMapping("/api/darshan/{darshanId}/available-seats")
    @ResponseBody
    public Map<String, Object> getAvailableSeats(@PathVariable Long darshanId,
                                                  @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date) {
        Darshan darshan = darshanService.findById(darshanId)
                .orElseThrow(() -> new RuntimeException("Darshan not found"));
        
        Integer maxSeats = darshan.getMaxBookingsPerSlot();
        Integer availableSeats = maxSeats != null ? darshanService.getAvailableSlots(darshan, date) : null;
        Integer bookedSeats = maxSeats != null ? darshanService.getTotalSeatsBooked(darshan, date) : null;
        
        Map<String, Object> response = new HashMap<>();
        response.put("maxSeats", maxSeats);
        response.put("availableSeats", availableSeats);
        response.put("bookedSeats", bookedSeats);
        response.put("hasLimit", maxSeats != null);
        
        return response;
    }
    
    @PostMapping("/darshan/{darshanId}")
    public String bookDarshan(@PathVariable Long darshanId,
                              @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate bookingDate,
                              @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.TIME) LocalTime slotTime,
                              @RequestParam Integer numberOfPersons,
                              @RequestParam String primaryDevoteeName,
                              @RequestParam String primaryDevoteePhone,
                              @RequestParam(required = false) String additionalDevoteeNames,
                              @RequestParam(required = false) String notes,
                              Authentication authentication,
                              RedirectAttributes redirectAttributes) {
        try {
            User user = userService.findByEmail(authentication.getName())
                    .orElseThrow(() -> new RuntimeException("User not found"));
            
            Darshan darshan = darshanService.findById(darshanId)
                    .orElseThrow(() -> new RuntimeException("Darshan not found"));
            
            if (!darshanService.isBookingDateValid(darshan, bookingDate)) {
                String errorMsg = "Booking not available for selected date.";
                if (darshan.getBookingStartDate() != null && darshan.getBookingEndDate() != null) {
                    errorMsg = "Booking is only available from " + darshan.getBookingStartDate() + " to " + darshan.getBookingEndDate() + ".";
                } else if (darshan.getBookingStartDate() != null) {
                    errorMsg = "Booking is only available from " + darshan.getBookingStartDate() + " onwards.";
                } else if (darshan.getBookingEndDate() != null) {
                    errorMsg = "Booking is only available until " + darshan.getBookingEndDate() + ".";
                }
                redirectAttributes.addFlashAttribute("error", errorMsg);
                return "redirect:/pilgrim/temple/booking/darshan/" + darshanId;
            }
            
            if (darshan.getStartTime() != null && darshan.getEndTime() != null) {
                if (slotTime == null) {
                    redirectAttributes.addFlashAttribute("error", "Please select a preferred slot time. Available time period is " + darshan.getStartTime() + " to " + darshan.getEndTime() + ".");
                    return "redirect:/pilgrim/temple/booking/darshan/" + darshanId;
                }
                
                if (slotTime.isBefore(darshan.getStartTime()) || slotTime.isAfter(darshan.getEndTime())) {
                    redirectAttributes.addFlashAttribute("error", "Selected time must be between " + darshan.getStartTime() + " and " + darshan.getEndTime() + ". Please select a time within the allowed period.");
                    return "redirect:/pilgrim/temple/booking/darshan/" + darshanId;
                }
            }
            
            if (!darshanService.canBookSlot(darshan, bookingDate, numberOfPersons)) {
                Integer available = darshanService.getAvailableSlots(darshan, bookingDate);
                if (available != null && available > 0) {
                    redirectAttributes.addFlashAttribute("error", "Only " + available + " seat(s) available for this date. You are trying to book " + numberOfPersons + " seat(s). Please reduce the number of persons.");
                } else {
                    redirectAttributes.addFlashAttribute("error", "No seats available for selected date. All " + darshan.getMaxBookingsPerSlot() + " seat(s) are already booked.");
                }
                return "redirect:/pilgrim/temple/booking/darshan/" + darshanId;
            }
            
            DarshanBooking booking = DarshanBooking.builder()
                    .user(user)
                    .darshan(darshan)
                    .bookingDate(bookingDate)
                    .slotTime(slotTime)
                    .numberOfPersons(numberOfPersons)
                    .primaryDevoteeName(primaryDevoteeName)
                    .primaryDevoteePhone(primaryDevoteePhone)
                    .additionalDevoteeNames(additionalDevoteeNames)
                    .notes(notes)
                    .build();
            
            DarshanBooking savedBooking = darshanService.createBooking(booking);
            redirectAttributes.addFlashAttribute("success", "Booking successful! Booking Number: " + savedBooking.getBookingNumber());
            return "redirect:/pilgrim/temple/user/bookings/darshan/" + savedBooking.getId();
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Booking failed: " + e.getMessage());
            return "redirect:/pilgrim/temple/booking/darshan/" + darshanId;
        }
    }
    
    // ============ POOJA BOOKING ============
    
    @GetMapping("/pooja/{poojaId}")
    public String poojaBookingPage(@PathVariable Long poojaId, Model model) {
        TemplePooja pooja = poojaService.findById(poojaId)
                .orElseThrow(() -> new RuntimeException("Pooja not found"));
        
        model.addAttribute("pooja", pooja);
        model.addAttribute("temple", pooja.getTemple());
        model.addAttribute("minDate", LocalDate.now().plusDays(pooja.isRequiresAdvanceBooking() ? 1 : 0));
        model.addAttribute("maxDate", LocalDate.now().plusDays(pooja.getAdvanceBookingDays() != null ? pooja.getAdvanceBookingDays() : 30));
        return "booking/pooja";
    }
    
    @PostMapping("/pooja/{poojaId}")
    public String bookPooja(@PathVariable Long poojaId,
                           @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate bookingDate,
                           @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.TIME) LocalTime preferredTime,
                           @RequestParam String devoteeName,
                           @RequestParam(required = false) String gotra,
                           @RequestParam(required = false) String nakshatra,
                           @RequestParam(required = false) String rashi,
                           @RequestParam(required = false) String familyMemberNames,
                           @RequestParam(required = false) String specialRequests,
                           @RequestParam(required = false, defaultValue = "false") boolean prasadhamRequired,
                           @RequestParam(required = false) String deliveryAddress,
                           Authentication authentication,
                           RedirectAttributes redirectAttributes) {
        try {
            User user = userService.findByEmail(authentication.getName())
                    .orElseThrow(() -> new RuntimeException("User not found"));
            
            TemplePooja pooja = poojaService.findById(poojaId)
                    .orElseThrow(() -> new RuntimeException("Pooja not found"));
            
            if (!poojaService.isDateAvailable(pooja, bookingDate)) {
                redirectAttributes.addFlashAttribute("error", "Pooja not available for selected date");
                return "redirect:/pilgrim/temple/booking/pooja/" + poojaId;
            }
            
            PoojaBooking booking = PoojaBooking.builder()
                    .user(user)
                    .pooja(pooja)
                    .bookingDate(bookingDate)
                    .preferredTime(preferredTime)
                    .devoteeName(devoteeName)
                    .gotra(gotra)
                    .nakshatra(nakshatra)
                    .rashi(rashi)
                    .familyMemberNames(familyMemberNames)
                    .specialRequests(specialRequests)
                    .prasadhamRequired(prasadhamRequired)
                    .deliveryAddress(deliveryAddress)
                    .build();
            
            PoojaBooking savedBooking = poojaService.createBooking(booking);
            redirectAttributes.addFlashAttribute("success", "Booking successful! Booking Number: " + savedBooking.getBookingNumber());
            return "redirect:/pilgrim/temple/user/bookings/pooja/" + savedBooking.getId();
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Booking failed: " + e.getMessage());
            return "redirect:/pilgrim/temple/booking/pooja/" + poojaId;
        }
    }
    
    // ============ PRASADHAM ORDER ============
    
    @GetMapping("/prasadham/{prasadhamId}")
    public String prasadhamOrderPage(@PathVariable Long prasadhamId, Model model) {
        Prasadham prasadham = prasadhamService.findById(prasadhamId)
                .orElseThrow(() -> new RuntimeException("Prasadham not found"));
        
        model.addAttribute("prasadham", prasadham);
        model.addAttribute("temple", prasadham.getTemple());
        return "booking/prasadham";
    }
    
    @PostMapping("/prasadham/{prasadhamId}")
    public String orderPrasadham(@PathVariable Long prasadhamId,
                                @RequestParam Integer quantity,
                                @RequestParam(required = false, defaultValue = "false") boolean forDelivery,
                                @RequestParam(required = false) String recipientName,
                                @RequestParam(required = false) String recipientPhone,
                                @RequestParam(required = false) String deliveryAddress,
                                @RequestParam(required = false) String city,
                                @RequestParam(required = false) String state,
                                @RequestParam(required = false) String pincode,
                                @RequestParam(required = false) String notes,
                                Authentication authentication,
                                RedirectAttributes redirectAttributes) {
        try {
            User user = userService.findByEmail(authentication.getName())
                    .orElseThrow(() -> new RuntimeException("User not found"));
            
            Prasadham prasadham = prasadhamService.findById(prasadhamId)
                    .orElseThrow(() -> new RuntimeException("Prasadham not found"));
            
            if (prasadham.getStockQuantity() != null && prasadham.getStockQuantity() < quantity) {
                redirectAttributes.addFlashAttribute("error", "Insufficient stock available");
                return "redirect:/pilgrim/temple/booking/prasadham/" + prasadhamId;
            }
            
            PrasadhamOrder order = PrasadhamOrder.builder()
                    .user(user)
                    .prasadham(prasadham)
                    .quantity(quantity)
                    .forDelivery(forDelivery)
                    .recipientName(recipientName)
                    .recipientPhone(recipientPhone)
                    .deliveryAddress(deliveryAddress)
                    .city(city)
                    .state(state)
                    .pincode(pincode)
                    .notes(notes)
                    .build();
            
            PrasadhamOrder savedOrder = prasadhamService.createOrder(order);
            redirectAttributes.addFlashAttribute("success", "Order successful! Order Number: " + savedOrder.getOrderNumber());
            return "redirect:/pilgrim/temple/user/orders/prasadham/" + savedOrder.getId();
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Order failed: " + e.getMessage());
            return "redirect:/pilgrim/temple/booking/prasadham/" + prasadhamId;
        }
    }
    
    // ============ TOUR GUIDE BOOKING ============
    
    @GetMapping("/tour-guide/{guideId}")
    public String tourGuideBookingPage(@PathVariable Long guideId, Model model) {
        TourGuide guide = tourGuideService.findById(guideId)
                .orElseThrow(() -> new RuntimeException("Tour guide not found"));
        
        model.addAttribute("tourGuide", guide);
        model.addAttribute("temple", guide.getTemple());
        model.addAttribute("tourTypes", TourBooking.TourType.values());
        model.addAttribute("minDate", LocalDate.now().plusDays(1));
        model.addAttribute("maxDate", LocalDate.now().plusDays(30));
        return "booking/tour-guide";
    }
    
    @PostMapping("/tour-guide/{guideId}")
    public String bookTourGuide(@PathVariable Long guideId,
                               @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate tourDate,
                               @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.TIME) LocalTime startTime,
                               @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.TIME) LocalTime endTime,
                               @RequestParam TourBooking.TourType tourType,
                               @RequestParam Integer numberOfPersons,
                               @RequestParam String contactName,
                               @RequestParam String contactPhone,
                               @RequestParam(required = false) String preferredLanguage,
                               @RequestParam(required = false) String specialRequirements,
                               Authentication authentication,
                               RedirectAttributes redirectAttributes) {
        try {
            User user = userService.findByEmail(authentication.getName())
                    .orElseThrow(() -> new RuntimeException("User not found"));
            
            TourGuide guide = tourGuideService.findById(guideId)
                    .orElseThrow(() -> new RuntimeException("Tour guide not found"));
            
            if (!tourGuideService.isGuideAvailable(guide, tourDate)) {
                redirectAttributes.addFlashAttribute("error", "Guide not available for selected date");
                return "redirect:/pilgrim/temple/booking/tour-guide/" + guideId;
            }
            
            TourBooking booking = TourBooking.builder()
                    .user(user)
                    .tourGuide(guide)
                    .tourDate(tourDate)
                    .startTime(startTime)
                    .endTime(endTime)
                    .tourType(tourType)
                    .numberOfPersons(numberOfPersons)
                    .contactName(contactName)
                    .contactPhone(contactPhone)
                    .preferredLanguage(preferredLanguage)
                    .specialRequirements(specialRequirements)
                    .build();
            
            TourBooking savedBooking = tourGuideService.createBooking(booking);
            redirectAttributes.addFlashAttribute("success", "Booking successful! Booking Number: " + savedBooking.getBookingNumber());
            return "redirect:/pilgrim/temple/user/bookings/tour/" + savedBooking.getId();
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Booking failed: " + e.getMessage());
            return "redirect:/pilgrim/temple/booking/tour-guide/" + guideId;
        }
    }
}

