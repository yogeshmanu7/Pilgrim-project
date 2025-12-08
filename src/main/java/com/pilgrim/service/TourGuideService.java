package com.pilgrim.service;

import com.pilgrim.entity.*;
import com.pilgrim.enums.BookingStatus;
import com.pilgrim.enums.PaymentStatus;
import com.pilgrim.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
public class TourGuideService {
    
    private final TourGuideRepository tourGuideRepository;
    private final TourBookingRepository bookingRepository;
    
    // Explicit constructor to ensure dependencies are injected
    public TourGuideService(TourGuideRepository tourGuideRepository, TourBookingRepository bookingRepository) {
        this.tourGuideRepository = tourGuideRepository;
        this.bookingRepository = bookingRepository;
    }
    
    // Tour Guide CRUD
    public TourGuide createTourGuide(TourGuide guide) {
        return tourGuideRepository.save(guide);
    }
    
    public Optional<TourGuide> findById(Long id) {
        return tourGuideRepository.findById(id);
    }
    
    public List<TourGuide> findAll() {
        return tourGuideRepository.findAll();
    }
    
    public List<TourGuide> findByTemple(Temple temple) {
        return tourGuideRepository.findByTempleAndIsAvailableTrue(temple);
    }
    
    public List<TourGuide> findVerifiedGuides() {
        return tourGuideRepository.findByIsVerifiedTrueAndIsAvailableTrue();
    }
    
    public List<TourGuide> findByLanguage(String language) {
        return tourGuideRepository.findByLanguage(language);
    }
    
    public List<TourGuide> findTopRatedGuides() {
        return tourGuideRepository.findTopRatedGuides();
    }
    
    public TourGuide updateTourGuide(TourGuide guide) {
        return tourGuideRepository.save(guide);
    }
    
    public void deleteTourGuide(Long id) {
        tourGuideRepository.deleteById(id);
    }
    
    // Booking Management
    public TourBooking createBooking(TourBooking booking) {
        TourGuide guide = booking.getTourGuide();
        
        // Calculate total based on tour type
        BigDecimal rate;
        switch (booking.getTourType()) {
            case FULL_DAY:
                rate = guide.getFullDayRate();
                break;
            case HALF_DAY:
                rate = guide.getHourlyRate().multiply(BigDecimal.valueOf(4));
                break;
            case HOURLY:
            default:
                if (booking.getStartTime() != null && booking.getEndTime() != null) {
                    long hours = ChronoUnit.HOURS.between(booking.getStartTime(), booking.getEndTime());
                    rate = guide.getHourlyRate().multiply(BigDecimal.valueOf(Math.max(1, hours)));
                } else {
                    rate = guide.getHourlyRate();
                }
        }
        booking.setTotalAmount(rate);
        
        return bookingRepository.save(booking);
    }
    
    public Optional<TourBooking> findBookingById(Long id) {
        return bookingRepository.findById(id);
    }
    
    public Optional<TourBooking> findBookingByNumber(String bookingNumber) {
        return bookingRepository.findByBookingNumber(bookingNumber);
    }
    
    public List<TourBooking> findBookingsByUser(User user) {
        return bookingRepository.findByUserOrderByCreatedAtDesc(user);
    }
    
    public List<TourBooking> findBookingsByGuide(TourGuide guide) {
        return bookingRepository.findByTourGuide(guide);
    }
    
    public List<TourBooking> findBookingsByTemple(Long templeId) {
        return bookingRepository.findByTempleId(templeId);
    }
    
    public boolean isGuideAvailable(TourGuide guide, LocalDate date) {
        Integer bookings = bookingRepository.countBookingsForDate(guide, date);
        return bookings == 0;
    }
    
    public TourBooking updateBookingStatus(Long bookingId, BookingStatus status) {
        TourBooking booking = bookingRepository.findById(bookingId)
                .orElseThrow(() -> new RuntimeException("Booking not found"));
        booking.setStatus(status);
        return bookingRepository.save(booking);
    }
    
    public TourBooking updatePaymentStatus(Long bookingId, PaymentStatus status, String transactionId) {
        TourBooking booking = bookingRepository.findById(bookingId)
                .orElseThrow(() -> new RuntimeException("Booking not found"));
        booking.setPaymentStatus(status);
        booking.setPaymentTransactionId(transactionId);
        if (status == PaymentStatus.PAID || status == PaymentStatus.SUCCESS) {
            booking.setStatus(BookingStatus.CONFIRMED);
        }
        return bookingRepository.save(booking);
    }
    
    public void cancelBooking(Long bookingId) {
        TourBooking booking = bookingRepository.findById(bookingId)
                .orElseThrow(() -> new RuntimeException("Booking not found"));
        booking.setStatus(BookingStatus.CANCELLED);
        bookingRepository.save(booking);
    }
    
    public void updateGuideRating(Long guideId, Double newRating) {
        TourGuide guide = tourGuideRepository.findById(guideId)
                .orElseThrow(() -> new RuntimeException("Tour guide not found"));
        
        Double currentRating = guide.getRating() != null ? guide.getRating() : 0.0;
        Integer totalTours = guide.getTotalTours() != null ? guide.getTotalTours() : 0;
        
        // Calculate new average rating
        Double updatedRating = ((currentRating * totalTours) + newRating) / (totalTours + 1);
        guide.setRating(updatedRating);
        guide.setTotalTours(totalTours + 1);
        
        tourGuideRepository.save(guide);
    }
}

