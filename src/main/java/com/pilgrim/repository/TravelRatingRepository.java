package com.pilgrim.repository;

import com.pilgrim.entity.TravelRating;
import com.pilgrim.entity.TravelPackage;
import com.pilgrim.entity.Guide;
import com.pilgrim.entity.Transport;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TravelRatingRepository extends JpaRepository<TravelRating, Long> {

    List<TravelRating> findByTravelPackage(TravelPackage travelPackage);
    List<TravelRating> findByGuide(Guide guide);
    List<TravelRating> findByTransport(Transport transport);
}

