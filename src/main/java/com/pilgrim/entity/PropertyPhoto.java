package com.pilgrim.entity;

import com.pilgrim.enums.PhotoCategory;

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
@Table(name = "property_photos")
public class PropertyPhoto {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@ManyToOne
	@JoinColumn(name = "property_id", nullable = false)
	private Property property;
	
	@Enumerated(EnumType.STRING)
	@Column(nullable = false)
	private PhotoCategory category;
	
	@Column(nullable = false)
	private String filePath;
	
	@Column(nullable = false)
	private String fileName;
	
	private Boolean isCoverPhoto = false;
	
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
	
	public PhotoCategory getCategory() {
		return category;
	}
	
	public void setCategory(PhotoCategory category) {
		this.category = category;
	}
	
	public String getFilePath() {
		return filePath;
	}
	
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	
	public String getFileName() {
		return fileName;
	}
	
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	public Boolean getIsCoverPhoto() {
		return isCoverPhoto;
	}
	
	public void setIsCoverPhoto(Boolean isCoverPhoto) {
		this.isCoverPhoto = isCoverPhoto;
	}
}

