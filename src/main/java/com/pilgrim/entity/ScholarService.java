package com.pilgrim.entity;

import com.pilgrim.enums.ServiceType;
import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "scholar_services")
public class ScholarService {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne
    @JoinColumn(name = "scholar_id", nullable = false)
    private Scholar scholar;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "service_type", length = 100)
    private ServiceType serviceType;
    
    @Column(nullable = false, length = 255)
    private String name;
    
    @Column(columnDefinition = "TEXT")
    private String description;
    
    @Column(name = "price_with_items", precision = 10, scale = 2, nullable = false)
    private BigDecimal priceWithItems;
    
    @Column(name = "price_without_items", precision = 10, scale = 2, nullable = false)
    private BigDecimal priceWithoutItems;
    
    @ElementCollection(fetch = FetchType.EAGER)
    @CollectionTable(name = "scholar_service_locations", joinColumns = @JoinColumn(name = "service_id"))
    @Column(name = "location")
    private List<String> locations = new ArrayList<>();
    
    @Column(name = "is_active")
    private Boolean isActive = true;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    public ScholarService() {
        this.isActive = true;
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
        this.locations = new ArrayList<>();
    }
    
    // Getters and Setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public Scholar getScholar() {
        return scholar;
    }
    
    public void setScholar(Scholar scholar) {
        this.scholar = scholar;
    }
    
    public ServiceType getServiceType() {
        return serviceType;
    }
    
    public void setServiceType(ServiceType serviceType) {
        this.serviceType = serviceType;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public BigDecimal getPriceWithItems() {
        return priceWithItems;
    }
    
    public void setPriceWithItems(BigDecimal priceWithItems) {
        this.priceWithItems = priceWithItems;
    }
    
    public BigDecimal getPriceWithoutItems() {
        return priceWithoutItems;
    }
    
    public void setPriceWithoutItems(BigDecimal priceWithoutItems) {
        this.priceWithoutItems = priceWithoutItems;
    }
    
    public List<String> getLocations() {
        if (locations == null) {
            locations = new ArrayList<>();
        }
        return locations;
    }
    
    public void setLocations(List<String> locations) {
        this.locations = locations;
    }
    
    public Boolean getIsActive() {
        return isActive;
    }
    
    public void setIsActive(Boolean isActive) {
        this.isActive = isActive;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    @PrePersist
    protected void onCreate() {
        if (createdAt == null) {
            createdAt = LocalDateTime.now();
        }
        if (updatedAt == null) {
            updatedAt = LocalDateTime.now();
        }
    }
    
    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
}

