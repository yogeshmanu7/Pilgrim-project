package com.pilgrim.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.pilgrim.entity.Property;
import com.pilgrim.entity.PropertyPhoto;
import com.pilgrim.enums.PhotoCategory;

@Repository
public interface PropertyPhotoRepository extends JpaRepository<PropertyPhoto, Long> {
	List<PropertyPhoto> findByProperty(Property property);
	List<PropertyPhoto> findByPropertyAndCategory(Property property, PhotoCategory category);
}

