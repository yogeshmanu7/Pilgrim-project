package com.pilgrim.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.pilgrim.entity.Property;
import com.pilgrim.entity.PropertyTaxInfo;

@Repository
public interface PropertyTaxInfoRepository extends JpaRepository<PropertyTaxInfo, Long> {
	Optional<PropertyTaxInfo> findByProperty(Property property);
}

