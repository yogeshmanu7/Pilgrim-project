package com.pilgrim.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {
    
    @Autowired(required = false)
    private JavaMailSender mailSender;
    
    @Value("${spring.mail.username:noreply@pilgrim.com}")
    private String fromEmail;
    
    public void sendOtpEmail(String to, String otp, String purpose) {
        String subject = "OTP for " + purpose + " - Pilgrim Temple";
        String body = "Dear User,\n\n" +
                "Your OTP for " + purpose + " is: " + otp + "\n\n" +
                "This OTP is valid for 10 minutes.\n\n" +
                "If you did not request this OTP, please ignore this email.\n\n" +
                "Regards,\nPilgrim Temple Team";
        
        sendEmail(to, subject, body);
    }
    
    public void sendWelcomeEmail(String to, String name) {
        String subject = "Welcome to Pilgrim Temple Admin Panel";
        String body = "Dear " + name + ",\n\n" +
                "Welcome to the Pilgrim Temple Admin Panel!\n\n" +
                "Your account has been successfully created. You can now login to access the dashboard.\n\n" +
                "Regards,\nPilgrim Temple Team";
        
        sendEmail(to, subject, body);
    }
    
    public void sendEmail(String to, String subject, String body) {
        // Print to console for development/testing
        System.out.println("========== EMAIL ==========");
        System.out.println("To: " + to);
        System.out.println("Subject: " + subject);
        System.out.println("Body: " + body);
        System.out.println("===========================");
        
        // Send actual email if mail sender is configured
        if (mailSender != null) {
            try {
                SimpleMailMessage message = new SimpleMailMessage();
                message.setFrom(fromEmail);
                message.setTo(to);
                message.setSubject(subject);
                message.setText(body);
                mailSender.send(message);
            } catch (Exception e) {
                System.err.println("Failed to send email: " + e.getMessage());
            }
        }
    }
    
    // For Travel Booking Confirmation
    public void sendBookingConfirmation(String to, com.pilgrim.entity.TravelBooking booking) {
        String subject = "Booking Confirmation - " + (booking.getTravelPackage() != null ? booking.getTravelPackage().getPackageName() : "Travel Package");
        
        String body = "Dear " + (booking.getUser() != null ? booking.getUser().getName() : "Customer") + ",\n\n"
                + "Your booking has been confirmed successfully.\n\n"
                + "Booking Details:\n"
                + "Package: " + (booking.getTravelPackage() != null ? booking.getTravelPackage().getPackageName() : "N/A") + "\n"
                + "Quantity: " + booking.getQuantity() + "\n"
                + "Amount Paid: ₹" + booking.getAmountPaid() + "\n"
                + "Status: " + booking.getStatus() + "\n"
                + "Travel Dates: " + booking.getTravelStartDate() + " to " + booking.getTravelEndDate() + "\n\n"
                + "Thank you for booking with GlobalPiligrim Travel.\n"
                + "We wish you a pleasant journey!";
        
        sendEmail(to, subject, body);
    }
}

