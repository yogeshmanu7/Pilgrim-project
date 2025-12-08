package com.pilgrim.entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;
import java.time.LocalTime;

@Entity
@Table(name = "rituals")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Ritual {
    
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
    
    private LocalTime time;
    
    private Integer durationMinutes;
    
    @Enumerated(EnumType.STRING)
    private RitualFrequency frequency;
    
    @Column(name = "ritual_procedure", columnDefinition = "TEXT")
    private String ritualProcedure;
    
    private String imageUrl;
    
    @Builder.Default
    private boolean isPublicAllowed = true;
    
    @Builder.Default
    private boolean isActive = true;
    
    private Integer displayOrder;
    
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
    public Ritual() {
    }
    
    // Static builder method
    public static RitualBuilder builder() {
        return new RitualBuilder();
    }
    
    // Builder class
    public static class RitualBuilder {
        private Long id;
        private Temple temple;
        private String name;
        private String nameHindi;
        private String description;
        private String descriptionHindi;
        private String significance;
        private LocalTime time;
        private Integer durationMinutes;
        private RitualFrequency frequency;
        private String ritualProcedure;
        private String imageUrl;
        private boolean isPublicAllowed = true;
        private boolean isActive = true;
        private Integer displayOrder;
        private LocalDateTime createdAt;
        private LocalDateTime updatedAt;
        
        public RitualBuilder id(Long id) { this.id = id; return this; }
        public RitualBuilder temple(Temple temple) { this.temple = temple; return this; }
        public RitualBuilder name(String name) { this.name = name; return this; }
        public RitualBuilder nameHindi(String nameHindi) { this.nameHindi = nameHindi; return this; }
        public RitualBuilder description(String description) { this.description = description; return this; }
        public RitualBuilder descriptionHindi(String descriptionHindi) { this.descriptionHindi = descriptionHindi; return this; }
        public RitualBuilder significance(String significance) { this.significance = significance; return this; }
        public RitualBuilder time(LocalTime time) { this.time = time; return this; }
        public RitualBuilder durationMinutes(Integer durationMinutes) { this.durationMinutes = durationMinutes; return this; }
        public RitualBuilder frequency(RitualFrequency frequency) { this.frequency = frequency; return this; }
        public RitualBuilder ritualProcedure(String ritualProcedure) { this.ritualProcedure = ritualProcedure; return this; }
        public RitualBuilder imageUrl(String imageUrl) { this.imageUrl = imageUrl; return this; }
        public RitualBuilder isPublicAllowed(boolean isPublicAllowed) { this.isPublicAllowed = isPublicAllowed; return this; }
        public RitualBuilder isActive(boolean isActive) { this.isActive = isActive; return this; }
        public RitualBuilder displayOrder(Integer displayOrder) { this.displayOrder = displayOrder; return this; }
        public RitualBuilder createdAt(LocalDateTime createdAt) { this.createdAt = createdAt; return this; }
        public RitualBuilder updatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; return this; }
        
        public Ritual build() {
            Ritual ritual = new Ritual();
            ritual.setId(id);
            ritual.setTemple(temple);
            ritual.setName(name);
            ritual.setNameHindi(nameHindi);
            ritual.setDescription(description);
            ritual.setDescriptionHindi(descriptionHindi);
            ritual.setSignificance(significance);
            ritual.setTime(time);
            ritual.setDurationMinutes(durationMinutes);
            ritual.setFrequency(frequency);
            ritual.setRitualProcedure(ritualProcedure);
            ritual.setImageUrl(imageUrl);
            ritual.setIsPublicAllowed(isPublicAllowed);
            ritual.setIsActive(isActive);
            ritual.setDisplayOrder(displayOrder);
            ritual.setCreatedAt(createdAt);
            ritual.setUpdatedAt(updatedAt);
            return ritual;
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
    public LocalTime getTime() { return time; }
    public void setTime(LocalTime time) { this.time = time; }
    public Integer getDurationMinutes() { return durationMinutes; }
    public void setDurationMinutes(Integer durationMinutes) { this.durationMinutes = durationMinutes; }
    public RitualFrequency getFrequency() { return frequency; }
    public void setFrequency(RitualFrequency frequency) { this.frequency = frequency; }
    public String getRitualProcedure() { return ritualProcedure; }
    public void setRitualProcedure(String ritualProcedure) { this.ritualProcedure = ritualProcedure; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    public boolean isPublicAllowed() { return isPublicAllowed; }
    public void setIsPublicAllowed(boolean isPublicAllowed) { this.isPublicAllowed = isPublicAllowed; }
    public boolean isActive() { return isActive; }
    public void setIsActive(boolean isActive) { this.isActive = isActive; }
    public Integer getDisplayOrder() { return displayOrder; }
    public void setDisplayOrder(Integer displayOrder) { this.displayOrder = displayOrder; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
    
    public enum RitualFrequency {
        DAILY("Daily"),
        WEEKLY("Weekly"),
        MONTHLY("Monthly"),
        ANNUALLY("Annually"),
        SPECIAL("Special Occasions");
        
        private final String displayName;
        
        RitualFrequency(String displayName) {
            this.displayName = displayName;
        }
        
        public String getDisplayName() {
            return displayName;
        }
    }
}

