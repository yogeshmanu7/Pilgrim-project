package com.pilgrim.controller;

import com.pilgrim.entity.TravelAgency;
import com.pilgrim.service.TravelAgencyService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/pilgrim/travel/agency")
public class AgencyDashboardController {

    @Autowired
    private TravelAgencyService agencyService;

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        TravelAgency agency = (TravelAgency) session.getAttribute("agency");

        if (agency == null) {
            return "redirect:/pilgrim/travel/agency/login";
        }

        model.addAttribute("agency", agency);

        return "travel/agency-dashboard";
    }
}

