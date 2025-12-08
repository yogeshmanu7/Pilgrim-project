package com.pilgrim.entity;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "accommodation_refunds")
public class AccommodationRefund {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@ManyToOne
	@JoinColumn(name = "booking_id", nullable = false)
	private AccommodationBooking booking;
	
	@Column(nullable = false)
	private BigDecimal amount;
	
	@Column(nullable = false)
	private String reason;
	
	@Column(nullable = false)
	private String status = "PENDING"; // PENDING, APPROVED, REJECTED, PROCESSED
	
	private String adminNotes;
	
	@ManyToOne
	@JoinColumn(name = "processed_by")
	private AccommodationUser processedBy;
	
	private LocalDateTime processedAt;
	
	@Column(nullable = false)
	private LocalDateTime createdAt = LocalDateTime.now();
	
	public Long getId() {
		return id;
	}
	
	public void setId(Long id) {
		this.id = id;
	}
	
	public AccommodationBooking getBooking() {
		return booking;
	}
	
	public void setBooking(AccommodationBooking booking) {
		this.booking = booking;
	}
	
	public BigDecimal getAmount() {
		return amount;
	}
	
	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}
	
	public String getReason() {
		return reason;
	}
	
	public void setReason(String reason) {
		this.reason = reason;
	}
	
	public String getStatus() {
		return status;
	}
	
	public void setStatus(String status) {
		this.status = status;
	}
	
	public String getAdminNotes() {
		return adminNotes;
	}
	
	public void setAdminNotes(String adminNotes) {
		this.adminNotes = adminNotes;
	}
	
	public AccommodationUser getProcessedBy() {
		return processedBy;
	}
	
	public void setProcessedBy(AccommodationUser processedBy) {
		this.processedBy = processedBy;
	}
	
	public LocalDateTime getProcessedAt() {
		return processedAt;
	}
	
	public void setProcessedAt(LocalDateTime processedAt) {
		this.processedAt = processedAt;
	}
	
	public LocalDateTime getCreatedAt() {
		return createdAt;
	}
	
	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}
}

