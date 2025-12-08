package com.pilgrim.repository;

import com.pilgrim.entity.ScholarChat;
import com.pilgrim.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ScholarChatRepository extends JpaRepository<ScholarChat, Long> {
    @Query("SELECT c FROM ScholarChat c WHERE " +
           "(c.sender = :user1 AND c.receiver = :user2) OR " +
           "(c.sender = :user2 AND c.receiver = :user1) " +
           "ORDER BY c.createdAt ASC")
    List<ScholarChat> findConversation(@Param("user1") User user1, @Param("user2") User user2);
    
    @Query("SELECT c FROM ScholarChat c WHERE c.receiver = :user AND c.isRead = false")
    List<ScholarChat> findUnreadMessages(@Param("user") User user);
}

