package com.pilgrim.repository;

import com.pilgrim.entity.Scholar;
import com.pilgrim.entity.ScholarBooking;
import com.pilgrim.entity.ScholarReview;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.List;

@Repository
public interface ScholarReviewRepository extends JpaRepository<ScholarReview, Long> {
    List<ScholarReview> findByScholar(Scholar scholar);
    ScholarReview findByBooking(ScholarBooking booking);
    
    @Query("SELECT COALESCE(AVG(r.rating), 0) FROM ScholarReview r WHERE r.scholar = :scholar")
    BigDecimal getAverageRating(@Param("scholar") Scholar scholar);
    
    @Query("SELECT COUNT(r) FROM ScholarReview r WHERE r.scholar = :scholar")
    Long countByScholar(@Param("scholar") Scholar scholar);
}

