package com.pilgrim.entity;

import java.math.BigDecimal;

import com.pilgrim.enums.RoomType;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "rooms")
public class Room {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@ManyToOne
	@JoinColumn(name = "property_id", nullable = false)
	private Property property;
	
	@Enumerated(EnumType.STRING)
	@Column(nullable = false, length = 50)
	private RoomType roomType;
	
	private String customRoomType;
	
	@Column(nullable = false)
	private Double roomSize;
	
	@Column(nullable = false)
	private Integer bathrooms;
	
	@Column(nullable = false)
	private Integer totalOccupancy;
	
	@Column(name = "total_rooms", nullable = false)
	private Integer totalRooms;
	
	@Column(nullable = false)
	private BigDecimal minimumRoomRate;
	
	@Column(nullable = false)
	private BigDecimal extraGuestPrice;
	
	@Column(nullable = false)
	private Boolean breakfastIncluded = false;
	
	private BigDecimal breakfastPricePerGuest;
	
	public Long getId() {
		return id;
	}
	
	public void setId(Long id) {
		this.id = id;
	}
	
	public Property getProperty() {
		return property;
	}
	
	public void setProperty(Property property) {
		this.property = property;
	}
	
	public RoomType getRoomType() {
		return roomType;
	}
	
	public void setRoomType(RoomType roomType) {
		this.roomType = roomType;
	}
	
	public String getCustomRoomType() {
		return customRoomType;
	}
	
	public void setCustomRoomType(String customRoomType) {
		this.customRoomType = customRoomType;
	}
	
	public Double getRoomSize() {
		return roomSize;
	}
	
	public void setRoomSize(Double roomSize) {
		this.roomSize = roomSize;
	}
	
	public Integer getBathrooms() {
		return bathrooms;
	}
	
	public void setBathrooms(Integer bathrooms) {
		this.bathrooms = bathrooms;
	}
	
	public Integer getTotalOccupancy() {
		return totalOccupancy;
	}
	
	public void setTotalOccupancy(Integer totalOccupancy) {
		this.totalOccupancy = totalOccupancy;
	}
	
	public Integer getTotalRooms() {
		return totalRooms;
	}
	
	public void setTotalRooms(Integer totalRooms) {
		this.totalRooms = totalRooms;
	}
	
	public BigDecimal getMinimumRoomRate() {
		return minimumRoomRate;
	}
	
	public void setMinimumRoomRate(BigDecimal minimumRoomRate) {
		this.minimumRoomRate = minimumRoomRate;
	}
	
	public BigDecimal getExtraGuestPrice() {
		return extraGuestPrice;
	}
	
	public void setExtraGuestPrice(BigDecimal extraGuestPrice) {
		this.extraGuestPrice = extraGuestPrice;
	}
	
	public Boolean getBreakfastIncluded() {
		return breakfastIncluded;
	}
	
	public void setBreakfastIncluded(Boolean breakfastIncluded) {
		this.breakfastIncluded = breakfastIncluded;
	}
	
	public BigDecimal getBreakfastPricePerGuest() {
		return breakfastPricePerGuest;
	}
	
	public void setBreakfastPricePerGuest(BigDecimal breakfastPricePerGuest) {
		this.breakfastPricePerGuest = breakfastPricePerGuest;
	}
}

