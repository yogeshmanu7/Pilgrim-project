package com.pilgrim.repository;

import com.pilgrim.entity.PoojaCustomer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface PoojaCustomerRepository extends JpaRepository<PoojaCustomer, Long> {
    Optional<PoojaCustomer> findByEmail(String email);
    boolean existsByEmail(String email);
}

