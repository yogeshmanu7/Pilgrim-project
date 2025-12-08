package com.pilgrim.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "scholar_reviews")
public class ScholarReview {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne
    @JoinColumn(name = "customer_id", nullable = false)
    private User customer;
    
    @ManyToOne
    @JoinColumn(name = "scholar_id", nullable = false)
    private Scholar scholar;
    
    @OneToOne
    @JoinColumn(name = "booking_id", nullable = false)
    private ScholarBooking booking;
    
    @Column(nullable = false)
    private Integer rating;
    
    @Column(name = "comment", length = 1000)
    private String comment;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    public ScholarReview() {
        this.createdAt = LocalDateTime.now();
    }
    
    // Getters and Setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public User getCustomer() {
        return customer;
    }
    
    public void setCustomer(User customer) {
        this.customer = customer;
    }
    
    public Scholar getScholar() {
        return scholar;
    }
    
    public void setScholar(Scholar scholar) {
        this.scholar = scholar;
    }
    
    public ScholarBooking getBooking() {
        return booking;
    }
    
    public void setBooking(ScholarBooking booking) {
        this.booking = booking;
    }
    
    public Integer getRating() {
        return rating;
    }
    
    public void setRating(Integer rating) {
        this.rating = rating;
    }
    
    public String getComment() {
        return comment;
    }
    
    public void setComment(String comment) {
        this.comment = comment;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    @PrePersist
    protected void onCreate() {
        if (createdAt == null) {
            createdAt = LocalDateTime.now();
        }
    }
}

