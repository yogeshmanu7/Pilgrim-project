package com.pilgrim.repository;

import com.pilgrim.entity.TravelAgencyDocuments;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TravelAgencyDocumentsRepository extends JpaRepository<TravelAgencyDocuments, Long> {
    TravelAgencyDocuments findByAgencyId(Long agencyId);
}

