package com.pilgrim.service;

import com.pilgrim.entity.Transport;
import com.pilgrim.entity.TravelAgency;
import com.pilgrim.enums.TransportType;
import com.pilgrim.repository.TransportRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class TransportServiceImpl implements TransportService {

    private final TransportRepository transportRepository;

    public TransportServiceImpl(TransportRepository transportRepository) {
        this.transportRepository = transportRepository;
    }

    @Override
    public Transport saveTransport(Transport transport) {
        return transportRepository.save(transport);
    }

    @Override
    public Transport getTransportById(Long id) {
        Optional<Transport> transport = transportRepository.findById(id);
        return transport.orElse(null);
    }

    @Override
    public void deleteTransport(Long id) {
        transportRepository.deleteById(id);
    }

    @Override
    public List<Transport> getTransportsByAgency(TravelAgency agency) {
        return transportRepository.findByAgency(agency);
    }

    @Override
    public List<Transport> getTransportsByType(TransportType type) {
        return transportRepository.findByType(type);
    }

    @Override
    public List<Transport> getTransportsByAgencyAndType(TravelAgency agency, TransportType type) {
        return transportRepository.findByAgencyAndType(agency, type);
    }

    @Override
    public List<Transport> searchByVehicleNumber(String vehicleNumber) {
        return transportRepository.findByVehicleNumberContainingIgnoreCase(vehicleNumber);
    }

    @Override
    public List<Transport> getTransportsByCity(String city) {
        return transportRepository.findByCityIgnoreCase(city);
    }

    @Override
    public List<Transport> getTransportsByTemple(String temple) {
        return transportRepository.findByTempleIgnoreCase(temple);
    }

    @Override
    public List<Transport> getAvailableTransportsByAgency(TravelAgency agency) {
        return transportRepository.findByAgencyAndAvailableTrue(agency);
    }

    @Override
    public List<Transport> getAvailableTransportsByTypeAndCity(TransportType type, String city) {
        return transportRepository.findByTypeAndCityIgnoreCaseAndAvailableTrue(type, city);
    }

    @Override
    public List<Transport> getAvailableTransportsByTypeAndTemple(TransportType type, String temple) {
        return transportRepository.findByTypeAndTempleIgnoreCaseAndAvailableTrue(type, temple);
    }

    @Override
    public List<Transport> getAllAvailableTransports() {
        return transportRepository.findByAvailableTrue();
    }

    @Override
    public long countTransportsByType(TravelAgency agency, TransportType type) {
        return transportRepository.countByAgencyAndType(agency, type);
    }

    @Override
    public long countAvailableTransportsByType(TravelAgency agency, TransportType type) {
        return transportRepository.countByAgencyAndTypeAndAvailableTrue(agency, type);
    }

    @Override
    public boolean bookTransport(Long id) {
        Transport transport = getTransportById(id);
        if (transport != null && transport.isAvailable()) {
            transport.setAvailable(false);
            transportRepository.save(transport);
            return true;
        }
        return false;
    }

    @Override
    public boolean releaseTransport(Long id) {
        Transport transport = getTransportById(id);
        if (transport != null && !transport.isAvailable()) {
            transport.setAvailable(true);
            transportRepository.save(transport);
            return true;
        }
        return false;
    }
}

