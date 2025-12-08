package com.pilgrim.repository;

import com.pilgrim.entity.SupportTicket;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface SupportTicketRepository extends JpaRepository<SupportTicket, Long> {
    
    Optional<SupportTicket> findByTicketNumber(String ticketNumber);
    
    Page<SupportTicket> findByUserId(Long userId, Pageable pageable);
    
    Page<SupportTicket> findByStatus(SupportTicket.TicketStatus status, Pageable pageable);
    
    Page<SupportTicket> findByAssignedAdminId(Long adminId, Pageable pageable);
    
    long countByStatus(SupportTicket.TicketStatus status);
    
    long countByStatusIn(java.util.List<SupportTicket.TicketStatus> statuses);
}

