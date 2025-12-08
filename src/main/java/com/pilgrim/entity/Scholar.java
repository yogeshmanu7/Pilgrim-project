package com.pilgrim.entity;

import com.pilgrim.enums.ScholarRegistrationStatus;
import com.pilgrim.enums.ScholarSpecialization;
import com.pilgrim.enums.ScholarType;
import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "scholars")
public class Scholar {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @OneToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;
    
    @Enumerated(EnumType.STRING)
    @Column(nullable = true)
    private ScholarType type;
    
    @Column(name = "experience_years")
    private Integer experienceYears;
    
    @ElementCollection
    @Enumerated(EnumType.STRING)
    @Column(name = "specializations")
    @CollectionTable(name = "scholar_specializations", joinColumns = @JoinColumn(name = "scholar_id"))
    private List<ScholarSpecialization> specializations;
    
    @ElementCollection
    @Column(name = "languages")
    @CollectionTable(name = "scholar_languages", joinColumns = @JoinColumn(name = "scholar_id"))
    private List<String> languages;
    
    @Column(name = "service_areas", columnDefinition = "TEXT")
    private String serviceAreas;
    
    @Column(name = "base_price", precision = 10, scale = 2)
    private BigDecimal basePrice;
    
    @Column(name = "id_proof_path")
    private String idProofPath;
    
    @Column(name = "certificates_path")
    private String certificatesPath;
    
    @Column(name = "profile_photo_path")
    private String profilePhotoPath;
    
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private ScholarRegistrationStatus status = ScholarRegistrationStatus.BASIC_REGISTERED;
    
    @Column(name = "rejection_reason", length = 1000)
    private String rejectionReason;
    
    @Column(name = "rating", precision = 3, scale = 2)
    private BigDecimal rating;
    
    @Column(name = "total_reviews")
    private Integer totalReviews;
    
    @Column(name = "is_available")
    private Boolean isAvailable;
    
    @Column(name = "video_call_link")
    private String videoCallLink;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    public Scholar() {
        this.status = ScholarRegistrationStatus.BASIC_REGISTERED;
        this.rating = BigDecimal.ZERO;
        this.totalReviews = 0;
        this.isAvailable = true;
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
        this.specializations = new ArrayList<>();
        this.languages = new ArrayList<>();
    }
    
    // Getters and Setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public User getUser() {
        return user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    
    public ScholarType getType() {
        return type;
    }
    
    public void setType(ScholarType type) {
        this.type = type;
    }
    
    public Integer getExperienceYears() {
        return experienceYears;
    }
    
    public void setExperienceYears(Integer experienceYears) {
        this.experienceYears = experienceYears;
    }
    
    public List<ScholarSpecialization> getSpecializations() {
        return specializations;
    }
    
    public void setSpecializations(List<ScholarSpecialization> specializations) {
        this.specializations = specializations;
    }
    
    public List<String> getLanguages() {
        return languages;
    }
    
    public void setLanguages(List<String> languages) {
        this.languages = languages;
    }
    
    public String getServiceAreas() {
        return serviceAreas;
    }
    
    public void setServiceAreas(String serviceAreas) {
        this.serviceAreas = serviceAreas;
    }
    
    public BigDecimal getBasePrice() {
        return basePrice;
    }
    
    public void setBasePrice(BigDecimal basePrice) {
        this.basePrice = basePrice;
    }
    
    public String getIdProofPath() {
        return idProofPath;
    }
    
    public void setIdProofPath(String idProofPath) {
        this.idProofPath = idProofPath;
    }
    
    public String getCertificatesPath() {
        return certificatesPath;
    }
    
    public void setCertificatesPath(String certificatesPath) {
        this.certificatesPath = certificatesPath;
    }
    
    public String getProfilePhotoPath() {
        return profilePhotoPath;
    }
    
    public void setProfilePhotoPath(String profilePhotoPath) {
        this.profilePhotoPath = profilePhotoPath;
    }
    
    public ScholarRegistrationStatus getStatus() {
        return status;
    }
    
    public void setStatus(ScholarRegistrationStatus status) {
        this.status = status;
    }
    
    public String getRejectionReason() {
        return rejectionReason;
    }
    
    public void setRejectionReason(String rejectionReason) {
        this.rejectionReason = rejectionReason;
    }
    
    public BigDecimal getRating() {
        return rating;
    }
    
    public void setRating(BigDecimal rating) {
        this.rating = rating;
    }
    
    public Integer getTotalReviews() {
        return totalReviews;
    }
    
    public void setTotalReviews(Integer totalReviews) {
        this.totalReviews = totalReviews;
    }
    
    public Boolean getIsAvailable() {
        return isAvailable;
    }
    
    public void setIsAvailable(Boolean isAvailable) {
        this.isAvailable = isAvailable;
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
    }
    
    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
}

