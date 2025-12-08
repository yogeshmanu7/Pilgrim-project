package com.pilgrim.service;

import com.pilgrim.entity.*;
import com.pilgrim.enums.PaymentStatus;
import com.pilgrim.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
public class TempleDonationService {
    
    private final TempleDonationRepository donationRepository;
    
    // Explicit constructor to ensure dependencies are injected
    public TempleDonationService(TempleDonationRepository donationRepository) {
        this.donationRepository = donationRepository;
    }
    
    public TempleDonation createDonation(TempleDonation donation) {
        return donationRepository.save(donation);
    }
    
    public Optional<TempleDonation> findById(Long id) {
        return donationRepository.findById(id);
    }
    
    public Optional<TempleDonation> findByDonationNumber(String donationNumber) {
        return donationRepository.findByDonationNumber(donationNumber);
    }
    
    public List<TempleDonation> findAll() {
        return donationRepository.findAll();
    }
    
    public List<TempleDonation> findByUser(User user) {
        return donationRepository.findByUserOrderByCreatedAtDesc(user);
    }
    
    public List<TempleDonation> findByTemple(Temple temple) {
        return donationRepository.findByTempleOrderByCreatedAtDesc(temple);
    }
    
    public List<TempleDonation> findByType(TempleDonation.DonationType type) {
        return donationRepository.findByDonationType(type);
    }
    
    public List<TempleDonation> findCompletedDonationsByTemple(Long templeId) {
        return donationRepository.findCompletedDonationsByTempleId(templeId);
    }
    
    public BigDecimal getTotalDonationsForTemple(Temple temple) {
        BigDecimal total = donationRepository.getTotalDonationsForTemple(temple);
        return total != null ? total : BigDecimal.ZERO;
    }
    
    public TempleDonation updatePaymentStatus(Long donationId, PaymentStatus status, String transactionId) {
        TempleDonation donation = donationRepository.findById(donationId)
                .orElseThrow(() -> new RuntimeException("Donation not found"));
        donation.setPaymentStatus(status);
        donation.setPaymentTransactionId(transactionId);
        
        // Generate receipt number on successful payment
        if (status == PaymentStatus.SUCCESS || status == PaymentStatus.PAID) {
            donation.setReceiptNumber("RCP" + System.currentTimeMillis());
        }
        
        return donationRepository.save(donation);
    }
    
    public TempleDonation updateDonation(TempleDonation donation) {
        return donationRepository.save(donation);
    }
    
    public void deleteDonation(Long id) {
        donationRepository.deleteById(id);
    }
}

