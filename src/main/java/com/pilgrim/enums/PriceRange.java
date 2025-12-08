package com.pilgrim.enums;

public enum PriceRange {
	UNDER_1000("Under ₹1,000"),
	RANGE_1000_2500("₹1,000 - ₹2,500"),
	RANGE_2500_5000("₹2,500 - ₹5,000"),
	RANGE_5000_10000("₹5,000 - ₹10,000"),
	OVER_10000("Over ₹10,000");
	
	private final String displayName;
	
	PriceRange(String displayName) {
		this.displayName = displayName;
	}
	
	public String getDisplayName() {
		return displayName;
	}
}

