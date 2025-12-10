package com.pilgrim.repository;

import com.pilgrim.entity.Scholar;
import com.pilgrim.enums.ScholarRegistrationStatus;
import com.pilgrim.enums.ScholarSpecialization;
import com.pilgrim.enums.ScholarType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ScholarRepository extends JpaRepository<Scholar, Long> {
    List<Scholar> findByType(ScholarType type);
    List<Scholar> findByStatus(ScholarRegistrationStatus status);
    List<Scholar> findByTypeAndStatus(ScholarType type, ScholarRegistrationStatus status);
    List<Scholar> findByTypeAndStatusAndIsAvailable(ScholarType type, ScholarRegistrationStatus status, Boolean isAvailable);
    List<Scholar> findBySpecializationsContaining(ScholarSpecialization specialization);
    Scholar findByUser_Id(Long userId);
}

