package com.pilgrim.service;

import com.pilgrim.entity.*;
import com.pilgrim.enums.PhotoCategory;
import com.pilgrim.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Transactional
public class TempleService {
    
    private final TempleRepository templeRepository;
    private final TemplePhotoRepository photoRepository;
    private final RitualRepository ritualRepository;
    private final FestivalRepository festivalRepository;
    private final TempleEventRepository eventRepository;
    
    @Value("${file.upload.directory:C:/pilgrim-uploads/}")
    private String uploadDirectory;
    
    // Explicit constructor to ensure dependencies are injected
    public TempleService(TempleRepository templeRepository, TemplePhotoRepository photoRepository,
                        RitualRepository ritualRepository, FestivalRepository festivalRepository,
                        TempleEventRepository eventRepository) {
        this.templeRepository = templeRepository;
        this.photoRepository = photoRepository;
        this.ritualRepository = ritualRepository;
        this.festivalRepository = festivalRepository;
        this.eventRepository = eventRepository;
    }
    
    private String getUploadsDir() {
        String templeUploadDir = uploadDirectory + "temples/";
        File uploadsDir = new File(templeUploadDir);
        if (!uploadsDir.exists()) {
            uploadsDir.mkdirs();
        }
        return uploadsDir.getAbsolutePath() + File.separator;
    }
    
    // Temple CRUD
    public Temple createTemple(Temple temple) {
        return templeRepository.save(temple);
    }
    
    public Optional<Temple> findById(Long id) {
        return templeRepository.findById(id);
    }
    
    public List<Temple> findAll() {
        return templeRepository.findAll();
    }
    
    public List<Temple> findActiveTemples() {
        return templeRepository.findByIsActiveTrue();
    }
    
    public List<Temple> findTemplesByAdmin(User admin) {
        return templeRepository.findByAdminAndIsActiveTrue(admin);
    }
    
    public List<Temple> findTemplesByReligion(com.pilgrim.enums.Religion religion) {
        return templeRepository.findByReligionAndIsActiveTrue(religion);
    }
    
    public List<Temple> findTemplesByAdminAndReligion(User admin, com.pilgrim.enums.Religion religion) {
        return templeRepository.findByAdminAndReligionAndIsActiveTrue(admin, religion);
    }
    
    public List<Temple> findTemplesByAdminAndReligionAll(User admin, com.pilgrim.enums.Religion religion) {
        return templeRepository.findByAdminAndReligion(admin, religion);
    }
    
    public List<Temple> findTemplesByAdminAll(User admin) {
        return templeRepository.findByAdmin(admin);
    }
    
    public List<Temple> searchTemples(String keyword) {
        return templeRepository.searchTemples(keyword);
    }
    
    public List<Temple> findByCity(String city) {
        return templeRepository.findByCity(city);
    }
    
    public List<Temple> findByState(String state) {
        return templeRepository.findByState(state);
    }
    
    public Temple updateTemple(Temple temple) {
        return templeRepository.save(temple);
    }
    
    public void deleteTemple(Long id) {
        templeRepository.deleteById(id);
    }
    
    public List<String> getAllCities() {
        return templeRepository.findAllCities();
    }
    
    public List<String> getAllStates() {
        return templeRepository.findAllStates();
    }
    
    // Photo Management
    public TemplePhoto addPhoto(Temple temple, MultipartFile file, String title, 
                                 String description, PhotoCategory category) throws IOException {
        String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
        Path uploadPath = Paths.get(getUploadsDir() + temple.getId());
        
        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }
        
        Path filePath = uploadPath.resolve(fileName);
        Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
        
        TemplePhoto photo = TemplePhoto.builder()
                .temple(temple)
                .photoUrl("/uploads/temples/" + temple.getId() + "/" + fileName)
                .title(title)
                .description(description)
                .category(category)
                .build();
        
        return photoRepository.save(photo);
    }
    
    public List<TemplePhoto> getTemplePhotos(Temple temple) {
        return photoRepository.findByTempleAndIsActiveTrue(temple);
    }
    
    public List<TemplePhoto> getPhotosByCategory(Temple temple, PhotoCategory category) {
        return photoRepository.findByTempleAndCategoryAndIsActiveTrue(temple, category);
    }
    
    public void deletePhoto(Long photoId) {
        photoRepository.deleteById(photoId);
    }
    
    // Ritual Management
    public Ritual addRitual(Ritual ritual) {
        return ritualRepository.save(ritual);
    }
    
    public List<Ritual> getTempleRituals(Temple temple) {
        return ritualRepository.findByTempleAndIsActiveTrueOrderByDisplayOrderAsc(temple);
    }
    
    public Optional<Ritual> findRitualById(Long id) {
        return ritualRepository.findById(id);
    }
    
    public void deleteRitual(Long id) {
        ritualRepository.deleteById(id);
    }
    
    // Festival Management
    public Festival addFestival(Festival festival) {
        return festivalRepository.save(festival);
    }
    
    public List<Festival> getTempleFestivals(Temple temple) {
        return festivalRepository.findByTempleAndIsActiveTrue(temple);
    }
    
    public Optional<Festival> findFestivalById(Long id) {
        return festivalRepository.findById(id);
    }
    
    public List<Festival> getUpcomingFestivals(Temple temple) {
        return festivalRepository.findUpcomingFestivalsByTemple(temple, LocalDate.now());
    }
    
    public List<Festival> getAllUpcomingFestivals() {
        return festivalRepository.findUpcomingFestivals(LocalDate.now());
    }
    
    public void deleteFestival(Long id) {
        festivalRepository.deleteById(id);
    }
    
    // Event Management
    public TempleEvent addEvent(TempleEvent event) {
        return eventRepository.save(event);
    }
    
    public List<TempleEvent> getTempleEvents(Temple temple) {
        return eventRepository.findByTempleAndIsActiveTrue(temple);
    }
    
    public List<TempleEvent> getUpcomingEvents(Temple temple) {
        return eventRepository.findUpcomingEventsByTemple(temple, LocalDate.now());
    }
    
    public List<TempleEvent> getAllUpcomingEvents() {
        return eventRepository.findUpcomingEvents(LocalDate.now());
    }
    
    public void deleteEvent(Long id) {
        eventRepository.deleteById(id);
    }
}

