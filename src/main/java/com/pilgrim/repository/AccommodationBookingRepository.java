package com.pilgrim.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.pilgrim.entity.AccommodationBooking;
import com.pilgrim.entity.Property;
import com.pilgrim.entity.AccommodationUser;

@Repository
public interface AccommodationBookingRepository extends JpaRepository<AccommodationBooking, Long> {
	List<AccommodationBooking> findByProperty(Property property);
	List<AccommodationBooking> findByUser(AccommodationUser user);
	List<AccommodationBooking> findByStatus(String status);
	Optional<AccommodationBooking> findByReferenceNumber(String referenceNumber);
}

