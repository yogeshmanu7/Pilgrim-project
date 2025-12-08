package com.pilgrim.repository;

import com.pilgrim.entity.Vendor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface VendorRepository extends JpaRepository<Vendor, Long> {
    
    Optional<Vendor> findByEmail(String email);
    
    boolean existsByEmail(String email);
    
    Page<Vendor> findByStatus(Vendor.VendorStatus status, Pageable pageable);
    
    List<Vendor> findByStatus(Vendor.VendorStatus status);
    
    Page<Vendor> findByIsActiveTrue(Pageable pageable);
    
    long countByStatus(Vendor.VendorStatus status);
    
    long countByIsActiveTrue();
}

