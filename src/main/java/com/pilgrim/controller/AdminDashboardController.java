package com.pilgrim.controller;

import com.pilgrim.entity.Admin;
import com.pilgrim.entity.AccommodationBooking;
import com.pilgrim.entity.AccommodationComplaint;
import com.pilgrim.entity.AccommodationPayout;
import com.pilgrim.entity.AccommodationRefund;
import com.pilgrim.entity.AccommodationUser;
import com.pilgrim.entity.Property;
import com.pilgrim.entity.PoojaItem;
import com.pilgrim.entity.PoojaOrder;
import com.pilgrim.entity.Vendor;
import com.pilgrim.enums.PropertyStatus;
import com.pilgrim.service.DashboardService;
import com.pilgrim.service.AdminService;
import com.pilgrim.service.FileStorageService;
import com.pilgrim.service.AccommodationAdminService;
import com.pilgrim.service.AccommodationPropertyService;
import com.pilgrim.service.PoojaAdminService;
import com.pilgrim.service.PoojaVendorService;
import com.pilgrim.service.PoojaItemService;
import com.pilgrim.service.PoojaOrderService;
import com.pilgrim.service.TravelAgencyService;
import com.pilgrim.service.TravelPackageService;
import com.pilgrim.service.TravelBookingService;
import com.pilgrim.service.GuideService;
import com.pilgrim.service.TransportService;
import com.pilgrim.entity.TravelAgency;
import com.pilgrim.entity.TravelAgencyPersonal;
import com.pilgrim.entity.TravelAgencyBank;
import com.pilgrim.entity.TravelAgencyGST;
import com.pilgrim.entity.TravelAgencyDocuments;
import com.pilgrim.entity.TravelPackage;
import com.pilgrim.entity.TravelBooking;
import com.pilgrim.entity.Guide;
import com.pilgrim.entity.Transport;
import com.pilgrim.repository.TravelBookingRepository;
import com.pilgrim.repository.GuideRepository;
import com.pilgrim.repository.TransportRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminDashboardController {
    
    @Autowired
    private DashboardService dashboardService;
    
    @Autowired
    private AdminService adminService;
    
    @Autowired
    private FileStorageService fileStorageService;
    
    // Accommodation Admin Services
    @Autowired
    private AccommodationPropertyService accommodationPropertyService;
    
    @Autowired
    private AccommodationAdminService accommodationAdminService;
    
    // Pooja Admin Services
    @Autowired
    private PoojaAdminService poojaAdminService;
    
    @Autowired
    private PoojaVendorService poojaVendorService;
    
    @Autowired
    private PoojaItemService poojaItemService;
    
    @Autowired
    private PoojaOrderService poojaOrderService;
    
    // Travel Admin Services
    @Autowired
    private TravelAgencyService travelAgencyService;
    
    @Autowired
    private TravelPackageService travelPackageService;
    
    @Autowired
    private TravelBookingRepository travelBookingRepository;
    
    @Autowired
    private GuideRepository guideRepository;
    
    @Autowired
    private TransportRepository transportRepository;
    
    @RequestMapping(value = "/dashboard", method = RequestMethod.GET)
    public String showDashboard(Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        Map<String, Object> stats = dashboardService.getDashboardStats();
        model.addAttribute("stats", stats);
        model.addAttribute("admin", admin);
        
        return "admin/dashboard";
    }
    
    @RequestMapping(value = "/profile", method = RequestMethod.GET)
    public String showProfile(Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        // Refresh admin data
        admin = adminService.findById(admin.getId()).orElse(admin);
        model.addAttribute("admin", admin);
        
        return "admin/profile";
    }
    
    @RequestMapping(value = "/profile/update", method = RequestMethod.POST)
    public String updateProfile(@RequestParam String name,
                                @RequestParam String phone,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        try {
            Admin admin = (Admin) session.getAttribute("adminSession");
            if (admin == null) {
                return "redirect:/admin/login";
            }
            
            admin = adminService.updateProfile(admin.getId(), name, phone);
            session.setAttribute("adminSession", admin);
            session.setAttribute("adminName", admin.getName());
            
            redirectAttributes.addFlashAttribute("success", "Profile updated successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        
        return "redirect:/admin/profile";
    }
    
    @RequestMapping(value = "/profile/change-password", method = RequestMethod.POST)
    public String changePassword(@RequestParam String currentPassword,
                                 @RequestParam String newPassword,
                                 @RequestParam String confirmPassword,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {
        try {
            Admin admin = (Admin) session.getAttribute("adminSession");
            if (admin == null) {
                return "redirect:/admin/login";
            }
            
            if (!newPassword.equals(confirmPassword)) {
                throw new RuntimeException("New passwords do not match");
            }
            
            adminService.changePassword(admin.getId(), currentPassword, newPassword);
            
            redirectAttributes.addFlashAttribute("success", "Password changed successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        
        return "redirect:/admin/profile";
    }
    
    @RequestMapping(value = "/profile/upload-image", method = RequestMethod.POST)
    public String uploadProfileImage(@RequestParam("image") MultipartFile image,
                                     HttpSession session,
                                     RedirectAttributes redirectAttributes) {
        try {
            Admin admin = (Admin) session.getAttribute("adminSession");
            if (admin == null) {
                return "redirect:/admin/login";
            }
            
            if (!image.isEmpty()) {
                String imagePath = fileStorageService.storeProfileImage(image);
                adminService.updateProfileImage(admin.getId(), imagePath);
                
                admin = adminService.findById(admin.getId()).orElse(admin);
                session.setAttribute("adminSession", admin);
            }
            
            redirectAttributes.addFlashAttribute("success", "Profile image updated successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        
        return "redirect:/admin/profile";
    }
    
    // ========== ACCOMMODATION ADMIN METHODS ==========
    
    @GetMapping("/accommodation/properties")
    public String accommodationProperties(HttpSession session, Model model, 
                                          @RequestParam(required = false) String status) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        List<Property> properties;
        if (status != null && !status.isEmpty()) {
            properties = accommodationAdminService.getPropertiesByStatus(PropertyStatus.valueOf(status));
        } else {
            properties = accommodationAdminService.getAllProperties();
        }
        model.addAttribute("properties", properties);
        model.addAttribute("currentStatus", status);
        return "accommodation/admin-properties";
    }
    
    @GetMapping("/accommodation/property/{id}")
    public String viewAccommodationProperty(HttpSession session, @PathVariable Long id, Model model) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        accommodationPropertyService.findById(id).ifPresent(property -> {
            model.addAttribute("property", property);
        });
        return "accommodation/admin-property-detail";
    }
    
    @PostMapping("/accommodation/property/{id}/approve")
    public String approveAccommodationProperty(HttpSession session, @PathVariable Long id, 
                                               RedirectAttributes redirectAttributes) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        accommodationAdminService.updatePropertyStatus(id, PropertyStatus.APPROVED);
        redirectAttributes.addFlashAttribute("success", "Property approved successfully");
        return "redirect:/admin/accommodation/properties";
    }
    
    @PostMapping("/accommodation/property/{id}/reject")
    public String rejectAccommodationProperty(HttpSession session, @PathVariable Long id,
                                             @RequestParam(required = false) String reason,
                                             RedirectAttributes redirectAttributes) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        accommodationAdminService.updatePropertyStatus(id, PropertyStatus.REJECTED);
        redirectAttributes.addFlashAttribute("success", "Property rejected");
        return "redirect:/admin/accommodation/properties";
    }
    
    @PostMapping("/accommodation/property/{id}/hold")
    public String holdAccommodationProperty(HttpSession session, @PathVariable Long id,
                                           RedirectAttributes redirectAttributes) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        accommodationAdminService.updatePropertyStatus(id, PropertyStatus.ON_HOLD);
        redirectAttributes.addFlashAttribute("success", "Property put on hold");
        return "redirect:/admin/accommodation/properties";
    }
    
    @PostMapping("/accommodation/property/{id}/activate")
    public String activateAccommodationProperty(HttpSession session, @PathVariable Long id,
                                               RedirectAttributes redirectAttributes) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        accommodationAdminService.updatePropertyVisibility(id, true);
        redirectAttributes.addFlashAttribute("success", "Property activated");
        return "redirect:/admin/accommodation/properties";
    }
    
    @PostMapping("/accommodation/property/{id}/deactivate")
    public String deactivateAccommodationProperty(HttpSession session, @PathVariable Long id,
                                                 RedirectAttributes redirectAttributes) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        accommodationAdminService.updatePropertyVisibility(id, false);
        redirectAttributes.addFlashAttribute("success", "Property deactivated");
        return "redirect:/admin/accommodation/properties";
    }
    
    @GetMapping("/accommodation/users")
    public String accommodationUsers(HttpSession session, Model model, 
                                      @RequestParam(required = false) String role) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        List<AccommodationUser> users;
        if (role != null && !role.isEmpty()) {
            users = accommodationAdminService.getUsersByRole(role);
        } else {
            users = accommodationAdminService.getAllUsers();
        }
        model.addAttribute("users", users);
        model.addAttribute("currentRole", role);
        return "accommodation/admin-users";
    }
    
    @PostMapping("/accommodation/user/{id}/ban")
    public String banAccommodationUser(HttpSession session, @PathVariable Long id,
                                      RedirectAttributes redirectAttributes) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        accommodationAdminService.banUser(id);
        redirectAttributes.addFlashAttribute("success", "User banned successfully");
        return "redirect:/admin/accommodation/users";
    }
    
    @PostMapping("/accommodation/user/{id}/unban")
    public String unbanAccommodationUser(HttpSession session, @PathVariable Long id,
                                        RedirectAttributes redirectAttributes) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        accommodationAdminService.unbanUser(id);
        redirectAttributes.addFlashAttribute("success", "User unbanned successfully");
        return "redirect:/admin/accommodation/users";
    }
    
    @GetMapping("/accommodation/bookings")
    public String accommodationBookings(HttpSession session, Model model,
                                        @RequestParam(required = false) String status) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        List<AccommodationBooking> bookings;
        if (status != null && !status.isEmpty()) {
            bookings = accommodationAdminService.getBookingsByStatus(status);
        } else {
            bookings = accommodationAdminService.getAllBookings();
        }
        model.addAttribute("bookings", bookings);
        model.addAttribute("currentStatus", status);
        return "accommodation/admin-bookings";
    }
    
    @PostMapping("/accommodation/booking/{id}/approve")
    public String approveAccommodationBooking(HttpSession session, @PathVariable Long id,
                                              RedirectAttributes redirectAttributes) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        accommodationAdminService.updateBookingStatus(id, "CONFIRMED");
        redirectAttributes.addFlashAttribute("success", "Booking approved successfully");
        return "redirect:/admin/accommodation/bookings";
    }
    
    @PostMapping("/accommodation/booking/{id}/reject")
    public String rejectAccommodationBooking(HttpSession session, @PathVariable Long id,
                                            @RequestParam(required = false) String reason,
                                            RedirectAttributes redirectAttributes) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        accommodationAdminService.updateBookingStatus(id, "CANCELLED");
        redirectAttributes.addFlashAttribute("success", "Booking rejected");
        return "redirect:/admin/accommodation/bookings";
    }
    
    @GetMapping("/accommodation/complaints")
    public String accommodationComplaints(HttpSession session, Model model,
                                         @RequestParam(required = false) String status) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        List<AccommodationComplaint> complaints;
        if (status != null && !status.isEmpty()) {
            complaints = accommodationAdminService.getComplaintsByStatus(status);
        } else {
            complaints = accommodationAdminService.getAllComplaints();
        }
        model.addAttribute("complaints", complaints);
        model.addAttribute("currentStatus", status);
        return "accommodation/admin-complaints";
    }
    
    @PostMapping("/accommodation/complaint/{id}/resolve")
    public String resolveAccommodationComplaint(HttpSession session, @PathVariable Long id,
                                               @RequestParam String adminNotes,
                                               RedirectAttributes redirectAttributes) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        accommodationAdminService.updateComplaintStatus(id, "RESOLVED", adminNotes, admin.getId());
        redirectAttributes.addFlashAttribute("success", "Complaint resolved");
        return "redirect:/admin/accommodation/complaints";
    }
    
    @GetMapping("/accommodation/refunds")
    public String accommodationRefunds(HttpSession session, Model model,
                                     @RequestParam(required = false) String status) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        List<AccommodationRefund> refunds;
        if (status != null && !status.isEmpty()) {
            refunds = accommodationAdminService.getRefundsByStatus(status);
        } else {
            refunds = accommodationAdminService.getAllRefunds();
        }
        model.addAttribute("refunds", refunds);
        model.addAttribute("currentStatus", status);
        return "accommodation/admin-refunds";
    }
    
    @PostMapping("/accommodation/refund/{id}/approve")
    public String approveAccommodationRefund(HttpSession session, @PathVariable Long id,
                                           @RequestParam(required = false) String adminNotes,
                                           RedirectAttributes redirectAttributes) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        accommodationAdminService.processRefund(id, "APPROVED", adminNotes, admin.getId());
        redirectAttributes.addFlashAttribute("success", "Refund approved");
        return "redirect:/admin/accommodation/refunds";
    }
    
    @GetMapping("/accommodation/payouts")
    public String accommodationPayouts(HttpSession session, Model model,
                                       @RequestParam(required = false) String status) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        List<AccommodationPayout> payouts;
        if (status != null && !status.isEmpty()) {
            payouts = accommodationAdminService.getPayoutsByStatus(status);
        } else {
            payouts = accommodationAdminService.getAllPayouts();
        }
        model.addAttribute("payouts", payouts);
        model.addAttribute("currentStatus", status);
        return "accommodation/admin-payouts";
    }
    
    @PostMapping("/accommodation/payout/{id}/approve")
    public String approveAccommodationPayout(HttpSession session, @PathVariable Long id,
                                            @RequestParam(required = false) String adminNotes,
                                            RedirectAttributes redirectAttributes) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        accommodationAdminService.processPayout(id, "APPROVED", adminNotes, admin.getId());
        redirectAttributes.addFlashAttribute("success", "Payout approved");
        return "redirect:/admin/accommodation/payouts";
    }
    
    // ========== POOJA ADMIN METHODS ==========
    
    @GetMapping("/pooja/vendors")
    public String poojaVendors(HttpSession session, Model model) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        List<Vendor> vendors = poojaVendorService.getAllVendors();
        model.addAttribute("vendors", vendors);
        return "pooja/admin/vendors";
    }
    
    @GetMapping("/pooja/vendors/pending")
    public String poojaPendingVendors(HttpSession session, Model model) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        List<Vendor> pendingVendors = poojaVendorService.getPendingVendors();
        model.addAttribute("vendors", pendingVendors);
        return "pooja/admin/pending-vendors";
    }
    
    @PostMapping("/pooja/vendors/approve/{id}")
    public String approvePoojaVendor(HttpSession session, @PathVariable Long id,
                                   RedirectAttributes redirectAttributes) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        poojaVendorService.approveVendor(id);
        redirectAttributes.addFlashAttribute("success", "Vendor approved successfully");
        return "redirect:/admin/pooja/vendors/pending";
    }
    
    @PostMapping("/pooja/vendors/reject/{id}")
    public String rejectPoojaVendor(HttpSession session, @PathVariable Long id,
                                  RedirectAttributes redirectAttributes) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        poojaVendorService.rejectVendor(id);
        redirectAttributes.addFlashAttribute("success", "Vendor rejected");
        return "redirect:/admin/pooja/vendors/pending";
    }
    
    @GetMapping("/pooja/items")
    public String poojaItems(HttpSession session, Model model) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        List<PoojaItem> items = poojaItemService.getAllItems();
        model.addAttribute("items", items);
        return "pooja/admin/items";
    }
    
    @PostMapping("/pooja/items/block/{id}")
    public String blockPoojaItem(HttpSession session, @PathVariable Long id,
                                RedirectAttributes redirectAttributes) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        var itemOpt = poojaItemService.getItemById(id);
        if (itemOpt.isPresent()) {
            PoojaItem item = itemOpt.get();
            item.setStatus(PoojaItem.ItemStatus.BLOCKED);
            poojaItemService.updateItem(id, item);
            redirectAttributes.addFlashAttribute("success", "Item blocked successfully");
        }
        return "redirect:/admin/pooja/items";
    }
    
    @PostMapping("/pooja/items/unblock/{id}")
    public String unblockPoojaItem(HttpSession session, @PathVariable Long id,
                                  RedirectAttributes redirectAttributes) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        var itemOpt = poojaItemService.getItemById(id);
        if (itemOpt.isPresent()) {
            PoojaItem item = itemOpt.get();
            item.setStatus(PoojaItem.ItemStatus.ACTIVE);
            poojaItemService.updateItem(id, item);
            redirectAttributes.addFlashAttribute("success", "Item unblocked successfully");
        }
        return "redirect:/admin/pooja/items";
    }
    
    @GetMapping("/pooja/orders")
    public String poojaOrders(HttpSession session, Model model) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        List<PoojaOrder> orders = poojaOrderService.getAllOrders();
        model.addAttribute("orders", orders);
        return "pooja/admin/orders";
    }
    
    // ========== TRAVEL ADMIN METHODS ==========
    
    @GetMapping("/travel/agencies/pending")
    public String travelPendingAgencies(HttpSession session, Model model) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        List<TravelAgency> pendingAgencies = travelAgencyService.getPendingAgencies();
        model.addAttribute("pendingAgencies", pendingAgencies);
        return "travel/admin/agency-approval";
    }
    
    @GetMapping("/travel/agencies/view/{id}")
    public String viewTravelAgency(HttpSession session, @PathVariable Long id, Model model) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        TravelAgency agency = travelAgencyService.findById(id);
        if (agency == null) {
            return "redirect:/admin/travel/agencies/pending";
        }
        
        model.addAttribute("agency", agency);
        model.addAttribute("personal", travelAgencyService.findPersonalByAgencyId(id));
        model.addAttribute("bank", travelAgencyService.findBankByAgencyId(id));
        model.addAttribute("gst", travelAgencyService.findGstByAgencyId(id));
        model.addAttribute("documents", travelAgencyService.findDocumentsByAgencyId(id));
        
        return "travel/admin/agency-view";
    }
    
    @PostMapping("/travel/agencies/approve/{id}")
    public String approveTravelAgency(HttpSession session, @PathVariable Long id,
                                     RedirectAttributes redirectAttributes) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        travelAgencyService.approveAgency(id);
        redirectAttributes.addFlashAttribute("success", "Travel agency approved successfully");
        return "redirect:/admin/travel/agencies/pending";
    }
    
    @PostMapping("/travel/agencies/reject/{id}")
    public String rejectTravelAgency(HttpSession session, @PathVariable Long id,
                                    RedirectAttributes redirectAttributes) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        travelAgencyService.rejectAgency(id);
        redirectAttributes.addFlashAttribute("success", "Travel agency rejected");
        return "redirect:/admin/travel/agencies/pending";
    }
    
    @GetMapping("/travel/agencies/approval")
    public String travelAgenciesApproval(HttpSession session, Model model) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        List<TravelAgency> pendingAgencies = travelAgencyService.getPendingAgencies();
        model.addAttribute("pendingAgencies", pendingAgencies);
        return "travel/admin/agency-approval";
    }
    
    @GetMapping("/travel/packages")
    public String travelPackages(HttpSession session, Model model) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        List<TravelPackage> packages = travelPackageService.getAllPackages();
        model.addAttribute("packages", packages);
        return "travel/admin/packages";
    }
    
    @GetMapping("/travel/bookings")
    public String travelBookings(HttpSession session, Model model) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        List<TravelBooking> bookings = travelBookingRepository.findAll();
        model.addAttribute("bookings", bookings);
        return "travel/admin/bookings";
    }
    
    @GetMapping("/travel/guides")
    public String travelGuides(HttpSession session, Model model) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        List<Guide> guides = guideRepository.findAll();
        model.addAttribute("guides", guides);
        return "travel/admin/guides";
    }
    
    @GetMapping("/travel/transport")
    public String travelTransport(HttpSession session, Model model) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        List<Transport> transports = transportRepository.findAll();
        model.addAttribute("transports", transports);
        return "travel/admin/transport";
    }
}
