package com.pilgrim.controller;

import com.pilgrim.entity.Transport;
import com.pilgrim.entity.TravelAgency;
import com.pilgrim.enums.TransportType;
import com.pilgrim.service.TransportService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.*;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/pilgrim/travel/agency/transport")
public class TransportController {

    @Autowired
    private TransportService transportService;

    @GetMapping("/list")
    public String listTransports(Model model, HttpSession session,
                                 @RequestParam(value = "type", required = false) TransportType type,
                                 @RequestParam(value = "search", required = false) String search) {
        TravelAgency agency = (TravelAgency) session.getAttribute("agency");
        if (agency == null) return "redirect:/pilgrim/travel/agency/login";

        List<Transport> transports;
        if (search != null && !search.isEmpty()) {
            transports = transportService.searchByVehicleNumber(search);
        } else if (type != null) {
            transports = transportService.getTransportsByAgencyAndType(agency, type);
        } else {
            transports = transportService.getTransportsByAgency(agency);
        }

        long totalBuses = transports.stream().filter(t -> t.getType() == TransportType.BUS).count();
        long totalCars = transports.stream().filter(t -> t.getType() == TransportType.CAR).count();
        long totalAutos = transports.stream().filter(t -> t.getType() == TransportType.AUTO).count();
        long totalBikes = transports.stream().filter(t -> t.getType() == TransportType.BIKE).count();
        long totalScooties = transports.stream().filter(t -> t.getType() == TransportType.SCOOTY).count();

        model.addAttribute("transports", transports);
        model.addAttribute("selectedType", type);
        model.addAttribute("search", search);
        model.addAttribute("totalBuses", totalBuses);
        model.addAttribute("totalCars", totalCars);
        model.addAttribute("totalAutos", totalAutos);
        model.addAttribute("totalBikes", totalBikes);
        model.addAttribute("totalScooties", totalScooties);

        return "travel/transport-list";
    }

    @GetMapping("/add")
    public String addForm(Model model) {
        model.addAttribute("transport", new Transport());
        return "travel/transport-add";
    }

    @PostMapping("/add")
    public String saveTransport(@RequestParam("type") TransportType type,
                                @RequestParam("city") String city,
                                @RequestParam(value = "temple", required = false) String temple,
                                @RequestParam("capacity") int capacity,
                                @RequestParam(value = "pricePerHour", required = false) Double pricePerHour,
                                @RequestParam(value = "pricePerDay", required = false) Double pricePerDay,
                                @RequestParam(value = "priceTempleSight", required = false) Double priceTempleSight,
                                @RequestParam(value = "pricePerTrip", required = false) Double pricePerTrip,
                                @RequestParam("vehicleNumber") String vehicleNumber,
                                @RequestParam("driverName") String driverName,
                                @RequestParam("driverMobile") String driverMobile,
                                @RequestParam("vehicleImages") MultipartFile[] vehicleImages,
                                @RequestParam("driverImagePath") MultipartFile driverImage,
                                HttpSession session) throws IOException {

        TravelAgency agency = (TravelAgency) session.getAttribute("agency");
        if (agency == null) return "redirect:/pilgrim/travel/agency/login";

        Transport transport = new Transport();
        transport.setAgency(agency);
        transport.setType(type);
        transport.setCity(city);
        transport.setTemple(temple);
        transport.setCapacity(capacity);
        transport.setPricePerHour(pricePerHour != null ? pricePerHour : 0);
        transport.setPricePerDay(pricePerDay != null ? pricePerDay : 0);
        transport.setPriceTempleSight(priceTempleSight != null ? priceTempleSight : 0);
        transport.setPricePerTrip(pricePerTrip != null ? pricePerTrip : 0);
        transport.setVehicleNumber(vehicleNumber);
        transport.setDriverName(driverName);
        transport.setDriverMobile(driverMobile);

        List<String> imagePaths = new ArrayList<>();
        if (vehicleImages != null) {
            for (MultipartFile file : vehicleImages) {
                if (!file.isEmpty()) {
                    String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
                    Path uploadPath = Paths.get("uploads/travel/");
                    if (!Files.exists(uploadPath)) {
                        Files.createDirectories(uploadPath);
                    }
                    Files.copy(file.getInputStream(), uploadPath.resolve(fileName),
                               StandardCopyOption.REPLACE_EXISTING);
                    imagePaths.add("/uploads/travel/" + fileName);
                }
            }
        }
        transport.setVehicleImagePaths(imagePaths);

        if (driverImage != null && !driverImage.isEmpty()) {
            String driverFileName = System.currentTimeMillis() + "_" + driverImage.getOriginalFilename();
            Path uploadPath = Paths.get("uploads/travel/");
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }
            Files.copy(driverImage.getInputStream(), uploadPath.resolve(driverFileName),
                       StandardCopyOption.REPLACE_EXISTING);
            transport.setDriverImagePath("/uploads/travel/" + driverFileName);
        }

        transportService.saveTransport(transport);
        return "redirect:/pilgrim/travel/agency/transport/list";
    }

    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable Long id, Model model) {
        Transport transport = transportService.getTransportById(id);
        if (transport == null) return "redirect:/pilgrim/travel/agency/transport/list";

        model.addAttribute("transport", transport);
        return "travel/transport-edit";
    }

    @PostMapping("/edit/{id}")
    public String updateTransport(@PathVariable Long id,
                                  @RequestParam("type") TransportType type,
                                  @RequestParam("city") String city,
                                  @RequestParam(value = "temple", required = false) String temple,
                                  @RequestParam("capacity") int capacity,
                                  @RequestParam(value = "pricePerHour", required = false) Double pricePerHour,
                                  @RequestParam(value = "pricePerDay", required = false) Double pricePerDay,
                                  @RequestParam(value = "priceTempleSight", required = false) Double priceTempleSight,
                                  @RequestParam(value = "pricePerTrip", required = false) Double pricePerTrip,
                                  @RequestParam("vehicleNumber") String vehicleNumber,
                                  @RequestParam("driverName") String driverName,
                                  @RequestParam("driverMobile") String driverMobile,
                                  @RequestParam(value = "vehicleImages", required = false) MultipartFile[] vehicleImages,
                                  @RequestParam(value = "driverImagePath", required = false) MultipartFile driverImage,
                                  HttpSession session) throws IOException {

        TravelAgency agency = (TravelAgency) session.getAttribute("agency");
        if (agency == null) return "redirect:/pilgrim/travel/agency/login";

        Transport existing = transportService.getTransportById(id);
        if (existing == null) return "redirect:/pilgrim/travel/agency/transport/list";

        existing.setAgency(agency);
        existing.setType(type);
        existing.setCity(city);
        existing.setTemple(temple);
        existing.setCapacity(capacity);
        existing.setPricePerHour(pricePerHour != null ? pricePerHour : 0);
        existing.setPricePerDay(pricePerDay != null ? pricePerDay : 0);
        existing.setPriceTempleSight(priceTempleSight != null ? priceTempleSight : 0);
        existing.setPricePerTrip(pricePerTrip != null ? pricePerTrip : 0);
        existing.setVehicleNumber(vehicleNumber);
        existing.setDriverName(driverName);
        existing.setDriverMobile(driverMobile);

        if (vehicleImages != null) {
            for (MultipartFile file : vehicleImages) {
                if (!file.isEmpty()) {
                    String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
                    Path uploadPath = Paths.get("uploads/travel/");
                    if (!Files.exists(uploadPath)) {
                        Files.createDirectories(uploadPath);
                    }
                    Files.copy(file.getInputStream(), uploadPath.resolve(fileName),
                               StandardCopyOption.REPLACE_EXISTING);
                    existing.getVehicleImagePaths().add("/uploads/travel/" + fileName);
                }
            }
        }

        if (driverImage != null && !driverImage.isEmpty()) {
            String driverFileName = System.currentTimeMillis() + "_" + driverImage.getOriginalFilename();
            Path uploadPath = Paths.get("uploads/travel/");
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }
            Files.copy(driverImage.getInputStream(), uploadPath.resolve(driverFileName),
                       StandardCopyOption.REPLACE_EXISTING);
            existing.setDriverImagePath("/uploads/travel/" + driverFileName);
        }

        transportService.saveTransport(existing);
        return "redirect:/pilgrim/travel/agency/transport/list";
    }

    @GetMapping("/delete/{id}")
    public String deleteTransport(@PathVariable Long id) {
        transportService.deleteTransport(id);
        return "redirect:/pilgrim/travel/agency/transport/list";
    }

    @GetMapping("/details/{id}")
    public String viewTransport(@PathVariable Long id, Model model) {
        Transport transport = transportService.getTransportById(id);
        if (transport == null) return "redirect:/pilgrim/travel/agency/transport/list";

        model.addAttribute("transport", transport);
        return "travel/transport-details";
    }

    @PostMapping("/book/{id}")
    public String bookTransport(@PathVariable Long id, HttpSession session) {
        TravelAgency agency = (TravelAgency) session.getAttribute("agency");
        if (agency == null) return "redirect:/pilgrim/travel/agency/login";

        Transport transport = transportService.getTransportById(id);
        if (transport != null) {
            transport.setAvailable(false);
            transportService.saveTransport(transport);
        }
        return "redirect:/pilgrim/travel/agency/transport/list";
    }

    @PostMapping("/release/{id}")
    public String releaseTransport(@PathVariable Long id, HttpSession session) {
        TravelAgency agency = (TravelAgency) session.getAttribute("agency");
        if (agency == null) return "redirect:/pilgrim/travel/agency/login";

        Transport transport = transportService.getTransportById(id);
        if (transport != null) {
            transport.setAvailable(true);
            transportService.saveTransport(transport);
        }
        return "redirect:/pilgrim/travel/agency/transport/list";
    }
}

