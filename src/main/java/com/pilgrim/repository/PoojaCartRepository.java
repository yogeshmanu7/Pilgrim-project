package com.pilgrim.repository;

import com.pilgrim.entity.PoojaCart;
import com.pilgrim.entity.PoojaCustomer;
import com.pilgrim.entity.PoojaItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface PoojaCartRepository extends JpaRepository<PoojaCart, Long> {
    List<PoojaCart> findByCustomer(PoojaCustomer customer);
    List<PoojaCart> findByCustomerAndStatus(PoojaCustomer customer, PoojaCart.CartStatus status);
    Optional<PoojaCart> findByCustomerAndItemAndStatus(PoojaCustomer customer, PoojaItem item, PoojaCart.CartStatus status);
    @Query("SELECT c FROM PoojaCart c WHERE c.status = 'ACTIVE' AND c.expiresAt < :now")
    List<PoojaCart> findExpiredCarts(LocalDateTime now);
}

