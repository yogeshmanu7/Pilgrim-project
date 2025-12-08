package com.pilgrim.service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pilgrim.entity.AccommodationBooking;
import com.pilgrim.entity.AccommodationComplaint;
import com.pilgrim.entity.AccommodationPayout;
import com.pilgrim.entity.Property;
import com.pilgrim.entity.AccommodationRefund;
import com.pilgrim.entity.AccommodationUser;
import com.pilgrim.enums.PropertyStatus;
import com.pilgrim.repository.AccommodationBookingRepository;
import com.pilgrim.repository.AccommodationComplaintRepository;
import com.pilgrim.repository.AccommodationPayoutRepository;
import com.pilgrim.repository.PropertyRepository;
import com.pilgrim.repository.AccommodationRefundRepository;
import com.pilgrim.repository.AccommodationUserRepository;

@Service
public class AccommodationAdminService {
	
	@Autowired
	private PropertyRepository propertyRepository;
	
	@Autowired
	private AccommodationUserRepository userRepository;
	
	@Autowired
	private AccommodationComplaintRepository complaintRepository;
	
	@Autowired
	private AccommodationRefundRepository refundRepository;
	
	@Autowired
	private AccommodationPayoutRepository payoutRepository;
	
	@Autowired
	private AccommodationBookingRepository bookingRepository;
	
	@Transactional
	public Property updatePropertyStatus(Long propertyId, PropertyStatus status) {
		Optional<Property> propertyOpt = propertyRepository.findById(propertyId);
		if (propertyOpt.isPresent()) {
			Property property = propertyOpt.get();
			property.setStatus(status);
			property.setUpdatedAt(LocalDateTime.now());
			return propertyRepository.save(property);
		}
		return null;
	}
	
	@Transactional
	public Property updatePropertyVisibility(Long propertyId, boolean visible) {
		Optional<Property> propertyOpt = propertyRepository.findById(propertyId);
		if (propertyOpt.isPresent()) {
			Property property = propertyOpt.get();
			if (visible) {
				property.setStatus(PropertyStatus.ACTIVE);
			} else {
				property.setStatus(PropertyStatus.INACTIVE);
			}
			property.setUpdatedAt(LocalDateTime.now());
			return propertyRepository.save(property);
		}
		return null;
	}
	
	public List<Property> getAllProperties() {
		return propertyRepository.findAll();
	}
	
	public List<Property> getPropertiesByStatus(PropertyStatus status) {
		return propertyRepository.findByStatus(status);
	}
	
	@Transactional
	public AccommodationUser banUser(Long userId) {
		Optional<AccommodationUser> userOpt = userRepository.findById(userId);
		if (userOpt.isPresent()) {
			AccommodationUser user = userOpt.get();
			return userRepository.save(user);
		}
		return null;
	}
	
	@Transactional
	public AccommodationUser unbanUser(Long userId) {
		Optional<AccommodationUser> userOpt = userRepository.findById(userId);
		if (userOpt.isPresent()) {
			AccommodationUser user = userOpt.get();
			return userRepository.save(user);
		}
		return null;
	}
	
	public List<AccommodationUser> getAllUsers() {
		return userRepository.findAll();
	}
	
	public List<AccommodationUser> getUsersByRole(String role) {
		return userRepository.findByRole(com.pilgrim.enums.AccommodationUserRole.valueOf(role));
	}
	
	public List<AccommodationComplaint> getAllComplaints() {
		return complaintRepository.findAll();
	}
	
	public List<AccommodationComplaint> getComplaintsByStatus(String status) {
		return complaintRepository.findByStatusOrderByCreatedAtDesc(status);
	}
	
	@Transactional
	public AccommodationComplaint updateComplaintStatus(Long complaintId, String status, String adminNotes, Long adminId) {
		Optional<AccommodationComplaint> complaintOpt = complaintRepository.findById(complaintId);
		if (complaintOpt.isPresent()) {
			AccommodationComplaint complaint = complaintOpt.get();
			complaint.setStatus(status);
			complaint.setAdminNotes(adminNotes);
			if (status.equals("RESOLVED")) {
				Optional<AccommodationUser> adminOpt = userRepository.findById(adminId);
				if (adminOpt.isPresent()) {
					complaint.setResolvedBy(adminOpt.get());
					complaint.setResolvedAt(LocalDateTime.now());
				}
			}
			return complaintRepository.save(complaint);
		}
		return null;
	}
	
	public List<AccommodationRefund> getAllRefunds() {
		return refundRepository.findAll();
	}
	
	public List<AccommodationRefund> getRefundsByStatus(String status) {
		return refundRepository.findByStatusOrderByCreatedAtDesc(status);
	}
	
	@Transactional
	public AccommodationRefund processRefund(Long refundId, String status, String adminNotes, Long adminId) {
		Optional<AccommodationRefund> refundOpt = refundRepository.findById(refundId);
		if (refundOpt.isPresent()) {
			AccommodationRefund refund = refundOpt.get();
			refund.setStatus(status);
			refund.setAdminNotes(adminNotes);
			if (status.equals("APPROVED") || status.equals("PROCESSED")) {
				Optional<AccommodationUser> adminOpt = userRepository.findById(adminId);
				if (adminOpt.isPresent()) {
					refund.setProcessedBy(adminOpt.get());
					refund.setProcessedAt(LocalDateTime.now());
				}
			}
			return refundRepository.save(refund);
		}
		return null;
	}
	
	public List<AccommodationPayout> getAllPayouts() {
		return payoutRepository.findAll();
	}
	
	public List<AccommodationPayout> getPayoutsByStatus(String status) {
		return payoutRepository.findByStatusOrderByCreatedAtDesc(status);
	}
	
	@Transactional
	public AccommodationPayout processPayout(Long payoutId, String status, String adminNotes, Long adminId) {
		Optional<AccommodationPayout> payoutOpt = payoutRepository.findById(payoutId);
		if (payoutOpt.isPresent()) {
			AccommodationPayout payout = payoutOpt.get();
			payout.setStatus(status);
			payout.setAdminNotes(adminNotes);
			if (status.equals("APPROVED") || status.equals("PROCESSED")) {
				Optional<AccommodationUser> adminOpt = userRepository.findById(adminId);
				if (adminOpt.isPresent()) {
					payout.setProcessedBy(adminOpt.get());
					payout.setProcessedAt(LocalDateTime.now());
				}
			}
			return payoutRepository.save(payout);
		}
		return null;
	}
	
	@Transactional
	public Property updatePropertyPricing(Long propertyId, BigDecimal basePrice) {
		Optional<Property> propertyOpt = propertyRepository.findById(propertyId);
		if (propertyOpt.isPresent()) {
			Property property = propertyOpt.get();
			property.setUpdatedAt(LocalDateTime.now());
			return propertyRepository.save(property);
		}
		return null;
	}
	
	public long getTotalProperties() {
		return propertyRepository.count();
	}
	
	public long getPendingProperties() {
		return propertyRepository.findByStatus(PropertyStatus.PENDING_REVIEW).size();
	}
	
	public long getTotalUsers() {
		return userRepository.count();
	}
	
	public long getPendingComplaints() {
		return complaintRepository.findByStatus("PENDING").size();
	}
	
	public long getPendingRefunds() {
		return refundRepository.findByStatus("PENDING").size();
	}
	
	public long getPendingPayouts() {
		return payoutRepository.findByStatus("PENDING").size();
	}
	
	public List<AccommodationBooking> getAllBookings() {
		return bookingRepository.findAll();
	}
	
	public List<AccommodationBooking> getBookingsByStatus(String status) {
		return bookingRepository.findByStatus(status);
	}
	
	@Transactional
	public AccommodationBooking updateBookingStatus(Long bookingId, String status) {
		Optional<AccommodationBooking> bookingOpt = bookingRepository.findById(bookingId);
		if (bookingOpt.isPresent()) {
			AccommodationBooking booking = bookingOpt.get();
			booking.setStatus(status);
			return bookingRepository.save(booking);
		}
		return null;
	}
	
	public long getPendingBookings() {
		return bookingRepository.findByStatus("PENDING").size();
	}
}

