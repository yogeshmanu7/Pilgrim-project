package com.pilgrim.repository;

import com.pilgrim.entity.TourBooking;
import com.pilgrim.entity.TourGuide;
import com.pilgrim.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface TourBookingRepository extends JpaRepository<TourBooking, Long> {
    
    List<TourBooking> findByUser(User user);
    
    List<TourBooking> findByUserOrderByCreatedAtDesc(User user);
    
    List<TourBooking> findByTourGuide(TourGuide tourGuide);
    
    List<TourBooking> findByTourGuideAndTourDate(TourGuide tourGuide, LocalDate date);
    
    Optional<TourBooking> findByBookingNumber(String bookingNumber);
    
    @Query("SELECT tb FROM TourBooking tb WHERE tb.tourGuide.temple.id = :templeId ORDER BY tb.createdAt DESC")
    List<TourBooking> findByTempleId(@Param("templeId") Long templeId);
    
    @Query("SELECT COUNT(tb) FROM TourBooking tb WHERE tb.tourGuide = :guide AND tb.tourDate = :date AND tb.status != 'CANCELLED'")
    Integer countBookingsForDate(@Param("guide") TourGuide guide, @Param("date") LocalDate date);
}

