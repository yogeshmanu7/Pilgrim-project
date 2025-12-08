package com.pilgrim.enums;

public enum PaymentStatus {
	PENDING,
	SUCCESS,
	PAID,      // Alias for SUCCESS (for Temple module compatibility)
	FAILED,
	REFUNDED
}

