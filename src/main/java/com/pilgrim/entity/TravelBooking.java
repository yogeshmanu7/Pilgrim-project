package com.pilgrim.entity;

import com.pilgrim.enums.TravelBookingStatus;
import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "travel_booking")
public class TravelBooking {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne @JoinColumn(name = "package_id")
    private TravelPackage travelPackage;

    @ManyToOne @JoinColumn(name = "guide_id")
    private Guide guide;

    @ManyToOne @JoinColumn(name = "transport_id")
    private Transport transport;

    @ManyToOne @JoinColumn(name = "user_id")
    private User user;

    private int quantity;
    private double amountPaid;

    @Enumerated(EnumType.STRING)
    @Column(length = 50)
    private TravelBookingStatus status;

    private LocalDate travelStartDate;
    private LocalDate travelEndDate;

    private LocalDateTime bookedAt;
    private LocalDateTime cancelledAt;
    private LocalDateTime refundInitiatedAt;
    private LocalDateTime refundedAt;
    private LocalDateTime completedAt;

    @Column(length = 500)
    private String cancellationReason;
    @Column(length = 500)
    private String refundReason;

    private String paymentOrderId;
    private String paymentId;
    private String paymentSignature;

    @ElementCollection
    @CollectionTable(name = "travel_booking_passenger_names", joinColumns = @JoinColumn(name = "booking_id"))
    @Column(name = "passenger_name", length = 200)
    private List<String> passengerNames = new ArrayList<>();

    @ElementCollection
    @CollectionTable(name = "travel_booking_passenger_ages", joinColumns = @JoinColumn(name = "booking_id"))
    @Column(name = "passenger_age")
    private List<Integer> passengerAges = new ArrayList<>();

    // Getters & Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public TravelPackage getTravelPackage() { return travelPackage; }
    public void setTravelPackage(TravelPackage travelPackage) { this.travelPackage = travelPackage; }

    public Guide getGuide() { return guide; }
    public void setGuide(Guide guide) { this.guide = guide; }

    public Transport getTransport() { return transport; }
    public void setTransport(Transport transport) { this.transport = transport; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public double getAmountPaid() { return amountPaid; }
    public void setAmountPaid(double amountPaid) { this.amountPaid = amountPaid; }

    public TravelBookingStatus getStatus() { return status; }
    public void setStatus(TravelBookingStatus status) { this.status = status; }

    public LocalDate getTravelStartDate() { return travelStartDate; }
    public void setTravelStartDate(LocalDate travelStartDate) { this.travelStartDate = travelStartDate; }

    public LocalDate getTravelEndDate() { return travelEndDate; }
    public void setTravelEndDate(LocalDate travelEndDate) { this.travelEndDate = travelEndDate; }

    public LocalDateTime getBookedAt() { return bookedAt; }
    public void setBookedAt(LocalDateTime bookedAt) { this.bookedAt = bookedAt; }

    public LocalDateTime getCancelledAt() { return cancelledAt; }
    public void setCancelledAt(LocalDateTime cancelledAt) { this.cancelledAt = cancelledAt; }

    public LocalDateTime getRefundInitiatedAt() { return refundInitiatedAt; }
    public void setRefundInitiatedAt(LocalDateTime refundInitiatedAt) { this.refundInitiatedAt = refundInitiatedAt; }

    public LocalDateTime getRefundedAt() { return refundedAt; }
    public void setRefundedAt(LocalDateTime refundedAt) { this.refundedAt = refundedAt; }

    public LocalDateTime getCompletedAt() { return completedAt; }
    public void setCompletedAt(LocalDateTime completedAt) { this.completedAt = completedAt; }

    public String getCancellationReason() { return cancellationReason; }
    public void setCancellationReason(String cancellationReason) { this.cancellationReason = cancellationReason; }

    public String getRefundReason() { return refundReason; }
    public void setRefundReason(String refundReason) { this.refundReason = refundReason; }

    public String getPaymentOrderId() { return paymentOrderId; }
    public void setPaymentOrderId(String paymentOrderId) { this.paymentOrderId = paymentOrderId; }

    public String getPaymentId() { return paymentId; }
    public void setPaymentId(String paymentId) { this.paymentId = paymentId; }

    public String getPaymentSignature() { return paymentSignature; }
    public void setPaymentSignature(String paymentSignature) { this.paymentSignature = paymentSignature; }

    public List<String> getPassengerNames() { return passengerNames; }
    public void setPassengerNames(List<String> passengerNames) { this.passengerNames = passengerNames; }

    public List<Integer> getPassengerAges() { return passengerAges; }
    public void setPassengerAges(List<Integer> passengerAges) { this.passengerAges = passengerAges; }
}

