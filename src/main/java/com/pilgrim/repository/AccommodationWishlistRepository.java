package com.pilgrim.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.pilgrim.entity.Property;
import com.pilgrim.entity.AccommodationUser;
import com.pilgrim.entity.AccommodationWishlist;

@Repository
public interface AccommodationWishlistRepository extends JpaRepository<AccommodationWishlist, Long> {
	Optional<AccommodationWishlist> findByUserAndProperty(AccommodationUser user, Property property);
	List<AccommodationWishlist> findByUser(AccommodationUser user);
	boolean existsByUserAndProperty(AccommodationUser user, Property property);
	void deleteByUserAndProperty(AccommodationUser user, Property property);
}

