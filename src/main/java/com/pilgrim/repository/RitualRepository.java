package com.pilgrim.repository;

import com.pilgrim.entity.Ritual;
import com.pilgrim.entity.Temple;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface RitualRepository extends JpaRepository<Ritual, Long> {
    
    List<Ritual> findByTempleAndIsActiveTrue(Temple temple);
    
    List<Ritual> findByTemple(Temple temple);
    
    List<Ritual> findByTempleAndIsActiveTrueOrderByDisplayOrderAsc(Temple temple);
    
    List<Ritual> findByTempleAndFrequencyAndIsActiveTrue(Temple temple, Ritual.RitualFrequency frequency);
    
    List<Ritual> findByIsPublicAllowedTrueAndIsActiveTrue();
}

