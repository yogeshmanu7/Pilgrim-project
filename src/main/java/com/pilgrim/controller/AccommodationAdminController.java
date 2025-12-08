package com.pilgrim.controller;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pilgrim.entity.AccommodationBooking;
import com.pilgrim.entity.AccommodationComplaint;
import com.pilgrim.entity.AccommodationPayout;
import com.pilgrim.entity.Property;
import com.pilgrim.entity.AccommodationRefund;
import com.pilgrim.entity.AccommodationUser;
import com.pilgrim.enums.PropertyStatus;
import com.pilgrim.service.AccommodationAdminService;
import com.pilgrim.service.AccommodationPropertyService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/accommodation/admin")
public class AccommodationAdminController {
	
	@Autowired
	private AccommodationPropertyService propertyService;
	
	@Autowired
	private AccommodationAdminService adminService;
	
	@GetMapping("/dashboard")
	public String dashboard(Model model) {
		model.addAttribute("totalProperties", adminService.getTotalProperties());
		model.addAttribute("pendingProperties", adminService.getPendingProperties());
		model.addAttribute("totalUsers", adminService.getTotalUsers());
		model.addAttribute("pendingComplaints", adminService.getPendingComplaints());
		model.addAttribute("pendingRefunds", adminService.getPendingRefunds());
		model.addAttribute("pendingPayouts", adminService.getPendingPayouts());
		model.addAttribute("pendingBookings", adminService.getPendingBookings());
		
		List<Property> recentPending = adminService.getPropertiesByStatus(PropertyStatus.PENDING_REVIEW);
		model.addAttribute("recentPendingProperties", recentPending.size() > 10 ? recentPending.subList(0, 10) : recentPending);
		
		return "accommodation/admin-dashboard";
	}
	
	@GetMapping("/properties")
	public String properties(Model model, @RequestParam(required = false) String status) {
		List<Property> properties;
		if (status != null && !status.isEmpty()) {
			properties = adminService.getPropertiesByStatus(PropertyStatus.valueOf(status));
		} else {
			properties = adminService.getAllProperties();
		}
		model.addAttribute("properties", properties);
		model.addAttribute("currentStatus", status);
		return "accommodation/admin-properties";
	}
	
	@GetMapping("/property/{id}")
	public String viewProperty(@PathVariable Long id, Model model) {
		propertyService.findById(id).ifPresent(property -> {
			model.addAttribute("property", property);
		});
		return "accommodation/admin-property-detail";
	}
	
	@PostMapping("/property/{id}/approve")
	public String approveProperty(@PathVariable Long id, RedirectAttributes redirectAttributes) {
		adminService.updatePropertyStatus(id, PropertyStatus.APPROVED);
		redirectAttributes.addFlashAttribute("success", "Property approved successfully");
		return "redirect:/accommodation/admin/properties";
	}
	
	@PostMapping("/property/{id}/reject")
	public String rejectProperty(@PathVariable Long id, 
			@RequestParam(required = false) String reason,
			RedirectAttributes redirectAttributes) {
		adminService.updatePropertyStatus(id, PropertyStatus.REJECTED);
		redirectAttributes.addFlashAttribute("success", "Property rejected");
		return "redirect:/accommodation/admin/properties";
	}
	
	@PostMapping("/property/{id}/hold")
	public String holdProperty(@PathVariable Long id, RedirectAttributes redirectAttributes) {
		adminService.updatePropertyStatus(id, PropertyStatus.ON_HOLD);
		redirectAttributes.addFlashAttribute("success", "Property put on hold");
		return "redirect:/accommodation/admin/properties";
	}
	
	@PostMapping("/property/{id}/activate")
	public String activateProperty(@PathVariable Long id, RedirectAttributes redirectAttributes) {
		adminService.updatePropertyVisibility(id, true);
		redirectAttributes.addFlashAttribute("success", "Property activated");
		return "redirect:/accommodation/admin/properties";
	}
	
	@PostMapping("/property/{id}/deactivate")
	public String deactivateProperty(@PathVariable Long id, RedirectAttributes redirectAttributes) {
		adminService.updatePropertyVisibility(id, false);
		redirectAttributes.addFlashAttribute("success", "Property deactivated");
		return "redirect:/accommodation/admin/properties";
	}
	
	@PostMapping("/property/{id}/ban")
	public String banProperty(@PathVariable Long id, RedirectAttributes redirectAttributes) {
		adminService.updatePropertyStatus(id, PropertyStatus.BANNED);
		redirectAttributes.addFlashAttribute("success", "Property banned");
		return "redirect:/accommodation/admin/properties";
	}
	
	@GetMapping("/users")
	public String users(Model model, @RequestParam(required = false) String role) {
		List<AccommodationUser> users;
		if (role != null && !role.isEmpty()) {
			users = adminService.getUsersByRole(role);
		} else {
			users = adminService.getAllUsers();
		}
		model.addAttribute("users", users);
		model.addAttribute("currentRole", role);
		return "accommodation/admin-users";
	}
	
	@PostMapping("/user/{id}/ban")
	public String banUser(@PathVariable Long id, RedirectAttributes redirectAttributes) {
		adminService.banUser(id);
		redirectAttributes.addFlashAttribute("success", "User banned successfully");
		return "redirect:/accommodation/admin/users";
	}
	
	@PostMapping("/user/{id}/unban")
	public String unbanUser(@PathVariable Long id, RedirectAttributes redirectAttributes) {
		adminService.unbanUser(id);
		redirectAttributes.addFlashAttribute("success", "User unbanned successfully");
		return "redirect:/accommodation/admin/users";
	}
	
	@GetMapping("/complaints")
	public String complaints(Model model, @RequestParam(required = false) String status) {
		List<AccommodationComplaint> complaints;
		if (status != null && !status.isEmpty()) {
			complaints = adminService.getComplaintsByStatus(status);
		} else {
			complaints = adminService.getAllComplaints();
		}
		model.addAttribute("complaints", complaints);
		model.addAttribute("currentStatus", status);
		return "accommodation/admin-complaints";
	}
	
	@PostMapping("/complaint/{id}/resolve")
	public String resolveComplaint(@PathVariable Long id,
			@RequestParam String adminNotes,
			HttpSession session,
			RedirectAttributes redirectAttributes) {
		Long adminId = (Long) session.getAttribute("accommodationUserId");
		adminService.updateComplaintStatus(id, "RESOLVED", adminNotes, adminId);
		redirectAttributes.addFlashAttribute("success", "Complaint resolved");
		return "redirect:/accommodation/admin/complaints";
	}
	
	@PostMapping("/complaint/{id}/dismiss")
	public String dismissComplaint(@PathVariable Long id,
			@RequestParam String adminNotes,
			HttpSession session,
			RedirectAttributes redirectAttributes) {
		Long adminId = (Long) session.getAttribute("accommodationUserId");
		adminService.updateComplaintStatus(id, "DISMISSED", adminNotes, adminId);
		redirectAttributes.addFlashAttribute("success", "Complaint dismissed");
		return "redirect:/accommodation/admin/complaints";
	}
	
	@GetMapping("/refunds")
	public String refunds(Model model, @RequestParam(required = false) String status) {
		List<AccommodationRefund> refunds;
		if (status != null && !status.isEmpty()) {
			refunds = adminService.getRefundsByStatus(status);
		} else {
			refunds = adminService.getAllRefunds();
		}
		model.addAttribute("refunds", refunds);
		model.addAttribute("currentStatus", status);
		return "accommodation/admin-refunds";
	}
	
	@PostMapping("/refund/{id}/approve")
	public String approveRefund(@PathVariable Long id,
			@RequestParam(required = false) String adminNotes,
			HttpSession session,
			RedirectAttributes redirectAttributes) {
		Long adminId = (Long) session.getAttribute("accommodationUserId");
		adminService.processRefund(id, "APPROVED", adminNotes, adminId);
		redirectAttributes.addFlashAttribute("success", "Refund approved");
		return "redirect:/accommodation/admin/refunds";
	}
	
	@PostMapping("/refund/{id}/reject")
	public String rejectRefund(@PathVariable Long id,
			@RequestParam String adminNotes,
			HttpSession session,
			RedirectAttributes redirectAttributes) {
		Long adminId = (Long) session.getAttribute("accommodationUserId");
		adminService.processRefund(id, "REJECTED", adminNotes, adminId);
		redirectAttributes.addFlashAttribute("success", "Refund rejected");
		return "redirect:/accommodation/admin/refunds";
	}
	
	@PostMapping("/refund/{id}/process")
	public String processRefund(@PathVariable Long id,
			@RequestParam(required = false) String adminNotes,
			HttpSession session,
			RedirectAttributes redirectAttributes) {
		Long adminId = (Long) session.getAttribute("accommodationUserId");
		adminService.processRefund(id, "PROCESSED", adminNotes, adminId);
		redirectAttributes.addFlashAttribute("success", "Refund processed");
		return "redirect:/accommodation/admin/refunds";
	}
	
	@GetMapping("/payouts")
	public String payouts(Model model, @RequestParam(required = false) String status) {
		List<AccommodationPayout> payouts;
		if (status != null && !status.isEmpty()) {
			payouts = adminService.getPayoutsByStatus(status);
		} else {
			payouts = adminService.getAllPayouts();
		}
		model.addAttribute("payouts", payouts);
		model.addAttribute("currentStatus", status);
		return "accommodation/admin-payouts";
	}
	
	@PostMapping("/payout/{id}/approve")
	public String approvePayout(@PathVariable Long id,
			@RequestParam(required = false) String adminNotes,
			HttpSession session,
			RedirectAttributes redirectAttributes) {
		Long adminId = (Long) session.getAttribute("accommodationUserId");
		adminService.processPayout(id, "APPROVED", adminNotes, adminId);
		redirectAttributes.addFlashAttribute("success", "Payout approved");
		return "redirect:/accommodation/admin/payouts";
	}
	
	@PostMapping("/payout/{id}/reject")
	public String rejectPayout(@PathVariable Long id,
			@RequestParam String adminNotes,
			HttpSession session,
			RedirectAttributes redirectAttributes) {
		Long adminId = (Long) session.getAttribute("accommodationUserId");
		adminService.processPayout(id, "REJECTED", adminNotes, adminId);
		redirectAttributes.addFlashAttribute("success", "Payout rejected");
		return "redirect:/accommodation/admin/payouts";
	}
	
	@PostMapping("/payout/{id}/process")
	public String processPayout(@PathVariable Long id,
			@RequestParam(required = false) String adminNotes,
			HttpSession session,
			RedirectAttributes redirectAttributes) {
		Long adminId = (Long) session.getAttribute("accommodationUserId");
		adminService.processPayout(id, "PROCESSED", adminNotes, adminId);
		redirectAttributes.addFlashAttribute("success", "Payout processed");
		return "redirect:/accommodation/admin/payouts";
	}
	
	@PostMapping("/property/{id}/update-pricing")
	public String updatePricing(@PathVariable Long id,
			@RequestParam BigDecimal basePrice,
			RedirectAttributes redirectAttributes) {
		adminService.updatePropertyPricing(id, basePrice);
		redirectAttributes.addFlashAttribute("success", "Pricing updated");
		return "redirect:/accommodation/admin/property/" + id;
	}
	
	@GetMapping("/bookings")
	public String bookings(Model model, @RequestParam(required = false) String status) {
		List<AccommodationBooking> bookings;
		if (status != null && !status.isEmpty()) {
			bookings = adminService.getBookingsByStatus(status);
		} else {
			bookings = adminService.getAllBookings();
		}
		model.addAttribute("bookings", bookings);
		model.addAttribute("currentStatus", status);
		return "accommodation/admin-bookings";
	}
	
	@PostMapping("/booking/{id}/approve")
	public String approveBooking(@PathVariable Long id, RedirectAttributes redirectAttributes) {
		adminService.updateBookingStatus(id, "CONFIRMED");
		redirectAttributes.addFlashAttribute("success", "Booking approved successfully");
		return "redirect:/accommodation/admin/bookings";
	}
	
	@PostMapping("/booking/{id}/reject")
	public String rejectBooking(@PathVariable Long id, 
			@RequestParam(required = false) String reason,
			RedirectAttributes redirectAttributes) {
		adminService.updateBookingStatus(id, "CANCELLED");
		redirectAttributes.addFlashAttribute("success", "Booking rejected");
		return "redirect:/accommodation/admin/bookings";
	}
}

