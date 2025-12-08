package com.pilgrim.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.pilgrim.entity.AccommodationUser;
import com.pilgrim.enums.AccommodationUserRole;

@Repository
public interface AccommodationUserRepository extends JpaRepository<AccommodationUser, Long> {
	Optional<AccommodationUser> findByEmail(String email);
	Optional<AccommodationUser> findByUsername(String username);
	Optional<AccommodationUser> findByEmailOrUsername(String email, String username);
	Boolean existsByEmail(String email);
	Boolean existsByUsername(String username);
	List<AccommodationUser> findByRole(AccommodationUserRole role);
}

