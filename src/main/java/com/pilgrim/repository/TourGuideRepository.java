package com.pilgrim.repository;

import com.pilgrim.entity.Temple;
import com.pilgrim.entity.TourGuide;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface TourGuideRepository extends JpaRepository<TourGuide, Long> {
    
    List<TourGuide> findByTempleAndIsAvailableTrue(Temple temple);
    
    List<TourGuide> findByTemple(Temple temple);
    
    List<TourGuide> findByIsVerifiedTrueAndIsAvailableTrue();
    
    @Query("SELECT tg FROM TourGuide tg WHERE tg.isAvailable = true AND " +
           "tg.languages LIKE %:language%")
    List<TourGuide> findByLanguage(@Param("language") String language);
    
    @Query("SELECT tg FROM TourGuide tg WHERE tg.isAvailable = true ORDER BY tg.rating DESC")
    List<TourGuide> findTopRatedGuides();
}

