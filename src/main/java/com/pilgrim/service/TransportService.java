package com.pilgrim.service;

import com.pilgrim.entity.Transport;
import com.pilgrim.entity.TravelAgency;
import com.pilgrim.enums.TransportType;

import java.util.List;

public interface TransportService {
    Transport saveTransport(Transport transport);
    Transport getTransportById(Long id);
    void deleteTransport(Long id);

    List<Transport> getTransportsByAgency(TravelAgency agency);
    List<Transport> getTransportsByType(TransportType type);
    List<Transport> getTransportsByAgencyAndType(TravelAgency agency, TransportType type);
    List<Transport> searchByVehicleNumber(String vehicleNumber);

    List<Transport> getTransportsByCity(String city);
    List<Transport> getTransportsByTemple(String temple);

    List<Transport> getAvailableTransportsByAgency(TravelAgency agency);
    List<Transport> getAvailableTransportsByTypeAndCity(TransportType type, String city);
    List<Transport> getAvailableTransportsByTypeAndTemple(TransportType type, String temple);

    List<Transport> getAllAvailableTransports();

    long countTransportsByType(TravelAgency agency, TransportType type);
    long countAvailableTransportsByType(TravelAgency agency, TransportType type);

    boolean bookTransport(Long id);
    boolean releaseTransport(Long id);
}

