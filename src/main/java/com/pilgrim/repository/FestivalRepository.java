package com.pilgrim.repository;

import com.pilgrim.entity.Festival;
import com.pilgrim.entity.Temple;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.time.LocalDate;
import java.util.List;

@Repository
public interface FestivalRepository extends JpaRepository<Festival, Long> {
    
    List<Festival> findByTempleAndIsActiveTrue(Temple temple);
    
    List<Festival> findByTemple(Temple temple);
    
    @Query("SELECT f FROM Festival f WHERE f.isActive = true AND f.startDate >= :today ORDER BY f.startDate ASC")
    List<Festival> findUpcomingFestivals(@Param("today") LocalDate today);
    
    @Query("SELECT f FROM Festival f WHERE f.temple = :temple AND f.isActive = true AND f.startDate >= :today ORDER BY f.startDate ASC")
    List<Festival> findUpcomingFestivalsByTemple(@Param("temple") Temple temple, @Param("today") LocalDate today);
    
    @Query("SELECT f FROM Festival f WHERE f.isActive = true AND " +
           "(LOWER(f.name) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(f.nameHindi) LIKE LOWER(CONCAT('%', :keyword, '%')))")
    List<Festival> searchFestivals(@Param("keyword") String keyword);
}

