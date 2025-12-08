package com.pilgrim.service;

import com.pilgrim.entity.*;
import com.pilgrim.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.YearMonth;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

@Service
public class DashboardService {
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private VendorRepository vendorRepository;
    
    @Autowired
    private SupportTicketRepository supportTicketRepository;
    
    @Autowired
    private com.pilgrim.repository.ScholarRepository scholarRepository;
    
    @Autowired
    private com.pilgrim.repository.ScholarBookingRepository scholarBookingRepository;
    
    // Accommodation repositories
    @Autowired
    private com.pilgrim.repository.PropertyRepository propertyRepository;
    
    @Autowired
    private com.pilgrim.repository.AccommodationBookingRepository accommodationBookingRepository;
    
    @Autowired
    private com.pilgrim.repository.AccommodationUserRepository accommodationUserRepository;
    
    @Autowired
    private com.pilgrim.repository.AccommodationComplaintRepository accommodationComplaintRepository;
    
    @Autowired
    private com.pilgrim.repository.AccommodationRefundRepository accommodationRefundRepository;
    
    @Autowired
    private com.pilgrim.repository.AccommodationPayoutRepository accommodationPayoutRepository;
    
    // Pooja repositories
    @Autowired
    private com.pilgrim.repository.PoojaItemRepository poojaItemRepository;
    
    @Autowired
    private com.pilgrim.repository.PoojaOrderRepository poojaOrderRepository;
    
    // Travel repositories
    @Autowired
    private com.pilgrim.repository.TravelAgencyRepository travelAgencyRepository;
    
    @Autowired
    private com.pilgrim.repository.TravelPackageRepository travelPackageRepository;
    
    @Autowired
    private com.pilgrim.repository.TravelBookingRepository travelBookingRepository;
    
    @Autowired
    private com.pilgrim.repository.GuideRepository guideRepository;
    
    @Autowired
    private com.pilgrim.repository.TransportRepository transportRepository;
    
    // Temple repositories
    @Autowired
    private com.pilgrim.repository.TempleRepository templeRepository;
    
    @Autowired
    private com.pilgrim.repository.DarshanBookingRepository darshanBookingRepository;
    
    @Autowired
    private com.pilgrim.repository.PoojaBookingRepository poojaBookingRepository;
    
    @Autowired
    private com.pilgrim.repository.PrasadhamOrderRepository prasadhamOrderRepository;
    
    @Autowired
    private com.pilgrim.repository.TourBookingRepository tourBookingRepository;
    
    @Autowired
    private com.pilgrim.repository.TempleDonationRepository templeDonationRepository;
    
    public Map<String, Object> getDashboardStats() {
        Map<String, Object> stats = new HashMap<>();
        
        // Scholar Module Counts
        stats.put("totalScholars", scholarRepository.count());
        stats.put("totalUsers", userRepository.countByIsActiveTrue());
        long pendingScholars = scholarRepository.findByStatus(com.pilgrim.enums.ScholarRegistrationStatus.PENDING_APPROVAL).size();
        stats.put("pendingScholars", pendingScholars);
        
        // Pooja Module Counts
        stats.put("totalVendors", vendorRepository.countByIsActiveTrue());
        long pendingVendors = vendorRepository.countByStatus(Vendor.VendorStatus.PENDING);
        stats.put("pendingVendors", pendingVendors);
        stats.put("totalPoojaItems", poojaItemRepository.count());
        stats.put("totalPoojaOrders", poojaOrderRepository.count());
        
        // Accommodation Module Counts
        stats.put("totalProperties", propertyRepository.count());
        long pendingProperties = propertyRepository.findByStatus(com.pilgrim.enums.PropertyStatus.PENDING_REVIEW).size();
        stats.put("pendingProperties", pendingProperties);
        stats.put("totalAccommodationUsers", accommodationUserRepository.count());
        stats.put("totalAccommodationBookings", accommodationBookingRepository.count());
        
        // Pending complaints, refunds, payouts
        long pendingComplaints = accommodationComplaintRepository.findByStatus("PENDING").size();
        long pendingRefunds = accommodationRefundRepository.findByStatus("PENDING").size();
        long pendingPayouts = accommodationPayoutRepository.findByStatus("PENDING").size();
        stats.put("pendingComplaints", pendingComplaints);
        stats.put("pendingRefunds", pendingRefunds);
        stats.put("pendingPayouts", pendingPayouts);
        
        // Travel Module Counts
        stats.put("totalTravelAgencies", travelAgencyRepository.count());
        long pendingTravelAgencies = travelAgencyRepository.countByApprovalStatus(com.pilgrim.enums.ApprovalStatus.PENDING);
        stats.put("pendingTravelAgencies", pendingTravelAgencies);
        stats.put("totalTravelPackages", travelPackageRepository.count());
        stats.put("totalTravelBookings", travelBookingRepository.count());
        stats.put("totalGuides", guideRepository.count());
        stats.put("totalTransport", transportRepository.count());
        
        // Temple Module Counts
        stats.put("totalTemples", templeRepository.count());
        stats.put("totalDarshanBookings", darshanBookingRepository.count());
        stats.put("totalPoojaBookings", poojaBookingRepository.count());
        stats.put("totalPrasadhamOrders", prasadhamOrderRepository.count());
        stats.put("totalTourBookings", tourBookingRepository.count());
        stats.put("totalDonations", templeDonationRepository.count());
        
        // Today's date range
        LocalDateTime startOfDay = LocalDateTime.of(LocalDate.now(), LocalTime.MIN);
        LocalDateTime endOfDay = LocalDateTime.of(LocalDate.now(), LocalTime.MAX);
        
        // Pending verifications (all modules)
        stats.put("pendingVerifications", pendingVendors + pendingScholars + pendingProperties + pendingTravelAgencies);
        
        // Support tickets
        long openTickets = supportTicketRepository.countByStatus(SupportTicket.TicketStatus.OPEN);
        long inProgressTickets = supportTicketRepository.countByStatus(SupportTicket.TicketStatus.IN_PROGRESS);
        stats.put("unresolvedTickets", openTickets + inProgressTickets);
        stats.put("openTickets", openTickets);
        stats.put("inProgressTickets", inProgressTickets);
        
        // New users today
        stats.put("newUsersToday", userRepository.countByCreatedAtAfter(startOfDay));
        
        return stats;
    }
    
    // Get revenue data for charts
    public Map<String, Object> getRevenueChartData() {
        Map<String, Object> chartData = new HashMap<>();
        
        // Last 12 months revenue by category
        Map<String, Map<String, Double>> monthlyTrend = new LinkedHashMap<>();
        
        for (int i = 11; i >= 0; i--) {
            YearMonth month = YearMonth.now().minusMonths(i);
            LocalDateTime startOfMonth = month.atDay(1).atStartOfDay();
            LocalDateTime endOfMonth = month.atEndOfMonth().atTime(LocalTime.MAX);
            
            String monthLabel = month.getMonth().toString().substring(0, 3) + " " + month.getYear();
            
            Map<String, Double> monthRevenue = new LinkedHashMap<>();
            
            monthlyTrend.put(monthLabel, monthRevenue);
        }
        
        chartData.put("monthlyTrend", monthlyTrend);
        
        return chartData;
    }
}
