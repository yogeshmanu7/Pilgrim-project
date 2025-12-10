package com.pilgrim.controller;

import com.pilgrim.entity.Scholar;
import com.pilgrim.enums.ScholarRegistrationStatus;
import com.pilgrim.service.ScholarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.ArrayList;
import java.util.List;

@Controller
public class HomeController {

    @Autowired
    private ScholarService scholarService;

    @GetMapping("/")
    public String index() {
        return "index";
    }

    @GetMapping("/home")
    public String home() {
        return "home";
    }

    @GetMapping("/aboutus")
    public String aboutUs() {
        return "aboutus";
    }

    @GetMapping("/contactus")
    public String contactUs() {
        return "contactus";
    }

    @GetMapping("/services")
    public String services() {
        return "services";
    }

    @GetMapping("/privacy")
    public String privacy() {
        return "privacy";
    }

    @GetMapping("/terms")
    public String terms() {
        return "terms";
    }

    @GetMapping("/pooja")
    public String poojaIndex() {
        return "pooja/index";
    }

    @GetMapping("/book-scholar")
    public String bookScholar(Model model) {
        // Get all approved and available scholars
        List<Scholar> allScholars = scholarService.findByStatus(ScholarRegistrationStatus.APPROVED);
        List<Scholar> availableScholars = new ArrayList<>();
        
        for (Scholar scholar : allScholars) {
            // Filter by availability
            if (scholar.getIsAvailable() != null && scholar.getIsAvailable()) {
                availableScholars.add(scholar);
            }
        }
        
        model.addAttribute("scholars", availableScholars);
        return "book-scholar";
    }
}

