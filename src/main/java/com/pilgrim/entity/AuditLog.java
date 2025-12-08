package com.pilgrim.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "audit_logs")
public class AuditLog {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "admin_id")
    private Long adminId;
    
    @Column(name = "admin_name")
    private String adminName;
    
    @Column(name = "admin_email")
    private String adminEmail;
    
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private ActionType action;
    
    @Column(name = "entity_type")
    private String entityType;
    
    @Column(name = "entity_id")
    private Long entityId;
    
    @Column(name = "entity_name")
    private String entityName;
    
    @Column(columnDefinition = "TEXT")
    private String description;
    
    @Column(name = "old_value", columnDefinition = "TEXT")
    private String oldValue;
    
    @Column(name = "new_value", columnDefinition = "TEXT")
    private String newValue;
    
    @Column(name = "ip_address")
    private String ipAddress;
    
    @Column(name = "user_agent")
    private String userAgent;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    public enum ActionType {
        CREATE, UPDATE, DELETE, LOGIN, LOGOUT, VIEW, APPROVE, REJECT, BLOCK, UNBLOCK
    }
    
    public AuditLog() {}
    
    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public Long getAdminId() { return adminId; }
    public void setAdminId(Long adminId) { this.adminId = adminId; }
    
    public String getAdminName() { return adminName; }
    public void setAdminName(String adminName) { this.adminName = adminName; }
    
    public String getAdminEmail() { return adminEmail; }
    public void setAdminEmail(String adminEmail) { this.adminEmail = adminEmail; }
    
    public ActionType getAction() { return action; }
    public void setAction(ActionType action) { this.action = action; }
    
    public String getEntityType() { return entityType; }
    public void setEntityType(String entityType) { this.entityType = entityType; }
    
    public Long getEntityId() { return entityId; }
    public void setEntityId(Long entityId) { this.entityId = entityId; }
    
    public String getEntityName() { return entityName; }
    public void setEntityName(String entityName) { this.entityName = entityName; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public String getOldValue() { return oldValue; }
    public void setOldValue(String oldValue) { this.oldValue = oldValue; }
    
    public String getNewValue() { return newValue; }
    public void setNewValue(String newValue) { this.newValue = newValue; }
    
    public String getIpAddress() { return ipAddress; }
    public void setIpAddress(String ipAddress) { this.ipAddress = ipAddress; }
    
    public String getUserAgent() { return userAgent; }
    public void setUserAgent(String userAgent) { this.userAgent = userAgent; }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }
    
    // Builder pattern
    public static AuditLogBuilder builder() {
        return new AuditLogBuilder();
    }
    
    public static class AuditLogBuilder {
        private Long adminId;
        private String adminName;
        private String adminEmail;
        private ActionType action;
        private String entityType;
        private Long entityId;
        private String entityName;
        private String description;
        private String oldValue;
        private String newValue;
        private String ipAddress;
        private String userAgent;
        
        public AuditLogBuilder adminId(Long adminId) {
            this.adminId = adminId;
            return this;
        }
        
        public AuditLogBuilder adminName(String adminName) {
            this.adminName = adminName;
            return this;
        }
        
        public AuditLogBuilder adminEmail(String adminEmail) {
            this.adminEmail = adminEmail;
            return this;
        }
        
        public AuditLogBuilder action(ActionType action) {
            this.action = action;
            return this;
        }
        
        public AuditLogBuilder entityType(String entityType) {
            this.entityType = entityType;
            return this;
        }
        
        public AuditLogBuilder entityId(Long entityId) {
            this.entityId = entityId;
            return this;
        }
        
        public AuditLogBuilder entityName(String entityName) {
            this.entityName = entityName;
            return this;
        }
        
        public AuditLogBuilder description(String description) {
            this.description = description;
            return this;
        }
        
        public AuditLogBuilder oldValue(String oldValue) {
            this.oldValue = oldValue;
            return this;
        }
        
        public AuditLogBuilder newValue(String newValue) {
            this.newValue = newValue;
            return this;
        }
        
        public AuditLogBuilder ipAddress(String ipAddress) {
            this.ipAddress = ipAddress;
            return this;
        }
        
        public AuditLogBuilder userAgent(String userAgent) {
            this.userAgent = userAgent;
            return this;
        }
        
        public AuditLog build() {
            AuditLog log = new AuditLog();
            log.setAdminId(this.adminId);
            log.setAdminName(this.adminName);
            log.setAdminEmail(this.adminEmail);
            log.setAction(this.action);
            log.setEntityType(this.entityType);
            log.setEntityId(this.entityId);
            log.setEntityName(this.entityName);
            log.setDescription(this.description);
            log.setOldValue(this.oldValue);
            log.setNewValue(this.newValue);
            log.setIpAddress(this.ipAddress);
            log.setUserAgent(this.userAgent);
            return log;
        }
    }
}
