package com.pilgrim.service;

import com.pilgrim.entity.*;
import com.pilgrim.enums.BookingStatus;
import com.pilgrim.enums.DarshanType;
import com.pilgrim.enums.PaymentStatus;
import com.pilgrim.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
public class DarshanService {
    
    private final DarshanRepository darshanRepository;
    private final DarshanBookingRepository bookingRepository;
    
    // Explicit constructor to ensure dependencies are injected
    public DarshanService(DarshanRepository darshanRepository, DarshanBookingRepository bookingRepository) {
        this.darshanRepository = darshanRepository;
        this.bookingRepository = bookingRepository;
    }
    
    // Darshan CRUD
    public Darshan createDarshan(Darshan darshan) {
        return darshanRepository.save(darshan);
    }
    
    public Optional<Darshan> findById(Long id) {
        return darshanRepository.findById(id);
    }
    
    public List<Darshan> findByTemple(Temple temple) {
        return darshanRepository.findByTempleAndIsActiveTrue(temple);
    }
    
    public List<Darshan> findByType(DarshanType type) {
        return darshanRepository.findByDarshanTypeAndIsActiveTrue(type);
    }
    
    public Darshan updateDarshan(Darshan darshan) {
        return darshanRepository.save(darshan);
    }
    
    public void deleteDarshan(Long id) {
        Darshan darshan = darshanRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Darshan not found"));
        
        // Check if there are any bookings for this darshan
        List<DarshanBooking> bookings = bookingRepository.findByDarshan(darshan);
        if (!bookings.isEmpty()) {
            // Use soft delete instead - set isActive to false
            darshan.setIsActive(false);
            darshanRepository.save(darshan);
        } else {
            // No bookings exist, safe to hard delete
            darshanRepository.deleteById(id);
        }
    }
    
    public boolean hasBookings(Long id) {
        Darshan darshan = darshanRepository.findById(id).orElse(null);
        if (darshan == null) {
            return false;
        }
        List<DarshanBooking> bookings = bookingRepository.findByDarshan(darshan);
        return !bookings.isEmpty();
    }
    
    // Booking Management
    public DarshanBooking createBooking(DarshanBooking booking) {
        Darshan darshan = booking.getDarshan();
        
        // Validate that slotTime is provided if darshan has time restrictions
        if (darshan.getStartTime() != null && darshan.getEndTime() != null) {
            if (booking.getSlotTime() == null) {
                throw new IllegalArgumentException("Slot time is required. Available time period is " + 
                    darshan.getStartTime() + " to " + darshan.getEndTime() + ".");
            }
            
            // Validate that slotTime is within the allowed period
            if (booking.getSlotTime().isBefore(darshan.getStartTime()) || 
                booking.getSlotTime().isAfter(darshan.getEndTime())) {
                throw new IllegalArgumentException("Selected time must be between " + 
                    darshan.getStartTime() + " and " + darshan.getEndTime() + ".");
            }
        }
        
        // Ensure status is set to PENDING if not already set
        if (booking.getStatus() == null) {
            booking.setStatus(BookingStatus.PENDING);
        }
        
        // Calculate total amount
        BigDecimal price = darshan.getPrice();
        if (price != null) {
            booking.setTotalAmount(price.multiply(BigDecimal.valueOf(booking.getNumberOfPersons())));
        }
        return bookingRepository.save(booking);
    }
    
    public Optional<DarshanBooking> findBookingById(Long id) {
        return bookingRepository.findById(id);
    }
    
    public Optional<DarshanBooking> findBookingByNumber(String bookingNumber) {
        return bookingRepository.findByBookingNumber(bookingNumber);
    }
    
    public List<DarshanBooking> findBookingsByUser(User user) {
        return bookingRepository.findByUserOrderByCreatedAtDesc(user);
    }
    
    public List<DarshanBooking> findBookingsByTemple(Long templeId) {
        return bookingRepository.findByTempleId(templeId);
    }
    
    public List<DarshanBooking> findBookingsByDate(Darshan darshan, LocalDate date) {
        return bookingRepository.findByDarshanAndBookingDate(darshan, date);
    }
    
    public boolean isBookingDateValid(Darshan darshan, LocalDate date) {
        // Check if booking dates are set
        if (darshan.getBookingStartDate() != null && date.isBefore(darshan.getBookingStartDate())) {
            return false; // Date is before booking start date
        }
        if (darshan.getBookingEndDate() != null && date.isAfter(darshan.getBookingEndDate())) {
            return false; // Date is after booking end date
        }
        return true; // Date is within booking availability range (or no restrictions set)
    }
    
    public boolean isSlotAvailable(Darshan darshan, LocalDate date) {
        // First check if date is within booking availability range
        if (!isBookingDateValid(darshan, date)) {
            return false;
        }
        
        Integer maxSeats = darshan.getMaxBookingsPerSlot();
        if (maxSeats == null) {
            return true; // No limit set, always available
        }
        Integer currentSeatsBooked = bookingRepository.countTotalPersonsForDate(darshan, date);
        return currentSeatsBooked < maxSeats;
    }
    
    public boolean canBookSlot(Darshan darshan, LocalDate date, Integer numberOfPersons) {
        // First check if date is within booking availability range
        if (!isBookingDateValid(darshan, date)) {
            return false;
        }
        
        Integer maxSeats = darshan.getMaxBookingsPerSlot();
        if (maxSeats == null) {
            return true; // No limit set, always available
        }
        Integer currentSeatsBooked = bookingRepository.countTotalPersonsForDate(darshan, date);
        // Check if adding this number of persons would exceed the available seats
        return (currentSeatsBooked + numberOfPersons) <= maxSeats;
    }
    
    public Integer getAvailableSlots(Darshan darshan, LocalDate date) {
        Integer maxSeats = darshan.getMaxBookingsPerSlot();
        if (maxSeats == null) {
            return Integer.MAX_VALUE;
        }
        Integer currentSeatsBooked = bookingRepository.countTotalPersonsForDate(darshan, date);
        return Math.max(0, maxSeats - currentSeatsBooked);
    }
    
    public Integer getTotalSeatsBooked(Darshan darshan, LocalDate date) {
        return bookingRepository.countTotalPersonsForDate(darshan, date);
    }
    
    public DarshanBooking updateBookingStatus(Long bookingId, BookingStatus status) {
        DarshanBooking booking = bookingRepository.findById(bookingId)
                .orElseThrow(() -> new RuntimeException("Booking not found"));
        booking.setStatus(status);
        return bookingRepository.save(booking);
    }
    
    public DarshanBooking updatePaymentStatus(Long bookingId, PaymentStatus status, String transactionId) {
        DarshanBooking booking = bookingRepository.findById(bookingId)
                .orElseThrow(() -> new RuntimeException("Booking not found"));
        booking.setPaymentStatus(status);
        booking.setPaymentTransactionId(transactionId);
        if (status == PaymentStatus.PAID || status == PaymentStatus.SUCCESS) {
            booking.setStatus(BookingStatus.CONFIRMED);
        }
        return bookingRepository.save(booking);
    }
    
    public void cancelBooking(Long bookingId) {
        DarshanBooking booking = bookingRepository.findById(bookingId)
                .orElseThrow(() -> new RuntimeException("Booking not found"));
        booking.setStatus(BookingStatus.CANCELLED);
        bookingRepository.save(booking);
    }
}

