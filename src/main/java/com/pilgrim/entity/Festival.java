package com.pilgrim.entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "festivals")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Festival {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne
    @JoinColumn(name = "temple_id", nullable = false)
    private Temple temple;
    
    @Column(nullable = false)
    private String name;
    
    private String nameHindi;
    
    @Column(columnDefinition = "TEXT")
    private String description;
    
    @Column(columnDefinition = "TEXT")
    private String descriptionHindi;
    
    @Column(columnDefinition = "TEXT")
    private String significance;
    
    private LocalDate startDate;
    
    private LocalDate endDate;
    
    @Column(columnDefinition = "TEXT")
    private String schedule; // Daily schedule during festival
    
    @Column(columnDefinition = "TEXT")
    private String specialPoojas;
    
    @Column(columnDefinition = "TEXT")
    private String specialRituals;
    
    private String imageUrl;
    
    @Builder.Default
    private boolean isAnnual = true;
    
    private String lunarDate; // Hindu calendar date
    
    @Builder.Default
    private boolean isActive = true;
    
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
    public Festival() {
    }
    
    // Static builder method
    public static FestivalBuilder builder() {
        return new FestivalBuilder();
    }
    
    // Builder class
    public static class FestivalBuilder {
        private Long id;
        private Temple temple;
        private String name;
        private String nameHindi;
        private String description;
        private String descriptionHindi;
        private String significance;
        private LocalDate startDate;
        private LocalDate endDate;
        private String schedule;
        private String specialPoojas;
        private String specialRituals;
        private String imageUrl;
        private boolean isAnnual = true;
        private String lunarDate;
        private boolean isActive = true;
        private LocalDateTime createdAt;
        private LocalDateTime updatedAt;
        
        public FestivalBuilder id(Long id) { this.id = id; return this; }
        public FestivalBuilder temple(Temple temple) { this.temple = temple; return this; }
        public FestivalBuilder name(String name) { this.name = name; return this; }
        public FestivalBuilder nameHindi(String nameHindi) { this.nameHindi = nameHindi; return this; }
        public FestivalBuilder description(String description) { this.description = description; return this; }
        public FestivalBuilder descriptionHindi(String descriptionHindi) { this.descriptionHindi = descriptionHindi; return this; }
        public FestivalBuilder significance(String significance) { this.significance = significance; return this; }
        public FestivalBuilder startDate(LocalDate startDate) { this.startDate = startDate; return this; }
        public FestivalBuilder endDate(LocalDate endDate) { this.endDate = endDate; return this; }
        public FestivalBuilder schedule(String schedule) { this.schedule = schedule; return this; }
        public FestivalBuilder specialPoojas(String specialPoojas) { this.specialPoojas = specialPoojas; return this; }
        public FestivalBuilder specialRituals(String specialRituals) { this.specialRituals = specialRituals; return this; }
        public FestivalBuilder imageUrl(String imageUrl) { this.imageUrl = imageUrl; return this; }
        public FestivalBuilder isAnnual(boolean isAnnual) { this.isAnnual = isAnnual; return this; }
        public FestivalBuilder lunarDate(String lunarDate) { this.lunarDate = lunarDate; return this; }
        public FestivalBuilder isActive(boolean isActive) { this.isActive = isActive; return this; }
        public FestivalBuilder createdAt(LocalDateTime createdAt) { this.createdAt = createdAt; return this; }
        public FestivalBuilder updatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; return this; }
        
        public Festival build() {
            Festival festival = new Festival();
            festival.setId(id);
            festival.setTemple(temple);
            festival.setName(name);
            festival.setNameHindi(nameHindi);
            festival.setDescription(description);
            festival.setDescriptionHindi(descriptionHindi);
            festival.setSignificance(significance);
            festival.setStartDate(startDate);
            festival.setEndDate(endDate);
            festival.setSchedule(schedule);
            festival.setSpecialPoojas(specialPoojas);
            festival.setSpecialRituals(specialRituals);
            festival.setImageUrl(imageUrl);
            festival.setAnnual(isAnnual);
            festival.setLunarDate(lunarDate);
            festival.setIsActive(isActive);
            festival.setCreatedAt(createdAt);
            festival.setUpdatedAt(updatedAt);
            return festival;
        }
    }
    
    // Explicit getters and setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Temple getTemple() { return temple; }
    public void setTemple(Temple temple) { this.temple = temple; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getNameHindi() { return nameHindi; }
    public void setNameHindi(String nameHindi) { this.nameHindi = nameHindi; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getDescriptionHindi() { return descriptionHindi; }
    public void setDescriptionHindi(String descriptionHindi) { this.descriptionHindi = descriptionHindi; }
    public String getSignificance() { return significance; }
    public void setSignificance(String significance) { this.significance = significance; }
    public LocalDate getStartDate() { return startDate; }
    public void setStartDate(LocalDate startDate) { this.startDate = startDate; }
    public LocalDate getEndDate() { return endDate; }
    public void setEndDate(LocalDate endDate) { this.endDate = endDate; }
    public String getSchedule() { return schedule; }
    public void setSchedule(String schedule) { this.schedule = schedule; }
    public String getSpecialPoojas() { return specialPoojas; }
    public void setSpecialPoojas(String specialPoojas) { this.specialPoojas = specialPoojas; }
    public String getSpecialRituals() { return specialRituals; }
    public void setSpecialRituals(String specialRituals) { this.specialRituals = specialRituals; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    public boolean isAnnual() { return isAnnual; }
    public void setAnnual(boolean isAnnual) { this.isAnnual = isAnnual; }
    public String getLunarDate() { return lunarDate; }
    public void setLunarDate(String lunarDate) { this.lunarDate = lunarDate; }
    public boolean isActive() { return isActive; }
    public void setIsActive(boolean isActive) { this.isActive = isActive; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
}

