package com.pilgrim.repository;

import com.pilgrim.entity.TravelAgencyOtp;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TravelAgencyOtpRepository extends JpaRepository<TravelAgencyOtp, Long> {
    TravelAgencyOtp findByEmail(String email);
    TravelAgencyOtp findByMobile(String mobile);
}

