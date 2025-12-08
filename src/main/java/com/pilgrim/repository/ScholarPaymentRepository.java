package com.pilgrim.repository;

import com.pilgrim.entity.Scholar;
import com.pilgrim.entity.ScholarBooking;
import com.pilgrim.entity.ScholarPayment;
import com.pilgrim.enums.ScholarPaymentStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.List;

@Repository
public interface ScholarPaymentRepository extends JpaRepository<ScholarPayment, Long> {
    ScholarPayment findByBooking(ScholarBooking booking);
    
    @Query("SELECT p FROM ScholarPayment p WHERE p.booking.scholar = :scholar")
    List<ScholarPayment> findByScholar(@Param("scholar") Scholar scholar);
    
    @Query("SELECT p FROM ScholarPayment p WHERE p.status = :status AND p.booking.scholar IS NOT NULL")
    List<ScholarPayment> findPendingSettlements(@Param("status") ScholarPaymentStatus status);
    
    @Query("SELECT COALESCE(SUM(p.scholarAmount), 0) FROM ScholarPayment p WHERE p.booking.scholar = :scholar AND p.status = 'SETTLED'")
    BigDecimal getTotalEarnings(@Param("scholar") Scholar scholar);
    
    @Query("SELECT COALESCE(SUM(p.scholarAmount), 0) FROM ScholarPayment p WHERE p.booking.scholar = :scholar AND p.status = 'PAID'")
    BigDecimal getPendingEarnings(@Param("scholar") Scholar scholar);
}

