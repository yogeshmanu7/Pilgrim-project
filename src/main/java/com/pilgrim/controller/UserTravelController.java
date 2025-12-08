package com.pilgrim.controller;

import com.pilgrim.entity.TravelPackage;
import com.pilgrim.enums.TravelType;
import com.pilgrim.service.TravelPackageService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/pilgrim/travel")
public class UserTravelController {

    @Autowired
    private TravelPackageService packageService;

    @GetMapping("/packages")
    public String listAllActivePackages(Model model) {
        model.addAttribute("packages", packageService.getAllActivePackages());
        return "travel/travel-package-user-list";
    }

    @GetMapping("/view/{id}")
    public String viewPackage(@PathVariable Long id, Model model) {
        TravelPackage pack = packageService.getPackageById(id);
        if (pack == null) {
            model.addAttribute("error", "Package not found!");
            return "travel/travel-package-user-list";
        }

        model.addAttribute("pack", pack);
        return "travel/travel-package-view";
    }

    @GetMapping("/type/{type}")
    public String filterByType(@PathVariable TravelType type, Model model) {
        model.addAttribute("packages", packageService.getPackagesByTravelType(type));
        model.addAttribute("type", type);
        return "travel/travel-package-user-list";
    }

    @GetMapping("/search")
    public String searchPackages(@RequestParam String keyword, Model model) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return "redirect:/pilgrim/travel/packages";
        }

        model.addAttribute("packages", packageService.searchPackages(keyword));
        model.addAttribute("search", keyword);

        return "travel/travel-package-user-list";
    }

    @GetMapping("/price")
    public String filterByPrice(@RequestParam double min,
                                @RequestParam double max,
                                Model model) {
        model.addAttribute("packages", packageService.filterByPrice(min, max));
        model.addAttribute("min", min);
        model.addAttribute("max", max);

        return "travel/travel-package-user-list";
    }
}

