package com.pilgrim.service;

import com.pilgrim.entity.Scholar;
import com.pilgrim.entity.ScholarBooking;
import com.pilgrim.entity.ScholarPayment;
import com.pilgrim.entity.User;
import com.pilgrim.enums.ScholarBookingStatus;
import com.pilgrim.enums.ScholarPaymentStatus;
import com.pilgrim.repository.ScholarPaymentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Service
@Transactional
public class ScholarPaymentService {
    
    @Autowired
    private ScholarPaymentRepository paymentRepository;
    
    @Autowired
    private ScholarBookingService bookingService;
    
    public ScholarPayment createPayment(ScholarBooking booking, BigDecimal amount) {
        ScholarPayment payment = new ScholarPayment();
        payment.setBooking(booking);
        payment.setAmount(amount);
        BigDecimal commission = amount.multiply(new BigDecimal("0.10")); // 10% commission
        payment.setPlatformCommission(commission);
        payment.setScholarAmount(amount.subtract(commission));
        payment.setStatus(ScholarPaymentStatus.PENDING);
        payment.setCreatedAt(LocalDateTime.now());
        return paymentRepository.save(payment);
    }
    
    public ScholarPayment processPayment(Long paymentId, String transactionId) {
        ScholarPayment payment = paymentRepository.findById(paymentId)
            .orElseThrow(() -> new RuntimeException("Payment not found"));
        payment.setStatus(ScholarPaymentStatus.PAID);
        payment.setPaymentDate(LocalDateTime.now());
        payment.setTransactionId(transactionId);
        
        // Update booking status to CONFIRMED after payment
        ScholarBooking booking = payment.getBooking();
        if (booking != null) {
            booking.setStatus(ScholarBookingStatus.CONFIRMED);
            bookingService.save(booking);
        }
        
        return paymentRepository.save(payment);
    }
    
    public ScholarPayment settlePayment(Long paymentId) {
        ScholarPayment payment = paymentRepository.findById(paymentId)
            .orElseThrow(() -> new RuntimeException("Payment not found"));
        payment.setStatus(ScholarPaymentStatus.SETTLED);
        payment.setSettlementDate(LocalDateTime.now());
        return paymentRepository.save(payment);
    }
    
    public ScholarPayment refundPayment(Long paymentId, String reason) {
        ScholarPayment payment = paymentRepository.findById(paymentId)
            .orElseThrow(() -> new RuntimeException("Payment not found"));
        payment.setStatus(ScholarPaymentStatus.REFUNDED);
        payment.setSettlementDate(LocalDateTime.now());
        return paymentRepository.save(payment);
    }
    
    public List<ScholarPayment> findByScholar(Scholar scholar) {
        return paymentRepository.findByScholar(scholar);
    }
    
    public List<ScholarPayment> findPendingSettlements() {
        return paymentRepository.findPendingSettlements(ScholarPaymentStatus.PAID);
    }
    
    public ScholarPayment findByBooking(ScholarBooking booking) {
        return paymentRepository.findByBooking(booking);
    }
    
    public ScholarPayment findById(Long id) {
        return paymentRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Payment not found"));
    }
    
    public BigDecimal getTotalEarnings(Scholar scholar) {
        return paymentRepository.getTotalEarnings(scholar);
    }
    
    public BigDecimal getPendingEarnings(Scholar scholar) {
        return paymentRepository.getPendingEarnings(scholar);
    }
    
    public List<ScholarPayment> findAll() {
        return paymentRepository.findAll();
    }
}

