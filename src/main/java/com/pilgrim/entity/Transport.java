package com.pilgrim.entity;

import com.pilgrim.enums.TransportType;
import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "transport")
public class Transport {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 50)
    private TransportType type;

    private String city;
    private String temple;

    @Column(unique = true, nullable = false)
    private String vehicleNumber;
    private int capacity;

    private int totalBuses;
    private int totalCars;
    private int totalAutos;
    private int totalBikes;
    private int totalScooties;

    private double pricePerHour;
    private double pricePerDay;
    private double priceTempleSight;
    private double pricePerTrip;

    @ElementCollection
    @CollectionTable(name = "transport_vehicle_images", joinColumns = @JoinColumn(name = "transport_id"))
    @Column(name = "image_path", length = 500)
    private List<String> vehicleImagePaths = new ArrayList<>();

    private String driverName;
    private String driverMobile;
    private String driverImagePath;

    private boolean available = true;

    @ManyToOne
    @JoinColumn(name = "agency_id", nullable = false)
    private TravelAgency agency;

    public Transport() {}

    // Getters & Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public TransportType getType() { return type; }
    public void setType(TransportType type) { this.type = type; }

    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }

    public String getTemple() { return temple; }
    public void setTemple(String temple) { this.temple = temple; }

    public String getVehicleNumber() { return vehicleNumber; }
    public void setVehicleNumber(String vehicleNumber) { this.vehicleNumber = vehicleNumber; }

    public int getCapacity() { return capacity; }
    public void setCapacity(int capacity) { this.capacity = capacity; }

    public int getTotalBuses() { return totalBuses; }
    public void setTotalBuses(int totalBuses) { this.totalBuses = totalBuses; }

    public int getTotalCars() { return totalCars; }
    public void setTotalCars(int totalCars) { this.totalCars = totalCars; }

    public int getTotalAutos() { return totalAutos; }
    public void setTotalAutos(int totalAutos) { this.totalAutos = totalAutos; }

    public int getTotalBikes() { return totalBikes; }
    public void setTotalBikes(int totalBikes) { this.totalBikes = totalBikes; }

    public int getTotalScooties() { return totalScooties; }
    public void setTotalScooties(int totalScooties) { this.totalScooties = totalScooties; }

    public double getPricePerHour() { return pricePerHour; }
    public void setPricePerHour(double pricePerHour) { this.pricePerHour = pricePerHour; }

    public double getPricePerDay() { return pricePerDay; }
    public void setPricePerDay(double pricePerDay) { this.pricePerDay = pricePerDay; }

    public double getPriceTempleSight() { return priceTempleSight; }
    public void setPriceTempleSight(double priceTempleSight) { this.priceTempleSight = priceTempleSight; }

    public double getPricePerTrip() { return pricePerTrip; }
    public void setPricePerTrip(double pricePerTrip) { this.pricePerTrip = pricePerTrip; }

    public List<String> getVehicleImagePaths() { return vehicleImagePaths; }
    public void setVehicleImagePaths(List<String> vehicleImagePaths) { this.vehicleImagePaths = vehicleImagePaths; }

    public String getDriverName() { return driverName; }
    public void setDriverName(String driverName) { this.driverName = driverName; }

    public String getDriverMobile() { return driverMobile; }
    public void setDriverMobile(String driverMobile) { this.driverMobile = driverMobile; }

    public String getDriverImagePath() { return driverImagePath; }
    public void setDriverImagePath(String driverImagePath) { this.driverImagePath = driverImagePath; }

    public boolean isAvailable() { return available; }
    public void setAvailable(boolean available) { this.available = available; }

    public TravelAgency getAgency() { return agency; }
    public void setAgency(TravelAgency agency) { this.agency = agency; }
}

