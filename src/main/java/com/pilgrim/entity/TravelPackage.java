package com.pilgrim.entity;

import com.pilgrim.enums.TravelType;
import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "travel_package")
public class TravelPackage {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String packageName;

    @Column(columnDefinition = "TEXT")
    private String description;

    private String country;
    private String state;
    private String city;

    private double price;
    private int durationDays;

    @ElementCollection
    @CollectionTable(name = "travel_package_images", joinColumns = @JoinColumn(name = "package_id"))
    @Column(name = "image_path", length = 500)
    private List<String> imagePaths = new ArrayList<>();

    @Enumerated(EnumType.STRING)
    @Column(length = 50)
    private TravelType travelType;

    @ManyToOne
    @JoinColumn(name = "agency_id")
    private TravelAgency agency;

    public TravelPackage() {}

    // Getters & Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getPackageName() { return packageName; }
    public void setPackageName(String packageName) { this.packageName = packageName; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getCountry() { return country; }
    public void setCountry(String country) { this.country = country; }

    public String getState() { return state; }
    public void setState(String state) { this.state = state; }

    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getDurationDays() { return durationDays; }
    public void setDurationDays(int durationDays) { this.durationDays = durationDays; }

    public List<String> getImagePaths() { return imagePaths; }
    public void setImagePaths(List<String> imagePaths) { this.imagePaths = imagePaths; }

    public TravelType getTravelType() { return travelType; }
    public void setTravelType(TravelType travelType) { this.travelType = travelType; }

    public TravelAgency getAgency() { return agency; }
    public void setAgency(TravelAgency agency) { this.agency = agency; }
}

