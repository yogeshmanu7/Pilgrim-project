package com.pilgrim.service;

import com.pilgrim.entity.SupportTicket;
import com.pilgrim.entity.SupportMessage;
import com.pilgrim.entity.Admin;
import com.pilgrim.repository.SupportTicketRepository;
import com.pilgrim.repository.SupportMessageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

@Service
public class SupportService {
    
    @Autowired
    private SupportTicketRepository ticketRepository;
    
    @Autowired
    private SupportMessageRepository messageRepository;
    
    @Autowired
    private AuditLogService auditLogService;
    
    public Page<SupportTicket> getAllTickets(Pageable pageable) {
        return ticketRepository.findAll(pageable);
    }
    
    public Page<SupportTicket> getTicketsByStatus(SupportTicket.TicketStatus status, Pageable pageable) {
        return ticketRepository.findByStatus(status, pageable);
    }
    
    public Page<SupportTicket> getTicketsByAdmin(Long adminId, Pageable pageable) {
        return ticketRepository.findByAssignedAdminId(adminId, pageable);
    }
    
    public Optional<SupportTicket> getTicketById(Long id) {
        return ticketRepository.findById(id);
    }
    
    public List<SupportMessage> getTicketMessages(Long ticketId) {
        return messageRepository.findByTicketIdOrderByCreatedAtAsc(ticketId);
    }
    
    @Transactional
    public SupportMessage replyToTicket(Long ticketId, String message, Admin admin) {
        SupportTicket ticket = ticketRepository.findById(ticketId)
                .orElseThrow(() -> new RuntimeException("Ticket not found"));
        
        SupportMessage supportMessage = SupportMessage.builder()
                .ticket(ticket)
                .message(message)
                .senderType(SupportMessage.SenderType.ADMIN)
                .senderId(admin.getId())
                .senderName(admin.getName())
                .build();
        
        supportMessage = messageRepository.save(supportMessage);
        
        if (ticket.getStatus() == SupportTicket.TicketStatus.OPEN) {
            ticket.setStatus(SupportTicket.TicketStatus.IN_PROGRESS);
        } else if (ticket.getStatus() == SupportTicket.TicketStatus.WAITING_FOR_USER) {
            ticket.setStatus(SupportTicket.TicketStatus.IN_PROGRESS);
        }
        
        if (ticket.getAssignedAdminId() == null) {
            ticket.setAssignedAdminId(admin.getId());
        }
        
        ticketRepository.save(ticket);
        
        return supportMessage;
    }
    
    @Transactional
    public SupportTicket updateTicketStatus(Long id, SupportTicket.TicketStatus status, Admin admin) {
        SupportTicket ticket = ticketRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Ticket not found"));
        
        String oldStatus = ticket.getStatus().toString();
        ticket.setStatus(status);
        
        if (status == SupportTicket.TicketStatus.RESOLVED) {
            ticket.setResolvedAt(LocalDateTime.now());
        }
        
        ticket = ticketRepository.save(ticket);
        
        auditLogService.logAction(admin.getId(), admin.getName(), admin.getEmail(),
                "UPDATE", "SupportTicket", ticket.getId(), ticket.getTicketNumber(),
                "Ticket status updated", oldStatus, status.toString(), null, null);
        
        return ticket;
    }
    
    @Transactional
    public SupportTicket assignTicket(Long id, Long adminId, Admin admin) {
        SupportTicket ticket = ticketRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Ticket not found"));
        
        ticket.setAssignedAdminId(adminId);
        ticket = ticketRepository.save(ticket);
        
        auditLogService.logAction(admin.getId(), admin.getName(), admin.getEmail(),
                "UPDATE", "SupportTicket", ticket.getId(), ticket.getTicketNumber(),
                "Ticket assigned", null, null, null, null);
        
        return ticket;
    }
    
    public long countUnresolvedTickets() {
        return ticketRepository.countByStatusIn(
            Arrays.asList(SupportTicket.TicketStatus.OPEN, SupportTicket.TicketStatus.IN_PROGRESS)
        );
    }
    
    public long countByStatus(SupportTicket.TicketStatus status) {
        return ticketRepository.countByStatus(status);
    }
}

