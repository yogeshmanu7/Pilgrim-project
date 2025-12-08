package com.pilgrim.service;

import com.pilgrim.entity.User;
import com.pilgrim.entity.TravelRating;
import com.pilgrim.entity.TravelPackage;
import com.pilgrim.entity.Guide;
import com.pilgrim.entity.Transport;
import com.pilgrim.repository.TravelRatingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TravelRatingServiceImpl implements TravelRatingService {

    @Autowired private TravelRatingRepository ratingRepo;

    @Override
    public TravelRating addRating(User user, Object entity, int stars, String comment, List<String> images) {
        TravelRating rating = new TravelRating();
        rating.setUser(user);
        rating.setStars(stars);
        rating.setComment(comment);
        rating.setImages(images);

        if (entity instanceof TravelPackage travelPackage) {
            rating.setTravelPackage(travelPackage);
        } else if (entity instanceof Guide guide) {
            rating.setGuide(guide);
        } else if (entity instanceof Transport transport) {
            rating.setTransport(transport);
        } else {
            throw new IllegalArgumentException("Unsupported entity type for rating");
        }

        return ratingRepo.save(rating);
    }

    @Override
    public List<TravelRating> getRatings(Object entity) {
        if (entity instanceof TravelPackage travelPackage) {
            return ratingRepo.findByTravelPackage(travelPackage);
        } else if (entity instanceof Guide guide) {
            return ratingRepo.findByGuide(guide);
        } else if (entity instanceof Transport transport) {
            return ratingRepo.findByTransport(transport);
        } else {
            throw new IllegalArgumentException("Unsupported entity type for ratings");
        }
    }
}

