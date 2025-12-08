package com.pilgrim.entity;

import com.pilgrim.enums.PhotoCategory;
import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "temple_photos")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TemplePhoto {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne
    @JoinColumn(name = "temple_id", nullable = false)
    private Temple temple;
    
    @Column(nullable = false)
    private String photoUrl;
    
    private String title;
    
    private String description;
    
    @Enumerated(EnumType.STRING)
    private PhotoCategory category; // Using global PhotoCategory enum
    
    private Integer displayOrder;
    
    @Builder.Default
    private boolean isActive = true;
    
    @Column(updatable = false)
    private LocalDateTime createdAt;
    
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }
    
    // Explicit constructors
    public TemplePhoto() {
    }
    
    // Static builder method
    public static TemplePhotoBuilder builder() {
        return new TemplePhotoBuilder();
    }
    
    // Builder class
    public static class TemplePhotoBuilder {
        private Long id;
        private Temple temple;
        private String photoUrl;
        private String title;
        private String description;
        private PhotoCategory category;
        private Integer displayOrder;
        private boolean isActive = true;
        private LocalDateTime createdAt;
        
        public TemplePhotoBuilder id(Long id) { this.id = id; return this; }
        public TemplePhotoBuilder temple(Temple temple) { this.temple = temple; return this; }
        public TemplePhotoBuilder photoUrl(String photoUrl) { this.photoUrl = photoUrl; return this; }
        public TemplePhotoBuilder title(String title) { this.title = title; return this; }
        public TemplePhotoBuilder description(String description) { this.description = description; return this; }
        public TemplePhotoBuilder category(PhotoCategory category) { this.category = category; return this; }
        public TemplePhotoBuilder displayOrder(Integer displayOrder) { this.displayOrder = displayOrder; return this; }
        public TemplePhotoBuilder isActive(boolean isActive) { this.isActive = isActive; return this; }
        public TemplePhotoBuilder createdAt(LocalDateTime createdAt) { this.createdAt = createdAt; return this; }
        
        public TemplePhoto build() {
            TemplePhoto photo = new TemplePhoto();
            photo.setId(id);
            photo.setTemple(temple);
            photo.setPhotoUrl(photoUrl);
            photo.setTitle(title);
            photo.setDescription(description);
            photo.setCategory(category);
            photo.setDisplayOrder(displayOrder);
            photo.setIsActive(isActive);
            photo.setCreatedAt(createdAt);
            return photo;
        }
    }
    
    // Explicit getters and setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Temple getTemple() { return temple; }
    public void setTemple(Temple temple) { this.temple = temple; }
    public String getPhotoUrl() { return photoUrl; }
    public void setPhotoUrl(String photoUrl) { this.photoUrl = photoUrl; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public PhotoCategory getCategory() { return category; }
    public void setCategory(PhotoCategory category) { this.category = category; }
    public Integer getDisplayOrder() { return displayOrder; }
    public void setDisplayOrder(Integer displayOrder) { this.displayOrder = displayOrder; }
    public boolean isActive() { return isActive; }
    public void setIsActive(boolean isActive) { this.isActive = isActive; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}

