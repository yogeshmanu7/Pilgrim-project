package com.pilgrim.service;

import com.pilgrim.entity.Guide;
import com.pilgrim.entity.TravelAgency;
import com.pilgrim.enums.GuideLanguage;

import java.util.List;

public interface GuideService {
    Guide saveGuide(Guide guide);
    Guide getGuideById(Long id);
    void deleteGuide(Long id);

    List<Guide> getGuidesByAgency(TravelAgency agency);
    List<Guide> getGuidesByLanguage(GuideLanguage language);
    List<Guide> searchByName(String name);

    List<Guide> searchByCity(String city);
    List<Guide> searchByTemple(String temple);
    List<Guide> searchByDescription(String description);

    List<Guide> getAllAvailableGuides();
}

