package com.pilgrim.controller;

import com.pilgrim.entity.User;
import com.pilgrim.entity.TravelRating;
import com.pilgrim.entity.TravelPackage;
import com.pilgrim.entity.Guide;
import com.pilgrim.entity.Transport;
import com.pilgrim.repository.TravelPackageRepository;
import com.pilgrim.repository.GuideRepository;
import com.pilgrim.repository.TransportRepository;
import com.pilgrim.service.TravelRatingService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/pilgrim/travel/rating")
public class TravelRatingController {

    @Autowired private TravelRatingService ratingService;
    @Autowired private TravelPackageRepository packageRepo;
    @Autowired private GuideRepository guideRepo;
    @Autowired private TransportRepository transportRepo;

    @PostMapping("/{type}/{id}")
    public String addRating(@PathVariable String type,
                            @PathVariable Long id,
                            @RequestParam int stars,
                            @RequestParam String comment,
                            @RequestParam("images") List<MultipartFile> images,
                            HttpSession session) throws Exception {
        User user = (User) session.getAttribute("userSession");
        if (user == null) return "redirect:/pilgrim/user/login";

        Object entity;
        String folder;
        String redirectUrl;

        switch (type.toLowerCase()) {
            case "package" -> {
                entity = packageRepo.findById(id).orElseThrow();
                folder = "packages";
                redirectUrl = "/pilgrim/travel/view/" + id;
            }
            case "guide" -> {
                entity = guideRepo.findById(id).orElseThrow();
                folder = "guides";
                redirectUrl = "/pilgrim/travel/guide/view/" + id;
            }
            case "transport" -> {
                entity = transportRepo.findById(id).orElseThrow();
                folder = "transport";
                redirectUrl = "/pilgrim/travel/transport/view/" + id;
            }
            default -> throw new IllegalArgumentException("Unsupported rating type: " + type);
        }

        List<String> imagePaths = saveImages(images, folder);
        ratingService.addRating(user, entity, stars, comment, imagePaths);

        return "redirect:" + redirectUrl;
    }

    @GetMapping("/{type}/{id}/list")
    public String listRatings(@PathVariable String type,
                              @PathVariable Long id,
                              Model model) {
        Object entity;
        switch (type.toLowerCase()) {
            case "package" -> entity = packageRepo.findById(id).orElseThrow();
            case "guide" -> entity = guideRepo.findById(id).orElseThrow();
            case "transport" -> entity = transportRepo.findById(id).orElseThrow();
            default -> throw new IllegalArgumentException("Unsupported rating type: " + type);
        }

        List<TravelRating> ratings = ratingService.getRatings(entity);
        model.addAttribute("ratings", ratings);
        model.addAttribute(type, entity);
        return "travel/rating-list";
    }

    private List<String> saveImages(List<MultipartFile> images, String folder) throws Exception {
        List<String> paths = new ArrayList<>();
        for (MultipartFile file : images) {
            if (!file.isEmpty()) {
                String path = "/uploads/" + folder + "/ratings/" + file.getOriginalFilename();
                file.transferTo(new java.io.File("uploads/" + folder + "/ratings/" + file.getOriginalFilename()));
                paths.add(path);
            }
        }
        return paths;
    }
}

