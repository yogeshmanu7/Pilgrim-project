package com.pilgrim.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "admins")
public class Admin {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(nullable = false)
    private String name;
    
    @Column(nullable = false, unique = true)
    private String email;
    
    @Column(nullable = false)
    private String phone;
    
    @Column(nullable = false)
    private String password;
    
    @Column(name = "profile_image")
    private String profileImage;
    
    @Column(name = "is_verified")
    private boolean isVerified = false;
    
    @Column(name = "is_active")
    private boolean isActive = true;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    @Column(name = "last_login")
    private LocalDateTime lastLogin;
    
    public Admin() {}
    
    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    
    public String getProfileImage() { return profileImage; }
    public void setProfileImage(String profileImage) { this.profileImage = profileImage; }
    
    public boolean isVerified() { return isVerified; }
    public void setVerified(boolean isVerified) { this.isVerified = isVerified; }
    
    public boolean isActive() { return isActive; }
    public void setActive(boolean isActive) { this.isActive = isActive; }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
    
    public LocalDateTime getLastLogin() { return lastLogin; }
    public void setLastLogin(LocalDateTime lastLogin) { this.lastLogin = lastLogin; }
    
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
    public static AdminBuilder builder() {
        return new AdminBuilder();
    }
    
    public static class AdminBuilder {
        private String name;
        private String email;
        private String phone;
        private String password;
        private String profileImage;
        private boolean isVerified = false;
        private boolean isActive = true;
        
        public AdminBuilder name(String name) {
            this.name = name;
            return this;
        }
        
        public AdminBuilder email(String email) {
            this.email = email;
            return this;
        }
        
        public AdminBuilder phone(String phone) {
            this.phone = phone;
            return this;
        }
        
        public AdminBuilder password(String password) {
            this.password = password;
            return this;
        }
        
        public AdminBuilder profileImage(String profileImage) {
            this.profileImage = profileImage;
            return this;
        }
        
        public AdminBuilder isVerified(boolean isVerified) {
            this.isVerified = isVerified;
            return this;
        }
        
        public AdminBuilder isActive(boolean isActive) {
            this.isActive = isActive;
            return this;
        }
        
        public Admin build() {
            Admin admin = new Admin();
            admin.setName(this.name);
            admin.setEmail(this.email);
            admin.setPhone(this.phone);
            admin.setPassword(this.password);
            admin.setProfileImage(this.profileImage);
            admin.setVerified(this.isVerified);
            admin.setActive(this.isActive);
            return admin;
        }
    }
}
