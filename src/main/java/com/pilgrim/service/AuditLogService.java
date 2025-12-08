package com.pilgrim.service;

import com.pilgrim.entity.AuditLog;
import com.pilgrim.repository.AuditLogRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class AuditLogService {
    
    @Autowired
    private AuditLogRepository auditLogRepository;
    
    public void logAction(Long adminId, String adminName, String adminEmail,
                          String action, String entityType, Long entityId, String entityName,
                          String description, String oldValue, String newValue,
                          String ipAddress, String userAgent) {
        
        AuditLog.ActionType actionType;
        try {
            actionType = AuditLog.ActionType.valueOf(action.toUpperCase());
        } catch (IllegalArgumentException e) {
            actionType = AuditLog.ActionType.UPDATE;
        }
        
        AuditLog log = AuditLog.builder()
                .adminId(adminId)
                .adminName(adminName)
                .adminEmail(adminEmail)
                .action(actionType)
                .entityType(entityType)
                .entityId(entityId)
                .entityName(entityName)
                .description(description)
                .oldValue(oldValue)
                .newValue(newValue)
                .ipAddress(ipAddress)
                .userAgent(userAgent)
                .build();
        
        auditLogRepository.save(log);
    }
    
    public Page<AuditLog> getAllLogs(Pageable pageable) {
        return auditLogRepository.findAllByOrderByCreatedAtDesc(pageable);
    }
    
    public Page<AuditLog> getLogsByAdmin(Long adminId, Pageable pageable) {
        return auditLogRepository.findByAdminIdOrderByCreatedAtDesc(adminId, pageable);
    }
    
    public Page<AuditLog> getLogsByEntityType(String entityType, Pageable pageable) {
        return auditLogRepository.findByEntityTypeOrderByCreatedAtDesc(entityType, pageable);
    }
    
    public Page<AuditLog> getLogsByAction(AuditLog.ActionType action, Pageable pageable) {
        return auditLogRepository.findByActionOrderByCreatedAtDesc(action, pageable);
    }
    
    public List<AuditLog> getLogsByDateRange(LocalDateTime start, LocalDateTime end) {
        return auditLogRepository.findByCreatedAtBetweenOrderByCreatedAtDesc(start, end);
    }
}

