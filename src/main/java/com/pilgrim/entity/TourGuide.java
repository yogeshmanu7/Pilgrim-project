package com.pilgrim.entity;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "tour_guides")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TourGuide {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne
    @JoinColumn(name = "temple_id", nullable = false)
    private Temple temple;
    
    @OneToOne
    @JoinColumn(name = "user_id")
    private User user;
    
    @Column(nullable = false)
    private String name;
    
    private String phone;
    
    private String email;
    
    private String photoUrl;
    
    @Column(columnDefinition = "TEXT")
    private String bio;
    
    @Column(columnDefinition = "TEXT")
    private String languages; // JSON array like ["English", "Hindi", "Tamil"]
    
    private Integer experienceYears;
    
    @Column(precision = 10, scale = 2)
    private BigDecimal hourlyRate;
    
    @Column(precision = 10, scale = 2)
    private BigDecimal fullDayRate;
    
    private Double rating;
    
    private Integer totalTours;
    
    @Builder.Default
    private boolean isAvailable = true;
    
    @Builder.Default
    private boolean isVerified = false;
    
    @Column(columnDefinition = "TEXT")
    private String certifications;
    
    @OneToMany(mappedBy = "tourGuide", cascade = CascadeType.ALL)
    private List<TourBooking> bookings;
    
    @Column(updatable = false)
    private LocalDateTime createdAt;
    
    private LocalDateTime updatedAt;
    
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }
    
    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
    
    // Explicit constructors
    public TourGuide() {
    }
    
    // Static builder method
    public static TourGuideBuilder builder() {
        return new TourGuideBuilder();
    }
    
    // Builder class
    public static class TourGuideBuilder {
        private Long id;
        private Temple temple;
        private User user;
        private String name;
        private String phone;
        private String email;
        private String photoUrl;
        private String bio;
        private String languages;
        private Integer experienceYears;
        private BigDecimal hourlyRate;
        private BigDecimal fullDayRate;
        private Double rating;
        private Integer totalTours;
        private boolean isAvailable = true;
        private boolean isVerified = false;
        private String certifications;
        private List<TourBooking> bookings;
        private LocalDateTime createdAt;
        private LocalDateTime updatedAt;
        
        public TourGuideBuilder id(Long id) { this.id = id; return this; }
        public TourGuideBuilder temple(Temple temple) { this.temple = temple; return this; }
        public TourGuideBuilder user(User user) { this.user = user; return this; }
        public TourGuideBuilder name(String name) { this.name = name; return this; }
        public TourGuideBuilder phone(String phone) { this.phone = phone; return this; }
        public TourGuideBuilder email(String email) { this.email = email; return this; }
        public TourGuideBuilder photoUrl(String photoUrl) { this.photoUrl = photoUrl; return this; }
        public TourGuideBuilder bio(String bio) { this.bio = bio; return this; }
        public TourGuideBuilder languages(String languages) { this.languages = languages; return this; }
        public TourGuideBuilder experienceYears(Integer experienceYears) { this.experienceYears = experienceYears; return this; }
        public TourGuideBuilder hourlyRate(BigDecimal hourlyRate) { this.hourlyRate = hourlyRate; return this; }
        public TourGuideBuilder fullDayRate(BigDecimal fullDayRate) { this.fullDayRate = fullDayRate; return this; }
        public TourGuideBuilder rating(Double rating) { this.rating = rating; return this; }
        public TourGuideBuilder totalTours(Integer totalTours) { this.totalTours = totalTours; return this; }
        public TourGuideBuilder isAvailable(boolean isAvailable) { this.isAvailable = isAvailable; return this; }
        public TourGuideBuilder isVerified(boolean isVerified) { this.isVerified = isVerified; return this; }
        public TourGuideBuilder certifications(String certifications) { this.certifications = certifications; return this; }
        public TourGuideBuilder bookings(List<TourBooking> bookings) { this.bookings = bookings; return this; }
        public TourGuideBuilder createdAt(LocalDateTime createdAt) { this.createdAt = createdAt; return this; }
        public TourGuideBuilder updatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; return this; }
        
        public TourGuide build() {
            TourGuide guide = new TourGuide();
            guide.setId(id);
            guide.setTemple(temple);
            guide.setUser(user);
            guide.setName(name);
            guide.setPhone(phone);
            guide.setEmail(email);
            guide.setPhotoUrl(photoUrl);
            guide.setBio(bio);
            guide.setLanguages(languages);
            guide.setExperienceYears(experienceYears);
            guide.setHourlyRate(hourlyRate);
            guide.setFullDayRate(fullDayRate);
            guide.setRating(rating);
            guide.setTotalTours(totalTours);
            guide.setIsAvailable(isAvailable);
            guide.setIsVerified(isVerified);
            guide.setCertifications(certifications);
            guide.setBookings(bookings);
            guide.setCreatedAt(createdAt);
            guide.setUpdatedAt(updatedAt);
            return guide;
        }
    }
    
    // Explicit getters and setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Temple getTemple() { return temple; }
    public void setTemple(Temple temple) { this.temple = temple; }
    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPhotoUrl() { return photoUrl; }
    public void setPhotoUrl(String photoUrl) { this.photoUrl = photoUrl; }
    public String getBio() { return bio; }
    public void setBio(String bio) { this.bio = bio; }
    public String getLanguages() { return languages; }
    public void setLanguages(String languages) { this.languages = languages; }
    public Integer getExperienceYears() { return experienceYears; }
    public void setExperienceYears(Integer experienceYears) { this.experienceYears = experienceYears; }
    public BigDecimal getHourlyRate() { return hourlyRate; }
    public void setHourlyRate(BigDecimal hourlyRate) { this.hourlyRate = hourlyRate; }
    public BigDecimal getFullDayRate() { return fullDayRate; }
    public void setFullDayRate(BigDecimal fullDayRate) { this.fullDayRate = fullDayRate; }
    public Double getRating() { return rating; }
    public void setRating(Double rating) { this.rating = rating; }
    public Integer getTotalTours() { return totalTours; }
    public void setTotalTours(Integer totalTours) { this.totalTours = totalTours; }
    public boolean isAvailable() { return isAvailable; }
    public void setIsAvailable(boolean isAvailable) { this.isAvailable = isAvailable; }
    public boolean isVerified() { return isVerified; }
    public void setIsVerified(boolean isVerified) { this.isVerified = isVerified; }
    public String getCertifications() { return certifications; }
    public void setCertifications(String certifications) { this.certifications = certifications; }
    public List<TourBooking> getBookings() { return bookings; }
    public void setBookings(List<TourBooking> bookings) { this.bookings = bookings; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
}

