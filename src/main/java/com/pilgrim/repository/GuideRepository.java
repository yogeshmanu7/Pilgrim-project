package com.pilgrim.repository;

import com.pilgrim.entity.Guide;
import com.pilgrim.entity.TravelAgency;
import com.pilgrim.enums.GuideLanguage;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface GuideRepository extends JpaRepository<Guide, Long> {

    // Find guides by language
    List<Guide> findByLanguage(GuideLanguage language);

    // Find all guides for a specific agency
    List<Guide> findByAgency(TravelAgency agency);

    // Search by guide name (case-insensitive)
    List<Guide> findByNameContainingIgnoreCase(String name);

    // Find guides by city
    List<Guide> findByCityContainingIgnoreCase(String city);

    // Find guides by temple
    List<Guide> findByTempleContainingIgnoreCase(String temple);

    // Search by short description
    List<Guide> findByShortDescriptionContainingIgnoreCase(String description);

    // Combined search: by agency and language
    List<Guide> findByAgencyAndLanguage(TravelAgency agency, GuideLanguage language);

    // Find guides by availability
    List<Guide> findByAvailable(boolean available);

    // Find guides by agency and availability
    List<Guide> findByAgencyAndAvailable(TravelAgency agency, boolean available);

    // Convenience method for dashboard
    List<Guide> findByAvailableTrue();
}

