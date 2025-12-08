package com.pilgrim.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.pilgrim.entity.AccommodationBooking;
import com.pilgrim.entity.AccommodationPayment;
import com.pilgrim.enums.PaymentStatus;

@Repository
public interface AccommodationPaymentRepository extends JpaRepository<AccommodationPayment, Long> {
	Optional<AccommodationPayment> findByBooking(AccommodationBooking booking);
	List<AccommodationPayment> findByStatus(PaymentStatus status);
}

