package com.pilgrim.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.pilgrim.entity.AccommodationBooking;
import com.pilgrim.entity.Property;

@Service
public class AccommodationEmailService {
	
	@Autowired
	private JavaMailSender mailSender;
	
	public void sendOTPEmail(String to, String otpCode) {
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(to);
		message.setSubject("OTP Verification - GlobalPiligrim");
		message.setText("Your OTP for email verification is: " + otpCode + "\n\nThis OTP will expire in 10 minutes.");
		mailSender.send(message);
	}
	
	public void sendBookingConfirmationToOwner(Property property, AccommodationBooking booking) {
		if (property.getOwner() == null || property.getOwner().getEmail() == null) {
			return;
		}
		
		String propertyName = property.getDetails() != null && property.getDetails().getPropertyName() != null 
			? property.getDetails().getPropertyName() 
			: "Property #" + property.getId();
		
		String guestInfo = "";
		if (booking.getUser() != null) {
			guestInfo = "Guest: " + booking.getUser().getFullName() + " (" + booking.getUser().getEmail() + ")";
		} else {
			guestInfo = "Guest: " + booking.getGuestName() + " (" + booking.getGuestEmail() + ", Phone: " + booking.getGuestPhone() + ")";
		}
		
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(property.getOwner().getEmail());
		message.setSubject("New Booking Confirmation - Your Room is Booked!");
		message.setText(
			"Dear " + property.getOwner().getFullName() + ",\n\n" +
			"Great news! You have received a new booking for your property.\n\n" +
			"Booking Details:\n" +
			"-------------------\n" +
			"Property: " + propertyName + "\n" +
			"Booking Reference: " + booking.getReferenceNumber() + "\n" +
			guestInfo + "\n" +
			"Check-in Date: " + booking.getCheckInDate() + "\n" +
			"Check-out Date: " + booking.getCheckOutDate() + "\n" +
			"Number of Guests: " + booking.getNumberOfGuests() + "\n" +
			"Number of Rooms: " + booking.getNumberOfRooms() + "\n" +
			"Total Amount: ₹" + booking.getTotalAmount() + "\n\n" +
			"Please prepare the room for the guest's arrival.\n\n" +
			"Thank you for using GlobalPiligrim!\n\n" +
			"Best regards,\n" +
			"GlobalPiligrim Team"
		);
		
		try {
			mailSender.send(message);
		} catch (Exception e) {
			System.err.println("Failed to send email to property owner: " + e.getMessage());
		}
	}
}

