package com.pilgrim.entity;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "accommodation_complaints")
public class AccommodationComplaint {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@ManyToOne
	@JoinColumn(name = "property_id")
	private Property property;
	
	@ManyToOne
	@JoinColumn(name = "reporter_id")
	private AccommodationUser reporter;
	
	@ManyToOne
	@JoinColumn(name = "reported_user_id")
	private AccommodationUser reportedUser;
	
	@Column(nullable = false, length = 1000)
	private String description;
	
	@Column(nullable = false)
	private String status = "PENDING"; // PENDING, REVIEWED, RESOLVED, DISMISSED
	
	private String adminNotes;
	
	@ManyToOne
	@JoinColumn(name = "resolved_by")
	private AccommodationUser resolvedBy;
	
	private LocalDateTime resolvedAt;
	
	@Column(nullable = false)
	private LocalDateTime createdAt = LocalDateTime.now();
	
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
	
	public AccommodationUser getReporter() {
		return reporter;
	}
	
	public void setReporter(AccommodationUser reporter) {
		this.reporter = reporter;
	}
	
	public AccommodationUser getReportedUser() {
		return reportedUser;
	}
	
	public void setReportedUser(AccommodationUser reportedUser) {
		this.reportedUser = reportedUser;
	}
	
	public String getDescription() {
		return description;
	}
	
	public void setDescription(String description) {
		this.description = description;
	}
	
	public String getStatus() {
		return status;
	}
	
	public void setStatus(String status) {
		this.status = status;
	}
	
	public String getAdminNotes() {
		return adminNotes;
	}
	
	public void setAdminNotes(String adminNotes) {
		this.adminNotes = adminNotes;
	}
	
	public AccommodationUser getResolvedBy() {
		return resolvedBy;
	}
	
	public void setResolvedBy(AccommodationUser resolvedBy) {
		this.resolvedBy = resolvedBy;
	}
	
	public LocalDateTime getResolvedAt() {
		return resolvedAt;
	}
	
	public void setResolvedAt(LocalDateTime resolvedAt) {
		this.resolvedAt = resolvedAt;
	}
	
	public LocalDateTime getCreatedAt() {
		return createdAt;
	}
	
	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}
}

