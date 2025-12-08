package com.pilgrim.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.pilgrim.entity.TravelAgency;
import com.pilgrim.enums.ApprovalStatus;

public interface TravelAgencyRepository extends JpaRepository<TravelAgency, Long> {

    // ---------------- LOGIN / DUPLICATE CHECKS ----------------
    TravelAgency findByEmail(String email);
    TravelAgency findByMobile(String mobile);
    TravelAgency findByEmailOrMobile(String email, String mobile);

    // ---------------- APPROVAL STATUS FILTERS ----------------
    List<TravelAgency> findByApprovalStatus(ApprovalStatus status);
    long countByApprovalStatus(ApprovalStatus status);

    // ---------------- ACTIVE STATUS FILTERS ----------------
    List<TravelAgency> findByActiveTrue();
    List<TravelAgency> findByActiveFalse();

    // ---------------- COMBINED FILTERS ----------------
    List<TravelAgency> findByApprovalStatusAndActive(ApprovalStatus status, boolean active);
}

