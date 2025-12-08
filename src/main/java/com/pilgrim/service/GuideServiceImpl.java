package com.pilgrim.service;

import com.pilgrim.entity.Guide;
import com.pilgrim.entity.TravelAgency;
import com.pilgrim.enums.GuideLanguage;
import com.pilgrim.repository.GuideRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GuideServiceImpl implements GuideService {

    @Autowired
    private GuideRepository repo;

    @Override
    public Guide saveGuide(Guide guide) {
        return repo.save(guide);
    }

    @Override
    public Guide getGuideById(Long id) {
        return repo.findById(id).orElse(null);
    }

    @Override
    public void deleteGuide(Long id) {
        repo.deleteById(id);
    }

    @Override
    public List<Guide> getGuidesByAgency(TravelAgency agency) {
        return repo.findByAgency(agency);
    }

    @Override
    public List<Guide> getGuidesByLanguage(GuideLanguage language) {
        return repo.findByLanguage(language);
    }

    @Override
    public List<Guide> searchByName(String name) {
        return repo.findByNameContainingIgnoreCase(name);
    }

    @Override
    public List<Guide> searchByCity(String city) {
        return repo.findByCityContainingIgnoreCase(city);
    }

    @Override
    public List<Guide> searchByTemple(String temple) {
        return repo.findByTempleContainingIgnoreCase(temple);
    }

    @Override
    public List<Guide> searchByDescription(String description) {
        return repo.findByShortDescriptionContainingIgnoreCase(description);
    }

    @Override
    public List<Guide> getAllAvailableGuides() {
        return repo.findByAvailableTrue();
    }
}

