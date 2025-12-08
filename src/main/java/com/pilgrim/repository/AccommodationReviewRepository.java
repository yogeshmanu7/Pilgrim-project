package com.pilgrim.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.pilgrim.entity.Property;
import com.pilgrim.entity.AccommodationReview;
import com.pilgrim.entity.AccommodationUser;

@Repository
public interface AccommodationReviewRepository extends JpaRepository<AccommodationReview, Long> {
	List<AccommodationReview> findByProperty(Property property);
	List<AccommodationReview> findByUser(AccommodationUser user);
	List<AccommodationReview> findByBookingId(Long bookingId);
}

