package com.pilgrim.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.pilgrim.entity.Property;
import com.pilgrim.entity.PropertyPayout;

@Repository
public interface PropertyPayoutRepository extends JpaRepository<PropertyPayout, Long> {
	Optional<PropertyPayout> findByProperty(Property property);
}

