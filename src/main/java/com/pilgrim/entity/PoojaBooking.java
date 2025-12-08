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
@Table(name = "pooja_bookings")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PoojaBooking {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(unique = true, nullable = false)
    private String bookingNumber;
    
    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;
    
    @ManyToOne
    @JoinColumn(name = "pooja_id", nullable = false)
    private TemplePooja pooja;
    
    @Column(nullable = false)
    private LocalDate bookingDate;
    
    private LocalTime preferredTime;
    
    @Column(precision = 10, scale = 2)
    private BigDecimal amount;
    
    // Devotee Details
    @Column(nullable = false)
    private String devoteeName;
    
    private String gotra;
    
    private String nakshatra;
    
    private String rashi;
    
    @Column(columnDefinition = "TEXT")
    private String familyMemberNames;
    
    @Column(columnDefinition = "TEXT")
    private String specialRequests;
    
    @Builder.Default
    @Enumerated(EnumType.STRING)
    private BookingStatus status = BookingStatus.PENDING;
    
    @Builder.Default
    @Enumerated(EnumType.STRING)
    private PaymentStatus paymentStatus = PaymentStatus.PENDING;
    
    private String paymentTransactionId;
    
    @Builder.Default
    private boolean prasadhamRequired = true;
    
    private String deliveryAddress;
    
    private String qrCode;
    
    @Column(updatable = false)
    private LocalDateTime createdAt;
    
    private LocalDateTime updatedAt;
    
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (bookingNumber == null) {
            bookingNumber = "POJ" + System.currentTimeMillis();
        }
    }
    
    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
    
    // Explicit constructors
    public PoojaBooking() {
    }
    
    // Static builder method
    public static PoojaBookingBuilder builder() {
        return new PoojaBookingBuilder();
    }
    
    // Builder class
    public static class PoojaBookingBuilder {
        private Long id;
        private String bookingNumber;
        private User user;
        private TemplePooja pooja;
        private LocalDate bookingDate;
        private LocalTime preferredTime;
        private BigDecimal amount;
        private String devoteeName;
        private String gotra;
        private String nakshatra;
        private String rashi;
        private String familyMemberNames;
        private String specialRequests;
        private BookingStatus status = BookingStatus.PENDING;
        private PaymentStatus paymentStatus = PaymentStatus.PENDING;
        private String paymentTransactionId;
        private boolean prasadhamRequired = true;
        private String deliveryAddress;
        private String qrCode;
        private LocalDateTime createdAt;
        private LocalDateTime updatedAt;
        
        public PoojaBookingBuilder id(Long id) { this.id = id; return this; }
        public PoojaBookingBuilder bookingNumber(String bookingNumber) { this.bookingNumber = bookingNumber; return this; }
        public PoojaBookingBuilder user(User user) { this.user = user; return this; }
        public PoojaBookingBuilder pooja(TemplePooja pooja) { this.pooja = pooja; return this; }
        public PoojaBookingBuilder bookingDate(LocalDate bookingDate) { this.bookingDate = bookingDate; return this; }
        public PoojaBookingBuilder preferredTime(LocalTime preferredTime) { this.preferredTime = preferredTime; return this; }
        public PoojaBookingBuilder amount(BigDecimal amount) { this.amount = amount; return this; }
        public PoojaBookingBuilder devoteeName(String devoteeName) { this.devoteeName = devoteeName; return this; }
        public PoojaBookingBuilder gotra(String gotra) { this.gotra = gotra; return this; }
        public PoojaBookingBuilder nakshatra(String nakshatra) { this.nakshatra = nakshatra; return this; }
        public PoojaBookingBuilder rashi(String rashi) { this.rashi = rashi; return this; }
        public PoojaBookingBuilder familyMemberNames(String familyMemberNames) { this.familyMemberNames = familyMemberNames; return this; }
        public PoojaBookingBuilder specialRequests(String specialRequests) { this.specialRequests = specialRequests; return this; }
        public PoojaBookingBuilder status(BookingStatus status) { this.status = status; return this; }
        public PoojaBookingBuilder paymentStatus(PaymentStatus paymentStatus) { this.paymentStatus = paymentStatus; return this; }
        public PoojaBookingBuilder paymentTransactionId(String paymentTransactionId) { this.paymentTransactionId = paymentTransactionId; return this; }
        public PoojaBookingBuilder prasadhamRequired(boolean prasadhamRequired) { this.prasadhamRequired = prasadhamRequired; return this; }
        public PoojaBookingBuilder deliveryAddress(String deliveryAddress) { this.deliveryAddress = deliveryAddress; return this; }
        public PoojaBookingBuilder qrCode(String qrCode) { this.qrCode = qrCode; return this; }
        public PoojaBookingBuilder createdAt(LocalDateTime createdAt) { this.createdAt = createdAt; return this; }
        public PoojaBookingBuilder updatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; return this; }
        
        public PoojaBooking build() {
            PoojaBooking booking = new PoojaBooking();
            booking.setId(id);
            booking.setBookingNumber(bookingNumber);
            booking.setUser(user);
            booking.setPooja(pooja);
            booking.setBookingDate(bookingDate);
            booking.setPreferredTime(preferredTime);
            booking.setAmount(amount);
            booking.setDevoteeName(devoteeName);
            booking.setGotra(gotra);
            booking.setNakshatra(nakshatra);
            booking.setRashi(rashi);
            booking.setFamilyMemberNames(familyMemberNames);
            booking.setSpecialRequests(specialRequests);
            booking.setStatus(status);
            booking.setPaymentStatus(paymentStatus);
            booking.setPaymentTransactionId(paymentTransactionId);
            booking.setPrasadhamRequired(prasadhamRequired);
            booking.setDeliveryAddress(deliveryAddress);
            booking.setQrCode(qrCode);
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
    public TemplePooja getPooja() { return pooja; }
    public void setPooja(TemplePooja pooja) { this.pooja = pooja; }
    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
    public LocalDate getBookingDate() { return bookingDate; }
    public void setBookingDate(LocalDate bookingDate) { this.bookingDate = bookingDate; }
    public LocalTime getPreferredTime() { return preferredTime; }
    public void setPreferredTime(LocalTime preferredTime) { this.preferredTime = preferredTime; }
    public BigDecimal getAmount() { return amount; }
    public void setAmount(BigDecimal amount) { this.amount = amount; }
    public String getDevoteeName() { return devoteeName; }
    public void setDevoteeName(String devoteeName) { this.devoteeName = devoteeName; }
    public String getGotra() { return gotra; }
    public void setGotra(String gotra) { this.gotra = gotra; }
    public String getNakshatra() { return nakshatra; }
    public void setNakshatra(String nakshatra) { this.nakshatra = nakshatra; }
    public String getRashi() { return rashi; }
    public void setRashi(String rashi) { this.rashi = rashi; }
    public String getFamilyMemberNames() { return familyMemberNames; }
    public void setFamilyMemberNames(String familyMemberNames) { this.familyMemberNames = familyMemberNames; }
    public String getSpecialRequests() { return specialRequests; }
    public void setSpecialRequests(String specialRequests) { this.specialRequests = specialRequests; }
    public BookingStatus getStatus() { return status; }
    public void setStatus(BookingStatus status) { this.status = status; }
    public PaymentStatus getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(PaymentStatus paymentStatus) { this.paymentStatus = paymentStatus; }
    public String getPaymentTransactionId() { return paymentTransactionId; }
    public void setPaymentTransactionId(String paymentTransactionId) { this.paymentTransactionId = paymentTransactionId; }
    public boolean isPrasadhamRequired() { return prasadhamRequired; }
    public void setPrasadhamRequired(boolean prasadhamRequired) { this.prasadhamRequired = prasadhamRequired; }
    public String getDeliveryAddress() { return deliveryAddress; }
    public void setDeliveryAddress(String deliveryAddress) { this.deliveryAddress = deliveryAddress; }
    public String getQrCode() { return qrCode; }
    public void setQrCode(String qrCode) { this.qrCode = qrCode; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
}

