package com.pilgrim.repository;

import com.pilgrim.entity.Prasadham;
import com.pilgrim.entity.PrasadhamOrder;
import com.pilgrim.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface PrasadhamOrderRepository extends JpaRepository<PrasadhamOrder, Long> {
    
    List<PrasadhamOrder> findByUser(User user);
    
    List<PrasadhamOrder> findByUserOrderByCreatedAtDesc(User user);
    
    List<PrasadhamOrder> findByPrasadham(Prasadham prasadham);
    
    Optional<PrasadhamOrder> findByOrderNumber(String orderNumber);
    
    List<PrasadhamOrder> findByStatus(PrasadhamOrder.OrderStatus status);
    
    @Query("SELECT po FROM PrasadhamOrder po WHERE po.prasadham.temple.id = :templeId ORDER BY po.createdAt DESC")
    List<PrasadhamOrder> findByTempleId(@Param("templeId") Long templeId);
}

