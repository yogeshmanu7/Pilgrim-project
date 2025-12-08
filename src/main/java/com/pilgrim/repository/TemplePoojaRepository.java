package com.pilgrim.repository;

import com.pilgrim.entity.Temple;
import com.pilgrim.entity.TemplePooja;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface TemplePoojaRepository extends JpaRepository<TemplePooja, Long> {
    
    List<TemplePooja> findByTempleAndIsActiveTrue(Temple temple);
    
    List<TemplePooja> findByTemple(Temple temple);
    
    List<TemplePooja> findByTempleAndCategoryAndIsActiveTrue(Temple temple, TemplePooja.PoojaCategory category);
    
    List<TemplePooja> findByCategoryAndIsActiveTrue(TemplePooja.PoojaCategory category);
    
    @Query("SELECT p FROM TemplePooja p WHERE p.isActive = true AND " +
           "(LOWER(p.name) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(p.nameHindi) LIKE LOWER(CONCAT('%', :keyword, '%')))")
    List<TemplePooja> searchPoojas(@Param("keyword") String keyword);
}

