package com.pilgrim.service;

import com.pilgrim.entity.TravelAgency;
import com.pilgrim.entity.TravelPackage;
import com.pilgrim.enums.TravelType;

import java.util.List;

public interface TravelPackageService {
    TravelPackage savePackage(TravelPackage travelPackage);
    TravelPackage getPackageById(Long id);
    void deletePackage(Long id);

    List<TravelPackage> getPackagesByAgency(TravelAgency agency);

    List<TravelPackage> getAllActivePackages();
    List<TravelPackage> getPackagesByTravelType(TravelType type);

    List<TravelPackage> searchPackages(String keyword);
    List<TravelPackage> searchByCity(String city);
    List<TravelPackage> searchByState(String state);
    List<TravelPackage> searchByPackageName(String name);
    List<TravelPackage> searchByCountry(String country);

    List<TravelPackage> filterByPrice(double min, double max);

    List<TravelPackage> searchByImagePath(String imagePath);
    List<TravelPackage> searchByCityAndType(String city, TravelType type);
    List<TravelPackage> filterByPriceAndType(double min, double max, TravelType type);
    List<TravelPackage> getPackagesByAgencyAndType(TravelAgency agency, TravelType type);

    List<TravelPackage> getAllPackages();
}

