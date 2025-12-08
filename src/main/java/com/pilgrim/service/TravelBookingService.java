package com.pilgrim.service;

import com.pilgrim.entity.User;
import com.pilgrim.entity.TravelAgency;
import com.pilgrim.entity.TravelBooking;
import com.pilgrim.enums.TravelBookingStatus;

import java.time.LocalDate;
import java.util.List;

public interface TravelBookingService {

    TravelBooking createBooking(User user, Long packageId, Long guideId, Long transportId,
                                int quantity, double amount,
                                LocalDate startDate, LocalDate endDate);

    TravelBooking saveBooking(TravelBooking booking);

    TravelBooking getBookingById(Long id);

    void cancelByUser(Long bookingId, String reason);
    void cancelByAgency(Long bookingId, String reason);

    void initiateRefund(Long bookingId, String reason);
    void completeRefund(Long bookingId);

    void markCompleted(Long bookingId);

    List<TravelBooking> getBookingsByUser(User user);
    List<TravelBooking> getBookingsByUserAndStatus(User user, TravelBookingStatus status);
    List<TravelBooking> getBookingsByStatus(TravelBookingStatus status);
    long countActiveBookings(User user);

    List<TravelBooking> findByAgency(TravelAgency agency);

    void deleteBooking(Long id);
}

