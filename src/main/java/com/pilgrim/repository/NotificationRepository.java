package com.pilgrim.repository;

import com.pilgrim.entity.Notification;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface NotificationRepository extends JpaRepository<Notification, Long> {
    
    Page<Notification> findAllByOrderByCreatedAtDesc(Pageable pageable);
    
    List<Notification> findByIsSentFalseAndIsScheduledTrueAndScheduledAtBefore(LocalDateTime dateTime);
    
    Page<Notification> findByTargetAudience(Notification.TargetAudience audience, Pageable pageable);
}

