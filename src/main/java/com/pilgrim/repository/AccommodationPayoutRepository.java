package com.pilgrim.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.pilgrim.entity.AccommodationPayout;
import com.pilgrim.entity.Property;
import com.pilgrim.entity.AccommodationUser;

@Repository
public interface AccommodationPayoutRepository extends JpaRepository<AccommodationPayout, Long> {
	List<AccommodationPayout> findByProperty(Property property);
	List<AccommodationPayout> findByOwner(AccommodationUser owner);
	List<AccommodationPayout> findByStatus(String status);
	List<AccommodationPayout> findByStatusOrderByCreatedAtDesc(String status);
}

