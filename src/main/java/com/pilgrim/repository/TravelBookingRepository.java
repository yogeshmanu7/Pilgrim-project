package com.pilgrim.repository;

import com.pilgrim.entity.User;
import com.pilgrim.entity.TravelAgency;
import com.pilgrim.entity.TravelBooking;
import com.pilgrim.enums.TravelBookingStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TravelBookingRepository extends JpaRepository<TravelBooking, Long> {

    // Find all bookings for a given user
    List<TravelBooking> findByUser(User user);

    // Find bookings for a user filtered by status
    List<TravelBooking> findByUserAndStatus(User user, TravelBookingStatus status);

    // Find bookings by status
    List<TravelBooking> findByStatus(TravelBookingStatus status);

    // Count active bookings for a user
    long countByUserAndStatus(User user, TravelBookingStatus status);

    // Find bookings by agency (through TravelPackage → TravelAgency relation)
    List<TravelBooking> findByTravelPackage_Agency(TravelAgency agency);
}

