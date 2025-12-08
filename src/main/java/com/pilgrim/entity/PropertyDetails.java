package com.pilgrim.entity;

import java.time.LocalTime;

import com.pilgrim.enums.CancellationPolicy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "property_details")
public class PropertyDetails {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@OneToOne
	@JoinColumn(name = "property_id", nullable = false, unique = true)
	private Property property;
	
	@Column(nullable = false)
	private String propertyName;
	
	@Column(nullable = false)
	private Integer starRating;
	
	@Column(nullable = false)
	private LocalTime checkInTimeFrom;
	
	@Column(nullable = false)
	private LocalTime checkInTimeTo;
	
	@Column(nullable = false)
	private LocalTime checkOutTime;
	
	@Enumerated(EnumType.STRING)
	@Column(nullable = false)
	private CancellationPolicy cancellationPolicy;
	
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
	
	public String getPropertyName() {
		return propertyName;
	}
	
	public void setPropertyName(String propertyName) {
		this.propertyName = propertyName;
	}
	
	public Integer getStarRating() {
		return starRating;
	}
	
	public void setStarRating(Integer starRating) {
		this.starRating = starRating;
	}
	
	public LocalTime getCheckInTimeFrom() {
		return checkInTimeFrom;
	}
	
	public void setCheckInTimeFrom(LocalTime checkInTimeFrom) {
		this.checkInTimeFrom = checkInTimeFrom;
	}
	
	public LocalTime getCheckInTimeTo() {
		return checkInTimeTo;
	}
	
	public void setCheckInTimeTo(LocalTime checkInTimeTo) {
		this.checkInTimeTo = checkInTimeTo;
	}
	
	public LocalTime getCheckOutTime() {
		return checkOutTime;
	}
	
	public void setCheckOutTime(LocalTime checkOutTime) {
		this.checkOutTime = checkOutTime;
	}
	
	public CancellationPolicy getCancellationPolicy() {
		return cancellationPolicy;
	}
	
	public void setCancellationPolicy(CancellationPolicy cancellationPolicy) {
		this.cancellationPolicy = cancellationPolicy;
	}
}

