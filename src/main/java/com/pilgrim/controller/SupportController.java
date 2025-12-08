package com.pilgrim.controller;

import com.pilgrim.entity.*;
import com.pilgrim.service.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/admin/support")
public class SupportController {
    
    @Autowired
    private SupportService supportService;
    
    @RequestMapping(value = "", method = RequestMethod.GET)
    public String listTickets(@RequestParam(defaultValue = "0") int page,
                              @RequestParam(defaultValue = "10") int size,
                              @RequestParam(required = false) String status,
                              Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) return "redirect:/admin/login";
        
        Pageable pageable = PageRequest.of(page, size, Sort.by("createdAt").descending());
        Page<SupportTicket> tickets;
        
        if (status != null && !status.isEmpty()) {
            tickets = supportService.getTicketsByStatus(SupportTicket.TicketStatus.valueOf(status), pageable);
            model.addAttribute("selectedStatus", status);
        } else {
            tickets = supportService.getAllTickets(pageable);
        }
        
        model.addAttribute("tickets", tickets);
        model.addAttribute("statuses", SupportTicket.TicketStatus.values());
        model.addAttribute("unresolvedCount", supportService.countUnresolvedTickets());
        model.addAttribute("admin", admin);
        return "admin/support/list";
    }
    
    @RequestMapping(value = "/ticket/{id}", method = RequestMethod.GET)
    public String viewTicket(@PathVariable Long id, Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) return "redirect:/admin/login";
        
        SupportTicket ticket = supportService.getTicketById(id)
                .orElseThrow(() -> new RuntimeException("Ticket not found"));
        
        List<SupportMessage> messages = supportService.getTicketMessages(id);
        
        model.addAttribute("ticket", ticket);
        model.addAttribute("messages", messages);
        model.addAttribute("statuses", SupportTicket.TicketStatus.values());
        model.addAttribute("admin", admin);
        return "admin/support/view";
    }
    
    @RequestMapping(value = "/ticket/{id}/reply", method = RequestMethod.POST)
    public String replyToTicket(@PathVariable Long id,
                                @RequestParam String message,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        try {
            Admin admin = (Admin) session.getAttribute("adminSession");
            if (admin == null) return "redirect:/admin/login";
            
            supportService.replyToTicket(id, message, admin);
            redirectAttributes.addFlashAttribute("success", "Reply sent successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/support/ticket/" + id;
    }
    
    @RequestMapping(value = "/ticket/{id}/update-status", method = RequestMethod.POST)
    public String updateTicketStatus(@PathVariable Long id,
                                     @RequestParam String status,
                                     HttpSession session,
                                     RedirectAttributes redirectAttributes) {
        try {
            Admin admin = (Admin) session.getAttribute("adminSession");
            if (admin == null) return "redirect:/admin/login";
            
            supportService.updateTicketStatus(id, SupportTicket.TicketStatus.valueOf(status), admin);
            redirectAttributes.addFlashAttribute("success", "Ticket status updated");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/support/ticket/" + id;
    }
    
    @RequestMapping(value = "/ticket/{id}/resolve", method = RequestMethod.POST)
    public String resolveTicket(@PathVariable Long id,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        try {
            Admin admin = (Admin) session.getAttribute("adminSession");
            if (admin == null) return "redirect:/admin/login";
            
            supportService.updateTicketStatus(id, SupportTicket.TicketStatus.RESOLVED, admin);
            redirectAttributes.addFlashAttribute("success", "Ticket marked as resolved");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/support";
    }
}
