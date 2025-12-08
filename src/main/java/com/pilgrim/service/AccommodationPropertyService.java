package com.pilgrim.service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pilgrim.entity.Property;
import com.pilgrim.entity.PropertyDetails;
import com.pilgrim.entity.PropertyLocation;
import com.pilgrim.entity.PropertyPayout;
import com.pilgrim.entity.PropertyTaxInfo;
import com.pilgrim.entity.AccommodationUser;
import com.pilgrim.enums.Amenity;
import com.pilgrim.enums.CancellationPolicy;
import com.pilgrim.enums.HomeType;
import com.pilgrim.enums.HotelType;
import com.pilgrim.enums.PayoutMethod;
import com.pilgrim.enums.PropertyStatus;
import com.pilgrim.enums.PropertyType;
import com.pilgrim.enums.UniqueType;
import com.pilgrim.enums.UnitSelection;
import com.pilgrim.repository.PropertyDetailsRepository;
import com.pilgrim.repository.PropertyLocationRepository;
import com.pilgrim.repository.PropertyPayoutRepository;
import com.pilgrim.repository.PropertyRepository;
import com.pilgrim.repository.PropertyTaxInfoRepository;
import com.pilgrim.repository.AccommodationUserRepository;

@Service
public class AccommodationPropertyService {
	
	@Autowired
	private PropertyRepository propertyRepository;
	
	@Autowired
	private PropertyLocationRepository locationRepository;
	
	@Autowired
	private PropertyPayoutRepository payoutRepository;
	
	@Autowired
	private PropertyDetailsRepository detailsRepository;
	
	@Autowired
	private PropertyTaxInfoRepository taxInfoRepository;
	
	@Autowired
	private AccommodationUserRepository userRepository;
	
	@Transactional
	public Property createDraftProperty(Long ownerId) {
		Property property = new Property();
		Optional<AccommodationUser> ownerOpt = userRepository.findById(ownerId);
		if (ownerOpt.isPresent()) {
			property.setOwner(ownerOpt.get());
		} else {
			AccommodationUser owner = new AccommodationUser();
			owner.setId(ownerId);
			property.setOwner(owner);
		}
		property.setPropertyType(PropertyType.HOME_TYPE);
		property.setUnitSelection(UnitSelection.ONE_UNIT);
		property.setStatus(PropertyStatus.DRAFT);
		
		return propertyRepository.save(property);
	}
	
	@Transactional
	public Property createProperty(Long ownerId, PropertyType propertyType, HomeType homeType, 
			HotelType hotelType, UniqueType uniqueType, String customPropertyType, 
			UnitSelection unitSelection) {
		Property property = new Property();
		Optional<AccommodationUser> ownerOpt = userRepository.findById(ownerId);
		if (ownerOpt.isPresent()) {
			property.setOwner(ownerOpt.get());
		} else {
			AccommodationUser owner = new AccommodationUser();
			owner.setId(ownerId);
			property.setOwner(owner);
		}
		property.setPropertyType(propertyType);
		property.setHomeType(homeType);
		property.setHotelType(hotelType);
		property.setUniqueType(uniqueType);
		property.setCustomPropertyType(customPropertyType);
		property.setUnitSelection(unitSelection);
		property.setStatus(PropertyStatus.DRAFT);
		
		return propertyRepository.save(property);
	}
	
	@Transactional
	public Property updateLocationDetails(Long propertyId, String country, String state, 
			String city, String streetAddress, String buildingFloorUnit, 
			String zipPostalCode, BigDecimal latitude, BigDecimal longitude) {
		Optional<Property> propertyOpt = propertyRepository.findById(propertyId);
		if (propertyOpt.isPresent()) {
			Property property = propertyOpt.get();
			
			PropertyLocation location = locationRepository.findByProperty(property)
				.orElse(new PropertyLocation());
			
			location.setProperty(property);
			location.setCountry(country);
			location.setState(state);
			location.setCity(city);
			location.setStreetAddress(streetAddress);
			location.setBuildingFloorUnit(buildingFloorUnit);
			location.setZipPostalCode(zipPostalCode);
			location.setLatitude(latitude);
			location.setLongitude(longitude);
			
			locationRepository.save(location);
			property.setLocation(location);
			property.setUpdatedAt(LocalDateTime.now());
			return propertyRepository.save(property);
		}
		return null;
	}
	
	@Transactional
	public Property updateAmenities(Long propertyId, Set<Amenity> amenities) {
		Optional<Property> propertyOpt = propertyRepository.findById(propertyId);
		if (propertyOpt.isPresent()) {
			Property property = propertyOpt.get();
			property.setAmenities(amenities);
			property.setUpdatedAt(LocalDateTime.now());
			return propertyRepository.save(property);
		}
		return null;
	}
	
	@Transactional
	public Property updatePayoutMethod(Long propertyId, PayoutMethod payoutMethod) {
		Optional<Property> propertyOpt = propertyRepository.findById(propertyId);
		if (propertyOpt.isPresent()) {
			Property property = propertyOpt.get();
			
			PropertyPayout payout = payoutRepository.findByProperty(property)
				.orElse(new PropertyPayout());
			
			payout.setProperty(property);
			payout.setPayoutMethod(payoutMethod);
			
			payoutRepository.save(payout);
			property.setPayout(payout);
			property.setUpdatedAt(LocalDateTime.now());
			return propertyRepository.save(property);
		}
		return null;
	}
	
	@Transactional
	public Property updatePropertyDetails(Long propertyId, String propertyName, Integer starRating,
			LocalTime checkInTimeFrom, LocalTime checkInTimeTo, LocalTime checkOutTime,
			CancellationPolicy cancellationPolicy) {
		Optional<Property> propertyOpt = propertyRepository.findById(propertyId);
		if (propertyOpt.isPresent()) {
			Property property = propertyOpt.get();
			
			PropertyDetails details = detailsRepository.findByProperty(property)
				.orElse(new PropertyDetails());
			
			details.setProperty(property);
			details.setPropertyName(propertyName);
			details.setStarRating(starRating);
			details.setCheckInTimeFrom(checkInTimeFrom);
			details.setCheckInTimeTo(checkInTimeTo);
			details.setCheckOutTime(checkOutTime);
			details.setCancellationPolicy(cancellationPolicy);
			
			detailsRepository.save(details);
			property.setDetails(details);
			property.setUpdatedAt(LocalDateTime.now());
			return propertyRepository.save(property);
		}
		return null;
	}
	
	@Transactional
	public Property updateTaxInfo(Long propertyId, String pan, String gst) {
		Optional<Property> propertyOpt = propertyRepository.findById(propertyId);
		if (propertyOpt.isPresent()) {
			Property property = propertyOpt.get();
			
			PropertyTaxInfo taxInfo = taxInfoRepository.findByProperty(property)
				.orElse(new PropertyTaxInfo());
			
			taxInfo.setProperty(property);
			taxInfo.setPan(pan);
			taxInfo.setGst(gst);
			
			taxInfoRepository.save(taxInfo);
			property.setTaxInfo(taxInfo);
			property.setUpdatedAt(LocalDateTime.now());
			return propertyRepository.save(property);
		}
		return null;
	}
	
	@Transactional
	public Property publishProperty(Long propertyId) {
		Optional<Property> propertyOpt = propertyRepository.findById(propertyId);
		if (propertyOpt.isPresent()) {
			Property property = propertyOpt.get();
			property.setStatus(PropertyStatus.PENDING_REVIEW);
			property.setReferenceId("REF:" + UUID.randomUUID().toString().substring(0, 8).toUpperCase());
			property.setPublishedAt(LocalDateTime.now());
			property.setUpdatedAt(LocalDateTime.now());
			return propertyRepository.save(property);
		}
		return null;
	}
	
	public Optional<Property> findById(Long id) {
		return propertyRepository.findById(id);
	}
	
	public List<Property> findByOwner(AccommodationUser owner) {
		return propertyRepository.findByOwner(owner);
	}
	
	public List<Property> findByStatus(PropertyStatus status) {
		return propertyRepository.findByStatus(status);
	}
	
	public Optional<Property> findByReferenceId(String referenceId) {
		return propertyRepository.findByReferenceId(referenceId);
	}
	
	@Transactional
	public Property updateStatus(Long propertyId, PropertyStatus status) {
		Optional<Property> propertyOpt = propertyRepository.findById(propertyId);
		if (propertyOpt.isPresent()) {
			Property property = propertyOpt.get();
			property.setStatus(status);
			property.setUpdatedAt(LocalDateTime.now());
			return propertyRepository.save(property);
		}
		return null;
	}
}

