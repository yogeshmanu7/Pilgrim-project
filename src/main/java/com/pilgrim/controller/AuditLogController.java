package com.pilgrim.controller;

import com.pilgrim.entity.*;
import com.pilgrim.service.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/admin/logs")
public class AuditLogController {
    
    @Autowired
    private AuditLogService auditLogService;
    
    @RequestMapping(value = "", method = RequestMethod.GET)
    public String listLogs(@RequestParam(defaultValue = "0") int page,
                           @RequestParam(defaultValue = "20") int size,
                           @RequestParam(required = false) String entity,
                           @RequestParam(required = false) String action,
                           Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("adminSession");
        if (admin == null) return "redirect:/admin/login";
        
        Pageable pageable = PageRequest.of(page, size);
        Page<AuditLog> logs;
        
        if (entity != null && !entity.isEmpty()) {
            logs = auditLogService.getLogsByEntityType(entity, pageable);
            model.addAttribute("selectedEntity", entity);
        } else if (action != null && !action.isEmpty()) {
            logs = auditLogService.getLogsByAction(AuditLog.ActionType.valueOf(action), pageable);
            model.addAttribute("selectedAction", action);
        } else {
            logs = auditLogService.getAllLogs(pageable);
        }
        
        model.addAttribute("logs", logs);
        model.addAttribute("actions", AuditLog.ActionType.values());
        model.addAttribute("admin", admin);
        return "admin/logs/list";
    }
}
