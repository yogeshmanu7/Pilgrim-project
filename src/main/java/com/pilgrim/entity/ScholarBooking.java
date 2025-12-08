package com.pilgrim.entity;

import com.pilgrim.enums.ScholarBookingStatus;
import com.pilgrim.enums.ScholarServiceType;
import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "scholar_bookings")
public class ScholarBooking {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne
    @JoinColumn(name = "customer_id", nullable = false)
    private User customer;
    
    @ManyToOne
    @JoinColumn(name = "scholar_id", nullable = false)
    private Scholar scholar;
    
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private ScholarBookingStatus status = ScholarBookingStatus.PENDING_CONFIRMATION;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "service_type", nullable = false)
    private ScholarServiceType serviceType;
    
    @Column(name = "booking_date")
    private LocalDateTime bookingDate;
    
    @Column(name = "service_date")
    private LocalDateTime serviceDate;
    
    @Column(name = "service_location", length = 500)
    private String serviceLocation;
    
    @Column(name = "service_description", length = 1000)
    private String serviceDescription;
    
    @Column(name = "total_amount", precision = 10, scale = 2)
    private BigDecimal totalAmount;
    
    @Column(name = "video_call_link")
    private String videoCallLink;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    public ScholarBooking() {
        this.status = ScholarBookingStatus.PENDING_CONFIRMATION;
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }
    
    // Getters and Setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public User getCustomer() {
        return customer;
    }
    
    public void setCustomer(User customer) {
        this.customer = customer;
    }
    
    public Scholar getScholar() {
        return scholar;
    }
    
    public void setScholar(Scholar scholar) {
        this.scholar = scholar;
    }
    
    public ScholarBookingStatus getStatus() {
        return status;
    }
    
    public void setStatus(ScholarBookingStatus status) {
        this.status = status;
    }
    
    public ScholarServiceType getServiceType() {
        return serviceType;
    }
    
    public void setServiceType(ScholarServiceType serviceType) {
        this.serviceType = serviceType;
    }
    
    public LocalDateTime getBookingDate() {
        return bookingDate;
    }
    
    public void setBookingDate(LocalDateTime bookingDate) {
        this.bookingDate = bookingDate;
    }
    
    public LocalDateTime getServiceDate() {
        return serviceDate;
    }
    
    public void setServiceDate(LocalDateTime serviceDate) {
        this.serviceDate = serviceDate;
    }
    
    public String getServiceLocation() {
        return serviceLocation;
    }
    
    public void setServiceLocation(String serviceLocation) {
        this.serviceLocation = serviceLocation;
    }
    
    public String getServiceDescription() {
        return serviceDescription;
    }
    
    public void setServiceDescription(String serviceDescription) {
        this.serviceDescription = serviceDescription;
    }
    
    public BigDecimal getTotalAmount() {
        return totalAmount;
    }
    
    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }
    
    public String getVideoCallLink() {
        return videoCallLink;
    }
    
    public void setVideoCallLink(String videoCallLink) {
        this.videoCallLink = videoCallLink;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    @PrePersist
    protected void onCreate() {
        if (createdAt == null) {
            createdAt = LocalDateTime.now();
        }
        if (updatedAt == null) {
            updatedAt = LocalDateTime.now();
        }
        if (bookingDate == null) {
            bookingDate = LocalDateTime.now();
        }
    }
    
    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
}

