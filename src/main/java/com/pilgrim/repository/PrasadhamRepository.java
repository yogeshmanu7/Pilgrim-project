package com.pilgrim.repository;

import com.pilgrim.entity.Prasadham;
import com.pilgrim.entity.Temple;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface PrasadhamRepository extends JpaRepository<Prasadham, Long> {
    
    List<Prasadham> findByTempleAndIsAvailableTrue(Temple temple);
    
    List<Prasadham> findByTemple(Temple temple);
    
    List<Prasadham> findByTempleAndTypeAndIsAvailableTrue(Temple temple, Prasadham.PrasadhamType type);
    
    List<Prasadham> findByCanBeDeliveredTrueAndIsAvailableTrue();
}

