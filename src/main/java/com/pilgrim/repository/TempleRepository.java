package com.pilgrim.repository;

import com.pilgrim.entity.Temple;
import com.pilgrim.entity.User;
import com.pilgrim.enums.Religion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface TempleRepository extends JpaRepository<Temple, Long> {
    
    List<Temple> findByIsActiveTrue();
    
    List<Temple> findByAdmin(User admin);
    
    List<Temple> findByReligion(Religion religion);
    
    List<Temple> findByAdminAndReligion(User admin, Religion religion);
    
    List<Temple> findByAdminAndReligionAndIsActiveTrue(User admin, Religion religion);
    
    List<Temple> findByAdminAndIsActiveTrue(User admin);
    
    List<Temple> findByReligionAndIsActiveTrue(Religion religion);
    
    List<Temple> findByCity(String city);
    
    List<Temple> findByState(String state);
    
    @Query("SELECT t FROM Temple t WHERE t.isActive = true AND " +
           "(LOWER(t.name) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(t.nameHindi) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(t.city) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(t.mainDeity) LIKE LOWER(CONCAT('%', :keyword, '%')))")
    List<Temple> searchTemples(@Param("keyword") String keyword);
    
    @Query("SELECT DISTINCT t.city FROM Temple t WHERE t.isActive = true ORDER BY t.city")
    List<String> findAllCities();
    
    @Query("SELECT DISTINCT t.state FROM Temple t WHERE t.isActive = true ORDER BY t.state")
    List<String> findAllStates();
}

