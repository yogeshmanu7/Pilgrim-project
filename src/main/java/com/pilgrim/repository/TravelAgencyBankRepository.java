package com.pilgrim.repository;

import com.pilgrim.entity.TravelAgencyBank;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TravelAgencyBankRepository extends JpaRepository<TravelAgencyBank, Long> {
    TravelAgencyBank findByAgencyId(Long agencyId);
}

