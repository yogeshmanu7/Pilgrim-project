package com.pilgrim.service;

import com.pilgrim.entity.Scholar;
import com.pilgrim.entity.ScholarBooking;
import com.pilgrim.entity.ScholarReview;
import com.pilgrim.entity.User;
import com.pilgrim.repository.ScholarRepository;
import com.pilgrim.repository.ScholarReviewRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;

@Service
@Transactional
public class ScholarReviewService {
    
    @Autowired
    private ScholarReviewRepository reviewRepository;
    
    @Autowired
    private ScholarRepository scholarRepository;
    
    public ScholarReview createReview(User customer, Scholar scholar, ScholarBooking booking, 
            Integer rating, String comment) {
        // Check if review already exists for this booking
        ScholarReview existingReview = reviewRepository.findByBooking(booking);
        if (existingReview != null) {
            throw new RuntimeException("Review already exists for this booking");
        }
        
        ScholarReview review = new ScholarReview();
        review.setCustomer(customer);
        review.setScholar(scholar);
        review.setBooking(booking);
        review.setRating(rating);
        review.setComment(comment);
        
        ScholarReview savedReview = reviewRepository.save(review);
        
        // Update scholar rating
        updateScholarRating(scholar.getId());
        
        return savedReview;
    }
    
    public ScholarReview updateReview(Long reviewId, Integer rating, String comment) {
        ScholarReview review = reviewRepository.findById(reviewId)
            .orElseThrow(() -> new RuntimeException("Review not found"));
        review.setRating(rating);
        review.setComment(comment);
        
        ScholarReview savedReview = reviewRepository.save(review);
        
        // Update scholar rating
        updateScholarRating(review.getScholar().getId());
        
        return savedReview;
    }
    
    public void updateScholarRating(Long scholarId) {
        Scholar scholar = scholarRepository.findById(scholarId)
            .orElseThrow(() -> new RuntimeException("Scholar not found"));
        
        List<ScholarReview> reviews = reviewRepository.findByScholar(scholar);
        if (!reviews.isEmpty()) {
            double avgRating = reviews.stream()
                .mapToInt(ScholarReview::getRating)
                .average()
                .orElse(0.0);
            scholar.setRating(BigDecimal.valueOf(avgRating).setScale(2, RoundingMode.HALF_UP));
            scholar.setTotalReviews(reviews.size());
            scholarRepository.save(scholar);
        }
    }
    
    public List<ScholarReview> findByScholar(Scholar scholar) {
        return reviewRepository.findByScholar(scholar);
    }
    
    public ScholarReview findByBooking(ScholarBooking booking) {
        return reviewRepository.findByBooking(booking);
    }
    
    public boolean hasReviewed(ScholarBooking booking) {
        return reviewRepository.findByBooking(booking) != null;
    }
    
    public void deleteReview(Long reviewId) {
        ScholarReview review = reviewRepository.findById(reviewId)
            .orElseThrow(() -> new RuntimeException("Review not found"));
        Long scholarId = review.getScholar().getId();
        reviewRepository.delete(review);
        updateScholarRating(scholarId);
    }
    
    public List<ScholarReview> findAll() {
        return reviewRepository.findAll();
    }
}

