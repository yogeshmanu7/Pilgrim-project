package com.pilgrim.controller;

import com.pilgrim.entity.TravelAgency;
import com.pilgrim.entity.TravelPackage;
import com.pilgrim.enums.TravelType;
import com.pilgrim.service.TravelPackageService;
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
@RequestMapping("/pilgrim/travel/agency/package")
public class TravelPackageController {

    @Autowired
    private TravelPackageService packageService;

    @GetMapping("/list")
    public String listPackages(Model model, HttpSession session) {
        TravelAgency agency = (TravelAgency) session.getAttribute("agency");
        if (agency == null) {
            return "redirect:/pilgrim/travel/agency/login";
        }
        model.addAttribute("packages", packageService.getPackagesByAgency(agency));
        return "travel/travel-package-list";
    }

    @GetMapping("/details/{id}")
    public String viewPackageDetails(@PathVariable Long id, Model model, HttpSession session) {
        TravelAgency agency = (TravelAgency) session.getAttribute("agency");
        if (agency == null) {
            return "redirect:/pilgrim/travel/agency/login";
        }

        TravelPackage pkg = packageService.getPackageById(id);
        if (pkg == null) {
            return "redirect:/pilgrim/travel/agency/package/list";
        }

        model.addAttribute("travelPackage", pkg);
        return "travel/travel-package-details";
    }

    @GetMapping("/add")
    public String addForm(Model model) {
        model.addAttribute("travelPackage", new TravelPackage());
        return "travel/travel-package-add";
    }

    @PostMapping("/add")
    public String savePackage(@ModelAttribute("travelPackage") TravelPackage travelPackage,
                              @RequestParam("images") MultipartFile[] images,
                              HttpSession session) throws IOException {
        TravelAgency agency = (TravelAgency) session.getAttribute("agency");
        if (agency == null) {
            return "redirect:/pilgrim/travel/agency/login";
        }

        List<String> imagePaths = new ArrayList<>();
        for (MultipartFile imageFile : images) {
            if (!imageFile.isEmpty()) {
                String fileName = System.currentTimeMillis() + "_" + imageFile.getOriginalFilename();
                Path uploadPath = Paths.get("uploads/travel/");
                if (!Files.exists(uploadPath)) {
                    Files.createDirectories(uploadPath);
                }
                Files.copy(imageFile.getInputStream(), uploadPath.resolve(fileName),
                           StandardCopyOption.REPLACE_EXISTING);
                imagePaths.add("/uploads/travel/" + fileName);
            }
        }

        travelPackage.setImagePaths(imagePaths);
        travelPackage.setAgency(agency);
        packageService.savePackage(travelPackage);
        return "redirect:/pilgrim/travel/agency/package/list";
    }

    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable Long id, Model model, HttpSession session) {
        TravelAgency agency = (TravelAgency) session.getAttribute("agency");
        if (agency == null) {
            return "redirect:/pilgrim/travel/agency/login";
        }
        TravelPackage pkg = packageService.getPackageById(id);
        model.addAttribute("travelPackage", pkg);
        model.addAttribute("travelTypes", TravelType.values());
        return "travel/travel-package-edit";
    }

    @PostMapping("/edit/{id}")
    public String updatePackage(@PathVariable Long id,
                                @ModelAttribute("travelPackage") TravelPackage travelPackage,
                                @RequestParam(value = "images", required = false) MultipartFile[] images,
                                @RequestParam(value = "replaceImages", defaultValue = "false") boolean replaceImages,
                                HttpSession session) throws IOException {
        TravelAgency agency = (TravelAgency) session.getAttribute("agency");
        if (agency == null) {
            return "redirect:/pilgrim/travel/agency/login";
        }

        TravelPackage existing = packageService.getPackageById(id);
        if (existing == null) {
            return "redirect:/pilgrim/travel/agency/package/list";
        }

        existing.setPackageName(travelPackage.getPackageName());
        existing.setDescription(travelPackage.getDescription());
        existing.setCountry(travelPackage.getCountry());
        existing.setState(travelPackage.getState());
        existing.setCity(travelPackage.getCity());
        existing.setPrice(travelPackage.getPrice());
        existing.setDurationDays(travelPackage.getDurationDays());
        existing.setTravelType(travelPackage.getTravelType());

        if (images != null && images.length > 0) {
            if (replaceImages) {
                existing.getImagePaths().clear();
            }
            for (MultipartFile imageFile : images) {
                if (!imageFile.isEmpty()) {
                    String fileName = System.currentTimeMillis() + "_" + imageFile.getOriginalFilename();
                    Path uploadPath = Paths.get("uploads/travel/");
                    if (!Files.exists(uploadPath)) {
                        Files.createDirectories(uploadPath);
                    }
                    Files.copy(imageFile.getInputStream(), uploadPath.resolve(fileName),
                               StandardCopyOption.REPLACE_EXISTING);
                    existing.getImagePaths().add("/uploads/travel/" + fileName);
                }
            }
        }

        existing.setAgency(agency);
        packageService.savePackage(existing);
        return "redirect:/pilgrim/travel/agency/package/list";
    }

    @GetMapping("/delete/{id}")
    public String deletePackage(@PathVariable Long id, HttpSession session) {
        TravelAgency agency = (TravelAgency) session.getAttribute("agency");
        if (agency == null) {
            return "redirect:/pilgrim/travel/agency/login";
        }
        packageService.deletePackage(id);
        return "redirect:/pilgrim/travel/agency/package/list";
    }
}

