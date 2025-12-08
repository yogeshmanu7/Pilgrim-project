package com.pilgrim.entity;

import com.pilgrim.enums.GuideLanguage;
import jakarta.persistence.*;

@Entity
@Table(name = "guide")
public class Guide {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    @Enumerated(EnumType.STRING)
    @Column(length = 50)
    private GuideLanguage language;

    private double price;
    private String city;
    private String temple;

    @Column(length = 1000)
    private String shortDescription;

    private String imagePath;

    private boolean available = true;

    @ManyToOne
    @JoinColumn(name = "agency_id")
    private TravelAgency agency;

    public Guide() {}

    // Getters & Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public GuideLanguage getLanguage() { return language; }
    public void setLanguage(GuideLanguage language) { this.language = language; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }

    public String getTemple() { return temple; }
    public void setTemple(String temple) { this.temple = temple; }

    public String getShortDescription() { return shortDescription; }
    public void setShortDescription(String shortDescription) { this.shortDescription = shortDescription; }

    public String getImagePath() { return imagePath; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }

    public boolean isAvailable() { return available; }
    public void setAvailable(boolean available) { this.available = available; }

    public TravelAgency getAgency() { return agency; }
    public void setAgency(TravelAgency agency) { this.agency = agency; }
}

