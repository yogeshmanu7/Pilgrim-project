package com.pilgrim.entity;

import com.pilgrim.enums.PaymentStatus;
import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "temple_donations")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TempleDonation {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(unique = true, nullable = false)
    private String donationNumber;
    
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
    
    @ManyToOne
    @JoinColumn(name = "temple_id", nullable = false)
    private Temple temple;
    
    @Column(nullable = false)
    private String donorName;
    
    private String donorEmail;
    
    private String donorPhone;
    
    private String donorAddress;
    
    private String donorPanNumber; // For tax purposes
    
    @Enumerated(EnumType.STRING)
    private DonationType donationType;
    
    @Column(precision = 10, scale = 2, nullable = false)
    private BigDecimal amount;
    
    @Column(columnDefinition = "TEXT")
    private String purpose;
    
    private String inMemoryOf; // For memorial donations
    
    private boolean isAnonymous = false;
    
    private boolean receiptRequired = true;
    
    @Enumerated(EnumType.STRING)
    private PaymentStatus paymentStatus = PaymentStatus.PENDING;
    
    private String paymentTransactionId;
    
    private String paymentMethod;
    
    private String receiptNumber;
    
    private boolean is80GApplicable = false; // Tax exemption
    
    @Column(columnDefinition = "TEXT")
    private String notes;
    
    @Column(updatable = false)
    private LocalDateTime createdAt;
    
    private LocalDateTime updatedAt;
    
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (donationNumber == null) {
            donationNumber = "DON" + System.currentTimeMillis();
        }
    }
    
    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
    
    // Explicit constructors
    public TempleDonation() {
    }
    
    // Static builder method
    public static TempleDonationBuilder builder() {
        return new TempleDonationBuilder();
    }
    
    // Builder class
    public static class TempleDonationBuilder {
        private Long id;
        private String donationNumber;
        private User user;
        private Temple temple;
        private String donorName;
        private String donorEmail;
        private String donorPhone;
        private String donorAddress;
        private String donorPanNumber;
        private DonationType donationType;
        private BigDecimal amount;
        private String purpose;
        private String inMemoryOf;
        private boolean isAnonymous = false;
        private boolean receiptRequired = true;
        private PaymentStatus paymentStatus = PaymentStatus.PENDING;
        private String paymentTransactionId;
        private String paymentMethod;
        private String receiptNumber;
        private boolean is80GApplicable = false;
        private String notes;
        private LocalDateTime createdAt;
        private LocalDateTime updatedAt;
        
        public TempleDonationBuilder id(Long id) { this.id = id; return this; }
        public TempleDonationBuilder donationNumber(String donationNumber) { this.donationNumber = donationNumber; return this; }
        public TempleDonationBuilder user(User user) { this.user = user; return this; }
        public TempleDonationBuilder temple(Temple temple) { this.temple = temple; return this; }
        public TempleDonationBuilder donorName(String donorName) { this.donorName = donorName; return this; }
        public TempleDonationBuilder donorEmail(String donorEmail) { this.donorEmail = donorEmail; return this; }
        public TempleDonationBuilder donorPhone(String donorPhone) { this.donorPhone = donorPhone; return this; }
        public TempleDonationBuilder donorAddress(String donorAddress) { this.donorAddress = donorAddress; return this; }
        public TempleDonationBuilder donorPanNumber(String donorPanNumber) { this.donorPanNumber = donorPanNumber; return this; }
        public TempleDonationBuilder donationType(DonationType donationType) { this.donationType = donationType; return this; }
        public TempleDonationBuilder amount(BigDecimal amount) { this.amount = amount; return this; }
        public TempleDonationBuilder purpose(String purpose) { this.purpose = purpose; return this; }
        public TempleDonationBuilder inMemoryOf(String inMemoryOf) { this.inMemoryOf = inMemoryOf; return this; }
        public TempleDonationBuilder isAnonymous(boolean isAnonymous) { this.isAnonymous = isAnonymous; return this; }
        public TempleDonationBuilder receiptRequired(boolean receiptRequired) { this.receiptRequired = receiptRequired; return this; }
        public TempleDonationBuilder paymentStatus(PaymentStatus paymentStatus) { this.paymentStatus = paymentStatus; return this; }
        public TempleDonationBuilder paymentTransactionId(String paymentTransactionId) { this.paymentTransactionId = paymentTransactionId; return this; }
        public TempleDonationBuilder paymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; return this; }
        public TempleDonationBuilder receiptNumber(String receiptNumber) { this.receiptNumber = receiptNumber; return this; }
        public TempleDonationBuilder is80GApplicable(boolean is80GApplicable) { this.is80GApplicable = is80GApplicable; return this; }
        public TempleDonationBuilder notes(String notes) { this.notes = notes; return this; }
        public TempleDonationBuilder createdAt(LocalDateTime createdAt) { this.createdAt = createdAt; return this; }
        public TempleDonationBuilder updatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; return this; }
        
        public TempleDonation build() {
            TempleDonation donation = new TempleDonation();
            donation.setId(id);
            donation.setDonationNumber(donationNumber);
            donation.setUser(user);
            donation.setTemple(temple);
            donation.setDonorName(donorName);
            donation.setDonorEmail(donorEmail);
            donation.setDonorPhone(donorPhone);
            donation.setDonorAddress(donorAddress);
            donation.setDonorPanNumber(donorPanNumber);
            donation.setDonationType(donationType);
            donation.setAmount(amount);
            donation.setPurpose(purpose);
            donation.setInMemoryOf(inMemoryOf);
            donation.setIsAnonymous(isAnonymous);
            donation.setReceiptRequired(receiptRequired);
            donation.setPaymentStatus(paymentStatus);
            donation.setPaymentTransactionId(paymentTransactionId);
            donation.setPaymentMethod(paymentMethod);
            donation.setReceiptNumber(receiptNumber);
            donation.setIs80GApplicable(is80GApplicable);
            donation.setNotes(notes);
            donation.setCreatedAt(createdAt);
            donation.setUpdatedAt(updatedAt);
            return donation;
        }
    }
    
    // Explicit getters and setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getDonationNumber() { return donationNumber; }
    public void setDonationNumber(String donationNumber) { this.donationNumber = donationNumber; }
    public Temple getTemple() { return temple; }
    public void setTemple(Temple temple) { this.temple = temple; }
    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
    public String getDonorName() { return donorName; }
    public void setDonorName(String donorName) { this.donorName = donorName; }
    public String getDonorEmail() { return donorEmail; }
    public void setDonorEmail(String donorEmail) { this.donorEmail = donorEmail; }
    public String getDonorPhone() { return donorPhone; }
    public void setDonorPhone(String donorPhone) { this.donorPhone = donorPhone; }
    public String getDonorAddress() { return donorAddress; }
    public void setDonorAddress(String donorAddress) { this.donorAddress = donorAddress; }
    public String getDonorPanNumber() { return donorPanNumber; }
    public void setDonorPanNumber(String donorPanNumber) { this.donorPanNumber = donorPanNumber; }
    public DonationType getDonationType() { return donationType; }
    public void setDonationType(DonationType donationType) { this.donationType = donationType; }
    public BigDecimal getAmount() { return amount; }
    public void setAmount(BigDecimal amount) { this.amount = amount; }
    public String getPurpose() { return purpose; }
    public void setPurpose(String purpose) { this.purpose = purpose; }
    public String getInMemoryOf() { return inMemoryOf; }
    public void setInMemoryOf(String inMemoryOf) { this.inMemoryOf = inMemoryOf; }
    public boolean isAnonymous() { return isAnonymous; }
    public void setIsAnonymous(boolean isAnonymous) { this.isAnonymous = isAnonymous; }
    public boolean isReceiptRequired() { return receiptRequired; }
    public void setReceiptRequired(boolean receiptRequired) { this.receiptRequired = receiptRequired; }
    public PaymentStatus getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(PaymentStatus paymentStatus) { this.paymentStatus = paymentStatus; }
    public String getPaymentTransactionId() { return paymentTransactionId; }
    public void setPaymentTransactionId(String paymentTransactionId) { this.paymentTransactionId = paymentTransactionId; }
    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }
    public String getReceiptNumber() { return receiptNumber; }
    public void setReceiptNumber(String receiptNumber) { this.receiptNumber = receiptNumber; }
    public boolean isIs80GApplicable() { return is80GApplicable; }
    public void setIs80GApplicable(boolean is80GApplicable) { this.is80GApplicable = is80GApplicable; }
    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
    
    public enum DonationType {
        GENERAL("General Donation"),
        ANNA_DAAN("Anna Daan (Food)"),
        VASTRA_DAAN("Vastra Daan (Clothes)"),
        GO_DAAN("Go Daan (Cow)"),
        TEMPLE_CONSTRUCTION("Temple Construction"),
        FESTIVAL_SPONSORSHIP("Festival Sponsorship"),
        POOJA_SPONSORSHIP("Pooja Sponsorship"),
        MAINTENANCE("Temple Maintenance"),
        EDUCATION("Education Fund"),
        CHARITY("Charity");
        
        private final String displayName;
        
        DonationType(String displayName) {
            this.displayName = displayName;
        }
        
        public String getDisplayName() {
            return displayName;
        }
    }
}

