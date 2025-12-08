package com.pilgrim.service;

import com.pilgrim.entity.TravelAgency;
import com.pilgrim.entity.TravelPackage;
import com.pilgrim.enums.TravelType;
import com.pilgrim.repository.TravelPackageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class TravelPackageServiceImpl implements TravelPackageService {

    @Autowired
    private TravelPackageRepository repo;

    @Override
    public TravelPackage savePackage(TravelPackage travelPackage) {
        return repo.save(travelPackage);
    }

    @Override
    public TravelPackage getPackageById(Long id) {
        return repo.findById(id).orElse(null);
    }

    @Override
    public void deletePackage(Long id) {
        repo.deleteById(id);
    }

    @Override
    public List<TravelPackage> getPackagesByAgency(TravelAgency agency) {
        return repo.findByAgency(agency);
    }

    @Override
    public List<TravelPackage> getAllActivePackages() {
        return repo.findAllActive();
    }

    @Override
    public List<TravelPackage> getPackagesByTravelType(TravelType type) {
        return repo.findByTravelType(type);
    }

    @Override
    public List<TravelPackage> searchPackages(String keyword) {
        List<TravelPackage> result = new ArrayList<>();
        result.addAll(repo.findByCityContainingIgnoreCase(keyword));
        repo.findByStateContainingIgnoreCase(keyword).stream().filter(p -> !result.contains(p)).forEach(result::add);
        repo.findByCountryContainingIgnoreCase(keyword).stream().filter(p -> !result.contains(p)).forEach(result::add);
        repo.findByPackageNameContainingIgnoreCase(keyword).stream().filter(p -> !result.contains(p)).forEach(result::add);
        return result;
    }

    @Override
    public List<TravelPackage> searchByCity(String city) {
        return repo.findByCityContainingIgnoreCase(city);
    }

    @Override
    public List<TravelPackage> searchByState(String state) {
        return repo.findByStateContainingIgnoreCase(state);
    }

    @Override
    public List<TravelPackage> searchByPackageName(String name) {
        return repo.findByPackageNameContainingIgnoreCase(name);
    }

    @Override
    public List<TravelPackage> searchByCountry(String country) {
        return repo.findByCountryContainingIgnoreCase(country);
    }

    @Override
    public List<TravelPackage> filterByPrice(double min, double max) {
        return repo.findByPriceBetween(min, max);
    }

    @Override
    public List<TravelPackage> searchByImagePath(String imagePath) {
        return repo.findByImagePath(imagePath);
    }

    @Override
    public List<TravelPackage> searchByCityAndType(String city, TravelType type) {
        return repo.findByCityAndTravelType(city, type);
    }

    @Override
    public List<TravelPackage> filterByPriceAndType(double min, double max, TravelType type) {
        return repo.findByPriceBetweenAndTravelType(min, max, type);
    }

    @Override
    public List<TravelPackage> getPackagesByAgencyAndType(TravelAgency agency, TravelType type) {
        return repo.findByAgencyAndTravelType(agency, type);
    }

    @Override
    public List<TravelPackage> getAllPackages() {
        return repo.findAll();
    }
}

