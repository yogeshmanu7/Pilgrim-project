package com.pilgrim.service;

import com.pilgrim.entity.Scholar;
import com.pilgrim.entity.ScholarBooking;
import com.pilgrim.entity.ScholarPayment;
import com.pilgrim.entity.User;
import com.pilgrim.enums.ScholarBookingStatus;
import com.pilgrim.enums.ScholarPaymentStatus;
import com.pilgrim.enums.ScholarServiceType;
import com.pilgrim.repository.ScholarBookingRepository;
import com.pilgrim.repository.ScholarPaymentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@Transactional
public class ScholarBookingService {
    
    @Autowired
    private ScholarBookingRepository bookingRepository;
    
    @Autowired
    private ScholarPaymentRepository paymentRepository;
    
    public ScholarBooking createBooking(User customer, Scholar scholar, ScholarServiceType serviceType,
            LocalDateTime serviceDate, String serviceLocation, String serviceDescription,
            BigDecimal totalAmount) {
        ScholarBooking booking = new ScholarBooking();
        booking.setCustomer(customer);
        booking.setScholar(scholar);
        booking.setServiceType(serviceType);
        booking.setServiceDate(serviceDate);
        booking.setServiceLocation(serviceLocation);
        booking.setServiceDescription(serviceDescription);
        booking.setTotalAmount(totalAmount);
        booking.setBookingDate(LocalDateTime.now());
        
        // Generate video call link for video call services
        if (serviceType == ScholarServiceType.VIDEO_CALL) {
            String videoCallLink = "https://meet.pilgrim.com/" + UUID.randomUUID().toString();
            booking.setVideoCallLink(videoCallLink);
        }
        
        ScholarBooking savedBooking = bookingRepository.save(booking);
        
        // Create payment record
        ScholarPayment payment = new ScholarPayment();
        payment.setBooking(savedBooking);
        payment.setAmount(totalAmount);
        BigDecimal commission = totalAmount.multiply(new BigDecimal("0.10")); // 10% commission
        payment.setPlatformCommission(commission);
        payment.setScholarAmount(totalAmount.subtract(commission));
        payment.setStatus(ScholarPaymentStatus.PENDING);
        paymentRepository.save(payment);
        
        return savedBooking;
    }
    
    public ScholarBooking updateStatus(Long bookingId, ScholarBookingStatus status) {
        ScholarBooking booking = bookingRepository.findById(bookingId)
            .orElseThrow(() -> new RuntimeException("Booking not found"));
        booking.setStatus(status);
        booking.setUpdatedAt(LocalDateTime.now());
        return bookingRepository.save(booking);
    }
    
    public List<ScholarBooking> findByCustomer(User customer) {
        return bookingRepository.findByCustomer(customer);
    }
    
    public List<ScholarBooking> findByScholar(Scholar scholar) {
        return bookingRepository.findByScholar(scholar);
    }
    
    public List<ScholarBooking> findByStatus(ScholarBookingStatus status) {
        return bookingRepository.findByStatus(status);
    }
    
    public Optional<ScholarBooking> findById(Long id) {
        return bookingRepository.findById(id);
    }
    
    public ScholarBooking save(ScholarBooking booking) {
        return bookingRepository.save(booking);
    }
    
    public List<ScholarBooking> findAll() {
        return bookingRepository.findAll();
    }
    
    public long count() {
        return bookingRepository.count();
    }
    
    public ScholarBooking cancelBooking(Long bookingId, String reason) {
        ScholarBooking booking = bookingRepository.findById(bookingId)
            .orElseThrow(() -> new RuntimeException("Booking not found"));
        booking.setStatus(ScholarBookingStatus.CANCELLED);
        booking.setUpdatedAt(LocalDateTime.now());
        
        // Refund payment if exists
        ScholarPayment payment = paymentRepository.findByBooking(booking);
        if (payment != null && payment.getStatus() == ScholarPaymentStatus.PAID) {
            payment.setStatus(ScholarPaymentStatus.REFUNDED);
            payment.setSettlementDate(LocalDateTime.now());
            paymentRepository.save(payment);
        }
        
        return bookingRepository.save(booking);
    }
    
    public ScholarBooking rescheduleBooking(Long bookingId, LocalDateTime newServiceDate) {
        ScholarBooking booking = bookingRepository.findById(bookingId)
            .orElseThrow(() -> new RuntimeException("Booking not found"));
        booking.setServiceDate(newServiceDate);
        booking.setStatus(ScholarBookingStatus.RESCHEDULED);
        booking.setUpdatedAt(LocalDateTime.now());
        return bookingRepository.save(booking);
    }
}

