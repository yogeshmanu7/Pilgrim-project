package com.pilgrim.entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

@Entity
@Table(name = "temple_events")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TempleEvent {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne
    @JoinColumn(name = "temple_id", nullable = false)
    private Temple temple;
    
    @Column(nullable = false)
    private String title;
    
    private String titleHindi;
    
    @Column(columnDefinition = "TEXT")
    private String description;
    
    @Column(columnDefinition = "TEXT")
    private String descriptionHindi;
    
    @Enumerated(EnumType.STRING)
    private EventType eventType;
    
    private LocalDate eventDate;
    
    private LocalTime startTime;
    
    private LocalTime endTime;
    
    private String venue;
    
    private String imageUrl;
    
    @Builder.Default
    private boolean isFree = true;
    
    @Builder.Default
    private boolean requiresRegistration = false;
    
    private Integer maxParticipants;
    
    @Builder.Default
    private Integer currentParticipants = 0;
    
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
    public TempleEvent() {
    }
    
    // Static builder method
    public static TempleEventBuilder builder() {
        return new TempleEventBuilder();
    }
    
    // Builder class
    public static class TempleEventBuilder {
        private Long id;
        private Temple temple;
        private String title;
        private String titleHindi;
        private String description;
        private String descriptionHindi;
        private EventType eventType;
        private LocalDate eventDate;
        private LocalTime startTime;
        private LocalTime endTime;
        private String venue;
        private String imageUrl;
        private boolean isFree = true;
        private boolean requiresRegistration = false;
        private Integer maxParticipants;
        private Integer currentParticipants = 0;
        private boolean isActive = true;
        private LocalDateTime createdAt;
        private LocalDateTime updatedAt;
        
        public TempleEventBuilder id(Long id) { this.id = id; return this; }
        public TempleEventBuilder temple(Temple temple) { this.temple = temple; return this; }
        public TempleEventBuilder title(String title) { this.title = title; return this; }
        public TempleEventBuilder titleHindi(String titleHindi) { this.titleHindi = titleHindi; return this; }
        public TempleEventBuilder description(String description) { this.description = description; return this; }
        public TempleEventBuilder descriptionHindi(String descriptionHindi) { this.descriptionHindi = descriptionHindi; return this; }
        public TempleEventBuilder eventType(EventType eventType) { this.eventType = eventType; return this; }
        public TempleEventBuilder eventDate(LocalDate eventDate) { this.eventDate = eventDate; return this; }
        public TempleEventBuilder startTime(LocalTime startTime) { this.startTime = startTime; return this; }
        public TempleEventBuilder endTime(LocalTime endTime) { this.endTime = endTime; return this; }
        public TempleEventBuilder venue(String venue) { this.venue = venue; return this; }
        public TempleEventBuilder imageUrl(String imageUrl) { this.imageUrl = imageUrl; return this; }
        public TempleEventBuilder isFree(boolean isFree) { this.isFree = isFree; return this; }
        public TempleEventBuilder requiresRegistration(boolean requiresRegistration) { this.requiresRegistration = requiresRegistration; return this; }
        public TempleEventBuilder maxParticipants(Integer maxParticipants) { this.maxParticipants = maxParticipants; return this; }
        public TempleEventBuilder currentParticipants(Integer currentParticipants) { this.currentParticipants = currentParticipants; return this; }
        public TempleEventBuilder isActive(boolean isActive) { this.isActive = isActive; return this; }
        public TempleEventBuilder createdAt(LocalDateTime createdAt) { this.createdAt = createdAt; return this; }
        public TempleEventBuilder updatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; return this; }
        
        public TempleEvent build() {
            TempleEvent event = new TempleEvent();
            event.setId(id);
            event.setTemple(temple);
            event.setTitle(title);
            event.setTitleHindi(titleHindi);
            event.setDescription(description);
            event.setDescriptionHindi(descriptionHindi);
            event.setEventType(eventType);
            event.setEventDate(eventDate);
            event.setStartTime(startTime);
            event.setEndTime(endTime);
            event.setVenue(venue);
            event.setImageUrl(imageUrl);
            event.setIsFree(isFree);
            event.setRequiresRegistration(requiresRegistration);
            event.setMaxParticipants(maxParticipants);
            event.setCurrentParticipants(currentParticipants);
            event.setIsActive(isActive);
            event.setCreatedAt(createdAt);
            event.setUpdatedAt(updatedAt);
            return event;
        }
    }
    
    // Explicit getters and setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Temple getTemple() { return temple; }
    public void setTemple(Temple temple) { this.temple = temple; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getTitleHindi() { return titleHindi; }
    public void setTitleHindi(String titleHindi) { this.titleHindi = titleHindi; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getDescriptionHindi() { return descriptionHindi; }
    public void setDescriptionHindi(String descriptionHindi) { this.descriptionHindi = descriptionHindi; }
    public EventType getEventType() { return eventType; }
    public void setEventType(EventType eventType) { this.eventType = eventType; }
    public LocalDate getEventDate() { return eventDate; }
    public void setEventDate(LocalDate eventDate) { this.eventDate = eventDate; }
    public LocalTime getStartTime() { return startTime; }
    public void setStartTime(LocalTime startTime) { this.startTime = startTime; }
    public LocalTime getEndTime() { return endTime; }
    public void setEndTime(LocalTime endTime) { this.endTime = endTime; }
    public String getVenue() { return venue; }
    public void setVenue(String venue) { this.venue = venue; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    public boolean isFree() { return isFree; }
    public void setIsFree(boolean isFree) { this.isFree = isFree; }
    public boolean isRequiresRegistration() { return requiresRegistration; }
    public void setRequiresRegistration(boolean requiresRegistration) { this.requiresRegistration = requiresRegistration; }
    public Integer getMaxParticipants() { return maxParticipants; }
    public void setMaxParticipants(Integer maxParticipants) { this.maxParticipants = maxParticipants; }
    public Integer getCurrentParticipants() { return currentParticipants; }
    public void setCurrentParticipants(Integer currentParticipants) { this.currentParticipants = currentParticipants; }
    public boolean isActive() { return isActive; }
    public void setIsActive(boolean isActive) { this.isActive = isActive; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
    
    public enum EventType {
        SPIRITUAL_DISCOURSE("Spiritual Discourse"),
        BHAJAN_SANDHYA("Bhajan Sandhya"),
        CULTURAL_PROGRAM("Cultural Program"),
        MEDITATION("Meditation Session"),
        YOGA("Yoga Session"),
        ANNADAAN("Anna Daan"),
        BLOOD_DONATION("Blood Donation Camp"),
        HEALTH_CAMP("Health Camp"),
        WORKSHOP("Workshop"),
        COMPETITION("Competition"),
        OTHER("Other");
        
        private final String displayName;
        
        EventType(String displayName) {
            this.displayName = displayName;
        }
        
        public String getDisplayName() {
            return displayName;
        }
    }
}

