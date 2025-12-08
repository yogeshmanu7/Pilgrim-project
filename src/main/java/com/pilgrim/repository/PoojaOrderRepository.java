package com.pilgrim.repository;

import com.pilgrim.entity.PoojaOrder;
import com.pilgrim.entity.PoojaCustomer;
import com.pilgrim.entity.Vendor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface PoojaOrderRepository extends JpaRepository<PoojaOrder, Long> {
    List<PoojaOrder> findByCustomer(PoojaCustomer customer);
    List<PoojaOrder> findByVendor(Vendor vendor);
    Optional<PoojaOrder> findByOrderNumber(String orderNumber);
    List<PoojaOrder> findByStatus(PoojaOrder.OrderStatus status);
}

