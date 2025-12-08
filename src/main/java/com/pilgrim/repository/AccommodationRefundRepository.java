package com.pilgrim.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.pilgrim.entity.AccommodationRefund;

@Repository
public interface AccommodationRefundRepository extends JpaRepository<AccommodationRefund, Long> {
	List<AccommodationRefund> findByStatus(String status);
	List<AccommodationRefund> findByStatusOrderByCreatedAtDesc(String status);
}

