package com.pilgrim.controller;

import com.pilgrim.entity.*;
import com.pilgrim.enums.DarshanType;
import com.pilgrim.enums.PhotoCategory;
import com.pilgrim.enums.Religion;
import com.pilgrim.service.*;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/pilgrim/temple/admin")
@RequiredArgsConstructor
public class TempleAdminController {
    
    private final TempleService templeService;
    private final DarshanService darshanService;
    private final TemplePoojaService poojaService;
    private final PrasadhamService prasadhamService;
    private final TourGuideService tourGuideService;
    private final TempleDonationService donationService;
    private final com.pilgrim.service.UserService userService;
    
    // Explicit constructor for compatibility (if Lombok @RequiredArgsConstructor doesn't work)
    public TempleAdminController(TempleService templeService, DarshanService darshanService,
                                 TemplePoojaService poojaService, PrasadhamService prasadhamService,
                                 TourGuideService tourGuideService, TempleDonationService donationService,
                                 com.pilgrim.service.UserService userService) {
        this.templeService = templeService;
        this.darshanService = darshanService;
        this.poojaService = poojaService;
        this.prasadhamService = prasadhamService;
        this.tourGuideService = tourGuideService;
        this.donationService = donationService;
        this.userService = userService;
    }
    
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        String userEmail = (String) session.getAttribute("userEmail");
        if (userEmail == null) {
            return "redirect:/login";
        }
        User admin = userService.findByEmail(userEmail)
                .orElseThrow(() -> new RuntimeException("User not found"));
        
        List<Temple> temples;
        boolean hasTemple = false;
        
        if (admin.getReligion() != null) {
            List<Temple> allTemples = templeService.findTemplesByAdminAndReligionAll(admin, admin.getReligion());
            hasTemple = !allTemples.isEmpty();
            temples = templeService.findTemplesByAdminAndReligion(admin, admin.getReligion());
        } else {
            List<Temple> allTemples = templeService.findTemplesByAdminAll(admin);
            hasTemple = !allTemples.isEmpty();
            temples = templeService.findTemplesByAdmin(admin);
        }
        
        model.addAttribute("temples", temples);
        model.addAttribute("hasTemple", hasTemple);
        model.addAttribute("adminReligion", admin.getReligion());
        
        return "temple-admin/dashboard";
    }
    
    // ============ TEMPLE MANAGEMENT ============
    
    @GetMapping("/temple/add")
    public String addTemplePage(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        String userEmail = (String) session.getAttribute("userEmail");
        if (userEmail == null) {
            redirectAttributes.addFlashAttribute("error", "Please login to add a temple");
            return "redirect:/login";
        }
        User admin = userService.findByEmail(userEmail)
                .orElseThrow(() -> new RuntimeException("User not found"));
        
        if (admin.getReligion() != null) {
            List<Temple> existingTemples = templeService.findTemplesByAdminAndReligionAll(admin, admin.getReligion());
            if (!existingTemples.isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "You can only add one temple per religion. You already have a temple.");
                return "redirect:/pilgrim/temple/admin/dashboard";
            }
        } else {
            List<Temple> existingTemples = templeService.findTemplesByAdminAll(admin);
            if (!existingTemples.isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "You can only add one temple. You already have a temple.");
                return "redirect:/pilgrim/temple/admin/dashboard";
            }
        }
        
        Temple temple = new Temple();
        if (admin.getReligion() != null) {
            temple.setReligion(admin.getReligion());
        }
        model.addAttribute("temple", temple);
        model.addAttribute("adminReligion", admin.getReligion());
        return "temple-admin/temple-form";
    }
    
    @PostMapping("/temple/add")
    public String addTemple(@ModelAttribute Temple temple,
                           HttpSession session,
                           RedirectAttributes redirectAttributes) {
        try {
            String userEmail = (String) session.getAttribute("userEmail");
            if (userEmail == null) {
                redirectAttributes.addFlashAttribute("error", "Please login to add a temple");
                return "redirect:/login";
            }
            User admin = userService.findByEmail(userEmail)
                    .orElseThrow(() -> new RuntimeException("User not found"));
            
            temple.setAdmin(admin);
            if (temple.getReligion() == null && admin.getReligion() != null) {
                temple.setReligion(admin.getReligion());
            }
            
            Religion templeReligion = temple.getReligion() != null ? temple.getReligion() : admin.getReligion();
            if (templeReligion != null) {
                List<Temple> existingTemples = templeService.findTemplesByAdminAndReligionAll(admin, templeReligion);
                if (!existingTemples.isEmpty()) {
                    redirectAttributes.addFlashAttribute("error", "You can only add one temple per religion. You already have a temple for " + templeReligion.getDisplayName() + " religion.");
                    return "redirect:/pilgrim/temple/admin/dashboard";
                }
            } else {
                List<Temple> existingTemples = templeService.findTemplesByAdminAll(admin);
                if (!existingTemples.isEmpty()) {
                    redirectAttributes.addFlashAttribute("error", "You can only add one temple. You already have a temple.");
                    return "redirect:/pilgrim/temple/admin/dashboard";
                }
            }
            
            templeService.createTemple(temple);
            redirectAttributes.addFlashAttribute("success", "Temple added successfully!");
            return "redirect:/pilgrim/temple/admin/dashboard";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to add temple: " + e.getMessage());
            return "redirect:/pilgrim/temple/admin/temple/add";
        }
    }
    
    @GetMapping("/temple/{templeId}/edit")
    public String editTemplePage(@PathVariable Long templeId, 
                                  HttpSession session,
                                  Model model,
                                  RedirectAttributes redirectAttributes) {
        String userEmail = (String) session.getAttribute("userEmail");
        if (userEmail == null) {
            redirectAttributes.addFlashAttribute("error", "Please login to edit a temple");
            return "redirect:/login";
        }
        User admin = userService.findByEmail(userEmail)
                .orElseThrow(() -> new RuntimeException("User not found"));
        
        Temple temple = templeService.findById(templeId)
                .orElseThrow(() -> new RuntimeException("Temple not found"));
        
        if (admin.getReligion() != null && temple.getReligion() != admin.getReligion()) {
            redirectAttributes.addFlashAttribute("error", "You can only manage temples of your religion!");
            return "redirect:/pilgrim/temple/admin/dashboard";
        }
        
        model.addAttribute("temple", temple);
        model.addAttribute("adminReligion", admin.getReligion());
        return "temple-admin/temple-form";
    }
    
    @PostMapping("/temple/{templeId}/edit")
    public String editTemple(@PathVariable Long templeId,
                            @ModelAttribute Temple updatedTemple,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {
        try {
            String userEmail = (String) session.getAttribute("userEmail");
            if (userEmail == null) {
                redirectAttributes.addFlashAttribute("error", "Please login to edit a temple");
                return "redirect:/login";
            }
            User admin = userService.findByEmail(userEmail)
                    .orElseThrow(() -> new RuntimeException("User not found"));
            
            Temple temple = templeService.findById(templeId)
                    .orElseThrow(() -> new RuntimeException("Temple not found"));
            
            if (admin.getReligion() != null && temple.getReligion() != admin.getReligion()) {
                redirectAttributes.addFlashAttribute("error", "You can only manage temples of your religion!");
                return "redirect:/pilgrim/temple/admin/dashboard";
            }
            
            temple.setName(updatedTemple.getName());
            temple.setNameHindi(updatedTemple.getNameHindi());
            temple.setDescription(updatedTemple.getDescription());
            temple.setDescriptionHindi(updatedTemple.getDescriptionHindi());
            temple.setHistory(updatedTemple.getHistory());
            temple.setHistoryHindi(updatedTemple.getHistoryHindi());
            temple.setMainDeity(updatedTemple.getMainDeity());
            temple.setAddress(updatedTemple.getAddress());
            temple.setCity(updatedTemple.getCity());
            temple.setState(updatedTemple.getState());
            temple.setPincode(updatedTemple.getPincode());
            temple.setPhone(updatedTemple.getPhone());
            temple.setEmail(updatedTemple.getEmail());
            temple.setWebsite(updatedTemple.getWebsite());
            temple.setLatitude(updatedTemple.getLatitude());
            temple.setLongitude(updatedTemple.getLongitude());
            temple.setMapEmbedUrl(updatedTemple.getMapEmbedUrl());
            temple.setMorningOpenTime(updatedTemple.getMorningOpenTime());
            temple.setMorningCloseTime(updatedTemple.getMorningCloseTime());
            temple.setEveningOpenTime(updatedTemple.getEveningOpenTime());
            temple.setEveningCloseTime(updatedTemple.getEveningCloseTime());
            temple.setSpecialTimings(updatedTemple.getSpecialTimings());
            temple.setRules(updatedTemple.getRules());
            temple.setRulesHindi(updatedTemple.getRulesHindi());
            
            temple.setPastorName(updatedTemple.getPastorName());
            temple.setDenomination(updatedTemple.getDenomination());
            temple.setMassTimes(updatedTemple.getMassTimes());
            temple.setConfessionTimes(updatedTemple.getConfessionTimes());
            temple.setChurchType(updatedTemple.getChurchType());
            temple.setImamName(updatedTemple.getImamName());
            temple.setPrayerTimes(updatedTemple.getPrayerTimes());
            temple.setQiblaDirection(updatedTemple.getQiblaDirection());
            temple.setMosqueType(updatedTemple.getMosqueType());
            temple.setTirthankara(updatedTemple.getTirthankara());
            temple.setJainSect(updatedTemple.getJainSect());
            temple.setJainRituals(updatedTemple.getJainRituals());
            temple.setBuddhaStatue(updatedTemple.getBuddhaStatue());
            temple.setBuddhistSect(updatedTemple.getBuddhistSect());
            temple.setMeditationTimes(updatedTemple.getMeditationTimes());
            
            templeService.updateTemple(temple);
            redirectAttributes.addFlashAttribute("success", "Temple updated successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Update failed: " + e.getMessage());
        }
        return "redirect:/pilgrim/temple/admin/temple/" + templeId + "/edit";
    }
    
    // ============ PHOTO MANAGEMENT ============
    
    @GetMapping("/temple/{templeId}/photos")
    public String managePhotos(@PathVariable Long templeId, Model model) {
        Temple temple = templeService.findById(templeId)
                .orElseThrow(() -> new RuntimeException("Temple not found"));
        model.addAttribute("temple", temple);
        model.addAttribute("photos", templeService.getTemplePhotos(temple));
        model.addAttribute("categories", PhotoCategory.values());
        return "temple-admin/photos";
    }
    
    @PostMapping("/temple/{templeId}/photos/add")
    public String addPhoto(@PathVariable Long templeId,
                          @RequestParam("file") MultipartFile file,
                          @RequestParam String title,
                          @RequestParam(required = false) String description,
                          @RequestParam PhotoCategory category,
                          RedirectAttributes redirectAttributes) {
        try {
            Temple temple = templeService.findById(templeId)
                    .orElseThrow(() -> new RuntimeException("Temple not found"));
            templeService.addPhoto(temple, file, title, description, category);
            redirectAttributes.addFlashAttribute("success", "Photo added successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to add photo: " + e.getMessage());
        }
        return "redirect:/pilgrim/temple/admin/temple/" + templeId + "/photos";
    }
    
    // ============ DARSHAN MANAGEMENT ============
    
    @GetMapping("/temple/{templeId}/darshans")
    public String manageDarshans(@PathVariable Long templeId, Model model) {
        Temple temple = templeService.findById(templeId)
                .orElseThrow(() -> new RuntimeException("Temple not found"));
        List<Darshan> darshans = darshanService.findByTemple(temple);
        
        java.time.LocalDate today = java.time.LocalDate.now();
        java.util.Map<Long, SeatStatus> seatStatuses = new java.util.HashMap<>();
        for (Darshan darshan : darshans) {
            if (darshan.getMaxBookingsPerSlot() != null) {
                Integer bookedSeats = darshanService.getTotalSeatsBooked(darshan, today);
                Integer availableSeats = Math.max(0, darshan.getMaxBookingsPerSlot() - bookedSeats);
                seatStatuses.put(darshan.getId(), new SeatStatus(bookedSeats, availableSeats));
            }
        }
        
        model.addAttribute("temple", temple);
        model.addAttribute("darshans", darshans);
        model.addAttribute("darshanTypes", getDarshanTypesForReligion(temple.getReligion()));
        model.addAttribute("templeReligion", temple.getReligion());
        model.addAttribute("seatStatuses", seatStatuses);
        return "temple-admin/darshans";
    }
    
    public static class SeatStatus {
        private final Integer booked;
        private final Integer available;
        
        public SeatStatus(Integer booked, Integer available) {
            this.booked = booked;
            this.available = available;
        }
        
        public Integer getBooked() { return booked; }
        public Integer getAvailable() { return available; }
    }
    
    private DarshanType[] getDarshanTypesForReligion(Religion religion) {
        if (religion == null || religion == Religion.HINDU || religion == Religion.JAIN) {
            return new DarshanType[]{
                DarshanType.FREE, DarshanType.SPECIAL, DarshanType.VIP, 
                DarshanType.VVIP, DarshanType.SENIOR_CITIZEN, DarshanType.PHYSICALLY_CHALLENGED
            };
        } else if (religion == Religion.CHRISTIAN) {
            return new DarshanType[]{
                DarshanType.REGULAR_SERVICE, DarshanType.MASS, DarshanType.CONFESSION,
                DarshanType.BAPTISM, DarshanType.MARRIAGE, DarshanType.FUNERAL
            };
        } else if (religion == Religion.MUSLIM) {
            return new DarshanType[]{
                DarshanType.FAJR, DarshanType.DHUHR, DarshanType.ASR,
                DarshanType.MAGHRIB, DarshanType.ISHA, DarshanType.JUMAH, DarshanType.TARAWEEH
            };
        } else if (religion == Religion.BUDDHISM) {
            return new DarshanType[]{
                DarshanType.MEDITATION, DarshanType.DHARMA_TALK, DarshanType.CHANTING,
                DarshanType.OFFERING, DarshanType.BODHI_PUJA
            };
        }
        return DarshanType.values();
    }
    
    @PostMapping("/temple/{templeId}/darshans/add")
    public String addDarshan(@PathVariable Long templeId,
                            @RequestParam String name,
                            @RequestParam(required = false) String nameHindi,
                            @RequestParam DarshanType darshanType,
                            @RequestParam(required = false) String description,
                            @RequestParam(required = false) BigDecimal price,
                            @RequestParam(required = false) String startTime,
                            @RequestParam(required = false) String endTime,
                            @RequestParam Integer maxBookingsPerSlot,
                            @RequestParam(required = false) Integer durationMinutes,
                            @RequestParam(required = false) String benefits,
                            @RequestParam(required = false) String instructions,
                            @RequestParam(required = false, defaultValue = "true") boolean requiresBooking,
                            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate bookingStartDate,
                            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate bookingEndDate,
                            RedirectAttributes redirectAttributes) {
        try {
            Temple temple = templeService.findById(templeId)
                    .orElseThrow(() -> new RuntimeException("Temple not found"));
            
            LocalTime startTimeObj = null;
            LocalTime endTimeObj = null;
            
            if (startTime != null && !startTime.isEmpty()) {
                startTimeObj = LocalTime.parse(startTime);
            }
            if (endTime != null && !endTime.isEmpty()) {
                endTimeObj = LocalTime.parse(endTime);
            }
            
            Darshan darshan = Darshan.builder()
                    .temple(temple)
                    .name(name)
                    .nameHindi(nameHindi)
                    .darshanType(darshanType)
                    .description(description)
                    .price(price)
                    .startTime(startTimeObj)
                    .endTime(endTimeObj)
                    .maxBookingsPerSlot(maxBookingsPerSlot)
                    .durationMinutes(durationMinutes)
                    .benefits(benefits)
                    .instructions(instructions)
                    .requiresBooking(requiresBooking)
                    .bookingStartDate(bookingStartDate)
                    .bookingEndDate(bookingEndDate)
                    .build();
            
            darshanService.createDarshan(darshan);
            redirectAttributes.addFlashAttribute("success", "Darshan added successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to add darshan: " + e.getMessage());
        }
        return "redirect:/pilgrim/temple/admin/temple/" + templeId + "/darshans";
    }
    
    @GetMapping("/temple/{templeId}/darshans/{darshanId}/edit")
    public String editDarshanPage(@PathVariable Long templeId, @PathVariable Long darshanId, Model model) {
        Temple temple = templeService.findById(templeId)
                .orElseThrow(() -> new RuntimeException("Temple not found"));
        Darshan darshan = darshanService.findById(darshanId)
                .orElseThrow(() -> new RuntimeException("Darshan not found"));
        
        if (!darshan.getTemple().getId().equals(templeId)) {
            throw new RuntimeException("Darshan does not belong to this temple");
        }
        
        model.addAttribute("temple", temple);
        model.addAttribute("darshan", darshan);
        model.addAttribute("darshanTypes", getDarshanTypesForReligion(temple.getReligion()));
        model.addAttribute("templeReligion", temple.getReligion());
        return "temple-admin/darshan-edit";
    }
    
    @PostMapping("/temple/{templeId}/darshans/{darshanId}/edit")
    public String editDarshan(@PathVariable Long templeId,
                              @PathVariable Long darshanId,
                              @RequestParam String name,
                              @RequestParam(required = false) String nameHindi,
                              @RequestParam DarshanType darshanType,
                              @RequestParam(required = false) String description,
                              @RequestParam(required = false) BigDecimal price,
                              @RequestParam(required = false) String startTime,
                              @RequestParam(required = false) String endTime,
                              @RequestParam Integer maxBookingsPerSlot,
                              @RequestParam(required = false) Integer durationMinutes,
                              @RequestParam(required = false) String benefits,
                              @RequestParam(required = false) String instructions,
                              @RequestParam(required = false, defaultValue = "true") boolean requiresBooking,
                              @RequestParam(required = false, defaultValue = "true") boolean isActive,
                              @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate bookingStartDate,
                              @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate bookingEndDate,
                              RedirectAttributes redirectAttributes) {
        try {
            Darshan darshan = darshanService.findById(darshanId)
                    .orElseThrow(() -> new RuntimeException("Darshan not found"));
            
            if (!darshan.getTemple().getId().equals(templeId)) {
                redirectAttributes.addFlashAttribute("error", "Unauthorized access");
                return "redirect:/pilgrim/temple/admin/temple/" + templeId + "/darshans";
            }
            
            LocalTime startTimeObj = null;
            LocalTime endTimeObj = null;
            
            if (startTime != null && !startTime.isEmpty()) {
                startTimeObj = LocalTime.parse(startTime);
            }
            if (endTime != null && !endTime.isEmpty()) {
                endTimeObj = LocalTime.parse(endTime);
            }
            
            darshan.setName(name);
            darshan.setNameHindi(nameHindi);
            darshan.setDarshanType(darshanType);
            darshan.setDescription(description);
            darshan.setPrice(price);
            darshan.setStartTime(startTimeObj);
            darshan.setEndTime(endTimeObj);
            darshan.setMaxBookingsPerSlot(maxBookingsPerSlot);
            darshan.setDurationMinutes(durationMinutes);
            darshan.setBenefits(benefits);
            darshan.setInstructions(instructions);
            darshan.setRequiresBooking(requiresBooking);
            darshan.setIsActive(isActive);
            darshan.setBookingStartDate(bookingStartDate);
            darshan.setBookingEndDate(bookingEndDate);
            
            darshanService.updateDarshan(darshan);
            redirectAttributes.addFlashAttribute("success", "Darshan updated successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to update darshan: " + e.getMessage());
        }
        return "redirect:/pilgrim/temple/admin/temple/" + templeId + "/darshans";
    }
    
    @PostMapping("/temple/{templeId}/darshans/{darshanId}/delete")
    public String deleteDarshan(@PathVariable Long templeId,
                                @PathVariable Long darshanId,
                                RedirectAttributes redirectAttributes) {
        try {
            Darshan darshan = darshanService.findById(darshanId)
                    .orElseThrow(() -> new RuntimeException("Darshan not found"));
            
            if (!darshan.getTemple().getId().equals(templeId)) {
                redirectAttributes.addFlashAttribute("error", "Unauthorized access");
                return "redirect:/pilgrim/temple/admin/temple/" + templeId + "/darshans";
            }
            
            boolean hasBookings = darshanService.hasBookings(darshanId);
            
            darshanService.deleteDarshan(darshanId);
            
            if (hasBookings) {
                redirectAttributes.addFlashAttribute("success", "Darshan deactivated successfully! (Cannot delete darshan with existing bookings)");
            } else {
                redirectAttributes.addFlashAttribute("success", "Darshan deleted successfully!");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to delete darshan: " + e.getMessage());
        }
        return "redirect:/pilgrim/temple/admin/temple/" + templeId + "/darshans";
    }
    
    // ============ POOJA MANAGEMENT ============
    
    @GetMapping("/temple/{templeId}/poojas")
    public String managePoojas(@PathVariable Long templeId, Model model) {
        Temple temple = templeService.findById(templeId)
                .orElseThrow(() -> new RuntimeException("Temple not found"));
        model.addAttribute("temple", temple);
        model.addAttribute("poojas", poojaService.findByTemple(temple));
        model.addAttribute("categories", getPoojaCategoriesForReligion(temple.getReligion()));
        model.addAttribute("templeReligion", temple.getReligion());
        return "temple-admin/poojas";
    }
    
    private TemplePooja.PoojaCategory[] getPoojaCategoriesForReligion(Religion religion) {
        if (religion == null || religion == Religion.HINDU) {
            return new TemplePooja.PoojaCategory[]{
                TemplePooja.PoojaCategory.DAILY, TemplePooja.PoojaCategory.WEEKLY, TemplePooja.PoojaCategory.MONTHLY,
                TemplePooja.PoojaCategory.SPECIAL, TemplePooja.PoojaCategory.FESTIVAL, TemplePooja.PoojaCategory.ARCHANA,
                TemplePooja.PoojaCategory.ABHISHEKAM, TemplePooja.PoojaCategory.HOMAM, TemplePooja.PoojaCategory.SEVA
            };
        } else if (religion == Religion.CHRISTIAN) {
            return new TemplePooja.PoojaCategory[]{
                TemplePooja.PoojaCategory.SUNDAY_MASS, TemplePooja.PoojaCategory.WEEKDAY_MASS, TemplePooja.PoojaCategory.HOLY_MASS,
                TemplePooja.PoojaCategory.ROSARY, TemplePooja.PoojaCategory.NOVENA, TemplePooja.PoojaCategory.ADORATION,
                TemplePooja.PoojaCategory.BAPTISM_SERVICE, TemplePooja.PoojaCategory.CONFIRMATION, TemplePooja.PoojaCategory.MARRIAGE_SERVICE
            };
        } else if (religion == Religion.MUSLIM) {
            return new TemplePooja.PoojaCategory[]{
                TemplePooja.PoojaCategory.DAILY_PRAYER, TemplePooja.PoojaCategory.FRIDAY_PRAYER, TemplePooja.PoojaCategory.EID_PRAYER,
                TemplePooja.PoojaCategory.TARAWEEH, TemplePooja.PoojaCategory.TAHJJUD, TemplePooja.PoojaCategory.DUHA,
                TemplePooja.PoojaCategory.ISTIKHARA
            };
        } else if (religion == Religion.JAIN) {
            return new TemplePooja.PoojaCategory[]{
                TemplePooja.PoojaCategory.DAILY_RITUAL, TemplePooja.PoojaCategory.WEEKLY_RITUAL, TemplePooja.PoojaCategory.MONTHLY_RITUAL,
                TemplePooja.PoojaCategory.FESTIVAL_RITUAL, TemplePooja.PoojaCategory.ARCHANA, TemplePooja.PoojaCategory.ABHISHEKAM
            };
        } else if (religion == Religion.BUDDHISM) {
            return new TemplePooja.PoojaCategory[]{
                TemplePooja.PoojaCategory.DAILY_CEREMONY, TemplePooja.PoojaCategory.WEEKLY_CEREMONY, TemplePooja.PoojaCategory.MONTHLY_CEREMONY,
                TemplePooja.PoojaCategory.FESTIVAL_CEREMONY, TemplePooja.PoojaCategory.MEDITATION, TemplePooja.PoojaCategory.CHANTING,
                TemplePooja.PoojaCategory.OFFERING_CEREMONY
            };
        }
        return TemplePooja.PoojaCategory.values();
    }
    
    @PostMapping("/temple/{templeId}/poojas/add")
    public String addPooja(@PathVariable Long templeId,
                          @RequestParam String name,
                          @RequestParam(required = false) String nameHindi,
                          @RequestParam TemplePooja.PoojaCategory category,
                          @RequestParam(required = false) String description,
                          @RequestParam(required = false) String significance,
                          @RequestParam BigDecimal price,
                          @RequestParam(required = false) Integer durationMinutes,
                          @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.TIME) LocalTime defaultTime,
                          @RequestParam(required = false) Integer maxBookingsPerDay,
                          @RequestParam(required = false) String itemsIncluded,
                          @RequestParam(required = false) String benefits,
                          @RequestParam(required = false, defaultValue = "true") boolean requiresAdvanceBooking,
                          @RequestParam(required = false) Integer advanceBookingDays,
                          RedirectAttributes redirectAttributes) {
        try {
            Temple temple = templeService.findById(templeId)
                    .orElseThrow(() -> new RuntimeException("Temple not found"));
            
            TemplePooja pooja = TemplePooja.builder()
                    .temple(temple)
                    .name(name)
                    .nameHindi(nameHindi)
                    .category(category)
                    .description(description)
                    .significance(significance)
                    .price(price)
                    .durationMinutes(durationMinutes)
                    .defaultTime(defaultTime)
                    .maxBookingsPerDay(maxBookingsPerDay)
                    .itemsIncluded(itemsIncluded)
                    .benefits(benefits)
                    .requiresAdvanceBooking(requiresAdvanceBooking)
                    .advanceBookingDays(advanceBookingDays)
                    .build();
            
            poojaService.createPooja(pooja);
            redirectAttributes.addFlashAttribute("success", "Pooja added successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to add pooja: " + e.getMessage());
        }
        return "redirect:/pilgrim/temple/admin/temple/" + templeId + "/poojas";
    }
    
    @GetMapping("/temple/{templeId}/poojas/{poojaId}/edit")
    public String editPoojaPage(@PathVariable Long templeId, @PathVariable Long poojaId, Model model) {
        Temple temple = templeService.findById(templeId)
                .orElseThrow(() -> new RuntimeException("Temple not found"));
        TemplePooja pooja = poojaService.findById(poojaId)
                .orElseThrow(() -> new RuntimeException("Pooja not found"));
        
        if (!pooja.getTemple().getId().equals(templeId)) {
            throw new RuntimeException("Pooja does not belong to this temple");
        }
        
        model.addAttribute("temple", temple);
        model.addAttribute("pooja", pooja);
        model.addAttribute("categories", getPoojaCategoriesForReligion(temple.getReligion()));
        model.addAttribute("templeReligion", temple.getReligion());
        return "temple-admin/pooja-edit";
    }
    
    @PostMapping("/temple/{templeId}/poojas/{poojaId}/edit")
    public String editPooja(@PathVariable Long templeId,
                           @PathVariable Long poojaId,
                           @RequestParam String name,
                           @RequestParam(required = false) String nameHindi,
                           @RequestParam TemplePooja.PoojaCategory category,
                           @RequestParam(required = false) String description,
                           @RequestParam(required = false) String significance,
                           @RequestParam BigDecimal price,
                           @RequestParam(required = false) Integer durationMinutes,
                           @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.TIME) LocalTime defaultTime,
                           @RequestParam(required = false) Integer maxBookingsPerDay,
                           @RequestParam(required = false) String itemsIncluded,
                           @RequestParam(required = false) String benefits,
                           @RequestParam(required = false, defaultValue = "true") boolean requiresAdvanceBooking,
                           @RequestParam(required = false) Integer advanceBookingDays,
                           @RequestParam(required = false, defaultValue = "true") boolean isActive,
                           RedirectAttributes redirectAttributes) {
        try {
            TemplePooja pooja = poojaService.findById(poojaId)
                    .orElseThrow(() -> new RuntimeException("Pooja not found"));
            
            if (!pooja.getTemple().getId().equals(templeId)) {
                redirectAttributes.addFlashAttribute("error", "Unauthorized access");
                return "redirect:/pilgrim/temple/admin/temple/" + templeId + "/poojas";
            }
            
            pooja.setName(name);
            pooja.setNameHindi(nameHindi);
            pooja.setCategory(category);
            pooja.setDescription(description);
            pooja.setSignificance(significance);
            pooja.setPrice(price);
            pooja.setDurationMinutes(durationMinutes);
            pooja.setDefaultTime(defaultTime);
            pooja.setMaxBookingsPerDay(maxBookingsPerDay);
            pooja.setItemsIncluded(itemsIncluded);
            pooja.setBenefits(benefits);
            pooja.setRequiresAdvanceBooking(requiresAdvanceBooking);
            pooja.setAdvanceBookingDays(advanceBookingDays);
            pooja.setIsActive(isActive);
            
            poojaService.updatePooja(pooja);
            redirectAttributes.addFlashAttribute("success", "Pooja updated successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to update pooja: " + e.getMessage());
        }
        return "redirect:/pilgrim/temple/admin/temple/" + templeId + "/poojas";
    }
    
    @PostMapping("/temple/{templeId}/poojas/{poojaId}/delete")
    public String deletePooja(@PathVariable Long templeId,
                             @PathVariable Long poojaId,
                             RedirectAttributes redirectAttributes) {
        try {
            TemplePooja pooja = poojaService.findById(poojaId)
                    .orElseThrow(() -> new RuntimeException("Pooja not found"));
            
            if (!pooja.getTemple().getId().equals(templeId)) {
                redirectAttributes.addFlashAttribute("error", "Unauthorized access");
                return "redirect:/pilgrim/temple/admin/temple/" + templeId + "/poojas";
            }
            
            boolean hasBookings = poojaService.hasBookings(poojaId);
            
            poojaService.deletePooja(poojaId);
            
            if (hasBookings) {
                redirectAttributes.addFlashAttribute("success", "Pooja deactivated successfully! (Cannot delete pooja with existing bookings)");
            } else {
                redirectAttributes.addFlashAttribute("success", "Pooja deleted successfully!");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to delete pooja: " + e.getMessage());
        }
        return "redirect:/pilgrim/temple/admin/temple/" + templeId + "/poojas";
    }
    
    // ============ PRASADHAM MANAGEMENT ============
    
    @GetMapping("/temple/{templeId}/prasadhams")
    public String managePrasadhams(@PathVariable Long templeId, Model model) {
        Temple temple = templeService.findById(templeId)
                .orElseThrow(() -> new RuntimeException("Temple not found"));
        model.addAttribute("temple", temple);
        model.addAttribute("prasadhams", prasadhamService.findByTemple(temple));
        model.addAttribute("types", getPrasadhamTypesForReligion(temple.getReligion()));
        model.addAttribute("templeReligion", temple.getReligion());
        return "temple-admin/prasadhams";
    }
    
    private Prasadham.PrasadhamType[] getPrasadhamTypesForReligion(Religion religion) {
        if (religion == null || religion == Religion.HINDU || religion == Religion.JAIN) {
            return new Prasadham.PrasadhamType[]{
                Prasadham.PrasadhamType.LADDU, Prasadham.PrasadhamType.MODAK, Prasadham.PrasadhamType.PEDA,
                Prasadham.PrasadhamType.PANCHAMRIT, Prasadham.PrasadhamType.CHARNAMRIT, Prasadham.PrasadhamType.TULSI,
                Prasadham.PrasadhamType.VIBHUTI, Prasadham.PrasadhamType.KUMKUM, Prasadham.PrasadhamType.FLOWER,
                Prasadham.PrasadhamType.OTHER
            };
        } else if (religion == Religion.CHRISTIAN) {
            return new Prasadham.PrasadhamType[]{
                Prasadham.PrasadhamType.HOLY_BREAD, Prasadham.PrasadhamType.BLESSED_WATER, Prasadham.PrasadhamType.CONSECRATED_WINE,
                Prasadham.PrasadhamType.ROSARY, Prasadham.PrasadhamType.CHRISTIAN_CANDLE, Prasadham.PrasadhamType.CROSS,
                Prasadham.PrasadhamType.MEDAL, Prasadham.PrasadhamType.HOLY_CARD, Prasadham.PrasadhamType.OTHER
            };
        } else if (religion == Religion.MUSLIM) {
            return new Prasadham.PrasadhamType[]{
                Prasadham.PrasadhamType.DATES, Prasadham.PrasadhamType.ZAMZAM_WATER, Prasadham.PrasadhamType.HALAL_FOOD,
                Prasadham.PrasadhamType.MISWAK, Prasadham.PrasadhamType.TASBIH, Prasadham.PrasadhamType.QURAN,
                Prasadham.PrasadhamType.PRAYER_MAT, Prasadham.PrasadhamType.OTHER
            };
        } else if (religion == Religion.BUDDHISM) {
            return new Prasadham.PrasadhamType[]{
                Prasadham.PrasadhamType.INCENSE, Prasadham.PrasadhamType.BUDDHIST_CANDLE, Prasadham.PrasadhamType.FLOWERS,
                Prasadham.PrasadhamType.FRUITS, Prasadham.PrasadhamType.RICE, Prasadham.PrasadhamType.BUDDHA_STATUE,
                Prasadham.PrasadhamType.PRAYER_WHEEL, Prasadham.PrasadhamType.MALA, Prasadham.PrasadhamType.OTHER
            };
        }
        return Prasadham.PrasadhamType.values();
    }
    
    @PostMapping("/temple/{templeId}/prasadhams/add")
    public String addPrasadham(@PathVariable Long templeId,
                              @RequestParam String name,
                              @RequestParam(required = false) String nameHindi,
                              @RequestParam(required = false) String description,
                              @RequestParam BigDecimal price,
                              @RequestParam(required = false) Prasadham.PrasadhamType type,
                              @RequestParam(required = false) String weight,
                              @RequestParam(required = false, defaultValue = "true") boolean canBeDelivered,
                              @RequestParam(required = false) BigDecimal deliveryCharge,
                              @RequestParam(required = false) Integer stockQuantity,
                              @RequestParam(required = false) String ingredients,
                              @RequestParam(required = false) String shelfLife,
                              RedirectAttributes redirectAttributes) {
        try {
            Temple temple = templeService.findById(templeId)
                    .orElseThrow(() -> new RuntimeException("Temple not found"));
            
            Prasadham prasadham = Prasadham.builder()
                    .temple(temple)
                    .name(name)
                    .nameHindi(nameHindi)
                    .description(description)
                    .price(price)
                    .type(type)
                    .weight(weight)
                    .canBeDelivered(canBeDelivered)
                    .deliveryCharge(deliveryCharge)
                    .stockQuantity(stockQuantity)
                    .ingredients(ingredients)
                    .shelfLife(shelfLife)
                    .build();
            
            prasadhamService.createPrasadham(prasadham);
            redirectAttributes.addFlashAttribute("success", "Prasadham added successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to add prasadham: " + e.getMessage());
        }
        return "redirect:/pilgrim/temple/admin/temple/" + templeId + "/prasadhams";
    }
    
    @GetMapping("/temple/{templeId}/prasadhams/{prasadhamId}/edit")
    public String editPrasadhamPage(@PathVariable Long templeId, @PathVariable Long prasadhamId, Model model) {
        Temple temple = templeService.findById(templeId)
                .orElseThrow(() -> new RuntimeException("Temple not found"));
        Prasadham prasadham = prasadhamService.findById(prasadhamId)
                .orElseThrow(() -> new RuntimeException("Prasadham not found"));
        
        if (!prasadham.getTemple().getId().equals(templeId)) {
            throw new RuntimeException("Prasadham does not belong to this temple");
        }
        
        model.addAttribute("temple", temple);
        model.addAttribute("prasadham", prasadham);
        model.addAttribute("types", getPrasadhamTypesForReligion(temple.getReligion()));
        model.addAttribute("templeReligion", temple.getReligion());
        return "temple-admin/prasadham-edit";
    }
    
    @PostMapping("/temple/{templeId}/prasadhams/{prasadhamId}/edit")
    public String editPrasadham(@PathVariable Long templeId,
                               @PathVariable Long prasadhamId,
                               @RequestParam String name,
                               @RequestParam(required = false) String nameHindi,
                               @RequestParam(required = false) String description,
                               @RequestParam BigDecimal price,
                               @RequestParam(required = false) Prasadham.PrasadhamType type,
                               @RequestParam(required = false) String weight,
                               @RequestParam(required = false, defaultValue = "true") boolean canBeDelivered,
                               @RequestParam(required = false) BigDecimal deliveryCharge,
                               @RequestParam(required = false) Integer stockQuantity,
                               @RequestParam(required = false) String ingredients,
                               @RequestParam(required = false) String shelfLife,
                               @RequestParam(required = false, defaultValue = "true") boolean isAvailable,
                               RedirectAttributes redirectAttributes) {
        try {
            Prasadham prasadham = prasadhamService.findById(prasadhamId)
                    .orElseThrow(() -> new RuntimeException("Prasadham not found"));
            
            if (!prasadham.getTemple().getId().equals(templeId)) {
                redirectAttributes.addFlashAttribute("error", "Unauthorized access");
                return "redirect:/pilgrim/temple/admin/temple/" + templeId + "/prasadhams";
            }
            
            prasadham.setName(name);
            prasadham.setNameHindi(nameHindi);
            prasadham.setDescription(description);
            prasadham.setPrice(price);
            prasadham.setType(type);
            prasadham.setWeight(weight);
            prasadham.setCanBeDelivered(canBeDelivered);
            prasadham.setDeliveryCharge(deliveryCharge);
            prasadham.setStockQuantity(stockQuantity);
            prasadham.setIngredients(ingredients);
            prasadham.setShelfLife(shelfLife);
            prasadham.setIsAvailable(isAvailable);
            
            prasadhamService.updatePrasadham(prasadham);
            redirectAttributes.addFlashAttribute("success", "Prasadham updated successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to update prasadham: " + e.getMessage());
        }
        return "redirect:/pilgrim/temple/admin/temple/" + templeId + "/prasadhams";
    }
    
    @PostMapping("/temple/{templeId}/prasadhams/{prasadhamId}/delete")
    public String deletePrasadham(@PathVariable Long templeId,
                                 @PathVariable Long prasadhamId,
                                 RedirectAttributes redirectAttributes) {
        try {
            Prasadham prasadham = prasadhamService.findById(prasadhamId)
                    .orElseThrow(() -> new RuntimeException("Prasadham not found"));
            
            if (!prasadham.getTemple().getId().equals(templeId)) {
                redirectAttributes.addFlashAttribute("error", "Unauthorized access");
                return "redirect:/pilgrim/temple/admin/temple/" + templeId + "/prasadhams";
            }
            
            boolean hasOrders = prasadhamService.hasOrders(prasadhamId);
            
            prasadhamService.deletePrasadham(prasadhamId);
            
            if (hasOrders) {
                redirectAttributes.addFlashAttribute("success", "Prasadham deactivated successfully! (Cannot delete prasadham with existing orders)");
            } else {
                redirectAttributes.addFlashAttribute("success", "Prasadham deleted successfully!");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to delete prasadham: " + e.getMessage());
        }
        return "redirect:/pilgrim/temple/admin/temple/" + templeId + "/prasadhams";
    }
    
    // ============ FESTIVAL MANAGEMENT ============
    
    @GetMapping("/temple/{templeId}/festivals")
    public String manageFestivals(@PathVariable Long templeId, Model model) {
        Temple temple = templeService.findById(templeId)
                .orElseThrow(() -> new RuntimeException("Temple not found"));
        model.addAttribute("temple", temple);
        model.addAttribute("festivals", templeService.getTempleFestivals(temple));
        model.addAttribute("templeReligion", temple.getReligion());
        return "temple-admin/festivals";
    }
    
    @PostMapping("/temple/{templeId}/festivals/add")
    public String addFestival(@PathVariable Long templeId,
                             @RequestParam String name,
                             @RequestParam(required = false) String nameHindi,
                             @RequestParam(required = false) String description,
                             @RequestParam(required = false) String significance,
                             @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
                             @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate,
                             @RequestParam(required = false) String schedule,
                             @RequestParam(required = false) String specialPoojas,
                             @RequestParam(required = false) String specialRituals,
                             @RequestParam(required = false, defaultValue = "true") boolean isAnnual,
                             @RequestParam(required = false) String lunarDate,
                             RedirectAttributes redirectAttributes) {
        try {
            Temple temple = templeService.findById(templeId)
                    .orElseThrow(() -> new RuntimeException("Temple not found"));
            
            Festival festival = Festival.builder()
                    .temple(temple)
                    .name(name)
                    .nameHindi(nameHindi)
                    .description(description)
                    .significance(significance)
                    .startDate(startDate)
                    .endDate(endDate != null ? endDate : startDate)
                    .schedule(schedule)
                    .specialPoojas(specialPoojas)
                    .specialRituals(specialRituals)
                    .isAnnual(isAnnual)
                    .lunarDate(lunarDate)
                    .build();
            
            templeService.addFestival(festival);
            redirectAttributes.addFlashAttribute("success", "Festival added successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to add festival: " + e.getMessage());
        }
        return "redirect:/pilgrim/temple/admin/temple/" + templeId + "/festivals";
    }
    
    @GetMapping("/temple/{templeId}/festivals/{festivalId}/edit")
    public String editFestivalPage(@PathVariable Long templeId, @PathVariable Long festivalId, Model model) {
        Temple temple = templeService.findById(templeId)
                .orElseThrow(() -> new RuntimeException("Temple not found"));
        Festival festival = templeService.findFestivalById(festivalId)
                .orElseThrow(() -> new RuntimeException("Festival not found"));
        
        if (!festival.getTemple().getId().equals(templeId)) {
            throw new RuntimeException("Festival does not belong to this temple");
        }
        
        model.addAttribute("temple", temple);
        model.addAttribute("festival", festival);
        model.addAttribute("templeReligion", temple.getReligion());
        return "temple-admin/festival-edit";
    }
    
    @PostMapping("/temple/{templeId}/festivals/{festivalId}/edit")
    public String editFestival(@PathVariable Long templeId,
                              @PathVariable Long festivalId,
                              @RequestParam String name,
                              @RequestParam(required = false) String nameHindi,
                              @RequestParam(required = false) String description,
                              @RequestParam(required = false) String significance,
                              @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
                              @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate,
                              @RequestParam(required = false) String schedule,
                              @RequestParam(required = false) String specialPoojas,
                              @RequestParam(required = false) String specialRituals,
                              @RequestParam(required = false, defaultValue = "true") boolean isAnnual,
                              @RequestParam(required = false) String lunarDate,
                              @RequestParam(required = false, defaultValue = "true") boolean isActive,
                              RedirectAttributes redirectAttributes) {
        try {
            Festival festival = templeService.findFestivalById(festivalId)
                    .orElseThrow(() -> new RuntimeException("Festival not found"));
            
            if (!festival.getTemple().getId().equals(templeId)) {
                redirectAttributes.addFlashAttribute("error", "Unauthorized access");
                return "redirect:/pilgrim/temple/admin/temple/" + templeId + "/festivals";
            }
            
            festival.setName(name);
            festival.setNameHindi(nameHindi);
            festival.setDescription(description);
            festival.setSignificance(significance);
            festival.setStartDate(startDate);
            festival.setEndDate(endDate != null ? endDate : startDate);
            festival.setSchedule(schedule);
            festival.setSpecialPoojas(specialPoojas);
            festival.setSpecialRituals(specialRituals);
            festival.setAnnual(isAnnual);
            festival.setLunarDate(lunarDate);
            festival.setIsActive(isActive);
            
            templeService.addFestival(festival);
            redirectAttributes.addFlashAttribute("success", "Festival updated successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to update festival: " + e.getMessage());
        }
        return "redirect:/pilgrim/temple/admin/temple/" + templeId + "/festivals";
    }
    
    @PostMapping("/temple/{templeId}/festivals/{festivalId}/delete")
    public String deleteFestival(@PathVariable Long templeId,
                                @PathVariable Long festivalId,
                                RedirectAttributes redirectAttributes) {
        try {
            templeService.deleteFestival(festivalId);
            redirectAttributes.addFlashAttribute("success", "Festival deleted successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to delete festival: " + e.getMessage());
        }
        return "redirect:/pilgrim/temple/admin/temple/" + templeId + "/festivals";
    }
    
    // ============ RITUAL MANAGEMENT ============
    
    @GetMapping("/temple/{templeId}/rituals")
    public String manageRituals(@PathVariable Long templeId, Model model) {
        Temple temple = templeService.findById(templeId)
                .orElseThrow(() -> new RuntimeException("Temple not found"));
        model.addAttribute("temple", temple);
        model.addAttribute("rituals", templeService.getTempleRituals(temple));
        model.addAttribute("frequencies", Ritual.RitualFrequency.values());
        model.addAttribute("templeReligion", temple.getReligion());
        return "temple-admin/rituals";
    }
    
    @PostMapping("/temple/{templeId}/rituals/add")
    public String addRitual(@PathVariable Long templeId,
                           @RequestParam String name,
                           @RequestParam(required = false) String nameHindi,
                           @RequestParam(required = false) String description,
                           @RequestParam(required = false) String significance,
                           @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.TIME) LocalTime time,
                           @RequestParam(required = false) Integer durationMinutes,
                           @RequestParam(required = false) Ritual.RitualFrequency frequency,
                           @RequestParam(required = false) String procedure,
                           @RequestParam(required = false, defaultValue = "true") boolean isPublicAllowed,
                           @RequestParam(required = false) Integer displayOrder,
                           RedirectAttributes redirectAttributes) {
        try {
            Temple temple = templeService.findById(templeId)
                    .orElseThrow(() -> new RuntimeException("Temple not found"));
            
            Ritual ritual = Ritual.builder()
                    .temple(temple)
                    .name(name)
                    .nameHindi(nameHindi)
                    .description(description)
                    .significance(significance)
                    .time(time)
                    .durationMinutes(durationMinutes)
                    .frequency(frequency)
                    .ritualProcedure(procedure)
                    .isPublicAllowed(isPublicAllowed)
                    .displayOrder(displayOrder)
                    .build();
            
            templeService.addRitual(ritual);
            redirectAttributes.addFlashAttribute("success", "Ritual added successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to add ritual: " + e.getMessage());
        }
        return "redirect:/pilgrim/temple/admin/temple/" + templeId + "/rituals";
    }
    
    @GetMapping("/temple/{templeId}/rituals/{ritualId}/edit")
    public String editRitualPage(@PathVariable Long templeId, @PathVariable Long ritualId, Model model) {
        Temple temple = templeService.findById(templeId)
                .orElseThrow(() -> new RuntimeException("Temple not found"));
        Ritual ritual = templeService.findRitualById(ritualId)
                .orElseThrow(() -> new RuntimeException("Ritual not found"));
        
        if (!ritual.getTemple().getId().equals(templeId)) {
            throw new RuntimeException("Ritual does not belong to this temple");
        }
        
        model.addAttribute("temple", temple);
        model.addAttribute("ritual", ritual);
        model.addAttribute("frequencies", Ritual.RitualFrequency.values());
        model.addAttribute("templeReligion", temple.getReligion());
        return "temple-admin/ritual-edit";
    }
    
    @PostMapping("/temple/{templeId}/rituals/{ritualId}/edit")
    public String editRitual(@PathVariable Long templeId,
                            @PathVariable Long ritualId,
                            @RequestParam String name,
                            @RequestParam(required = false) String nameHindi,
                            @RequestParam(required = false) String description,
                            @RequestParam(required = false) String significance,
                            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.TIME) LocalTime time,
                            @RequestParam(required = false) Integer durationMinutes,
                            @RequestParam(required = false) Ritual.RitualFrequency frequency,
                            @RequestParam(required = false) String procedure,
                            @RequestParam(required = false, defaultValue = "true") boolean isPublicAllowed,
                            @RequestParam(required = false) Integer displayOrder,
                            @RequestParam(required = false, defaultValue = "true") boolean isActive,
                            RedirectAttributes redirectAttributes) {
        try {
            Ritual ritual = templeService.findRitualById(ritualId)
                    .orElseThrow(() -> new RuntimeException("Ritual not found"));
            
            if (!ritual.getTemple().getId().equals(templeId)) {
                redirectAttributes.addFlashAttribute("error", "Unauthorized access");
                return "redirect:/pilgrim/temple/admin/temple/" + templeId + "/rituals";
            }
            
            ritual.setName(name);
            ritual.setNameHindi(nameHindi);
            ritual.setDescription(description);
            ritual.setSignificance(significance);
            ritual.setTime(time);
            ritual.setDurationMinutes(durationMinutes);
            ritual.setFrequency(frequency);
            ritual.setRitualProcedure(procedure);
            ritual.setIsPublicAllowed(isPublicAllowed);
            ritual.setDisplayOrder(displayOrder);
            ritual.setIsActive(isActive);
            
            templeService.addRitual(ritual);
            redirectAttributes.addFlashAttribute("success", "Ritual updated successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to update ritual: " + e.getMessage());
        }
        return "redirect:/pilgrim/temple/admin/temple/" + templeId + "/rituals";
    }
    
    @PostMapping("/temple/{templeId}/rituals/{ritualId}/delete")
    public String deleteRitual(@PathVariable Long templeId,
                               @PathVariable Long ritualId,
                               RedirectAttributes redirectAttributes) {
        try {
            templeService.deleteRitual(ritualId);
            redirectAttributes.addFlashAttribute("success", "Ritual deleted successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to delete ritual: " + e.getMessage());
        }
        return "redirect:/pilgrim/temple/admin/temple/" + templeId + "/rituals";
    }
    
    // ============ TOUR GUIDE MANAGEMENT ============
    
    @GetMapping("/temple/{templeId}/tour-guides")
    public String manageTourGuides(@PathVariable Long templeId, Model model) {
        Temple temple = templeService.findById(templeId)
                .orElseThrow(() -> new RuntimeException("Temple not found"));
        model.addAttribute("temple", temple);
        model.addAttribute("tourGuides", tourGuideService.findByTemple(temple));
        return "temple-admin/tour-guides";
    }
    
    @PostMapping("/temple/{templeId}/tour-guides/add")
    public String addTourGuide(@PathVariable Long templeId,
                              @RequestParam String name,
                              @RequestParam(required = false) String phone,
                              @RequestParam(required = false) String email,
                              @RequestParam(required = false) String bio,
                              @RequestParam(required = false) String languages,
                              @RequestParam(required = false) Integer experienceYears,
                              @RequestParam(required = false) BigDecimal hourlyRate,
                              @RequestParam(required = false) BigDecimal fullDayRate,
                              @RequestParam(required = false) String certifications,
                              RedirectAttributes redirectAttributes) {
        try {
            Temple temple = templeService.findById(templeId)
                    .orElseThrow(() -> new RuntimeException("Temple not found"));
            
            TourGuide guide = TourGuide.builder()
                    .temple(temple)
                    .name(name)
                    .phone(phone)
                    .email(email)
                    .bio(bio)
                    .languages(languages)
                    .experienceYears(experienceYears)
                    .hourlyRate(hourlyRate)
                    .fullDayRate(fullDayRate)
                    .certifications(certifications)
                    .build();
            
            tourGuideService.createTourGuide(guide);
            redirectAttributes.addFlashAttribute("success", "Tour guide added successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to add tour guide: " + e.getMessage());
        }
        return "redirect:/pilgrim/temple/admin/temple/" + templeId + "/tour-guides";
    }
    
    // ============ BOOKINGS VIEW ============
    
    @GetMapping("/temple/{templeId}/bookings")
    public String viewBookings(@PathVariable Long templeId, Model model) {
        Temple temple = templeService.findById(templeId)
                .orElseThrow(() -> new RuntimeException("Temple not found"));
        
        model.addAttribute("temple", temple);
        model.addAttribute("darshanBookings", darshanService.findBookingsByTemple(templeId));
        model.addAttribute("poojaBookings", poojaService.findBookingsByTemple(templeId));
        model.addAttribute("tourBookings", tourGuideService.findBookingsByTemple(templeId));
        model.addAttribute("prasadhamOrders", prasadhamService.findOrdersByTemple(templeId));
        
        return "temple-admin/bookings";
    }
    
    // ============ DONATIONS VIEW ============
    
    @GetMapping("/temple/{templeId}/donations")
    public String viewDonations(@PathVariable Long templeId, Model model) {
        Temple temple = templeService.findById(templeId)
                .orElseThrow(() -> new RuntimeException("Temple not found"));
        
        model.addAttribute("temple", temple);
        model.addAttribute("donations", donationService.findCompletedDonationsByTemple(templeId));
        model.addAttribute("totalDonations", donationService.getTotalDonationsForTemple(temple));
        
        return "temple-admin/donations";
    }
}

