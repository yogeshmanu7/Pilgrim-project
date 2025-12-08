package com.pilgrim.controller;

import java.math.BigDecimal;
import java.time.LocalTime;
import java.util.List;
import java.util.Optional;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pilgrim.entity.Property;
import com.pilgrim.entity.Room;
import com.pilgrim.entity.AccommodationUser;
import com.pilgrim.enums.Amenity;
import com.pilgrim.enums.CancellationPolicy;
import com.pilgrim.enums.HomeType;
import com.pilgrim.enums.HotelType;
import com.pilgrim.enums.PayoutMethod;
import com.pilgrim.enums.PropertyType;
import com.pilgrim.enums.RoomType;
import com.pilgrim.enums.UniqueType;
import com.pilgrim.enums.UnitSelection;
import com.pilgrim.enums.PropertyStatus;
import com.pilgrim.service.AccommodationPropertyService;
import com.pilgrim.service.AccommodationRoomService;
import com.pilgrim.service.AccommodationUserService;
import com.pilgrim.repository.PropertyPhotoRepository;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/accommodation/property")
public class AccommodationPropertyController {
	
	@Autowired
	private AccommodationPropertyService propertyService;
	
	@Autowired
	private AccommodationRoomService roomService;
	
	@Autowired
	private AccommodationUserService userService;
	
	@Autowired
	private PropertyPhotoRepository propertyPhotoRepository;
	
	@GetMapping("/dashboard")
	public String propertyDashboard() {
		return "redirect:/accommodation/user/dashboard";
	}
	
	@GetMapping("/type-selection")
	public String propertyTypeSelection(HttpSession session, RedirectAttributes redirectAttributes) {
		Long userId = (Long) session.getAttribute("accommodationUserId");
		if (userId == null) {
			return "redirect:/accommodation/signin";
		}
		
		Long currentPropertyId = (Long) session.getAttribute("currentPropertyId");
		if (currentPropertyId != null) {
			Optional<Property> propertyOpt = propertyService.findById(currentPropertyId);
			if (propertyOpt.isPresent() && propertyOpt.get().getStatus() == PropertyStatus.DRAFT) {
				return "redirect:/accommodation/property/listing/step1";
			}
		}
		
		Property property = propertyService.createDraftProperty(userId);
		session.setAttribute("currentPropertyId", property.getId());
		return "redirect:/accommodation/property/listing/step1";
	}
	
	@PostMapping("/select-type")
	public String selectPropertyType(@RequestParam PropertyType propertyType, HttpSession session) {
		session.setAttribute("selectedPropertyType", propertyType.toString());
		
		if (propertyType == PropertyType.HOME_TYPE) {
			return "redirect:/accommodation/property/home-type";
		} else if (propertyType == PropertyType.HOTEL_TYPE) {
			return "redirect:/accommodation/property/hotel-type";
		} else {
			return "redirect:/accommodation/property/unique-type";
		}
	}
	
	@GetMapping("/home-type")
	public String homeTypePage(HttpSession session) {
		Long userId = (Long) session.getAttribute("accommodationUserId");
		if (userId == null) {
			return "redirect:/accommodation/signin";
		}
		return "accommodation/home-type-selection";
	}
	
	@GetMapping("/hotel-type")
	public String hotelTypePage(HttpSession session) {
		Long userId = (Long) session.getAttribute("accommodationUserId");
		if (userId == null) {
			return "redirect:/accommodation/signin";
		}
		return "accommodation/hotel-type-selection";
	}
	
	@GetMapping("/unique-type")
	public String uniqueTypePage(HttpSession session) {
		Long userId = (Long) session.getAttribute("accommodationUserId");
		if (userId == null) {
			return "redirect:/accommodation/signin";
		}
		return "accommodation/unique-type-selection";
	}
	
	@PostMapping("/select-home-type")
	public String selectHomeType(@RequestParam(required = false) HomeType homeType,
			@RequestParam(required = false) String customType, HttpSession session) {
		session.setAttribute("selectedHomeType", homeType != null ? homeType.toString() : null);
		session.setAttribute("customHomeType", customType);
		return "redirect:/accommodation/property/unit-selection";
	}
	
	@PostMapping("/select-hotel-type")
	public String selectHotelType(@RequestParam(required = false) HotelType hotelType,
			@RequestParam(required = false) String customType, HttpSession session) {
		session.setAttribute("selectedHotelType", hotelType != null ? hotelType.toString() : null);
		session.setAttribute("customHotelType", customType);
		return "redirect:/accommodation/property/unit-selection";
	}
	
	@PostMapping("/select-unique-type")
	public String selectUniqueType(@RequestParam(required = false) UniqueType uniqueType,
			@RequestParam(required = false) String customType, HttpSession session) {
		session.setAttribute("selectedUniqueType", uniqueType != null ? uniqueType.toString() : null);
		session.setAttribute("customUniqueType", customType);
		return "redirect:/accommodation/property/unit-selection";
	}
	
	@GetMapping("/unit-selection")
	public String unitSelectionPage(HttpSession session) {
		Long userId = (Long) session.getAttribute("accommodationUserId");
		if (userId == null) {
			return "redirect:/accommodation/signin";
		}
		return "accommodation/unit-selection";
	}
	
	@PostMapping("/select-units")
	public String selectUnits(@RequestParam(required = false) String unitSelection, HttpSession session, RedirectAttributes redirectAttributes) {
		if (unitSelection == null || unitSelection.isEmpty()) {
			redirectAttributes.addFlashAttribute("error", "Please select an option");
			return "redirect:/accommodation/property/unit-selection";
		}
		
		UnitSelection unitSelectionEnum;
		try {
			unitSelectionEnum = UnitSelection.valueOf(unitSelection);
		} catch (IllegalArgumentException e) {
			redirectAttributes.addFlashAttribute("error", "Invalid selection");
			return "redirect:/accommodation/property/unit-selection";
		}
		session.setAttribute("selectedUnitSelection", unitSelectionEnum.toString());
		
		Long userId = (Long) session.getAttribute("accommodationUserId");
		PropertyType propertyType = PropertyType.valueOf((String) session.getAttribute("selectedPropertyType"));
		HomeType homeType = session.getAttribute("selectedHomeType") != null ? 
			HomeType.valueOf((String) session.getAttribute("selectedHomeType")) : null;
		HotelType hotelType = session.getAttribute("selectedHotelType") != null ? 
			HotelType.valueOf((String) session.getAttribute("selectedHotelType")) : null;
		UniqueType uniqueType = session.getAttribute("selectedUniqueType") != null ? 
			UniqueType.valueOf((String) session.getAttribute("selectedUniqueType")) : null;
		String customType = (String) session.getAttribute("customHomeType");
		if (customType == null) customType = (String) session.getAttribute("customHotelType");
		if (customType == null) customType = (String) session.getAttribute("customUniqueType");
		
		Property property = propertyService.createProperty(userId, propertyType, homeType, 
			hotelType, uniqueType, customType, unitSelectionEnum);
		
		session.setAttribute("currentPropertyId", property.getId());
		return "redirect:/accommodation/property/listing/step1";
	}
	
	@GetMapping("/listing/step1")
	public String step1Location(Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("accommodationUserId");
		if (userId == null) {
			return "redirect:/accommodation/signin";
		}
		Long propertyId = (Long) session.getAttribute("currentPropertyId");
		if (propertyId == null) {
			Property property = propertyService.createDraftProperty(userId);
			session.setAttribute("currentPropertyId", property.getId());
		}
		return "accommodation/listing-step1-location";
	}
	
	@PostMapping("/listing/step1")
	public String saveStep1Location(@RequestParam String country, @RequestParam String state,
			@RequestParam String city, @RequestParam String streetAddress,
			@RequestParam(required = false) String buildingFloorUnit,
			@RequestParam(required = false) String zipPostalCode,
			@RequestParam BigDecimal latitude, @RequestParam BigDecimal longitude,
			HttpSession session) {
		Long propertyId = (Long) session.getAttribute("currentPropertyId");
		propertyService.updateLocationDetails(propertyId, country, state, city, 
			streetAddress, buildingFloorUnit, zipPostalCode, latitude, longitude);
		return "redirect:/accommodation/property/listing/step2";
	}
	
	@GetMapping("/listing/step2")
	public String step2Amenities(Model model) {
		model.addAttribute("amenities", Amenity.values());
		return "accommodation/listing-step2-amenities";
	}
	
	@PostMapping("/listing/step2")
	public String saveStep2Amenities(@RequestParam Set<Amenity> amenities, HttpSession session) {
		Long propertyId = (Long) session.getAttribute("currentPropertyId");
		propertyService.updateAmenities(propertyId, amenities);
		return "redirect:/accommodation/property/listing/step3";
	}
	
	@GetMapping("/listing/step3")
	public String step3Rooms(Model model) {
		model.addAttribute("roomTypes", RoomType.values());
		return "accommodation/listing-step3-rooms";
	}
	
	@PostMapping("/listing/step3")
	public String saveStep3Rooms(@RequestParam RoomType roomType,
			@RequestParam(required = false) String customRoomType,
			@RequestParam Double roomSize, @RequestParam Integer bathrooms,
			@RequestParam Integer totalOccupancy, 
			@RequestParam(value = "totalRooms", required = false, defaultValue = "1") Integer totalRooms,
			@RequestParam BigDecimal minimumRoomRate,
			@RequestParam BigDecimal extraGuestPrice, @RequestParam Boolean breakfastIncluded,
			@RequestParam(required = false) BigDecimal breakfastPricePerGuest,
			HttpSession session) {
		Long propertyId = (Long) session.getAttribute("currentPropertyId");
		if (totalRooms == null || totalRooms < 1) {
			totalRooms = 1;
		}
		roomService.addRoom(propertyId, roomType, customRoomType, roomSize, bathrooms,
			totalOccupancy, totalRooms, minimumRoomRate, extraGuestPrice, breakfastIncluded, breakfastPricePerGuest);
		return "redirect:/accommodation/property/listing/step4";
	}
	
	@GetMapping("/listing/step4")
	public String step4Pricing(Model model) {
		model.addAttribute("payoutMethods", PayoutMethod.values());
		return "accommodation/listing-step4-pricing";
	}
	
	@PostMapping("/listing/step4")
	public String saveStep4Pricing(@RequestParam PayoutMethod payoutMethod, HttpSession session) {
		Long propertyId = (Long) session.getAttribute("currentPropertyId");
		propertyService.updatePayoutMethod(propertyId, payoutMethod);
		return "redirect:/accommodation/property/listing/step5";
	}
	
	@GetMapping("/listing/step5")
	public String step5Photos() {
		return "accommodation/listing-step5-photos";
	}
	
	@PostMapping("/listing/step5")
	public String saveStep5Photos(HttpSession session) {
		return "redirect:/accommodation/property/listing/step6";
	}
	
	@GetMapping("/listing/step6")
	public String step6PropertyDetails() {
		return "accommodation/listing-step6-property-details";
	}
	
	@PostMapping("/listing/step6")
	public String saveStep6PropertyDetails(@RequestParam String propertyName,
			@RequestParam Integer starRating, @RequestParam String checkInTimeFrom,
			@RequestParam String checkInTimeTo, @RequestParam String checkOutTime,
			@RequestParam CancellationPolicy cancellationPolicy, HttpSession session) {
		Long propertyId = (Long) session.getAttribute("currentPropertyId");
		propertyService.updatePropertyDetails(propertyId, propertyName, starRating,
			LocalTime.parse(checkInTimeFrom), LocalTime.parse(checkInTimeTo),
			LocalTime.parse(checkOutTime), cancellationPolicy);
		return "redirect:/accommodation/property/listing/step7";
	}
	
	@GetMapping("/listing/step7")
	public String step7ProfileDetails(Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("accommodationUserId");
		userService.findById(userId).ifPresent(user -> {
			model.addAttribute("user", user);
		});
		return "accommodation/listing-step7-profile";
	}
	
	@PostMapping("/listing/step7")
	public String saveStep7ProfileDetails(@RequestParam String firstName, @RequestParam String lastName,
			@RequestParam(required = false) String nationality,
			@RequestParam(required = false) String dateOfBirth,
			@RequestParam String residenceCountry, @RequestParam String residenceState,
			@RequestParam String residenceCity, @RequestParam String preferredLanguage,
			@RequestParam String countryCode, @RequestParam String contactPhoneNumber,
			@RequestParam String contactEmail, HttpSession session) {
		Long userId = (Long) session.getAttribute("accommodationUserId");
		java.time.LocalDate dob = dateOfBirth != null && !dateOfBirth.isEmpty() ? 
			java.time.LocalDate.parse(dateOfBirth) : null;
		userService.updateProfileDetails(userId, firstName, lastName, nationality, dob,
			residenceCountry, residenceState, residenceCity, preferredLanguage,
			countryCode, contactPhoneNumber, contactEmail);
		return "redirect:/accommodation/property/listing/step8";
	}
	
	@GetMapping("/listing/step8")
	public String step8Publish(Model model, HttpSession session) {
		Long propertyId = (Long) session.getAttribute("currentPropertyId");
		propertyService.findById(propertyId).ifPresent(property -> {
			model.addAttribute("property", property);
			model.addAttribute("rooms", roomService.findByProperty(propertyId));
		});
		return "accommodation/listing-step8-publish";
	}
	
	@PostMapping("/listing/step8")
	public String publishProperty(@RequestParam String pan,
			@RequestParam(required = false) String gst, HttpSession session,
			RedirectAttributes redirectAttributes) {
		Long propertyId = (Long) session.getAttribute("currentPropertyId");
		propertyService.updateTaxInfo(propertyId, pan, gst);
		Property property = propertyService.publishProperty(propertyId);
		redirectAttributes.addFlashAttribute("referenceId", property.getReferenceId());
		session.removeAttribute("currentPropertyId");
		return "redirect:/accommodation/property/published";
	}
	
	@GetMapping("/published")
	public String publishedPage(Model model) {
		return "accommodation/property-published";
	}
	
	@GetMapping("/manage")
	public String manageProperties(Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("accommodationUserId");
		if (userId == null) {
			return "redirect:/accommodation/signin";
		}
		Optional<AccommodationUser> userOpt = userService.findById(userId);
		if (userOpt.isPresent()) {
			List<Property> properties = propertyService.findByOwner(userOpt.get());
			model.addAttribute("properties", properties);
		} else {
			model.addAttribute("properties", List.of());
		}
		return "accommodation/property-manage";
	}
	
	@GetMapping("/view/{id}")
	public String viewProperty(@PathVariable Long id, Model model) {
		Optional<Property> propertyOpt = propertyService.findById(id);
		if (propertyOpt.isPresent()) {
			Property property = propertyOpt.get();
			if (property.getStatus() == PropertyStatus.APPROVED || 
				property.getStatus() == PropertyStatus.ACTIVE) {
				
				List<com.pilgrim.entity.PropertyPhoto> photos = propertyPhotoRepository.findByProperty(property);
				property.setPhotos(photos);
				
				model.addAttribute("property", property);
				List<Room> rooms = roomService.findByProperty(id);
				model.addAttribute("rooms", rooms);
				return "accommodation/property-view";
			}
		}
		return "redirect:/accommodation";
	}
}

