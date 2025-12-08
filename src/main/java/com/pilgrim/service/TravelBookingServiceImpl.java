package com.pilgrim.service;

import com.pilgrim.entity.User;
import com.pilgrim.entity.TravelAgency;
import com.pilgrim.entity.TravelBooking;
import com.pilgrim.entity.TravelPackage;
import com.pilgrim.enums.TravelBookingStatus;
import com.pilgrim.repository.TravelBookingRepository;
import com.pilgrim.repository.TravelPackageRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class TravelBookingServiceImpl implements TravelBookingService {

    @Autowired
    private TravelBookingRepository bookingRepo;

    @Autowired
    private TravelPackageRepository packageRepo;

    @Override
    public TravelBooking createBooking(User user, Long packageId, Long guideId, Long transportId,
                                       int quantity, double amount,
                                       LocalDate startDate, LocalDate endDate) {

        TravelPackage pack = packageRepo.findById(packageId).orElse(null);
        if (pack == null) return null;

        TravelBooking booking = new TravelBooking();
        booking.setUser(user);
        booking.setTravelPackage(pack);
        booking.setQuantity(quantity);
        booking.setAmountPaid(amount);
        booking.setTravelStartDate(startDate);
        booking.setTravelEndDate(endDate);
        booking.setStatus(TravelBookingStatus.PENDING_PAYMENT);
        booking.setBookedAt(LocalDateTime.now());

        return bookingRepo.save(booking);
    }

    @Override
    public TravelBooking saveBooking(TravelBooking booking) {
        return bookingRepo.save(booking);
    }

    @Override
    public TravelBooking getBookingById(Long id) {
        return bookingRepo.findById(id).orElse(null);
    }

    @Override
    public void cancelByUser(Long bookingId, String reason) {
        TravelBooking booking = getBookingById(bookingId);
        if (booking != null) {
            booking.setStatus(TravelBookingStatus.CANCELLED_BY_USER);
            booking.setCancelledAt(LocalDateTime.now());
            booking.setCancellationReason(reason);
            bookingRepo.save(booking);
        }
    }

    @Override
    public void cancelByAgency(Long bookingId, String reason) {
        TravelBooking booking = getBookingById(bookingId);
        if (booking != null) {
            booking.setStatus(TravelBookingStatus.CANCELLED_BY_AGENCY);
            booking.setCancelledAt(LocalDateTime.now());
            booking.setCancellationReason(reason);
            bookingRepo.save(booking);
        }
    }

    @Override
    public void initiateRefund(Long bookingId, String reason) {
        TravelBooking booking = getBookingById(bookingId);
        if (booking != null) {
            booking.setStatus(TravelBookingStatus.REFUND_INITIATED);
            booking.setRefundInitiatedAt(LocalDateTime.now());
            booking.setRefundReason(reason);
            bookingRepo.save(booking);
        }
    }

    @Override
    public void completeRefund(Long bookingId) {
        TravelBooking booking = getBookingById(bookingId);
        if (booking != null) {
            booking.setStatus(TravelBookingStatus.REFUND_COMPLETED);
            booking.setRefundedAt(LocalDateTime.now());
            bookingRepo.save(booking);
        }
    }

    @Override
    public void markCompleted(Long bookingId) {
        TravelBooking booking = getBookingById(bookingId);
        if (booking != null) {
            booking.setStatus(TravelBookingStatus.COMPLETED);
            booking.setCompletedAt(LocalDateTime.now());
            bookingRepo.save(booking);
        }
    }

    @Override
    public List<TravelBooking> getBookingsByUser(User user) {
        return bookingRepo.findByUser(user);
    }

    @Override
    public List<TravelBooking> getBookingsByUserAndStatus(User user, TravelBookingStatus status) {
        return bookingRepo.findByUserAndStatus(user, status);
    }

    @Override
    public List<TravelBooking> getBookingsByStatus(TravelBookingStatus status) {
        return bookingRepo.findByStatus(status);
    }

    @Override
    public long countActiveBookings(User user) {
        return bookingRepo.countByUserAndStatus(user, TravelBookingStatus.CONFIRMED);
    }

    @Override
    public List<TravelBooking> findByAgency(TravelAgency agency) {
        return bookingRepo.findByTravelPackage_Agency(agency);
    }

    @Override
    public void deleteBooking(Long id) {
        bookingRepo.deleteById(id);
    }
}

