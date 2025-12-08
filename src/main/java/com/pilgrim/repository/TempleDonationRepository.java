package com.pilgrim.repository;

import com.pilgrim.entity.Temple;
import com.pilgrim.entity.TempleDonation;
import com.pilgrim.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Repository
public interface TempleDonationRepository extends JpaRepository<TempleDonation, Long> {
    
    List<TempleDonation> findByUser(User user);
    
    List<TempleDonation> findByUserOrderByCreatedAtDesc(User user);
    
    List<TempleDonation> findByTemple(Temple temple);
    
    List<TempleDonation> findByTempleOrderByCreatedAtDesc(Temple temple);
    
    Optional<TempleDonation> findByDonationNumber(String donationNumber);
    
    List<TempleDonation> findByDonationType(TempleDonation.DonationType type);
    
    @Query("SELECT SUM(d.amount) FROM TempleDonation d WHERE d.temple = :temple AND (d.paymentStatus = 'PAID' OR d.paymentStatus = 'SUCCESS')")
    BigDecimal getTotalDonationsForTemple(@Param("temple") Temple temple);
    
    @Query("SELECT d FROM TempleDonation d WHERE d.temple.id = :templeId AND (d.paymentStatus = 'PAID' OR d.paymentStatus = 'SUCCESS') ORDER BY d.createdAt DESC")
    List<TempleDonation> findCompletedDonationsByTempleId(@Param("templeId") Long templeId);
}

