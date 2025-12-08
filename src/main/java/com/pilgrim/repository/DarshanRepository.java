package com.pilgrim.repository;

import com.pilgrim.entity.Darshan;
import com.pilgrim.entity.Temple;
import com.pilgrim.enums.DarshanType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface DarshanRepository extends JpaRepository<Darshan, Long> {
    
    List<Darshan> findByTempleAndIsActiveTrue(Temple temple);
    
    List<Darshan> findByTemple(Temple temple);
    
    List<Darshan> findByTempleAndDarshanType(Temple temple, DarshanType type);
    
    List<Darshan> findByDarshanTypeAndIsActiveTrue(DarshanType type);
}

