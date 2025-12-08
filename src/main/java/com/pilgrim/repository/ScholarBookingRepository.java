package com.pilgrim.repository;

import com.pilgrim.entity.Scholar;
import com.pilgrim.entity.ScholarBooking;
import com.pilgrim.entity.User;
import com.pilgrim.enums.ScholarBookingStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ScholarBookingRepository extends JpaRepository<ScholarBooking, Long> {
    List<ScholarBooking> findByCustomer(User customer);
    List<ScholarBooking> findByScholar(Scholar scholar);
    List<ScholarBooking> findByStatus(ScholarBookingStatus status);
    List<ScholarBooking> findByCustomerAndStatus(User customer, ScholarBookingStatus status);
    List<ScholarBooking> findByScholarAndStatus(Scholar scholar, ScholarBookingStatus status);
}

