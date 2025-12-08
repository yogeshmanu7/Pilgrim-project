package com.pilgrim.service;

import com.pilgrim.entity.*;
import com.pilgrim.enums.BookingStatus;
import com.pilgrim.enums.PaymentStatus;
import com.pilgrim.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
public class TemplePoojaService {
    
    private final TemplePoojaRepository poojaRepository;
    private final PoojaBookingRepository bookingRepository;
    
    // Explicit constructor to ensure dependencies are injected
    public TemplePoojaService(TemplePoojaRepository poojaRepository, PoojaBookingRepository bookingRepository) {
        this.poojaRepository = poojaRepository;
        this.bookingRepository = bookingRepository;
    }
    
    // Pooja CRUD
    public TemplePooja createPooja(TemplePooja pooja) {
        return poojaRepository.save(pooja);
    }
    
    public Optional<TemplePooja> findById(Long id) {
        return poojaRepository.findById(id);
    }
    
    public List<TemplePooja> findAll() {
        return poojaRepository.findAll();
    }
    
    public List<TemplePooja> findByTemple(Temple temple) {
        return poojaRepository.findByTempleAndIsActiveTrue(temple);
    }
    
    public List<TemplePooja> findByCategory(TemplePooja.PoojaCategory category) {
        return poojaRepository.findByCategoryAndIsActiveTrue(category);
    }
    
    public List<TemplePooja> searchPoojas(String keyword) {
        return poojaRepository.searchPoojas(keyword);
    }
    
    public TemplePooja updatePooja(TemplePooja pooja) {
        return poojaRepository.save(pooja);
    }
    
    public void deletePooja(Long id) {
        TemplePooja pooja = poojaRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Pooja not found"));
        
        // Check if there are any bookings for this pooja
        List<PoojaBooking> bookings = bookingRepository.findByPooja(pooja);
        if (!bookings.isEmpty()) {
            // Use soft delete instead - set isActive to false
            pooja.setIsActive(false);
            poojaRepository.save(pooja);
        } else {
            // No bookings exist, safe to hard delete
            poojaRepository.deleteById(id);
        }
    }
    
    public boolean hasBookings(Long id) {
        TemplePooja pooja = poojaRepository.findById(id).orElse(null);
        if (pooja == null) {
            return false;
        }
        List<PoojaBooking> bookings = bookingRepository.findByPooja(pooja);
        return !bookings.isEmpty();
    }
    
    // Booking Management
    public PoojaBooking createBooking(PoojaBooking booking) {
        booking.setAmount(booking.getPooja().getPrice());
        return bookingRepository.save(booking);
    }
    
    public Optional<PoojaBooking> findBookingById(Long id) {
        return bookingRepository.findById(id);
    }
    
    public Optional<PoojaBooking> findBookingByNumber(String bookingNumber) {
        return bookingRepository.findByBookingNumber(bookingNumber);
    }
    
    public List<PoojaBooking> findBookingsByUser(User user) {
        return bookingRepository.findByUserOrderByCreatedAtDesc(user);
    }
    
    public List<PoojaBooking> findBookingsByTemple(Long templeId) {
        return bookingRepository.findByTempleId(templeId);
    }
    
    public boolean isDateAvailable(TemplePooja pooja, LocalDate date) {
        Integer maxBookings = pooja.getMaxBookingsPerDay();
        if (maxBookings == null) return true;
        Integer currentBookings = bookingRepository.countBookingsForDate(pooja, date);
        return currentBookings < maxBookings;
    }
    
    public Integer getAvailableSlots(TemplePooja pooja, LocalDate date) {
        Integer maxBookings = pooja.getMaxBookingsPerDay();
        if (maxBookings == null) return Integer.MAX_VALUE;
        Integer currentBookings = bookingRepository.countBookingsForDate(pooja, date);
        return maxBookings - currentBookings;
    }
    
    public PoojaBooking updateBookingStatus(Long bookingId, BookingStatus status) {
        PoojaBooking booking = bookingRepository.findById(bookingId)
                .orElseThrow(() -> new RuntimeException("Booking not found"));
        booking.setStatus(status);
        return bookingRepository.save(booking);
    }
    
    public PoojaBooking updatePaymentStatus(Long bookingId, PaymentStatus status, String transactionId) {
        PoojaBooking booking = bookingRepository.findById(bookingId)
                .orElseThrow(() -> new RuntimeException("Booking not found"));
        booking.setPaymentStatus(status);
        booking.setPaymentTransactionId(transactionId);
        if (status == PaymentStatus.PAID || status == PaymentStatus.SUCCESS) {
            booking.setStatus(BookingStatus.CONFIRMED);
        }
        return bookingRepository.save(booking);
    }
    
    public void cancelBooking(Long bookingId) {
        PoojaBooking booking = bookingRepository.findById(bookingId)
                .orElseThrow(() -> new RuntimeException("Booking not found"));
        booking.setStatus(BookingStatus.CANCELLED);
        bookingRepository.save(booking);
    }
}

