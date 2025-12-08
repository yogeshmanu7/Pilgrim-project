package com.pilgrim.entity;

import com.pilgrim.enums.BookingStatus;
import com.pilgrim.enums.PaymentStatus;
import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

@Entity
@Table(name = "darshan_bookings")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DarshanBooking {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(unique = true, nullable = false)
    private String bookingNumber;
    
    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;
    
    @ManyToOne
    @JoinColumn(name = "darshan_id", nullable = false)
    private Darshan darshan;
    
    @Column(nullable = false)
    private LocalDate bookingDate;
    
    private LocalTime slotTime;
    
    @Column(nullable = false)
    private Integer numberOfPersons;
    
    @Column(precision = 10, scale = 2)
    private BigDecimal totalAmount;
    
    @Builder.Default
    @Enumerated(EnumType.STRING)
    private BookingStatus status = BookingStatus.PENDING;
    
    @Builder.Default
    @Enumerated(EnumType.STRING)
    private PaymentStatus paymentStatus = PaymentStatus.PENDING;
    
    private String paymentTransactionId;
    
    // Devotee Details
    private String primaryDevoteeName;
    
    private String primaryDevoteePhone;
    
    @Column(columnDefinition = "TEXT")
    private String additionalDevoteeNames;
    
    private String qrCode;
    
    @Column(columnDefinition = "TEXT")
    private String notes;
    
    @Column(updatable = false)
    private LocalDateTime createdAt;
    
    private LocalDateTime updatedAt;
    
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (bookingNumber == null) {
            bookingNumber = "DRS" + System.currentTimeMillis();
        }
        // Ensure status is set to PENDING if not already set
        if (status == null) {
            status = BookingStatus.PENDING;
        }
        // Ensure paymentStatus is set to PENDING if not already set
        if (paymentStatus == null) {
            paymentStatus = PaymentStatus.PENDING;
        }
    }
    
    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
    
    // Explicit constructors
    public DarshanBooking() {
    }
    
    // Static builder method
    public static DarshanBookingBuilder builder() {
        return new DarshanBookingBuilder();
    }
    
    // Builder class
    public static class DarshanBookingBuilder {
        private Long id;
        private String bookingNumber;
        private User user;
        private Darshan darshan;
        private LocalDate bookingDate;
        private LocalTime slotTime;
        private Integer numberOfPersons;
        private BigDecimal totalAmount;
        private BookingStatus status = BookingStatus.PENDING;
        private PaymentStatus paymentStatus = PaymentStatus.PENDING;
        private String paymentTransactionId;
        private String primaryDevoteeName;
        private String primaryDevoteePhone;
        private String additionalDevoteeNames;
        private String qrCode;
        private String notes;
        private LocalDateTime createdAt;
        private LocalDateTime updatedAt;
        
        public DarshanBookingBuilder id(Long id) { this.id = id; return this; }
        public DarshanBookingBuilder bookingNumber(String bookingNumber) { this.bookingNumber = bookingNumber; return this; }
        public DarshanBookingBuilder user(User user) { this.user = user; return this; }
        public DarshanBookingBuilder darshan(Darshan darshan) { this.darshan = darshan; return this; }
        public DarshanBookingBuilder bookingDate(LocalDate bookingDate) { this.bookingDate = bookingDate; return this; }
        public DarshanBookingBuilder slotTime(LocalTime slotTime) { this.slotTime = slotTime; return this; }
        public DarshanBookingBuilder numberOfPersons(Integer numberOfPersons) { this.numberOfPersons = numberOfPersons; return this; }
        public DarshanBookingBuilder totalAmount(BigDecimal totalAmount) { this.totalAmount = totalAmount; return this; }
        public DarshanBookingBuilder status(BookingStatus status) { this.status = status; return this; }
        public DarshanBookingBuilder paymentStatus(PaymentStatus paymentStatus) { this.paymentStatus = paymentStatus; return this; }
        public DarshanBookingBuilder paymentTransactionId(String paymentTransactionId) { this.paymentTransactionId = paymentTransactionId; return this; }
        public DarshanBookingBuilder primaryDevoteeName(String primaryDevoteeName) { this.primaryDevoteeName = primaryDevoteeName; return this; }
        public DarshanBookingBuilder primaryDevoteePhone(String primaryDevoteePhone) { this.primaryDevoteePhone = primaryDevoteePhone; return this; }
        public DarshanBookingBuilder additionalDevoteeNames(String additionalDevoteeNames) { this.additionalDevoteeNames = additionalDevoteeNames; return this; }
        public DarshanBookingBuilder qrCode(String qrCode) { this.qrCode = qrCode; return this; }
        public DarshanBookingBuilder notes(String notes) { this.notes = notes; return this; }
        public DarshanBookingBuilder createdAt(LocalDateTime createdAt) { this.createdAt = createdAt; return this; }
        public DarshanBookingBuilder updatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; return this; }
        
        public DarshanBooking build() {
            DarshanBooking booking = new DarshanBooking();
            booking.setId(id);
            booking.setBookingNumber(bookingNumber);
            booking.setUser(user);
            booking.setDarshan(darshan);
            booking.setBookingDate(bookingDate);
            booking.setSlotTime(slotTime);
            booking.setNumberOfPersons(numberOfPersons);
            booking.setTotalAmount(totalAmount);
            booking.setStatus(status);
            booking.setPaymentStatus(paymentStatus);
            booking.setPaymentTransactionId(paymentTransactionId);
            booking.setPrimaryDevoteeName(primaryDevoteeName);
            booking.setPrimaryDevoteePhone(primaryDevoteePhone);
            booking.setAdditionalDevoteeNames(additionalDevoteeNames);
            booking.setQrCode(qrCode);
            booking.setNotes(notes);
            booking.setCreatedAt(createdAt);
            booking.setUpdatedAt(updatedAt);
            return booking;
        }
    }
    
    // Explicit getters and setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getBookingNumber() { return bookingNumber; }
    public void setBookingNumber(String bookingNumber) { this.bookingNumber = bookingNumber; }
    public Darshan getDarshan() { return darshan; }
    public void setDarshan(Darshan darshan) { this.darshan = darshan; }
    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
    public BookingStatus getStatus() { return status; }
    public void setStatus(BookingStatus status) { this.status = status; }
    public PaymentStatus getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(PaymentStatus paymentStatus) { this.paymentStatus = paymentStatus; }
    public BigDecimal getTotalAmount() { return totalAmount; }
    public void setTotalAmount(BigDecimal totalAmount) { this.totalAmount = totalAmount; }
    public LocalDate getBookingDate() { return bookingDate; }
    public void setBookingDate(LocalDate bookingDate) { this.bookingDate = bookingDate; }
    public LocalTime getSlotTime() { return slotTime; }
    public void setSlotTime(LocalTime slotTime) { this.slotTime = slotTime; }
    public Integer getNumberOfPersons() { return numberOfPersons; }
    public void setNumberOfPersons(Integer numberOfPersons) { this.numberOfPersons = numberOfPersons; }
    public String getPrimaryDevoteeName() { return primaryDevoteeName; }
    public void setPrimaryDevoteeName(String primaryDevoteeName) { this.primaryDevoteeName = primaryDevoteeName; }
    public String getPrimaryDevoteePhone() { return primaryDevoteePhone; }
    public void setPrimaryDevoteePhone(String primaryDevoteePhone) { this.primaryDevoteePhone = primaryDevoteePhone; }
    public String getAdditionalDevoteeNames() { return additionalDevoteeNames; }
    public void setAdditionalDevoteeNames(String additionalDevoteeNames) { this.additionalDevoteeNames = additionalDevoteeNames; }
    public String getQrCode() { return qrCode; }
    public void setQrCode(String qrCode) { this.qrCode = qrCode; }
    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }
    public String getPaymentTransactionId() { return paymentTransactionId; }
    public void setPaymentTransactionId(String paymentTransactionId) { this.paymentTransactionId = paymentTransactionId; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
}

