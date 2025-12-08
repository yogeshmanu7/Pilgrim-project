package com.pilgrim.repository;

import com.pilgrim.entity.Temple;
import com.pilgrim.entity.TempleEvent;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.time.LocalDate;
import java.util.List;

@Repository
public interface TempleEventRepository extends JpaRepository<TempleEvent, Long> {
    
    List<TempleEvent> findByTempleAndIsActiveTrue(Temple temple);
    
    List<TempleEvent> findByTemple(Temple temple);
    
    @Query("SELECT e FROM TempleEvent e WHERE e.isActive = true AND e.eventDate >= :today ORDER BY e.eventDate ASC")
    List<TempleEvent> findUpcomingEvents(@Param("today") LocalDate today);
    
    @Query("SELECT e FROM TempleEvent e WHERE e.temple = :temple AND e.isActive = true AND e.eventDate >= :today ORDER BY e.eventDate ASC")
    List<TempleEvent> findUpcomingEventsByTemple(@Param("temple") Temple temple, @Param("today") LocalDate today);
    
    List<TempleEvent> findByEventTypeAndIsActiveTrue(TempleEvent.EventType type);
}

