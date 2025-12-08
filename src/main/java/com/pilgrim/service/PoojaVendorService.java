package com.pilgrim.service;

import com.pilgrim.entity.Vendor;
import com.pilgrim.repository.VendorRepository;
import com.pilgrim.util.PasswordUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class PoojaVendorService {

    @Autowired
    private VendorRepository vendorRepository;

    @Autowired
    private EmailService emailService;

    public Vendor registerVendor(Vendor vendor) {
        if (vendorRepository.existsByEmail(vendor.getEmail())) {
            throw new RuntimeException("Email already exists");
        }
        vendor.setPassword(PasswordUtil.encode(vendor.getPassword()));
        vendor.setStatus(Vendor.VendorStatus.PENDING);
        Vendor savedVendor = vendorRepository.save(vendor);
        
        emailService.sendEmail("admin@pilgrim.com", "New Vendor Registered", 
            "A new vendor '" + savedVendor.getBusinessName() + "' has registered and is pending approval.");
        
        return savedVendor;
    }

    public Optional<Vendor> login(String email, String password) {
        Optional<Vendor> vendorOpt = vendorRepository.findByEmail(email);
        if (vendorOpt.isPresent()) {
            Vendor vendor = vendorOpt.get();
            if (PasswordUtil.matches(password, vendor.getPassword())) {
                if (vendor.getStatus() == Vendor.VendorStatus.APPROVED) {
                    return Optional.of(vendor);
                }
            }
        }
        return Optional.empty();
    }

    public List<Vendor> getPendingVendors() {
        return vendorRepository.findByStatus(Vendor.VendorStatus.PENDING);
    }

    public List<Vendor> getAllVendors() {
        return vendorRepository.findAll();
    }

    public Optional<Vendor> getVendorById(Long id) {
        return vendorRepository.findById(id);
    }

    public Vendor approveVendor(Long id) {
        Vendor vendor = vendorRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Vendor not found"));
        vendor.setStatus(Vendor.VendorStatus.APPROVED);
        Vendor updated = vendorRepository.save(vendor);
        emailService.sendEmail(updated.getEmail(), "Vendor Account Approved", 
            "Dear " + updated.getOwnerName() + ",\n\nYour vendor account has been approved. You can now log in to your dashboard.\n\nThank you!");
        return updated;
    }

    public Vendor rejectVendor(Long id) {
        Vendor vendor = vendorRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Vendor not found"));
        vendor.setStatus(Vendor.VendorStatus.REJECTED);
        Vendor updated = vendorRepository.save(vendor);
        emailService.sendEmail(updated.getEmail(), "Vendor Account Rejected", 
            "Dear " + updated.getOwnerName() + ",\n\nUnfortunately, your vendor account registration has been rejected. Please contact support for more information.\n\nThank you!");
        return updated;
    }

    public Vendor updateVendor(Long id, Vendor vendorDetails) {
        Vendor vendor = vendorRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Vendor not found"));
        vendor.setOwnerName(vendorDetails.getOwnerName());
        vendor.setPhone(vendorDetails.getPhone());
        vendor.setBusinessName(vendorDetails.getBusinessName());
        vendor.setBusinessType(vendorDetails.getBusinessType());
        vendor.setAddress(vendorDetails.getAddress());
        return vendorRepository.save(vendor);
    }

    public Vendor changePassword(Long id, String oldPassword, String newPassword) {
        Vendor vendor = vendorRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Vendor not found"));
        if (!PasswordUtil.matches(oldPassword, vendor.getPassword())) {
            throw new RuntimeException("Old password is incorrect");
        }
        vendor.setPassword(PasswordUtil.encode(newPassword));
        return vendorRepository.save(vendor);
    }
}

