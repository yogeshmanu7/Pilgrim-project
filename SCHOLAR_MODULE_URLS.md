# Complete Scholar Module URLs

## 📋 Table of Contents
1. [Scholar Authentication & Registration](#1-scholar-authentication--registration)
2. [Scholar Dashboard & Profile](#2-scholar-dashboard--profile)
3. [Service Management](#3-service-management)
4. [Booking Management](#4-booking-management)
5. [Chat & Communication](#5-chat--communication)
6. [Earnings & Payments](#6-earnings--payments)
7. [Reviews](#7-reviews)
8. [Customer Endpoints](#8-customer-endpoints)
9. [Admin Endpoints](#9-admin-endpoints)

---

## 1. Scholar Authentication & Registration

### Login
- **GET** `/scholar/login` - Show login page
- **POST** `/scholar/login` - Process login
  - Parameters: `email`, `password`
  - Redirects to: `/scholar/dashboard` on success

### Logout
- **GET** `/scholar/logout` - Logout and invalidate session
  - Redirects to: `/scholar/login`

### Registration
- **GET** `/scholar/register/step1` - Show registration step 1 (Basic Info)
- **POST** `/scholar/register/step1` - Process step 1
  - Parameters: `name`, `email`, `phone`, `password`, `confirmPassword`
  - Redirects to: `/scholar/register/step2`

- **GET** `/scholar/register/step2` - Show registration step 2 (Details & Documents)
- **POST** `/scholar/register/step2` - Process step 2
  - Parameters: `type`, `experienceYears`, `specializations[]`, `languages`, `serviceAreas`, `basePrice`, `idProof`, `certificates`, `profilePhoto`
  - Redirects to: `/scholar/register/success`

- **GET** `/scholar/register/success` - Show registration success page

---

## 2. Scholar Dashboard & Profile

### Dashboard
- **GET** `/scholar/dashboard` - Main scholar dashboard
  - Shows: Bookings, Messages, Profile Summary
  - Returns: `scholar/ScholarDashboard.jsp` or `scholar/AstrologerDashboard.jsp` (based on type)

### Profile Management
- **GET** `/scholar/profile/edit` - Show profile edit form
- **POST** `/scholar/profile/edit` - Update profile
  - Parameters: `experienceYears`, `specializations[]`, `languages`, `serviceAreas`, `basePrice`
  - Redirects to: `/scholar/dashboard`

### Availability
- **POST** `/scholar/availability` - Toggle availability status
  - Redirects to: `/scholar/dashboard`

### Reviews
- **GET** `/scholar/reviews` - View all reviews received
  - Returns: `scholar/reviews.jsp`

---

## 3. Service Management

### Service List
- **GET** `/scholar/service/list` - View all services
  - Returns: `scholar/service-list.jsp`

### Add Service
- **GET** `/scholar/service/add` - Show add service form
  - Returns: `scholar/service_add.jsp`
- **POST** `/scholar/service/add` - Create new service
  - Parameters: `name`, `description`, `priceWithItems`, `priceWithoutItems`
  - Redirects to: `/scholar/service/list`

### Edit Service
- **GET** `/scholar/service/edit?id={id}` - Show edit service form
  - Parameters: `id` (Long)
  - Returns: `scholar/service_edit.jsp`
- **POST** `/scholar/service/edit` - Update service
  - Parameters: `id`, `name`, `description`, `priceWithItems`, `priceWithoutItems`, `isActive` (optional)
  - Redirects to: `/scholar/service/list`

### Delete Service
- **POST** `/scholar/service/delete` - Delete service
  - Parameters: `id` (Long)
  - Redirects to: `/scholar/service/list`

### Toggle Service Status
- **POST** `/scholar/service/toggle` - Toggle active/inactive status
  - Parameters: `id` (Long)
  - Redirects to: `/scholar/service/list`

---

## 4. Booking Management

### Accept Booking
- **POST** `/scholar/booking/accept` - Accept a booking request
  - Parameters: `bookingId` (Long)
  - Updates status to: `CONFIRMED`
  - Redirects to: `/scholar/dashboard`

### Reject Booking
- **POST** `/scholar/booking/reject` - Reject a booking request
  - Parameters: `bookingId` (Long)
  - Updates status to: `REJECTED`
  - Redirects to: `/scholar/dashboard`

### Complete Booking
- **POST** `/scholar/booking/complete` - Mark booking as completed
  - Parameters: `bookingId` (Long)
  - Updates status to: `COMPLETED`
  - Redirects to: `/scholar/dashboard`

---

## 5. Chat & Communication

### View Chat
- **GET** `/scholar/chat` - View chat with customer
  - Parameters: `customerId` (Long), `bookingId` (Long, optional)
  - Returns: `scholar/chat.jsp`
  - Note: Only available for confirmed bookings

### Send Message
- **POST** `/scholar/chat/send` - Send message to customer
  - Parameters: `customerId` (Long), `bookingId` (Long, optional), `message` (String)
  - Redirects to: `/scholar/chat?customerId={id}`

### Video Call
- **GET** `/scholar/video-call` - Access video call
  - Parameters: `bookingId` (Long, optional)
  - Returns: `scholar/video-call.jsp`
  - Note: Only available for confirmed bookings

---

## 6. Earnings & Payments

### View Earnings
- **GET** `/scholar/earnings` - View earnings and payment history
  - Returns: `scholar/earnings.jsp`
  - Shows: Total earnings, Pending earnings, Payment list

---

## 7. Reviews

### View Reviews
- **GET** `/scholar/reviews` - View all reviews received
  - Returns: `scholar/reviews.jsp`

---

## 8. Customer Endpoints

### Browse Scholars
- **GET** `/book-scholar.jsp` - Browse all spiritual scholars
- **GET** `/book-astrologer.jsp` - Browse astrologers
- **GET** `/astrologer-book.jsp` - Browse astrologers (alternative)

### Customer Dashboard
- **GET** `/customer/scholar/dashboard` - Customer scholar booking dashboard
  - Returns: `customer/scholars/UserDashboard.jsp`

### Booking Details (Service Selection)
- **GET** `/customer/scholar/booking-details?scholarId={id}` - View service packages
  - Parameters: `scholarId` (Long)
  - Returns: `customer/scholars/booking-details.jsp`
  - Shows: 3-step booking process (Select Package → Addons → Payment)

### Create Booking
- **POST** `/customer/scholar/create-booking` - Create booking from service selection
  - Content-Type: `application/json`
  - Body:
    ```json
    {
      "scholarId": 123,
      "serviceId": 456,
      "amount": 6200,
      "addons": {
        "flowers": true,
        "havan": false
      }
    }
    ```
  - Returns: JSON `{ "success": true, "bookingId": 789 }` or `{ "error": "message" }`

### Traditional Booking (Legacy)
- **GET** `/customer/scholar/book?scholarId={id}` - Show booking form (old method)
  - Parameters: `scholarId` (Long)
  - Returns: `customer/scholars/booking-form.jsp`
- **POST** `/customer/scholar/book` - Process booking (old method)
  - Parameters: `scholarId`, `serviceType`, `serviceDate`, `serviceLocation`, `serviceDescription`
  - Redirects to: `/customer/scholar/payment/initiate?bookingId={id}`

### Customer Chat
- **GET** `/customer/scholar/chat` - View chat with scholar
  - Parameters: `scholarId` (Long), `bookingId` (Long, optional)
  - Returns: `customer/scholars/chat.jsp`
- **POST** `/customer/scholar/chat/send` - Send message
  - Parameters: `scholarId`, `bookingId` (optional), `message`

### Customer Video Call
- **GET** `/customer/scholar/video-call?bookingId={id}` - Access video call
  - Parameters: `bookingId` (Long)
  - Returns: `customer/scholars/video-call.jsp`

### Booking Management (Customer)
- **POST** `/customer/scholar/booking/cancel` - Cancel booking
  - Parameters: `bookingId`, `reason` (optional)
  - Redirects to: `/customer/scholar/dashboard`
- **POST** `/customer/scholar/booking/reschedule` - Reschedule booking
  - Parameters: `bookingId`, `newServiceDate`
  - Redirects to: `/customer/scholar/dashboard`

### Search Scholars
- **GET** `/customer/scholar/search` - Search scholars
  - Parameters: `type` (optional), `specialization` (optional), `location` (optional), `minPrice` (optional), `maxPrice` (optional)
  - Returns: `customer/scholars/search-scholars.jsp`

---

## 9. Payment Endpoints (Customer)

### Initiate Payment
- **GET** `/customer/scholar/payment/initiate?bookingId={id}` - Show payment page
  - Parameters: `bookingId` (Long)
  - Returns: `customer/scholars/payment.jsp`
  - Initializes Razorpay order

### Payment Success
- **POST** `/customer/scholar/payment/success` - Handle payment success
  - Parameters: `razorpay_order_id`, `razorpay_payment_id`, `razorpay_signature`, `bookingId`
  - Returns: `customer/scholars/payment-success.jsp` or `customer/scholars/payment-failure.jsp`

### Payment History
- **GET** `/customer/scholar/payment/history` - View payment history
  - Returns: `customer/scholars/payment-history.jsp`

---

## 10. Review Endpoints (Customer)

### Submit Review
- **GET** `/customer/scholar/review/submit?bookingId={id}` - Show review form
  - Parameters: `bookingId` (Long)
  - Returns: `customer/scholars/review-form.jsp`
  - Note: Only for completed bookings
- **POST** `/customer/scholar/review/submit` - Submit/Update review
  - Parameters: `bookingId`, `rating`, `comment` (optional)
  - Redirects to: `/customer/scholar/dashboard`

### View Scholar Reviews
- **GET** `/customer/scholar/review/scholar?scholarId={id}` - View all reviews for a scholar
  - Parameters: `scholarId` (Long)
  - Returns: `customer/scholars/reviews.jsp`

---

## 11. Admin Endpoints

### Manage Scholars
- **GET** `/admin/scholars` - List all scholars
  - Returns: `admin/scholars/list.jsp`
- **GET** `/admin/scholars/view/{id}` - View scholar details
  - Parameters: `id` (Long, path variable)
  - Returns: `admin/scholars/view.jsp`
  - Shows: Statistics, Bookings, Payments, Reviews

### Approve/Reject Scholars
- **POST** `/admin/scholars/approve` - Approve scholar registration
  - Parameters: `scholarId` (Long)
  - Redirects to: `/admin/scholars`
- **POST** `/admin/scholars/reject` - Reject scholar registration
  - Parameters: `scholarId` (Long), `rejectionReason` (String)
  - Redirects to: `/admin/scholars`
- **POST** `/admin/scholars/hold` - Put scholar on hold
  - Parameters: `scholarId` (Long)
  - Redirects to: `/admin/scholars`

### Manage Bookings
- **GET** `/admin/scholars/bookings` - View all bookings
  - Returns: `admin/scholars/bookings.jsp`
- **GET** `/admin/scholars/bookings/view/{id}` - View booking details
  - Parameters: `id` (Long, path variable)
  - Returns: `admin/scholars/booking-details.jsp`
- **GET** `/admin/scholars/{scholarId}/bookings` - View bookings for specific scholar
  - Parameters: `scholarId` (Long, path variable)
  - Returns: `admin/scholars/scholar-bookings.jsp`

### Manage Payments
- **GET** `/admin/scholars/payments` - View all payments
  - Returns: `admin/scholars/payments.jsp`
- **GET** `/admin/scholars/payments/settle` - View pending settlements
  - Returns: `admin/scholars/payment-settlements.jsp`
- **POST** `/admin/scholars/payments/settle` - Settle payment to scholar
  - Parameters: `paymentId` (Long)
  - Redirects to: `/admin/scholars/payments/settle`
- **GET** `/admin/scholars/{scholarId}/payments` - View payments for specific scholar
  - Parameters: `scholarId` (Long, path variable)
  - Returns: `admin/scholars/scholar-payments.jsp`

### Manage Reviews
- **GET** `/admin/scholars/reviews` - View all reviews
  - Returns: `admin/scholars/reviews.jsp`
- **GET** `/admin/scholars/{scholarId}/reviews` - View reviews for specific scholar
  - Parameters: `scholarId` (Long, path variable)
  - Returns: `admin/scholars/scholar-reviews.jsp`

---

## 📝 URL Summary by Category

### Scholar URLs (Base: `/scholar`)
```
Authentication:
  GET/POST  /scholar/login
  GET       /scholar/logout
  GET/POST  /scholar/register/step1
  GET/POST  /scholar/register/step2
  GET       /scholar/register/success

Dashboard & Profile:
  GET       /scholar/dashboard
  GET/POST  /scholar/profile/edit
  POST      /scholar/availability
  GET       /scholar/reviews
  GET       /scholar/earnings

Service Management:
  GET       /scholar/service/list
  GET/POST  /scholar/service/add
  GET/POST  /scholar/service/edit
  POST      /scholar/service/delete
  POST      /scholar/service/toggle

Booking Management:
  POST      /scholar/booking/accept
  POST      /scholar/booking/reject
  POST      /scholar/booking/complete

Communication:
  GET       /scholar/chat
  POST      /scholar/chat/send
  GET       /scholar/video-call
```

### Customer URLs (Base: `/customer/scholar`)
```
Dashboard & Browsing:
  GET       /customer/scholar/dashboard
  GET       /book-scholar.jsp
  GET       /book-astrologer.jsp
  GET       /astrologer-book.jsp
  GET       /customer/scholar/search

Booking:
  GET       /customer/scholar/booking-details
  POST      /customer/scholar/create-booking
  GET/POST  /customer/scholar/book (legacy)
  POST      /customer/scholar/booking/cancel
  POST      /customer/scholar/booking/reschedule

Communication:
  GET       /customer/scholar/chat
  POST      /customer/scholar/chat/send
  GET       /customer/scholar/video-call

Payment:
  GET       /customer/scholar/payment/initiate
  POST      /customer/scholar/payment/success
  GET       /customer/scholar/payment/history

Reviews:
  GET/POST  /customer/scholar/review/submit
  GET       /customer/scholar/review/scholar
```

### Admin URLs (Base: `/admin/scholars`)
```
Scholar Management:
  GET       /admin/scholars
  GET       /admin/scholars/view/{id}
  POST      /admin/scholars/approve
  POST      /admin/scholars/reject
  POST      /admin/scholars/hold

Booking Management:
  GET       /admin/scholars/bookings
  GET       /admin/scholars/bookings/view/{id}
  GET       /admin/scholars/{scholarId}/bookings

Payment Management:
  GET       /admin/scholars/payments
  GET       /admin/scholars/payments/settle
  POST      /admin/scholars/payments/settle
  GET       /admin/scholars/{scholarId}/payments

Review Management:
  GET       /admin/scholars/reviews
  GET       /admin/scholars/{scholarId}/reviews
```

---

## 🔐 Authentication Requirements

### Scholar Endpoints
- **Requires**: Scholar login session (`userSession` in session)
- **Validation**: Scholar account must be `APPROVED`
- **Redirect**: `/scholar/login` if not authenticated

### Customer Endpoints
- **Requires**: Customer login session (`userSession` in session)
- **Redirect**: `/customer/login` if not authenticated

### Admin Endpoints
- **Requires**: Admin login session (`adminSession` in session)
- **Redirect**: `/admin/login` if not authenticated

---

## 📌 Important Notes

1. **Service Management**: New feature added for scholars to manage their service packages
2. **Booking Flow**: Two methods available:
   - **New**: Service-based booking via `/customer/scholar/booking-details`
   - **Legacy**: Direct booking via `/customer/scholar/book`
3. **Payment Integration**: Uses Razorpay for payment processing
4. **Chat System**: Only available for confirmed bookings
5. **Video Calls**: Only available for confirmed bookings
6. **Reviews**: Can only be submitted for completed bookings

---

## 🚀 Quick Reference

### Most Used URLs:

**For Scholars:**
- Login: `/scholar/login`
- Dashboard: `/scholar/dashboard`
- Service List: `/scholar/service/list`
- Add Service: `/scholar/service/add`
- Earnings: `/scholar/earnings`

**For Customers:**
- Browse: `/book-scholar.jsp`
- Booking Details: `/customer/scholar/booking-details?scholarId={id}`
- Dashboard: `/customer/scholar/dashboard`
- Payment: `/customer/scholar/payment/initiate?bookingId={id}`

**For Admins:**
- Scholar List: `/admin/scholars`
- Approve: `/admin/scholars/approve`
- View Scholar: `/admin/scholars/view/{id}`

---

**Last Updated**: Based on current implementation
**Version**: 1.0

