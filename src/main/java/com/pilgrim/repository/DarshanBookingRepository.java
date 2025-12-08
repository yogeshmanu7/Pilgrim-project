package com.pilgrim.repository;

import com.pilgrim.entity.Darshan;
import com.pilgrim.entity.DarshanBooking;
import com.pilgrim.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface DarshanBookingRepository extends JpaRepository<DarshanBooking, Long> {
    
    List<DarshanBooking> findByUser(User user);
    
    List<DarshanBooking> findByUserOrderByCreatedAtDesc(User user);
    
    List<DarshanBooking> findByDarshan(Darshan darshan);
    
    List<DarshanBooking> findByDarshanAndBookingDate(Darshan darshan, LocalDate date);
    
    Optional<DarshanBooking> findByBookingNumber(String bookingNumber);
    
    @Query("SELECT COUNT(db) FROM DarshanBooking db WHERE db.darshan = :darshan AND db.bookingDate = :date AND db.status != 'CANCELLED'")
    Integer countBookingsForDate(@Param("darshan") Darshan darshan, @Param("date") LocalDate date);
    
    @Query("SELECT COALESCE(SUM(db.numberOfPersons), 0) FROM DarshanBooking db WHERE db.darshan = :darshan AND db.bookingDate = :date AND db.status != 'CANCELLED'")
    Integer countTotalPersonsForDate(@Param("darshan") Darshan darshan, @Param("date") LocalDate date);
    
    List<DarshanBooking> findByDarshanTempleIdAndBookingDate(Long templeId, LocalDate date);
    
    @Query("SELECT db FROM DarshanBooking db WHERE db.darshan.temple.id = :templeId ORDER BY db.createdAt DESC")
    List<DarshanBooking> findByTempleId(@Param("templeId") Long templeId);
}

