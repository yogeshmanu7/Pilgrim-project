package com.pilgrim.repository;

import com.pilgrim.entity.TravelAgencyPersonal;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TravelAgencyPersonalRepository extends JpaRepository<TravelAgencyPersonal, Long> {
    TravelAgencyPersonal findByAgencyId(Long agencyId);
}

