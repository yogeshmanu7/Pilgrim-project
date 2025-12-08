package com.pilgrim.repository;

import com.pilgrim.entity.PoojaBooking;
import com.pilgrim.entity.TemplePooja;
import com.pilgrim.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface PoojaBookingRepository extends JpaRepository<PoojaBooking, Long> {
    
    List<PoojaBooking> findByUser(User user);
    
    List<PoojaBooking> findByUserOrderByCreatedAtDesc(User user);
    
    List<PoojaBooking> findByPooja(TemplePooja pooja);
    
    List<PoojaBooking> findByPoojaAndBookingDate(TemplePooja pooja, LocalDate date);
    
    Optional<PoojaBooking> findByBookingNumber(String bookingNumber);
    
    @Query("SELECT COUNT(pb) FROM PoojaBooking pb WHERE pb.pooja = :pooja AND pb.bookingDate = :date AND pb.status != 'CANCELLED'")
    Integer countBookingsForDate(@Param("pooja") TemplePooja pooja, @Param("date") LocalDate date);
    
    @Query("SELECT pb FROM PoojaBooking pb WHERE pb.pooja.temple.id = :templeId ORDER BY pb.createdAt DESC")
    List<PoojaBooking> findByTempleId(@Param("templeId") Long templeId);
}

