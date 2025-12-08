package com.pilgrim.service;

import com.pilgrim.entity.Vendor;
import com.pilgrim.entity.Admin;
import com.pilgrim.repository.VendorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Optional;

@Service
public class VendorService {
    
    @Autowired
    private VendorRepository vendorRepository;
    
    @Autowired
    private AuditLogService auditLogService;
    
    public Page<Vendor> getAllVendors(Pageable pageable) {
        return vendorRepository.findAll(pageable);
    }
    
    public Page<Vendor> getActiveVendors(Pageable pageable) {
        return vendorRepository.findByIsActiveTrue(pageable);
    }
    
    public Page<Vendor> getVendorsByStatus(Vendor.VendorStatus status, Pageable pageable) {
        return vendorRepository.findByStatus(status, pageable);
    }
    
    public Optional<Vendor> getVendorById(Long id) {
        return vendorRepository.findById(id);
    }
    
    @Transactional
    public Vendor approveVendor(Long id, Admin admin) {
        Vendor vendor = vendorRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Vendor not found"));
        
        vendor.setStatus(Vendor.VendorStatus.APPROVED);
        vendor.setActive(true);
        vendor.setApprovedAt(LocalDateTime.now());
        vendor = vendorRepository.save(vendor);
        
        auditLogService.logAction(admin.getId(), admin.getName(), admin.getEmail(),
                "APPROVE", "Vendor", vendor.getId(), vendor.getBusinessName(),
                "Vendor approved", "PENDING", "APPROVED", null, null);
        
        return vendor;
    }
    
    @Transactional
    public Vendor rejectVendor(Long id, String reason, Admin admin) {
        Vendor vendor = vendorRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Vendor not found"));
        
        vendor.setStatus(Vendor.VendorStatus.REJECTED);
        vendor.setActive(false);
        vendor.setRejectionReason(reason);
        vendor = vendorRepository.save(vendor);
        
        auditLogService.logAction(admin.getId(), admin.getName(), admin.getEmail(),
                "REJECT", "Vendor", vendor.getId(), vendor.getBusinessName(),
                "Vendor rejected: " + reason, "PENDING", "REJECTED", null, null);
        
        return vendor;
    }
    
    @Transactional
    public Vendor updateVendorCategories(Long id, String categories, Admin admin) {
        Vendor vendor = vendorRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Vendor not found"));
        
        vendor.setAssignedCategories(categories);
        vendor = vendorRepository.save(vendor);
        
        auditLogService.logAction(admin.getId(), admin.getName(), admin.getEmail(),
                "UPDATE", "Vendor", vendor.getId(), vendor.getBusinessName(),
                "Vendor categories updated", null, null, null, null);
        
        return vendor;
    }
    
    @Transactional
    public void removeVendor(Long id, Admin admin) {
        Vendor vendor = vendorRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Vendor not found"));
        
        vendor.setActive(false);
        vendor.setStatus(Vendor.VendorStatus.SUSPENDED);
        vendorRepository.save(vendor);
        
        auditLogService.logAction(admin.getId(), admin.getName(), admin.getEmail(),
                "DELETE", "Vendor", vendor.getId(), vendor.getBusinessName(),
                "Vendor removed", null, null, null, null);
    }
    
    public long countByStatus(Vendor.VendorStatus status) {
        return vendorRepository.countByStatus(status);
    }
}

