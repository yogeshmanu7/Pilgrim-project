package com.pilgrim.service;

import com.pilgrim.entity.Notification;
import com.pilgrim.entity.Admin;
import com.pilgrim.repository.NotificationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class NotificationService {
    
    @Autowired
    private NotificationRepository notificationRepository;
    
    @Autowired
    private AuditLogService auditLogService;
    
    public Page<Notification> getAllNotifications(Pageable pageable) {
        return notificationRepository.findAllByOrderByCreatedAtDesc(pageable);
    }
    
    public Optional<Notification> getNotificationById(Long id) {
        return notificationRepository.findById(id);
    }
    
    @Transactional
    public Notification createNotification(Notification notification, Admin admin) {
        notification.setCreatedBy(admin.getId());
        
        if (!notification.isScheduled()) {
            notification.setSent(true);
            notification.setSentAt(LocalDateTime.now());
        }
        
        notification = notificationRepository.save(notification);
        
        auditLogService.logAction(admin.getId(), admin.getName(), admin.getEmail(),
                "CREATE", "Notification", notification.getId(), notification.getTitle(),
                "Notification created", null, null, null, null);
        
        return notification;
    }
    
    @Transactional
    public Notification sendNotification(Long id, Admin admin) {
        Notification notification = notificationRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Notification not found"));
        
        notification.setSent(true);
        notification.setSentAt(LocalDateTime.now());
        notification = notificationRepository.save(notification);
        
        // TODO: Implement actual push notification sending
        
        auditLogService.logAction(admin.getId(), admin.getName(), admin.getEmail(),
                "UPDATE", "Notification", notification.getId(), notification.getTitle(),
                "Notification sent", null, null, null, null);
        
        return notification;
    }
    
    public List<Notification> getScheduledNotificationsToSend() {
        return notificationRepository.findByIsSentFalseAndIsScheduledTrueAndScheduledAtBefore(LocalDateTime.now());
    }
    
    @Transactional
    public void deleteNotification(Long id, Admin admin) {
        Notification notification = notificationRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Notification not found"));
        
        notificationRepository.delete(notification);
        
        auditLogService.logAction(admin.getId(), admin.getName(), admin.getEmail(),
                "DELETE", "Notification", id, notification.getTitle(),
                "Notification deleted", null, null, null, null);
    }
}

