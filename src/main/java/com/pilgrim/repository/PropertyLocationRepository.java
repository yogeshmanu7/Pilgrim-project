package com.pilgrim.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.pilgrim.entity.Property;
import com.pilgrim.entity.PropertyLocation;

@Repository
public interface PropertyLocationRepository extends JpaRepository<PropertyLocation, Long> {
	Optional<PropertyLocation> findByProperty(Property property);
}

