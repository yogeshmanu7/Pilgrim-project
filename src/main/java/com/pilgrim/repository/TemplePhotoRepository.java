package com.pilgrim.repository;

import com.pilgrim.entity.Temple;
import com.pilgrim.entity.TemplePhoto;
import com.pilgrim.enums.PhotoCategory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface TemplePhotoRepository extends JpaRepository<TemplePhoto, Long> {
    
    List<TemplePhoto> findByTemple(Temple temple);
    
    List<TemplePhoto> findByTempleAndIsActiveTrue(Temple temple);
    
    List<TemplePhoto> findByTempleAndCategory(Temple temple, PhotoCategory category);
    
    List<TemplePhoto> findByTempleAndCategoryAndIsActiveTrue(Temple temple, PhotoCategory category);
}

