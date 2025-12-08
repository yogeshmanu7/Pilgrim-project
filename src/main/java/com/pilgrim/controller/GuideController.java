package com.pilgrim.controller;

import com.pilgrim.entity.Guide;
import com.pilgrim.entity.TravelAgency;
import com.pilgrim.enums.GuideLanguage;
import com.pilgrim.service.GuideService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.nio.file.*;

@Controller
@RequestMapping("/pilgrim/travel/agency/guides")
public class GuideController {

    @Autowired
    private GuideService guideService;

    @GetMapping("/list")
    public String listGuides(Model model, HttpSession session) {
        TravelAgency agency = (TravelAgency) session.getAttribute("agency");
        if (agency == null) return "redirect:/pilgrim/travel/agency/login";

        model.addAttribute("guides", guideService.getGuidesByAgency(agency));
        return "travel/guide-list";
    }

    @GetMapping("/add")
    public String addForm(Model model) {
        model.addAttribute("guide", new Guide());
        model.addAttribute("languages", GuideLanguage.values());
        return "travel/guide-add";
    }

    @PostMapping("/add")
    public String saveGuide(@ModelAttribute Guide guide,
                            @RequestParam("imageFile") MultipartFile imageFile,
                            HttpSession session) throws IOException {
        TravelAgency agency = (TravelAgency) session.getAttribute("agency");
        if (agency == null) return "redirect:/pilgrim/travel/agency/login";

        guide.setAgency(agency);
        guide.setAvailable(true);

        if (!imageFile.isEmpty()) {
            String fileName = System.currentTimeMillis() + "_" + imageFile.getOriginalFilename();
            Path uploadPath = Paths.get("uploads/travel/");
            if (!Files.exists(uploadPath)) Files.createDirectories(uploadPath);
            Files.copy(imageFile.getInputStream(), uploadPath.resolve(fileName),
                       StandardCopyOption.REPLACE_EXISTING);
            guide.setImagePath("/uploads/travel/" + fileName);
        }

        guideService.saveGuide(guide);
        return "redirect:/pilgrim/travel/agency/guides/list";
    }

    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable Long id, Model model) {
        Guide guide = guideService.getGuideById(id);
        model.addAttribute("guide", guide);
        model.addAttribute("languages", GuideLanguage.values());
        return "travel/guide-edit";
    }

    @PostMapping("/edit/{id}")
    public String updateGuide(@PathVariable Long id,
                              @ModelAttribute Guide formGuide,
                              @RequestParam(value = "imageFile", required = false) MultipartFile imageFile) throws IOException {
        Guide existing = guideService.getGuideById(id);
        if (existing == null) return "redirect:/pilgrim/travel/agency/guides/list";

        existing.setName(formGuide.getName());
        existing.setLanguage(formGuide.getLanguage());
        existing.setPrice(formGuide.getPrice());
        existing.setCity(formGuide.getCity());
        existing.setTemple(formGuide.getTemple());
        existing.setShortDescription(formGuide.getShortDescription());

        if (imageFile != null && !imageFile.isEmpty()) {
            String fileName = System.currentTimeMillis() + "_" + imageFile.getOriginalFilename();
            Path uploadPath = Paths.get("uploads/travel/");
            if (!Files.exists(uploadPath)) Files.createDirectories(uploadPath);
            Files.copy(imageFile.getInputStream(), uploadPath.resolve(fileName),
                       StandardCopyOption.REPLACE_EXISTING);
            existing.setImagePath("/uploads/travel/" + fileName);
        }

        guideService.saveGuide(existing);
        return "redirect:/pilgrim/travel/agency/guides/list";
    }

    @GetMapping("/details/{id}")
    public String guideDetails(@PathVariable Long id, Model model) {
        Guide guide = guideService.getGuideById(id);
        model.addAttribute("guide", guide);
        return "travel/guide-details";
    }

    @GetMapping("/delete/{id}")
    public String deleteGuide(@PathVariable Long id) {
        guideService.deleteGuide(id);
        return "redirect:/pilgrim/travel/agency/guides/list";
    }

    @PostMapping("/book/{id}")
    public String bookGuide(@PathVariable Long id) {
        Guide guide = guideService.getGuideById(id);
        if (guide != null) {
            guide.setAvailable(false);
            guideService.saveGuide(guide);
        }
        return "redirect:/pilgrim/travel/agency/guides/list";
    }

    @PostMapping("/release/{id}")
    public String releaseGuide(@PathVariable Long id) {
        Guide guide = guideService.getGuideById(id);
        if (guide != null) {
            guide.setAvailable(true);
            guideService.saveGuide(guide);
        }
        return "redirect:/pilgrim/travel/agency/guides/list";
    }
}

