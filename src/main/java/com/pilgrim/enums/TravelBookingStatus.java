package com.pilgrim.enums;

public enum TravelBookingStatus {
    BOOKED,                 // Successfully booked
    CANCELLED,              // Cancelled (generic)
    REFUNDED,               // Refund completed

    PENDING_PAYMENT,        // User started booking but payment not yet done
    PAYMENT_FAILED,         // Payment attempt failed
    CONFIRMED,              // Payment successful, booking confirmed
    CANCELLED_BY_USER,      // Cancelled by the user
    CANCELLED_BY_AGENCY,    // Cancelled by the agency in emergency
    REFUND_INITIATED,       // Refund process started
    REFUND_COMPLETED,       // Refund credited to user
    COMPLETED               // Trip finished, eligible for rating/review
}

