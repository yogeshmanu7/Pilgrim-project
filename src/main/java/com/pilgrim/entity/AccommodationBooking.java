package com.pilgrim.entity;

import java.math.BigDecimal;
import java.time.LocalDate;
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
@Table(name = "accommodation_bookings")
public class AccommodationBooking {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@ManyToOne
	@JoinColumn(name = "property_id", nullable = false)
	private Property property;
	
	@ManyToOne
	@JoinColumn(name = "user_id", nullable = true)
	private AccommodationUser user;
	
	// Guest information for bookings without login
	private String guestName;
	private String guestEmail;
	private String guestPhone;
	
	@Column(nullable = false)
	private LocalDate checkInDate;
	
	@Column(nullable = false)
	private LocalDate checkOutDate;
	
	@Column(nullable = false)
	private Integer numberOfGuests;
	
	@Column(name = "number_of_rooms", nullable = false)
	private Integer numberOfRooms;
	
	@Column(nullable = false)
	private BigDecimal totalAmount;
	
	@Column(nullable = false)
	private String status = "PENDING"; // PENDING, CONFIRMED, CANCELLED, COMPLETED
	
	private String cancellationReason;
	
	private LocalDateTime cancelledAt;
	
	@Column(nullable = false)
	private LocalDateTime createdAt = LocalDateTime.now();
	
	private String referenceNumber;
	
	public Long getId() {
		return id;
	}
	
	public void setId(Long id) {
		this.id = id;
	}
	
	public Property getProperty() {
		return property;
	}
	
	public void setProperty(Property property) {
		this.property = property;
	}
	
	public AccommodationUser getUser() {
		return user;
	}
	
	public void setUser(AccommodationUser user) {
		this.user = user;
	}
	
	public LocalDate getCheckInDate() {
		return checkInDate;
	}
	
	public void setCheckInDate(LocalDate checkInDate) {
		this.checkInDate = checkInDate;
	}
	
	public LocalDate getCheckOutDate() {
		return checkOutDate;
	}
	
	public void setCheckOutDate(LocalDate checkOutDate) {
		this.checkOutDate = checkOutDate;
	}
	
	public Integer getNumberOfGuests() {
		return numberOfGuests;
	}
	
	public void setNumberOfGuests(Integer numberOfGuests) {
		this.numberOfGuests = numberOfGuests;
	}
	
	public Integer getNumberOfRooms() {
		return numberOfRooms;
	}
	
	public void setNumberOfRooms(Integer numberOfRooms) {
		this.numberOfRooms = numberOfRooms;
	}
	
	public BigDecimal getTotalAmount() {
		return totalAmount;
	}
	
	public void setTotalAmount(BigDecimal totalAmount) {
		this.totalAmount = totalAmount;
	}
	
	public String getStatus() {
		return status;
	}
	
	public void setStatus(String status) {
		this.status = status;
	}
	
	public String getCancellationReason() {
		return cancellationReason;
	}
	
	public void setCancellationReason(String cancellationReason) {
		this.cancellationReason = cancellationReason;
	}
	
	public LocalDateTime getCancelledAt() {
		return cancelledAt;
	}
	
	public void setCancelledAt(LocalDateTime cancelledAt) {
		this.cancelledAt = cancelledAt;
	}
	
	public LocalDateTime getCreatedAt() {
		return createdAt;
	}
	
	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}
	
	public String getReferenceNumber() {
		return referenceNumber;
	}
	
	public void setReferenceNumber(String referenceNumber) {
		this.referenceNumber = referenceNumber;
	}
	
	public String getGuestName() {
		return guestName;
	}
	
	public void setGuestName(String guestName) {
		this.guestName = guestName;
	}
	
	public String getGuestEmail() {
		return guestEmail;
	}
	
	public void setGuestEmail(String guestEmail) {
		this.guestEmail = guestEmail;
	}
	
	public String getGuestPhone() {
		return guestPhone;
	}
	
	public void setGuestPhone(String guestPhone) {
		this.guestPhone = guestPhone;
	}
}

