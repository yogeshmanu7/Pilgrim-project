package com.pilgrim.entity;

import com.pilgrim.enums.PayoutMethod;

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
@Table(name = "property_payouts")
public class PropertyPayout {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@OneToOne
	@JoinColumn(name = "property_id", nullable = false, unique = true)
	private Property property;
	
	@Enumerated(EnumType.STRING)
	@Column(nullable = false)
	private PayoutMethod payoutMethod;
	
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
	
	public PayoutMethod getPayoutMethod() {
		return payoutMethod;
	}
	
	public void setPayoutMethod(PayoutMethod payoutMethod) {
		this.payoutMethod = payoutMethod;
	}
}

