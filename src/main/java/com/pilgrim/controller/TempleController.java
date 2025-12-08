package com.pilgrim.controller;

import com.pilgrim.entity.*;
import com.pilgrim.enums.DarshanType;
import com.pilgrim.enums.PhotoCategory;
import com.pilgrim.service.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDate;

@Controller
@RequestMapping("/pilgrim/temple")
@RequiredArgsConstructor
public class TempleController {
    
    private final TempleService templeService;
    private final DarshanService darshanService;
    private final TemplePoojaService poojaService;
    private final PrasadhamService prasadhamService;
    private final TourGuideService tourGuideService;
    
    // Explicit constructor to ensure dependencies are injected
    public TempleController(TempleService templeService, DarshanService darshanService,
                           TemplePoojaService poojaService, PrasadhamService prasadhamService,
                           TourGuideService tourGuideService) {
        this.templeService = templeService;
        this.darshanService = darshanService;
        this.poojaService = poojaService;
        this.prasadhamService = prasadhamService;
        this.tourGuideService = tourGuideService;
    }
    
    @GetMapping
    public String listTemples(Model model) {
        model.addAttribute("temples", templeService.findActiveTemples());
        model.addAttribute("cities", templeService.getAllCities());
        return "temples/list";
    }
    
    @GetMapping("/{id}")
    public String viewTemple(@PathVariable Long id, Model model) {
        Temple temple = templeService.findById(id)
                .orElseThrow(() -> new RuntimeException("Temple not found"));
        
        model.addAttribute("temple", temple);
        model.addAttribute("photos", templeService.getTemplePhotos(temple));
        model.addAttribute("interiorPhotos", templeService.getPhotosByCategory(temple, PhotoCategory.INTERIOR));
        model.addAttribute("exteriorPhotos", templeService.getPhotosByCategory(temple, PhotoCategory.EXTERIOR));
        model.addAttribute("sculpturePhotos", templeService.getPhotosByCategory(temple, PhotoCategory.SCULPTURE));
        model.addAttribute("rituals", templeService.getTempleRituals(temple));
        model.addAttribute("upcomingFestivals", templeService.getUpcomingFestivals(temple));
        model.addAttribute("upcomingEvents", templeService.getUpcomingEvents(temple));
        model.addAttribute("darshans", darshanService.findByTemple(temple));
        model.addAttribute("poojas", poojaService.findByTemple(temple));
        model.addAttribute("prasadhams", prasadhamService.findByTemple(temple));
        model.addAttribute("tourGuides", tourGuideService.findByTemple(temple));
        
        return "temples/view";
    }
    
    @GetMapping("/{id}/darshans")
    public String templeDarshans(@PathVariable Long id, Model model) {
        Temple temple = templeService.findById(id)
                .orElseThrow(() -> new RuntimeException("Temple not found"));
        
        model.addAttribute("temple", temple);
        model.addAttribute("darshans", darshanService.findByTemple(temple));
        model.addAttribute("darshanTypes", DarshanType.values());
        return "temples/darshans";
    }
    
    @GetMapping("/{id}/poojas")
    public String templePoojas(@PathVariable Long id, Model model) {
        Temple temple = templeService.findById(id)
                .orElseThrow(() -> new RuntimeException("Temple not found"));
        
        model.addAttribute("temple", temple);
        model.addAttribute("poojas", poojaService.findByTemple(temple));
        model.addAttribute("categories", TemplePooja.PoojaCategory.values());
        return "temples/poojas";
    }
    
    @GetMapping("/{id}/prasadhams")
    public String templePrasadhams(@PathVariable Long id, Model model) {
        Temple temple = templeService.findById(id)
                .orElseThrow(() -> new RuntimeException("Temple not found"));
        
        model.addAttribute("temple", temple);
        model.addAttribute("prasadhams", prasadhamService.findByTemple(temple));
        return "temples/prasadhams";
    }
    
    @GetMapping("/{id}/tour-guides")
    public String templeTourGuides(@PathVariable Long id, Model model) {
        Temple temple = templeService.findById(id)
                .orElseThrow(() -> new RuntimeException("Temple not found"));
        
        model.addAttribute("temple", temple);
        model.addAttribute("tourGuides", tourGuideService.findByTemple(temple));
        return "temples/tour-guides";
    }
    
    @GetMapping("/{id}/festivals")
    public String templeFestivals(@PathVariable Long id, Model model) {
        Temple temple = templeService.findById(id)
                .orElseThrow(() -> new RuntimeException("Temple not found"));
        
        model.addAttribute("temple", temple);
        model.addAttribute("festivals", templeService.getTempleFestivals(temple));
        model.addAttribute("upcomingFestivals", templeService.getUpcomingFestivals(temple));
        return "temples/festivals";
    }
    
    @GetMapping("/{id}/events")
    public String templeEvents(@PathVariable Long id, Model model) {
        Temple temple = templeService.findById(id)
                .orElseThrow(() -> new RuntimeException("Temple not found"));
        
        model.addAttribute("temple", temple);
        model.addAttribute("events", templeService.getTempleEvents(temple));
        model.addAttribute("upcomingEvents", templeService.getUpcomingEvents(temple));
        return "temples/events";
    }
    
    @GetMapping("/{id}/gallery")
    public String templeGallery(@PathVariable Long id, 
                                @RequestParam(required = false) String category,
                                Model model) {
        Temple temple = templeService.findById(id)
                .orElseThrow(() -> new RuntimeException("Temple not found"));
        
        model.addAttribute("temple", temple);
        
        if (category != null && !category.isEmpty()) {
            PhotoCategory cat = PhotoCategory.valueOf(category.toUpperCase());
            model.addAttribute("photos", templeService.getPhotosByCategory(temple, cat));
            model.addAttribute("selectedCategory", category);
        } else {
            model.addAttribute("photos", templeService.getTemplePhotos(temple));
        }
        
        model.addAttribute("categories", PhotoCategory.values());
        return "temples/gallery";
    }
    
    @GetMapping("/{id}/map")
    public String templeMap(@PathVariable Long id, Model model) {
        Temple temple = templeService.findById(id)
                .orElseThrow(() -> new RuntimeException("Temple not found"));
        
        model.addAttribute("temple", temple);
        return "temples/map";
    }
}

