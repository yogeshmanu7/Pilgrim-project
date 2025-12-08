package com.pilgrim.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "app_settings")
public class AppSettings {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "setting_key", unique = true, nullable = false)
    private String settingKey;
    
    @Column(name = "setting_value", columnDefinition = "TEXT")
    private String settingValue;
    
    @Column(name = "setting_type")
    private String settingType;
    
    @Column(name = "setting_group")
    private String settingGroup;
    
    @Column(columnDefinition = "TEXT")
    private String description;
    
    @Column(name = "is_editable")
    private boolean isEditable = true;
    
    @Column(name = "is_public")
    private boolean isPublic = false;
    
    @Column(name = "updated_by")
    private Long updatedBy;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    public AppSettings() {}
    
    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getSettingKey() { return settingKey; }
    public void setSettingKey(String settingKey) { this.settingKey = settingKey; }
    
    public String getSettingValue() { return settingValue; }
    public void setSettingValue(String settingValue) { this.settingValue = settingValue; }
    
    public String getSettingType() { return settingType; }
    public void setSettingType(String settingType) { this.settingType = settingType; }
    
    public String getSettingGroup() { return settingGroup; }
    public void setSettingGroup(String settingGroup) { this.settingGroup = settingGroup; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public boolean isEditable() { return isEditable; }
    public void setEditable(boolean isEditable) { this.isEditable = isEditable; }
    
    public boolean isPublic() { return isPublic; }
    public void setPublic(boolean isPublic) { this.isPublic = isPublic; }
    
    public Long getUpdatedBy() { return updatedBy; }
    public void setUpdatedBy(Long updatedBy) { this.updatedBy = updatedBy; }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
    
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }
    
    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
    
    // Builder pattern
    public static AppSettingsBuilder builder() {
        return new AppSettingsBuilder();
    }
    
    public static class AppSettingsBuilder {
        private String settingKey;
        private String settingValue;
        private String settingType;
        private String settingGroup;
        private String description;
        private boolean isEditable = true;
        private boolean isPublic = false;
        
        public AppSettingsBuilder settingKey(String settingKey) {
            this.settingKey = settingKey;
            return this;
        }
        
        public AppSettingsBuilder settingValue(String settingValue) {
            this.settingValue = settingValue;
            return this;
        }
        
        public AppSettingsBuilder settingType(String settingType) {
            this.settingType = settingType;
            return this;
        }
        
        public AppSettingsBuilder settingGroup(String settingGroup) {
            this.settingGroup = settingGroup;
            return this;
        }
        
        public AppSettingsBuilder description(String description) {
            this.description = description;
            return this;
        }
        
        public AppSettingsBuilder isEditable(boolean isEditable) {
            this.isEditable = isEditable;
            return this;
        }
        
        public AppSettingsBuilder isPublic(boolean isPublic) {
            this.isPublic = isPublic;
            return this;
        }
        
        public AppSettings build() {
            AppSettings settings = new AppSettings();
            settings.setSettingKey(this.settingKey);
            settings.setSettingValue(this.settingValue);
            settings.setSettingType(this.settingType);
            settings.setSettingGroup(this.settingGroup);
            settings.setDescription(this.description);
            settings.setEditable(this.isEditable);
            settings.setPublic(this.isPublic);
            return settings;
        }
    }
}
