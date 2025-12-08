package com.pilgrim.repository;

import com.pilgrim.entity.Transport;
import com.pilgrim.entity.TravelAgency;
import com.pilgrim.enums.TransportType;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TransportRepository extends JpaRepository<Transport, Long> {

    // Find by transport type (BUS, CAR, AUTO, BIKE, SCOOTY)
    List<Transport> findByType(TransportType type);

    // Find all transports for a specific agency
    List<Transport> findByAgency(TravelAgency agency);

    // Find transports for a specific agency and type
    List<Transport> findByAgencyAndType(TravelAgency agency, TransportType type);

    // Search by vehicle number (partial match, case-insensitive)
    List<Transport> findByVehicleNumberContainingIgnoreCase(String vehicleNumber);

    // Find by city
    List<Transport> findByCityIgnoreCase(String city);

    // Find by temple
    List<Transport> findByTempleIgnoreCase(String temple);

    // Find available transports of a type in a city
    List<Transport> findByTypeAndCityIgnoreCaseAndAvailableTrue(TransportType type, String city);

    // Find available transports of a type for a temple
    List<Transport> findByTypeAndTempleIgnoreCaseAndAvailableTrue(TransportType type, String temple);

    // Find all available transports for an agency
    List<Transport> findByAgencyAndAvailableTrue(TravelAgency agency);

    // Find all available transports (for dashboard)
    List<Transport> findByAvailableTrue();

    // Totals
    long countByAgencyAndType(TravelAgency agency, TransportType type);
    long countByAgencyAndTypeAndAvailableTrue(TravelAgency agency, TransportType type);

    // Optional: query by pricePerTrip
    List<Transport> findByPricePerTripLessThan(double maxPrice);
    List<Transport> findByPricePerTripGreaterThan(double minPrice);
}

