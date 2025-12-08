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
@Table(name = "tour_bookings")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TourBooking {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(unique = true, nullable = false)
    private String bookingNumber;
    
    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;
    
    @ManyToOne
    @JoinColumn(name = "tour_guide_id", nullable = false)
    private TourGuide tourGuide;
    
    @Column(nullable = false)
    private LocalDate tourDate;
    
    private LocalTime startTime;
    
    private LocalTime endTime;
    
    @Enumerated(EnumType.STRING)
    private TourType tourType;
    
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
    
    private String contactName;
    
    private String contactPhone;
    
    @Column(columnDefinition = "TEXT")
    private String specialRequirements;
    
    private String preferredLanguage;
    
    @Column(updatable = false)
    private LocalDateTime createdAt;
    
    private LocalDateTime updatedAt;
    
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (bookingNumber == null) {
            bookingNumber = "TUR" + System.currentTimeMillis();
        }
    }
    
    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
    
    // Explicit constructors
    public TourBooking() {
    }
    
    // Static builder method
    public static TourBookingBuilder builder() {
        return new TourBookingBuilder();
    }
    
    // Builder class
    public static class TourBookingBuilder {
        private Long id;
        private String bookingNumber;
        private User user;
        private TourGuide tourGuide;
        private LocalDate tourDate;
        private LocalTime startTime;
        private LocalTime endTime;
        private TourType tourType;
        private Integer numberOfPersons;
        private BigDecimal totalAmount;
        private BookingStatus status = BookingStatus.PENDING;
        private PaymentStatus paymentStatus = PaymentStatus.PENDING;
        private String paymentTransactionId;
        private String contactName;
        private String contactPhone;
        private String specialRequirements;
        private String preferredLanguage;
        private LocalDateTime createdAt;
        private LocalDateTime updatedAt;
        
        public TourBookingBuilder id(Long id) { this.id = id; return this; }
        public TourBookingBuilder bookingNumber(String bookingNumber) { this.bookingNumber = bookingNumber; return this; }
        public TourBookingBuilder user(User user) { this.user = user; return this; }
        public TourBookingBuilder tourGuide(TourGuide tourGuide) { this.tourGuide = tourGuide; return this; }
        public TourBookingBuilder tourDate(LocalDate tourDate) { this.tourDate = tourDate; return this; }
        public TourBookingBuilder startTime(LocalTime startTime) { this.startTime = startTime; return this; }
        public TourBookingBuilder endTime(LocalTime endTime) { this.endTime = endTime; return this; }
        public TourBookingBuilder tourType(TourType tourType) { this.tourType = tourType; return this; }
        public TourBookingBuilder numberOfPersons(Integer numberOfPersons) { this.numberOfPersons = numberOfPersons; return this; }
        public TourBookingBuilder totalAmount(BigDecimal totalAmount) { this.totalAmount = totalAmount; return this; }
        public TourBookingBuilder status(BookingStatus status) { this.status = status; return this; }
        public TourBookingBuilder paymentStatus(PaymentStatus paymentStatus) { this.paymentStatus = paymentStatus; return this; }
        public TourBookingBuilder paymentTransactionId(String paymentTransactionId) { this.paymentTransactionId = paymentTransactionId; return this; }
        public TourBookingBuilder contactName(String contactName) { this.contactName = contactName; return this; }
        public TourBookingBuilder contactPhone(String contactPhone) { this.contactPhone = contactPhone; return this; }
        public TourBookingBuilder specialRequirements(String specialRequirements) { this.specialRequirements = specialRequirements; return this; }
        public TourBookingBuilder preferredLanguage(String preferredLanguage) { this.preferredLanguage = preferredLanguage; return this; }
        public TourBookingBuilder createdAt(LocalDateTime createdAt) { this.createdAt = createdAt; return this; }
        public TourBookingBuilder updatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; return this; }
        
        public TourBooking build() {
            TourBooking booking = new TourBooking();
            booking.setId(id);
            booking.setBookingNumber(bookingNumber);
            booking.setUser(user);
            booking.setTourGuide(tourGuide);
            booking.setTourDate(tourDate);
            booking.setStartTime(startTime);
            booking.setEndTime(endTime);
            booking.setTourType(tourType);
            booking.setNumberOfPersons(numberOfPersons);
            booking.setTotalAmount(totalAmount);
            booking.setStatus(status);
            booking.setPaymentStatus(paymentStatus);
            booking.setPaymentTransactionId(paymentTransactionId);
            booking.setContactName(contactName);
            booking.setContactPhone(contactPhone);
            booking.setSpecialRequirements(specialRequirements);
            booking.setPreferredLanguage(preferredLanguage);
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
    public TourGuide getTourGuide() { return tourGuide; }
    public void setTourGuide(TourGuide tourGuide) { this.tourGuide = tourGuide; }
    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
    public LocalDate getTourDate() { return tourDate; }
    public void setTourDate(LocalDate tourDate) { this.tourDate = tourDate; }
    public LocalTime getStartTime() { return startTime; }
    public void setStartTime(LocalTime startTime) { this.startTime = startTime; }
    public LocalTime getEndTime() { return endTime; }
    public void setEndTime(LocalTime endTime) { this.endTime = endTime; }
    public TourType getTourType() { return tourType; }
    public void setTourType(TourType tourType) { this.tourType = tourType; }
    public Integer getNumberOfPersons() { return numberOfPersons; }
    public void setNumberOfPersons(Integer numberOfPersons) { this.numberOfPersons = numberOfPersons; }
    public BigDecimal getTotalAmount() { return totalAmount; }
    public void setTotalAmount(BigDecimal totalAmount) { this.totalAmount = totalAmount; }
    public BookingStatus getStatus() { return status; }
    public void setStatus(BookingStatus status) { this.status = status; }
    public PaymentStatus getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(PaymentStatus paymentStatus) { this.paymentStatus = paymentStatus; }
    public String getPaymentTransactionId() { return paymentTransactionId; }
    public void setPaymentTransactionId(String paymentTransactionId) { this.paymentTransactionId = paymentTransactionId; }
    public String getContactName() { return contactName; }
    public void setContactName(String contactName) { this.contactName = contactName; }
    public String getContactPhone() { return contactPhone; }
    public void setContactPhone(String contactPhone) { this.contactPhone = contactPhone; }
    public String getSpecialRequirements() { return specialRequirements; }
    public void setSpecialRequirements(String specialRequirements) { this.specialRequirements = specialRequirements; }
    public String getPreferredLanguage() { return preferredLanguage; }
    public void setPreferredLanguage(String preferredLanguage) { this.preferredLanguage = preferredLanguage; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
    
    public enum TourType {
        HOURLY("Hourly Tour"),
        HALF_DAY("Half Day Tour"),
        FULL_DAY("Full Day Tour");
        
        private final String displayName;
        
        TourType(String displayName) {
            this.displayName = displayName;
        }
        
        public String getDisplayName() {
            return displayName;
        }
    }
}

