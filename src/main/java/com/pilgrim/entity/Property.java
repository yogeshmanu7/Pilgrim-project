package com.pilgrim.entity;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Set;

import com.pilgrim.enums.Amenity;
import com.pilgrim.enums.HomeType;
import com.pilgrim.enums.HotelType;
import com.pilgrim.enums.PropertyStatus;
import com.pilgrim.enums.PropertyType;
import com.pilgrim.enums.UniqueType;
import com.pilgrim.enums.UnitSelection;

import jakarta.persistence.CascadeType;
import jakarta.persistence.CollectionTable;
import jakarta.persistence.Column;
import jakarta.persistence.ElementCollection;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "properties")
public class Property {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@ManyToOne
	@JoinColumn(name = "owner_id", nullable = false)
	private AccommodationUser owner;
	
	@Enumerated(EnumType.STRING)
	@Column(nullable = false, length = 50)
	private PropertyType propertyType;
	
	@Enumerated(EnumType.STRING)
	@Column(length = 50)
	private HomeType homeType;
	
	@Enumerated(EnumType.STRING)
	@Column(length = 50)
	private HotelType hotelType;
	
	@Enumerated(EnumType.STRING)
	@Column(length = 50)
	private UniqueType uniqueType;
	
	@Column(length = 255)
	private String customPropertyType;
	
	@Enumerated(EnumType.STRING)
	@Column(nullable = false, length = 50)
	private UnitSelection unitSelection;
	
	@ElementCollection(fetch = FetchType.EAGER)
	@CollectionTable(name = "property_amenities", joinColumns = @JoinColumn(name = "property_id"))
	@Enumerated(EnumType.STRING)
	@Column(name = "amenity")
	private Set<Amenity> amenities;
	
	@OneToOne(mappedBy = "property", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	private PropertyLocation location;
	
	@OneToOne(mappedBy = "property", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	private PropertyPayout payout;
	
	@OneToOne(mappedBy = "property", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	private PropertyDetails details;
	
	@OneToOne(mappedBy = "property", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	private PropertyTaxInfo taxInfo;
	
	@Enumerated(EnumType.STRING)
	@Column(nullable = false, length = 50)
	private PropertyStatus status = PropertyStatus.DRAFT;
	
	private String referenceId;
	
	private LocalDateTime createdAt;
	
	private LocalDateTime updatedAt;
	
	private LocalDateTime publishedAt;
	
	@OneToMany(mappedBy = "property", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	private List<Room> rooms;
	
	@OneToMany(mappedBy = "property", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	private List<PropertyPhoto> photos;
	
	public Property() {
		this.createdAt = LocalDateTime.now();
		this.updatedAt = LocalDateTime.now();
	}
	
	public Long getId() {
		return id;
	}
	
	public void setId(Long id) {
		this.id = id;
	}
	
	public AccommodationUser getOwner() {
		return owner;
	}
	
	public void setOwner(AccommodationUser owner) {
		this.owner = owner;
	}
	
	public PropertyType getPropertyType() {
		return propertyType;
	}
	
	public void setPropertyType(PropertyType propertyType) {
		this.propertyType = propertyType;
	}
	
	public HomeType getHomeType() {
		return homeType;
	}
	
	public void setHomeType(HomeType homeType) {
		this.homeType = homeType;
	}
	
	public HotelType getHotelType() {
		return hotelType;
	}
	
	public void setHotelType(HotelType hotelType) {
		this.hotelType = hotelType;
	}
	
	public UniqueType getUniqueType() {
		return uniqueType;
	}
	
	public void setUniqueType(UniqueType uniqueType) {
		this.uniqueType = uniqueType;
	}
	
	public String getCustomPropertyType() {
		return customPropertyType;
	}
	
	public void setCustomPropertyType(String customPropertyType) {
		this.customPropertyType = customPropertyType;
	}
	
	public UnitSelection getUnitSelection() {
		return unitSelection;
	}
	
	public void setUnitSelection(UnitSelection unitSelection) {
		this.unitSelection = unitSelection;
	}
	
	public Set<Amenity> getAmenities() {
		return amenities;
	}
	
	public void setAmenities(Set<Amenity> amenities) {
		this.amenities = amenities;
	}
	
	public PropertyLocation getLocation() {
		return location;
	}
	
	public void setLocation(PropertyLocation location) {
		this.location = location;
	}
	
	public PropertyPayout getPayout() {
		return payout;
	}
	
	public void setPayout(PropertyPayout payout) {
		this.payout = payout;
	}
	
	public PropertyDetails getDetails() {
		return details;
	}
	
	public void setDetails(PropertyDetails details) {
		this.details = details;
	}
	
	public PropertyTaxInfo getTaxInfo() {
		return taxInfo;
	}
	
	public void setTaxInfo(PropertyTaxInfo taxInfo) {
		this.taxInfo = taxInfo;
	}
	
	public PropertyStatus getStatus() {
		return status;
	}
	
	public void setStatus(PropertyStatus status) {
		this.status = status;
	}
	
	public String getReferenceId() {
		return referenceId;
	}
	
	public void setReferenceId(String referenceId) {
		this.referenceId = referenceId;
	}
	
	public LocalDateTime getCreatedAt() {
		return createdAt;
	}
	
	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}
	
	public LocalDateTime getUpdatedAt() {
		return updatedAt;
	}
	
	public void setUpdatedAt(LocalDateTime updatedAt) {
		this.updatedAt = updatedAt;
	}
	
	public LocalDateTime getPublishedAt() {
		return publishedAt;
	}
	
	public void setPublishedAt(LocalDateTime publishedAt) {
		this.publishedAt = publishedAt;
	}
	
	public List<Room> getRooms() {
		return rooms;
	}
	
	public void setRooms(List<Room> rooms) {
		this.rooms = rooms;
	}
	
	public List<PropertyPhoto> getPhotos() {
		return photos;
	}
	
	public void setPhotos(List<PropertyPhoto> photos) {
		this.photos = photos;
	}
}

