package com.pilgrim.service;

import com.pilgrim.entity.User;
import com.pilgrim.entity.TravelRating;

import java.util.List;

public interface TravelRatingService {

    TravelRating addRating(User user, Object entity, int stars, String comment, List<String> images);

    List<TravelRating> getRatings(Object entity);
}

