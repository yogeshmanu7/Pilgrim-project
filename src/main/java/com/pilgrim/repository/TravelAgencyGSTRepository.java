package com.pilgrim.repository;

import com.pilgrim.entity.TravelAgencyGST;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TravelAgencyGSTRepository extends JpaRepository<TravelAgencyGST, Long> {
    TravelAgencyGST findByAgencyId(Long agencyId);
}

