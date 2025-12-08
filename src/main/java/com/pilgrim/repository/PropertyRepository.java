package com.pilgrim.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.pilgrim.entity.Property;
import com.pilgrim.entity.AccommodationUser;
import com.pilgrim.enums.PropertyStatus;

@Repository
public interface PropertyRepository extends JpaRepository<Property, Long> {
	List<Property> findByOwner(AccommodationUser owner);
	List<Property> findByStatus(PropertyStatus status);
	Optional<Property> findByReferenceId(String referenceId);
	List<Property> findByOwnerAndStatus(AccommodationUser owner, PropertyStatus status);
}

