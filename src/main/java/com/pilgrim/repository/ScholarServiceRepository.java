package com.pilgrim.repository;

import com.pilgrim.entity.Scholar;
import com.pilgrim.entity.ScholarService;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ScholarServiceRepository extends JpaRepository<ScholarService, Long> {
    
    List<ScholarService> findByScholar(Scholar scholar);
    
    List<ScholarService> findByScholarAndIsActiveTrue(Scholar scholar);
    
    Optional<ScholarService> findByIdAndScholar(Long id, Scholar scholar);
    
    List<ScholarService> findByIsActiveTrue();
}

