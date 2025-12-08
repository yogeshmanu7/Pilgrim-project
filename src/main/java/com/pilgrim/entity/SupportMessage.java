package com.pilgrim.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "support_messages")
public class SupportMessage {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ticket_id")
    private SupportTicket ticket;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "sender_type")
    private SenderType senderType;
    
    @Column(name = "sender_id")
    private Long senderId;
    
    @Column(name = "sender_name")
    private String senderName;
    
    @Column(columnDefinition = "TEXT", nullable = false)
    private String message;
    
    @Column(name = "attachment")
    private String attachment;
    
    @Column(name = "is_read")
    private boolean isRead = false;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    public enum SenderType {
        USER, ADMIN
    }
    
    public SupportMessage() {}
    
    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public SupportTicket getTicket() { return ticket; }
    public void setTicket(SupportTicket ticket) { this.ticket = ticket; }
    
    public SenderType getSenderType() { return senderType; }
    public void setSenderType(SenderType senderType) { this.senderType = senderType; }
    
    public Long getSenderId() { return senderId; }
    public void setSenderId(Long senderId) { this.senderId = senderId; }
    
    public String getSenderName() { return senderName; }
    public void setSenderName(String senderName) { this.senderName = senderName; }
    
    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }
    
    public String getAttachment() { return attachment; }
    public void setAttachment(String attachment) { this.attachment = attachment; }
    
    public boolean isRead() { return isRead; }
    public void setRead(boolean isRead) { this.isRead = isRead; }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }
    
    // Builder pattern
    public static SupportMessageBuilder builder() {
        return new SupportMessageBuilder();
    }
    
    public static class SupportMessageBuilder {
        private SupportTicket ticket;
        private SenderType senderType;
        private Long senderId;
        private String senderName;
        private String message;
        private String attachment;
        
        public SupportMessageBuilder ticket(SupportTicket ticket) {
            this.ticket = ticket;
            return this;
        }
        
        public SupportMessageBuilder senderType(SenderType senderType) {
            this.senderType = senderType;
            return this;
        }
        
        public SupportMessageBuilder senderId(Long senderId) {
            this.senderId = senderId;
            return this;
        }
        
        public SupportMessageBuilder senderName(String senderName) {
            this.senderName = senderName;
            return this;
        }
        
        public SupportMessageBuilder message(String message) {
            this.message = message;
            return this;
        }
        
        public SupportMessageBuilder attachment(String attachment) {
            this.attachment = attachment;
            return this;
        }
        
        public SupportMessage build() {
            SupportMessage supportMessage = new SupportMessage();
            supportMessage.setTicket(this.ticket);
            supportMessage.setSenderType(this.senderType);
            supportMessage.setSenderId(this.senderId);
            supportMessage.setSenderName(this.senderName);
            supportMessage.setMessage(this.message);
            supportMessage.setAttachment(this.attachment);
            return supportMessage;
        }
    }
}
