package com.pilgrim.controller;

import com.pilgrim.entity.Scholar;
import com.pilgrim.entity.User;
import com.pilgrim.enums.ServiceType;
import com.pilgrim.service.ScholarService;
import com.pilgrim.service.ScholarServiceService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/scholar/service")
public class ServiceController {
    
    @Autowired
    private ScholarServiceService serviceService;
    
    @Autowired
    private ScholarService scholarService;
    
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String listServices(HttpSession session, Model model) {
        User user = (User) session.getAttribute("userSession");
        if (user == null) {
            return "redirect:/scholar/login";
        }
        
        Scholar scholar = scholarService.findByUserId(user.getId());
        if (scholar == null) {
            return "redirect:/scholar/login";
        }
        
        List<com.pilgrim.entity.ScholarService> services = serviceService.findByScholar(scholar);
        model.addAttribute("services", services);
        model.addAttribute("scholar", scholar);
        
        return "scholar/service-list";
    }
    
    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String showAddForm(HttpSession session, Model model) {
        User user = (User) session.getAttribute("userSession");
        if (user == null) {
            return "redirect:/scholar/login";
        }
        
        Scholar scholar = scholarService.findByUserId(user.getId());
        if (scholar == null) {
            return "redirect:/scholar/login";
        }
        
        model.addAttribute("service", new com.pilgrim.entity.ScholarService());
        model.addAttribute("scholar", scholar);
        model.addAttribute("serviceTypes", ServiceType.values());
        
        return "scholar/service_add";
    }
    
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String addService(
            @RequestParam String name,
            @RequestParam(required = false) String customName,
            @RequestParam(required = false) String description,
            @RequestParam(required = false) BigDecimal price,
            @RequestParam(required = false) BigDecimal priceWithItems,
            @RequestParam(required = false) BigDecimal priceWithoutItems,
            @RequestParam(required = false) String serviceTypeStr,
            @RequestParam(required = false) String[] locations,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        
        User user = (User) session.getAttribute("userSession");
        if (user == null) {
            return "redirect:/scholar/login";
        }
        
        Scholar scholar = scholarService.findByUserId(user.getId());
        if (scholar == null) {
            return "redirect:/scholar/login";
        }
        
        com.pilgrim.entity.ScholarService service = new com.pilgrim.entity.ScholarService();
        service.setScholar(scholar);
        
        // Use custom name if provided, otherwise use selected service type name
        String finalName = (customName != null && !customName.trim().isEmpty()) 
                ? customName.trim() 
                : name;
        service.setName(finalName);
        
        // Set service type if provided
        if (serviceTypeStr != null && !serviceTypeStr.isEmpty()) {
            try {
                ServiceType serviceType = ServiceType.valueOf(serviceTypeStr);
                service.setServiceType(serviceType);
            } catch (IllegalArgumentException e) {
                // If not an enum value, try to find by label
                for (ServiceType st : ServiceType.values()) {
                    if (st.getLabel().equals(serviceTypeStr)) {
                        service.setServiceType(st);
                        break;
                    }
                }
            }
        }
        
        service.setDescription(description);
        
        // Set locations - always set a list (empty if no locations provided)
        List<String> finalLocations = new java.util.ArrayList<>();
        if (locations != null && locations.length > 0) {
            for (String loc : locations) {
                if (loc != null && !loc.trim().isEmpty()) {
                    finalLocations.add(loc.trim());
                }
            }
        }
        service.setLocations(finalLocations);
        
        // Handle price - use single price if provided, otherwise use the two price fields
        if (price != null) {
            service.setPriceWithItems(price);
            service.setPriceWithoutItems(price);
        } else {
            service.setPriceWithItems(priceWithItems != null ? priceWithItems : BigDecimal.ZERO);
            service.setPriceWithoutItems(priceWithoutItems != null ? priceWithoutItems : BigDecimal.ZERO);
        }
        
        service.setIsActive(true);
        
        serviceService.createService(service);
        redirectAttributes.addFlashAttribute("success", "Service added successfully!");
        
        return "redirect:/scholar/service/list";
    }
    
    @RequestMapping(value = "/edit", method = RequestMethod.GET)
    public String showEditForm(@RequestParam Long id, HttpSession session, Model model) {
        User user = (User) session.getAttribute("userSession");
        if (user == null) {
            return "redirect:/scholar/login";
        }
        
        Scholar scholar = scholarService.findByUserId(user.getId());
        if (scholar == null) {
            return "redirect:/scholar/login";
        }
        
        com.pilgrim.entity.ScholarService service = serviceService.findByIdAndScholar(id, scholar)
                .orElse(null);
        
        if (service == null) {
            return "redirect:/scholar/service/list";
        }
        
        model.addAttribute("service", service);
        model.addAttribute("scholar", scholar);
        model.addAttribute("serviceTypes", ServiceType.values());
        
        return "scholar/service_edit";
    }
    
    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    public String updateService(
            @RequestParam Long id,
            @RequestParam String name,
            @RequestParam(required = false) String description,
            @RequestParam(required = false) BigDecimal price,
            @RequestParam(required = false) BigDecimal priceWithItems,
            @RequestParam(required = false) BigDecimal priceWithoutItems,
            @RequestParam(required = false) String serviceTypeStr,
            @RequestParam(required = false) String[] locations,
            @RequestParam(required = false) Boolean isActive,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        
        User user = (User) session.getAttribute("userSession");
        if (user == null) {
            return "redirect:/scholar/login";
        }
        
        Scholar scholar = scholarService.findByUserId(user.getId());
        if (scholar == null) {
            return "redirect:/scholar/login";
        }
        
        com.pilgrim.entity.ScholarService service = serviceService.findByIdAndScholar(id, scholar)
                .orElse(null);
        
        if (service == null) {
            redirectAttributes.addFlashAttribute("error", "Service not found");
            return "redirect:/scholar/service/list";
        }
        
        service.setName(name);
        service.setDescription(description);
        
        // Set service type if provided
        if (serviceTypeStr != null && !serviceTypeStr.isEmpty()) {
            try {
                ServiceType serviceType = ServiceType.valueOf(serviceTypeStr);
                service.setServiceType(serviceType);
            } catch (IllegalArgumentException e) {
                // If not an enum value, try to find by label
                for (ServiceType st : ServiceType.values()) {
                    if (st.getLabel().equals(serviceTypeStr)) {
                        service.setServiceType(st);
                        break;
                    }
                }
            }
        }
        
        // Set locations - always set a list (empty if no locations provided)
        List<String> finalLocations = new java.util.ArrayList<>();
        if (locations != null && locations.length > 0) {
            for (String loc : locations) {
                if (loc != null && !loc.trim().isEmpty()) {
                    finalLocations.add(loc.trim());
                }
            }
        }
        service.setLocations(finalLocations);
        
        // Handle price - use single price if provided, otherwise use the two price fields
        if (price != null) {
            service.setPriceWithItems(price);
            service.setPriceWithoutItems(price);
        } else {
            if (priceWithItems != null) {
                service.setPriceWithItems(priceWithItems);
            }
            if (priceWithoutItems != null) {
                service.setPriceWithoutItems(priceWithoutItems);
            }
        }
        
        if (isActive != null) {
            service.setIsActive(isActive);
        }
        
        serviceService.updateService(service);
        redirectAttributes.addFlashAttribute("success", "Service updated successfully!");
        
        return "redirect:/scholar/service/list";
    }
    
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public String deleteService(@RequestParam Long id, HttpSession session, RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("userSession");
        if (user == null) {
            return "redirect:/scholar/login";
        }
        
        Scholar scholar = scholarService.findByUserId(user.getId());
        if (scholar == null) {
            return "redirect:/scholar/login";
        }
        
        com.pilgrim.entity.ScholarService service = serviceService.findByIdAndScholar(id, scholar)
                .orElse(null);
        
        if (service == null) {
            redirectAttributes.addFlashAttribute("error", "Service not found");
            return "redirect:/scholar/service/list";
        }
        
        serviceService.deleteService(id);
        redirectAttributes.addFlashAttribute("success", "Service deleted successfully!");
        
        return "redirect:/scholar/service/list";
    }
    
    @RequestMapping(value = "/toggle", method = RequestMethod.POST)
    public String toggleService(@RequestParam Long id, HttpSession session, RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("userSession");
        if (user == null) {
            return "redirect:/scholar/login";
        }
        
        Scholar scholar = scholarService.findByUserId(user.getId());
        if (scholar == null) {
            return "redirect:/scholar/login";
        }
        
        com.pilgrim.entity.ScholarService service = serviceService.findByIdAndScholar(id, scholar)
                .orElse(null);
        
        if (service == null) {
            redirectAttributes.addFlashAttribute("error", "Service not found");
            return "redirect:/scholar/service/list";
        }
        
        if (service.getIsActive()) {
            serviceService.deactivateService(id);
            redirectAttributes.addFlashAttribute("success", "Service deactivated successfully!");
        } else {
            serviceService.activateService(id);
            redirectAttributes.addFlashAttribute("success", "Service activated successfully!");
        }
        
        return "redirect:/scholar/service/list";
    }
}

