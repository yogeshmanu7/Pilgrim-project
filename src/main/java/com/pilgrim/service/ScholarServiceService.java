package com.pilgrim.service;

import com.pilgrim.entity.Scholar;
import com.pilgrim.entity.ScholarService;
import com.pilgrim.repository.ScholarServiceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class ScholarServiceService {
    
    @Autowired
    private ScholarServiceRepository serviceRepository;
    
    public ScholarService createService(ScholarService service) {
        return serviceRepository.save(service);
    }
    
    public ScholarService updateService(ScholarService service) {
        return serviceRepository.save(service);
    }
    
    public Optional<ScholarService> findById(Long id) {
        return serviceRepository.findById(id);
    }
    
    public List<ScholarService> findByScholar(Scholar scholar) {
        return serviceRepository.findByScholar(scholar);
    }
    
    public List<ScholarService> findActiveByScholar(Scholar scholar) {
        return serviceRepository.findByScholarAndIsActiveTrue(scholar);
    }
    
    public Optional<ScholarService> findByIdAndScholar(Long id, Scholar scholar) {
        return serviceRepository.findByIdAndScholar(id, scholar);
    }
    
    public void deleteService(Long id) {
        serviceRepository.deleteById(id);
    }
    
    public void deactivateService(Long id) {
        Optional<ScholarService> serviceOpt = serviceRepository.findById(id);
        if (serviceOpt.isPresent()) {
            ScholarService service = serviceOpt.get();
            service.setIsActive(false);
            serviceRepository.save(service);
        }
    }
    
    public void activateService(Long id) {
        Optional<ScholarService> serviceOpt = serviceRepository.findById(id);
        if (serviceOpt.isPresent()) {
            ScholarService service = serviceOpt.get();
            service.setIsActive(true);
            serviceRepository.save(service);
        }
    }
}

