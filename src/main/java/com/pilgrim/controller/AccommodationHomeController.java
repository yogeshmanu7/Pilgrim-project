package com.pilgrim.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pilgrim.entity.Property;
import com.pilgrim.enums.PropertyStatus;
import com.pilgrim.service.AccommodationPropertyService;

@Controller
public class AccommodationHomeController {
	
	@Autowired
	private AccommodationPropertyService propertyService;
	
	@GetMapping("/accommodation")
	public String accommodationHome(Model model) {
		List<Property> approvedProperties = propertyService.findByStatus(PropertyStatus.APPROVED);
		List<Property> activeProperties = propertyService.findByStatus(PropertyStatus.ACTIVE);
		
		List<Property> allApprovedProperties = new ArrayList<>();
		allApprovedProperties.addAll(approvedProperties);
		allApprovedProperties.addAll(activeProperties);
		
		model.addAttribute("properties", allApprovedProperties);
		model.addAttribute("allAmenities", com.pilgrim.enums.Amenity.values());
		model.addAttribute("allPropertyTypes", com.pilgrim.enums.PropertyType.values());
		model.addAttribute("allPriceRanges", com.pilgrim.enums.PriceRange.values());
		return "accommodation/index";
	}
	
	@GetMapping("/accommodation/test")
	@ResponseBody
	public String test() {
		return "Accommodation module is running!";
	}
}

