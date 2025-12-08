package com.pilgrim.repository;

import com.pilgrim.entity.TravelAgency;
import com.pilgrim.entity.TravelPackage;
import com.pilgrim.enums.TravelType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface TravelPackageRepository extends JpaRepository<TravelPackage, Long> {

    // Travel type
    List<TravelPackage> findByTravelType(TravelType travelType);

    // Agency-specific packages
    List<TravelPackage> findByAgency(TravelAgency agency);

    // Search filters
    List<TravelPackage> findByCityContainingIgnoreCase(String city);
    List<TravelPackage> findByStateContainingIgnoreCase(String state);
    List<TravelPackage> findByCountryContainingIgnoreCase(String country);
    List<TravelPackage> findByPackageNameContainingIgnoreCase(String packageName);

    // Price filter
    List<TravelPackage> findByPriceBetween(double min, double max);

    // Multi-image search
    @Query("SELECT p FROM TravelPackage p JOIN p.imagePaths i WHERE i LIKE %:imagePath%")
    List<TravelPackage> findByImagePath(String imagePath);

    // Active packages (agency must be approved)
    @Query("SELECT p FROM TravelPackage p WHERE p.agency.approvalStatus = 'APPROVED'")
    List<TravelPackage> findAllActive();

    // Combined filters
    List<TravelPackage> findByCityAndTravelType(String city, TravelType travelType);
    List<TravelPackage> findByPriceBetweenAndTravelType(double min, double max, TravelType travelType);

    // Agency + TravelType
    List<TravelPackage> findByAgencyAndTravelType(TravelAgency agency, TravelType travelType);
}

