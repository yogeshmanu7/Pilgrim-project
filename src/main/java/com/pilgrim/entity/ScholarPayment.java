package com.pilgrim.entity;

import com.pilgrim.enums.ScholarPaymentStatus;
import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "scholar_payments")
public class ScholarPayment {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @OneToOne
    @JoinColumn(name = "booking_id", nullable = false)
    private ScholarBooking booking;
    
    @Column(name = "amount", precision = 10, scale = 2, nullable = false)
    private BigDecimal amount;
    
    @Column(name = "platform_commission", precision = 10, scale = 2)
    private BigDecimal platformCommission;
    
    @Column(name = "scholar_amount", precision = 10, scale = 2)
    private BigDecimal scholarAmount;
    
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private ScholarPaymentStatus status = ScholarPaymentStatus.PENDING;
    
    @Column(name = "payment_date")
    private LocalDateTime paymentDate;
    
    @Column(name = "settlement_date")
    private LocalDateTime settlementDate;
    
    @Column(name = "transaction_id")
    private String transactionId;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    public ScholarPayment() {
        this.status = ScholarPaymentStatus.PENDING;
        this.createdAt = LocalDateTime.now();
    }
    
    // Getters and Setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public ScholarBooking getBooking() {
        return booking;
    }
    
    public void setBooking(ScholarBooking booking) {
        this.booking = booking;
    }
    
    public BigDecimal getAmount() {
        return amount;
    }
    
    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }
    
    public BigDecimal getPlatformCommission() {
        return platformCommission;
    }
    
    public void setPlatformCommission(BigDecimal platformCommission) {
        this.platformCommission = platformCommission;
    }
    
    public BigDecimal getScholarAmount() {
        return scholarAmount;
    }
    
    public void setScholarAmount(BigDecimal scholarAmount) {
        this.scholarAmount = scholarAmount;
    }
    
    public ScholarPaymentStatus getStatus() {
        return status;
    }
    
    public void setStatus(ScholarPaymentStatus status) {
        this.status = status;
    }
    
    public LocalDateTime getPaymentDate() {
        return paymentDate;
    }
    
    public void setPaymentDate(LocalDateTime paymentDate) {
        this.paymentDate = paymentDate;
    }
    
    public LocalDateTime getSettlementDate() {
        return settlementDate;
    }
    
    public void setSettlementDate(LocalDateTime settlementDate) {
        this.settlementDate = settlementDate;
    }
    
    public String getTransactionId() {
        return transactionId;
    }
    
    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    @PrePersist
    protected void onCreate() {
        if (createdAt == null) {
            createdAt = LocalDateTime.now();
        }
    }
}

