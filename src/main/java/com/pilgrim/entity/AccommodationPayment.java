package com.pilgrim.entity;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import com.pilgrim.enums.PaymentMethod;
import com.pilgrim.enums.PaymentStatus;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "accommodation_payments")
public class AccommodationPayment {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@ManyToOne
	@JoinColumn(name = "booking_id", nullable = false)
	private AccommodationBooking booking;
	
	@Column(nullable = false)
	private BigDecimal amount;
	
	@Enumerated(EnumType.STRING)
	@Column(nullable = false)
	private PaymentMethod paymentMethod;
	
	@Enumerated(EnumType.STRING)
	@Column(nullable = false)
	private PaymentStatus status = PaymentStatus.PENDING;
	
	private String transactionId;
	
	private String paymentGatewayResponse;
	
	@Column(nullable = false)
	private LocalDateTime createdAt = LocalDateTime.now();
	
	private LocalDateTime processedAt;
	
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
	
	public PaymentMethod getPaymentMethod() {
		return paymentMethod;
	}
	
	public void setPaymentMethod(PaymentMethod paymentMethod) {
		this.paymentMethod = paymentMethod;
	}
	
	public PaymentStatus getStatus() {
		return status;
	}
	
	public void setStatus(PaymentStatus status) {
		this.status = status;
	}
	
	public String getTransactionId() {
		return transactionId;
	}
	
	public void setTransactionId(String transactionId) {
		this.transactionId = transactionId;
	}
	
	public String getPaymentGatewayResponse() {
		return paymentGatewayResponse;
	}
	
	public void setPaymentGatewayResponse(String paymentGatewayResponse) {
		this.paymentGatewayResponse = paymentGatewayResponse;
	}
	
	public LocalDateTime getCreatedAt() {
		return createdAt;
	}
	
	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}
	
	public LocalDateTime getProcessedAt() {
		return processedAt;
	}
	
	public void setProcessedAt(LocalDateTime processedAt) {
		this.processedAt = processedAt;
	}
}

