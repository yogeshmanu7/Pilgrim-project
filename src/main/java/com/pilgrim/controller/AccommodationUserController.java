package com.pilgrim.controller;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pilgrim.entity.AccommodationBooking;
import com.pilgrim.entity.AccommodationPayment;
import com.pilgrim.entity.Property;
import com.pilgrim.entity.AccommodationReview;
import com.pilgrim.entity.Room;
import com.pilgrim.entity.AccommodationUser;
import com.pilgrim.entity.AccommodationWishlist;
import com.pilgrim.enums.Amenity;
import com.pilgrim.enums.BookingStatus;
import com.pilgrim.enums.PaymentMethod;
import com.pilgrim.enums.PaymentStatus;
import com.pilgrim.enums.PriceRange;
import com.pilgrim.enums.PropertyStatus;
import com.pilgrim.enums.PropertyType;
import com.pilgrim.enums.HotelType;
import com.pilgrim.enums.HomeType;
import com.pilgrim.enums.UniqueType;
import com.pilgrim.repository.AccommodationBookingRepository;
import com.pilgrim.repository.AccommodationPaymentRepository;
import com.pilgrim.repository.PropertyRepository;
import com.pilgrim.repository.AccommodationReviewRepository;
import com.pilgrim.repository.AccommodationUserRepository;
import com.pilgrim.repository.AccommodationWishlistRepository;
import com.pilgrim.service.AccommodationPropertyService;
import com.pilgrim.service.AccommodationRoomService;
import com.pilgrim.service.AccommodationEmailService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/accommodation/user")
public class AccommodationUserController {
	
	@Autowired
	private AccommodationPropertyService propertyService;
	
	@Autowired
	private AccommodationUserRepository userRepository;
	
	@Autowired
	private AccommodationRoomService roomService;
	
	@Autowired
	private PropertyRepository propertyRepository;
	
	@Autowired
	private AccommodationBookingRepository bookingRepository;
	
	@Autowired
	private AccommodationPaymentRepository paymentRepository;
	
	@Autowired
	private AccommodationReviewRepository reviewRepository;
	
	@Autowired
	private AccommodationWishlistRepository wishlistRepository;
	
	@Autowired
	private AccommodationEmailService emailService;
	
	@GetMapping("")
	public String userHome() {
		return "redirect:/accommodation/user/dashboard";
	}
	
	@GetMapping("/dashboard")
	public String dashboard(Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("accommodationUserId");
		if (userId == null) {
			return "redirect:/accommodation/signin";
		}
		
		Optional<AccommodationUser> userOpt = userRepository.findById(userId);
		if (!userOpt.isPresent()) {
			return "redirect:/accommodation/signin";
		}
		
		AccommodationUser user = userOpt.get();
		
		List<Property> properties = propertyService.findByOwner(user);
		List<AccommodationBooking> bookings = bookingRepository.findByUser(user);
		
		List<AccommodationBooking> recentBookings = bookings.stream()
			.sorted((b1, b2) -> b2.getCreatedAt().compareTo(b1.getCreatedAt()))
			.limit(5)
			.collect(Collectors.toList());
		
		model.addAttribute("user", user);
		model.addAttribute("totalProperties", properties.size());
		model.addAttribute("totalBookings", bookings.size());
		model.addAttribute("recentBookings", recentBookings);
		model.addAttribute("properties", properties.stream().limit(5).collect(Collectors.toList()));
		
		return "accommodation/user-dashboard";
	}
	
	@GetMapping("/search")
	public String searchPage(
			@RequestParam(required = false) String location,
			@RequestParam(required = false) String checkIn,
			@RequestParam(required = false) String checkOut,
			@RequestParam(required = false) Integer guests,
			@RequestParam(required = false) PriceRange priceRange,
			@RequestParam(required = false) PropertyType propertyType,
			@RequestParam(required = false) List<Amenity> amenities,
			@RequestParam(required = false) Integer starRating,
			@RequestParam(required = false, defaultValue = "relevance") String sortBy,
			@RequestParam(required = false) Boolean veryGood,
			@RequestParam(required = false) Boolean hotels,
			@RequestParam(required = false) Boolean parking,
			@RequestParam(required = false) Boolean fiveStars,
			@RequestParam(required = false) Boolean lessThan1km,
			@RequestParam(required = false) Boolean resorts,
			@RequestParam(required = false) Boolean beachfront,
			@RequestParam(required = false) Boolean swimmingPool,
			@RequestParam(required = false) HotelType hotelType,
			@RequestParam(required = false) HomeType homeType,
			@RequestParam(required = false) UniqueType uniqueType,
			@RequestParam(required = false) Boolean petsAllowed,
			@RequestParam(required = false) Boolean adultsOnly,
			@RequestParam(required = false) List<String> roomFacilities,
			@RequestParam(required = false) Boolean bookingSuccess,
			@RequestParam(required = false) Long bookingId,
			Model model,
			HttpSession session,
			RedirectAttributes redirectAttributes) {
		
		Long userId = (Long) session.getAttribute("accommodationUserId");
		if (userId == null) {
			redirectAttributes.addFlashAttribute("error", "Please sign in to search properties");
			return "redirect:/accommodation/signin";
		}
		
		List<Property> allProperties = propertyRepository.findAll();
		
		List<Property> filteredProperties = allProperties.stream()
			.filter(p -> p.getStatus() == PropertyStatus.APPROVED || p.getStatus() == PropertyStatus.ACTIVE)
			.collect(Collectors.toList());
		
		if (location != null && !location.isEmpty()) {
			filteredProperties = filteredProperties.stream()
				.filter(p -> {
					if (p.getLocation() != null) {
						String fullLocation = (p.getLocation().getCity() != null ? p.getLocation().getCity() : "") +
							" " + (p.getLocation().getState() != null ? p.getLocation().getState() : "") +
							" " + (p.getLocation().getCountry() != null ? p.getLocation().getCountry() : "");
						return fullLocation.toLowerCase().contains(location.toLowerCase());
					}
					return false;
				})
				.collect(Collectors.toList());
		}
		
		if (propertyType != null) {
			filteredProperties = filteredProperties.stream()
				.filter(p -> p.getPropertyType() == propertyType)
				.collect(Collectors.toList());
		}
		
		if (amenities != null && !amenities.isEmpty()) {
			filteredProperties = filteredProperties.stream()
				.filter(p -> p.getAmenities() != null && p.getAmenities().containsAll(amenities))
				.collect(Collectors.toList());
		}
		
		if (priceRange != null) {
			filteredProperties = filteredProperties.stream()
				.filter(p -> {
					List<Room> rooms = roomService.findByProperty(p.getId());
					if (rooms.isEmpty()) return false;
					
					BigDecimal minPrice = rooms.stream()
						.map(Room::getMinimumRoomRate)
						.min(BigDecimal::compareTo)
						.orElse(BigDecimal.ZERO);
					
					switch (priceRange) {
						case UNDER_1000:
							return minPrice.compareTo(new BigDecimal("1000")) < 0;
						case RANGE_1000_2500:
							return minPrice.compareTo(new BigDecimal("1000")) >= 0 && 
								   minPrice.compareTo(new BigDecimal("2500")) <= 0;
						case RANGE_2500_5000:
							return minPrice.compareTo(new BigDecimal("2500")) > 0 && 
								   minPrice.compareTo(new BigDecimal("5000")) <= 0;
						case RANGE_5000_10000:
							return minPrice.compareTo(new BigDecimal("5000")) > 0 && 
								   minPrice.compareTo(new BigDecimal("10000")) <= 0;
						case OVER_10000:
							return minPrice.compareTo(new BigDecimal("10000")) > 0;
						default:
							return true;
					}
				})
				.collect(Collectors.toList());
		}
		
		if (starRating != null && starRating > 0) {
			filteredProperties = filteredProperties.stream()
				.filter(p -> {
					if (p.getDetails() != null && p.getDetails().getStarRating() != null) {
						return p.getDetails().getStarRating() >= starRating;
					}
					return false;
				})
				.collect(Collectors.toList());
		}
		
		if (veryGood != null && veryGood) {
			filteredProperties = filteredProperties.stream()
				.filter(p -> {
					if (p.getDetails() != null && p.getDetails().getStarRating() != null) {
						return p.getDetails().getStarRating() >= 4;
					}
					return false;
				})
				.collect(Collectors.toList());
		}
		
		if (hotels != null && hotels) {
			filteredProperties = filteredProperties.stream()
				.filter(p -> p.getPropertyType() == PropertyType.HOTEL_TYPE || p.getHotelType() != null)
				.collect(Collectors.toList());
		}
		
		if (parking != null && parking) {
			filteredProperties = filteredProperties.stream()
				.filter(p -> p.getAmenities() != null && p.getAmenities().contains(Amenity.CAR_PARK))
				.collect(Collectors.toList());
		}
		
		if (fiveStars != null && fiveStars) {
			filteredProperties = filteredProperties.stream()
				.filter(p -> {
					if (p.getDetails() != null && p.getDetails().getStarRating() != null) {
						return p.getDetails().getStarRating() == 5;
					}
					return false;
				})
				.collect(Collectors.toList());
		}
		
		if (resorts != null && resorts) {
			filteredProperties = filteredProperties.stream()
				.filter(p -> p.getHotelType() == HotelType.RESORT)
				.collect(Collectors.toList());
		}
		
		if (beachfront != null && beachfront) {
			filteredProperties = filteredProperties.stream()
				.filter(p -> {
					if (p.getLocation() != null && p.getLocation().getStreetAddress() != null) {
						return p.getLocation().getStreetAddress().toLowerCase().contains("beach");
					}
					return false;
				})
				.collect(Collectors.toList());
		}
		
		if (swimmingPool != null && swimmingPool) {
			filteredProperties = filteredProperties.stream()
				.filter(p -> p.getAmenities() != null && p.getAmenities().contains(Amenity.SWIMMING_POOL))
				.collect(Collectors.toList());
		}
		
		if (hotelType != null) {
			filteredProperties = filteredProperties.stream()
				.filter(p -> p.getHotelType() == hotelType)
				.collect(Collectors.toList());
		}
		
		if (homeType != null) {
			filteredProperties = filteredProperties.stream()
				.filter(p -> p.getHomeType() == homeType)
				.collect(Collectors.toList());
		}
		
		if (uniqueType != null) {
			filteredProperties = filteredProperties.stream()
				.filter(p -> p.getUniqueType() == uniqueType)
				.collect(Collectors.toList());
		}
		
		if (petsAllowed != null && petsAllowed) {
			filteredProperties = filteredProperties.stream()
				.filter(p -> p.getAmenities() != null && p.getAmenities().contains(Amenity.PETS_ALLOWED))
				.collect(Collectors.toList());
		}
		
		if (roomFacilities != null && !roomFacilities.isEmpty()) {
			filteredProperties = filteredProperties.stream()
				.filter(p -> {
					List<Room> rooms = roomService.findByProperty(p.getId());
					if (rooms.isEmpty()) return false;
					
					return rooms.stream().anyMatch(room -> {
						String roomTypeStr = room.getRoomType().toString().toLowerCase();
						String customType = room.getCustomRoomType() != null ? room.getCustomRoomType().toLowerCase() : "";
						
						return roomFacilities.stream().anyMatch(facility -> {
							String facilityLower = facility.toLowerCase();
							if (roomTypeStr.contains(facilityLower) || customType.contains(facilityLower)) {
								return true;
							}
							switch (facility) {
								case "SEA_VIEW":
									return roomTypeStr.contains("sea") || roomTypeStr.contains("ocean");
								case "BALCONY":
									return roomTypeStr.contains("balcony");
								case "PRIVATE_BATHROOM":
									return room.getBathrooms() != null && room.getBathrooms() > 0;
								case "AIR_CONDITIONING":
									return p.getAmenities() != null && p.getAmenities().contains(Amenity.AIR_CONDITIONING);
								case "PRIVATE_POOL":
									return roomTypeStr.contains("pool");
								case "KITCHEN":
									return roomTypeStr.contains("kitchen") || roomTypeStr.contains("studio") || roomTypeStr.contains("apartment");
								case "VIEW":
									return roomTypeStr.contains("view");
								default:
									return false;
							}
						});
					});
				})
				.collect(Collectors.toList());
		}
		
		if (sortBy != null) {
			switch (sortBy) {
				case "price_low":
					filteredProperties = filteredProperties.stream()
						.sorted((p1, p2) -> {
							List<Room> rooms1 = roomService.findByProperty(p1.getId());
							List<Room> rooms2 = roomService.findByProperty(p2.getId());
							BigDecimal price1 = rooms1.isEmpty() ? BigDecimal.ZERO : 
								rooms1.stream().map(Room::getMinimumRoomRate).min(BigDecimal::compareTo).orElse(BigDecimal.ZERO);
							BigDecimal price2 = rooms2.isEmpty() ? BigDecimal.ZERO : 
								rooms2.stream().map(Room::getMinimumRoomRate).min(BigDecimal::compareTo).orElse(BigDecimal.ZERO);
							return price1.compareTo(price2);
						})
						.collect(Collectors.toList());
					break;
				case "price_high":
					filteredProperties = filteredProperties.stream()
						.sorted((p1, p2) -> {
							List<Room> rooms1 = roomService.findByProperty(p1.getId());
							List<Room> rooms2 = roomService.findByProperty(p2.getId());
							BigDecimal price1 = rooms1.isEmpty() ? BigDecimal.ZERO : 
								rooms1.stream().map(Room::getMinimumRoomRate).min(BigDecimal::compareTo).orElse(BigDecimal.ZERO);
							BigDecimal price2 = rooms2.isEmpty() ? BigDecimal.ZERO : 
								rooms2.stream().map(Room::getMinimumRoomRate).min(BigDecimal::compareTo).orElse(BigDecimal.ZERO);
							return price2.compareTo(price1);
						})
						.collect(Collectors.toList());
					break;
				case "rating":
					filteredProperties = filteredProperties.stream()
						.sorted((p1, p2) -> {
							Integer rating1 = (p1.getDetails() != null && p1.getDetails().getStarRating() != null) ? 
								p1.getDetails().getStarRating() : 0;
							Integer rating2 = (p2.getDetails() != null && p2.getDetails().getStarRating() != null) ? 
								p2.getDetails().getStarRating() : 0;
							return rating2.compareTo(rating1);
						})
						.collect(Collectors.toList());
					break;
				default:
					break;
			}
		}
		
		Optional<AccommodationUser> userOpt = userRepository.findById(userId);
		List<Long> wishlistPropertyIds = new ArrayList<>();
		if (userOpt.isPresent()) {
			wishlistPropertyIds = wishlistRepository.findByUser(userOpt.get()).stream()
				.map(w -> w.getProperty().getId())
				.collect(Collectors.toList());
		}
		
		if (bookingSuccess != null && bookingSuccess && bookingId != null) {
			Optional<AccommodationBooking> bookingOpt = bookingRepository.findById(bookingId);
			if (bookingOpt.isPresent()) {
				AccommodationBooking booking = bookingOpt.get();
				model.addAttribute("bookingReference", booking.getReferenceNumber());
				model.addAttribute("bookingAmount", booking.getTotalAmount());
				model.addAttribute("success", "Payment successful! Booking confirmed. Reference: " + booking.getReferenceNumber());
			}
		}
		
		model.addAttribute("properties", filteredProperties);
		model.addAttribute("location", location);
		model.addAttribute("checkIn", checkIn);
		model.addAttribute("checkOut", checkOut);
		model.addAttribute("guests", guests);
		model.addAttribute("priceRange", priceRange);
		model.addAttribute("propertyType", propertyType);
		model.addAttribute("amenities", amenities);
		model.addAttribute("starRating", starRating);
		model.addAttribute("sortBy", sortBy);
		model.addAttribute("veryGood", veryGood);
		model.addAttribute("hotels", hotels);
		model.addAttribute("parking", parking);
		model.addAttribute("fiveStars", fiveStars);
		model.addAttribute("resorts", resorts);
		model.addAttribute("beachfront", beachfront);
		model.addAttribute("swimmingPool", swimmingPool);
		model.addAttribute("hotelType", hotelType);
		model.addAttribute("homeType", homeType);
		model.addAttribute("uniqueType", uniqueType);
		model.addAttribute("petsAllowed", petsAllowed);
		model.addAttribute("allAmenities", Amenity.values());
		model.addAttribute("allPropertyTypes", PropertyType.values());
		model.addAttribute("allPriceRanges", PriceRange.values());
		model.addAttribute("wishlistPropertyIds", wishlistPropertyIds);
		model.addAttribute("allHotelTypes", HotelType.values());
		model.addAttribute("allHomeTypes", HomeType.values());
		model.addAttribute("allUniqueTypes", UniqueType.values());
		
		return "accommodation/search-results";
	}
	
	@PostMapping("/wishlist/add/{propertyId}")
	@Transactional
	public String addToWishlist(
			@PathVariable Long propertyId,
			@RequestParam(required = false) String location,
			HttpSession session,
			RedirectAttributes redirectAttributes) {
		Long userId = (Long) session.getAttribute("accommodationUserId");
		if (userId == null) {
			redirectAttributes.addFlashAttribute("error", "Please sign in to add to wishlist");
			return "redirect:/accommodation/signin";
		}
		
		Optional<AccommodationUser> userOpt = userRepository.findById(userId);
		Optional<Property> propertyOpt = propertyService.findById(propertyId);
		
		if (!userOpt.isPresent() || !propertyOpt.isPresent()) {
			redirectAttributes.addFlashAttribute("error", "Invalid request");
			return "redirect:/accommodation/user/search";
		}
		
		AccommodationUser user = userOpt.get();
		Property property = propertyOpt.get();
		
		if (wishlistRepository.existsByUserAndProperty(user, property)) {
			redirectAttributes.addFlashAttribute("info", "Property already in wishlist");
		} else {
			AccommodationWishlist wishlist = new AccommodationWishlist();
			wishlist.setUser(user);
			wishlist.setProperty(property);
			wishlistRepository.save(wishlist);
			redirectAttributes.addFlashAttribute("success", "Added to wishlist");
		}
		
		StringBuilder redirectUrl = new StringBuilder("/accommodation/user/search");
		if (location != null && !location.isEmpty()) {
			redirectUrl.append("?location=").append(location);
		}
		
		return "redirect:" + redirectUrl.toString();
	}
	
	@PostMapping("/wishlist/remove/{propertyId}")
	@Transactional
	public String removeFromWishlist(
			@PathVariable Long propertyId,
			HttpSession session,
			RedirectAttributes redirectAttributes) {
		Long userId = (Long) session.getAttribute("accommodationUserId");
		if (userId == null) {
			return "redirect:/accommodation/signin";
		}
		
		Optional<AccommodationUser> userOpt = userRepository.findById(userId);
		Optional<Property> propertyOpt = propertyService.findById(propertyId);
		
		if (userOpt.isPresent() && propertyOpt.isPresent()) {
			Optional<AccommodationWishlist> wishlistOpt = wishlistRepository.findByUserAndProperty(userOpt.get(), propertyOpt.get());
			if (wishlistOpt.isPresent()) {
				wishlistRepository.delete(wishlistOpt.get());
				redirectAttributes.addFlashAttribute("success", "Removed from wishlist");
			}
		}
		
		return "redirect:/accommodation/user/search";
	}
	
	@PostMapping("/book")
	public String createBooking(
			@RequestParam Long propertyId,
			@RequestParam Long roomId,
			@RequestParam String checkInDate,
			@RequestParam String checkOutDate,
			@RequestParam Integer numberOfGuests,
			@RequestParam(required = false) String guestName,
			@RequestParam(required = false) String guestEmail,
			@RequestParam(required = false) String guestPhone,
			HttpSession session,
			RedirectAttributes redirectAttributes) {
		
		Long userId = (Long) session.getAttribute("accommodationUserId");
		
		Optional<Property> propertyOpt = propertyService.findById(propertyId);
		Optional<Room> roomOpt = roomService.findByProperty(propertyId).stream()
			.filter(r -> r.getId().equals(roomId))
			.findFirst();
		
		if (!propertyOpt.isPresent() || !roomOpt.isPresent()) {
			redirectAttributes.addFlashAttribute("error", "Invalid property or room");
			return "redirect:/accommodation";
		}
		
		Property property = propertyOpt.get();
		Room room = roomOpt.get();
		
		AccommodationUser user = null;
		if (userId != null) {
			Optional<AccommodationUser> userOpt = userRepository.findById(userId);
			if (userOpt.isPresent()) {
				user = userOpt.get();
			}
		} else {
			if (guestName == null || guestName.trim().isEmpty() ||
				guestEmail == null || guestEmail.trim().isEmpty() ||
				guestPhone == null || guestPhone.trim().isEmpty()) {
				redirectAttributes.addFlashAttribute("error", "Please provide your name, email, and phone number to book");
				return "redirect:/accommodation/property/view/" + propertyId;
			}
		}
		
		LocalDate checkIn = LocalDate.parse(checkInDate);
		LocalDate checkOut = LocalDate.parse(checkOutDate);
		
		long nights = java.time.temporal.ChronoUnit.DAYS.between(checkIn, checkOut);
		BigDecimal roomRate = room.getMinimumRoomRate();
		BigDecimal totalAmount = roomRate.multiply(new BigDecimal(nights));
		
		if (numberOfGuests > room.getTotalOccupancy() && room.getExtraGuestPrice() != null) {
			int extraGuests = numberOfGuests - room.getTotalOccupancy();
			BigDecimal extraCharges = room.getExtraGuestPrice().multiply(new BigDecimal(extraGuests * nights));
			totalAmount = totalAmount.add(extraCharges);
		}
		
		AccommodationBooking booking = new AccommodationBooking();
		booking.setProperty(property);
		booking.setUser(user);
		booking.setCheckInDate(checkIn);
		booking.setCheckOutDate(checkOut);
		booking.setNumberOfGuests(numberOfGuests);
		booking.setNumberOfRooms(1);
		booking.setTotalAmount(totalAmount);
		booking.setStatus(BookingStatus.PENDING.toString());
		booking.setReferenceNumber("BOOK-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase());
		booking.setCreatedAt(LocalDateTime.now());
		
		if (user == null) {
			booking.setGuestName(guestName);
			booking.setGuestEmail(guestEmail);
			booking.setGuestPhone(guestPhone);
		}
		
		bookingRepository.save(booking);
		
		session.setAttribute("currentBookingId", booking.getId());
		session.setAttribute("bookingReference", booking.getReferenceNumber());
		
		return "redirect:/accommodation/user/payment/" + booking.getId();
	}
	
	@GetMapping("/payment/{bookingId}")
	public String paymentPage(@PathVariable Long bookingId, Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("accommodationUserId");
		String bookingReference = (String) session.getAttribute("bookingReference");
		
		Optional<AccommodationBooking> bookingOpt = bookingRepository.findById(bookingId);
		if (!bookingOpt.isPresent()) {
			return "redirect:/accommodation";
		}
		
		AccommodationBooking booking = bookingOpt.get();
		
		boolean hasAccess = false;
		if (userId != null && booking.getUser() != null && booking.getUser().getId().equals(userId)) {
			hasAccess = true;
		} else if (bookingReference != null && bookingReference.equals(booking.getReferenceNumber())) {
			hasAccess = true;
		}
		
		if (!hasAccess) {
			return "redirect:/accommodation";
		}
		
		model.addAttribute("booking", booking);
		model.addAttribute("paymentMethods", PaymentMethod.values());
		
		return "accommodation/payment";
	}
	
	@PostMapping("/payment/process")
	public String processPayment(
			@RequestParam Long bookingId,
			@RequestParam PaymentMethod paymentMethod,
			HttpSession session,
			RedirectAttributes redirectAttributes) {
		
		Long userId = (Long) session.getAttribute("accommodationUserId");
		String bookingReference = (String) session.getAttribute("bookingReference");
		
		Optional<AccommodationBooking> bookingOpt = bookingRepository.findById(bookingId);
		if (!bookingOpt.isPresent()) {
			redirectAttributes.addFlashAttribute("error", "Booking not found");
			return "redirect:/accommodation";
		}
		
		AccommodationBooking booking = bookingOpt.get();
		
		boolean hasAccess = false;
		if (userId != null && booking.getUser() != null && booking.getUser().getId().equals(userId)) {
			hasAccess = true;
		} else if (bookingReference != null && bookingReference.equals(booking.getReferenceNumber())) {
			hasAccess = true;
		}
		
		if (!hasAccess) {
			redirectAttributes.addFlashAttribute("error", "Unauthorized");
			return "redirect:/accommodation";
		}
		
		AccommodationPayment payment = new AccommodationPayment();
		payment.setBooking(booking);
		payment.setAmount(booking.getTotalAmount());
		payment.setPaymentMethod(paymentMethod);
		payment.setStatus(PaymentStatus.SUCCESS);
		payment.setTransactionId("TXN-" + UUID.randomUUID().toString().substring(0, 12).toUpperCase());
		payment.setCreatedAt(LocalDateTime.now());
		payment.setProcessedAt(LocalDateTime.now());
		
		paymentRepository.save(payment);
		
		booking.setStatus(BookingStatus.PENDING.toString());
		bookingRepository.save(booking);
		
		try {
			Property property = booking.getProperty();
			if (property != null) {
				emailService.sendBookingConfirmationToOwner(property, booking);
			}
		} catch (Exception e) {
			System.err.println("Failed to send email to property owner: " + e.getMessage());
		}
		
		redirectAttributes.addFlashAttribute("success", "Payment successful! Booking confirmed. Reference: " + booking.getReferenceNumber());
		redirectAttributes.addFlashAttribute("bookingId", booking.getId());
		redirectAttributes.addFlashAttribute("bookingReference", booking.getReferenceNumber());
		redirectAttributes.addFlashAttribute("bookingAmount", booking.getTotalAmount());
		
		if (userId != null) {
			return "redirect:/accommodation/user/search?bookingSuccess=true&bookingId=" + booking.getId();
		} else {
			return "redirect:/accommodation/user/booking/confirmation/" + booking.getReferenceNumber();
		}
	}
	
	@GetMapping("/booking/confirmation/{referenceNumber}")
	public String bookingConfirmation(@PathVariable String referenceNumber, Model model, HttpSession session) {
		Optional<AccommodationBooking> bookingOpt = bookingRepository.findByReferenceNumber(referenceNumber);
		if (!bookingOpt.isPresent()) {
			return "redirect:/accommodation";
		}
		
		AccommodationBooking booking = bookingOpt.get();
		model.addAttribute("booking", booking);
		model.addAttribute("success", "Payment successful! Booking confirmed.");
		
		return "accommodation/booking-confirmation";
	}
	
	@GetMapping("/bookings")
	public String myBookings(Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("accommodationUserId");
		if (userId == null) {
			return "redirect:/accommodation/signin";
		}
		
		Optional<AccommodationUser> userOpt = userRepository.findById(userId);
		if (!userOpt.isPresent()) {
			return "redirect:/accommodation/signin";
		}
		
		List<AccommodationBooking> bookings = bookingRepository.findByUser(userOpt.get());
		model.addAttribute("bookings", bookings);
		
		return "accommodation/my-bookings";
	}
	
	@PostMapping("/booking/{bookingId}/cancel")
	public String cancelBooking(
			@PathVariable Long bookingId,
			@RequestParam String reason,
			HttpSession session,
			RedirectAttributes redirectAttributes) {
		
		Long userId = (Long) session.getAttribute("accommodationUserId");
		if (userId == null) {
			return "redirect:/accommodation/signin";
		}
		
		Optional<AccommodationBooking> bookingOpt = bookingRepository.findById(bookingId);
		if (!bookingOpt.isPresent()) {
			redirectAttributes.addFlashAttribute("error", "Booking not found");
			return "redirect:/accommodation/user/bookings";
		}
		
		AccommodationBooking booking = bookingOpt.get();
		if (booking.getUser() == null || !booking.getUser().getId().equals(userId)) {
			redirectAttributes.addFlashAttribute("error", "Unauthorized");
			return "redirect:/accommodation/user/bookings";
		}
		
		booking.setStatus(BookingStatus.CANCELLED.toString());
		booking.setCancellationReason(reason);
		booking.setCancelledAt(LocalDateTime.now());
		bookingRepository.save(booking);
		
		redirectAttributes.addFlashAttribute("success", "Booking cancelled successfully");
		return "redirect:/accommodation/user/bookings";
	}
	
	@GetMapping("/booking/{bookingId}/edit")
	public String editBookingPage(@PathVariable Long bookingId, Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("accommodationUserId");
		if (userId == null) {
			return "redirect:/accommodation/signin";
		}
		
		Optional<AccommodationBooking> bookingOpt = bookingRepository.findById(bookingId);
		if (!bookingOpt.isPresent()) {
			return "redirect:/accommodation/user/bookings";
		}
		
		AccommodationBooking booking = bookingOpt.get();
		if (booking.getUser() == null || !booking.getUser().getId().equals(userId)) {
			return "redirect:/accommodation/user/bookings";
		}
		
		if (!booking.getStatus().equals(BookingStatus.PENDING.toString()) && 
			!booking.getStatus().equals(BookingStatus.CONFIRMED.toString())) {
			return "redirect:/accommodation/user/bookings";
		}
		
		Property property = booking.getProperty();
		List<Room> rooms = roomService.findByProperty(property.getId());
		
		model.addAttribute("booking", booking);
		model.addAttribute("property", property);
		model.addAttribute("rooms", rooms);
		
		return "accommodation/edit-booking";
	}
	
	@PostMapping("/booking/{bookingId}/edit")
	public String updateBooking(
			@PathVariable Long bookingId,
			@RequestParam String checkInDate,
			@RequestParam String checkOutDate,
			@RequestParam Integer numberOfGuests,
			@RequestParam(required = false) Long roomId,
			HttpSession session,
			RedirectAttributes redirectAttributes) {
		
		Long userId = (Long) session.getAttribute("accommodationUserId");
		if (userId == null) {
			return "redirect:/accommodation/signin";
		}
		
		Optional<AccommodationBooking> bookingOpt = bookingRepository.findById(bookingId);
		if (!bookingOpt.isPresent()) {
			redirectAttributes.addFlashAttribute("error", "Booking not found");
			return "redirect:/accommodation/user/bookings";
		}
		
		AccommodationBooking booking = bookingOpt.get();
		if (booking.getUser() == null || !booking.getUser().getId().equals(userId)) {
			redirectAttributes.addFlashAttribute("error", "Unauthorized");
			return "redirect:/accommodation/user/bookings";
		}
		
		if (!booking.getStatus().equals(BookingStatus.PENDING.toString()) && 
			!booking.getStatus().equals(BookingStatus.CONFIRMED.toString())) {
			redirectAttributes.addFlashAttribute("error", "Cannot edit this booking");
			return "redirect:/accommodation/user/bookings";
		}
		
		Property property = booking.getProperty();
		Room room = null;
		
		if (roomId != null) {
			Optional<Room> roomOpt = roomService.findByProperty(property.getId()).stream()
				.filter(r -> r.getId().equals(roomId))
				.findFirst();
			if (roomOpt.isPresent()) {
				room = roomOpt.get();
			}
		}
		
		if (room == null) {
			List<Room> rooms = roomService.findByProperty(property.getId());
			if (!rooms.isEmpty()) {
				room = rooms.get(0);
			} else {
				redirectAttributes.addFlashAttribute("error", "No rooms available for this property");
				return "redirect:/accommodation/user/bookings";
			}
		}
		
		LocalDate checkIn = LocalDate.parse(checkInDate);
		LocalDate checkOut = LocalDate.parse(checkOutDate);
		
		if (checkOut.isBefore(checkIn) || checkOut.isEqual(checkIn)) {
			redirectAttributes.addFlashAttribute("error", "Check-out date must be after check-in date");
			return "redirect:/accommodation/user/booking/" + bookingId + "/edit";
		}
		
		if (checkIn.isBefore(LocalDate.now())) {
			redirectAttributes.addFlashAttribute("error", "Check-in date cannot be in the past");
			return "redirect:/accommodation/user/booking/" + bookingId + "/edit";
		}
		
		long nights = java.time.temporal.ChronoUnit.DAYS.between(checkIn, checkOut);
		BigDecimal roomRate = room.getMinimumRoomRate();
		BigDecimal totalAmount = roomRate.multiply(new BigDecimal(nights));
		
		if (numberOfGuests > room.getTotalOccupancy() && room.getExtraGuestPrice() != null) {
			int extraGuests = numberOfGuests - room.getTotalOccupancy();
			BigDecimal extraCharges = room.getExtraGuestPrice().multiply(new BigDecimal(extraGuests * nights));
			totalAmount = totalAmount.add(extraCharges);
		}
		
		booking.setCheckInDate(checkIn);
		booking.setCheckOutDate(checkOut);
		booking.setNumberOfGuests(numberOfGuests);
		booking.setTotalAmount(totalAmount);
		
		bookingRepository.save(booking);
		
		redirectAttributes.addFlashAttribute("success", "Booking updated successfully");
		return "redirect:/accommodation/user/bookings";
	}
	
	@GetMapping("/booking/{bookingId}/invoice")
	public String downloadInvoice(@PathVariable Long bookingId, Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("accommodationUserId");
		if (userId == null) {
			return "redirect:/accommodation/signin";
		}
		
		Optional<AccommodationBooking> bookingOpt = bookingRepository.findById(bookingId);
		if (!bookingOpt.isPresent()) {
			return "redirect:/accommodation/user/bookings";
		}
		
		AccommodationBooking booking = bookingOpt.get();
		if (booking.getUser() == null || !booking.getUser().getId().equals(userId)) {
			return "redirect:/accommodation/user/bookings";
		}
		
		Optional<AccommodationPayment> paymentOpt = paymentRepository.findByBooking(booking);
		model.addAttribute("booking", booking);
		model.addAttribute("payment", paymentOpt.orElse(null));
		
		return "accommodation/invoice";
	}
	
	@GetMapping("/booking/{bookingId}/review")
	public String reviewPage(@PathVariable Long bookingId, Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("accommodationUserId");
		if (userId == null) {
			return "redirect:/accommodation/signin";
		}
		
		Optional<AccommodationBooking> bookingOpt = bookingRepository.findById(bookingId);
		if (!bookingOpt.isPresent()) {
			return "redirect:/accommodation/user/bookings";
		}
		
		AccommodationBooking booking = bookingOpt.get();
		if (booking.getUser() == null || !booking.getUser().getId().equals(userId)) {
			return "redirect:/accommodation/user/bookings";
		}
		
		model.addAttribute("booking", booking);
		
		return "accommodation/review";
	}
	
	@PostMapping("/booking/{bookingId}/review")
	public String submitReview(
			@PathVariable Long bookingId,
			@RequestParam Integer rating,
			@RequestParam(required = false) String comment,
			HttpSession session,
			RedirectAttributes redirectAttributes) {
		
		Long userId = (Long) session.getAttribute("accommodationUserId");
		if (userId == null) {
			return "redirect:/accommodation/signin";
		}
		
		Optional<AccommodationBooking> bookingOpt = bookingRepository.findById(bookingId);
		if (!bookingOpt.isPresent()) {
			redirectAttributes.addFlashAttribute("error", "Booking not found");
			return "redirect:/accommodation/user/bookings";
		}
		
		AccommodationBooking booking = bookingOpt.get();
		if (booking.getUser() == null || !booking.getUser().getId().equals(userId)) {
			redirectAttributes.addFlashAttribute("error", "Unauthorized");
			return "redirect:/accommodation/user/bookings";
		}
		
		Optional<AccommodationUser> userOpt = userRepository.findById(userId);
		if (!userOpt.isPresent()) {
			return "redirect:/accommodation/user/bookings";
		}
		
		AccommodationReview review = new AccommodationReview();
		review.setBooking(booking);
		review.setProperty(booking.getProperty());
		review.setUser(userOpt.get());
		review.setRating(rating);
		review.setComment(comment);
		review.setCreatedAt(LocalDateTime.now());
		
		reviewRepository.save(review);
		
		redirectAttributes.addFlashAttribute("success", "Review submitted successfully");
		return "redirect:/accommodation/user/bookings";
	}
}

