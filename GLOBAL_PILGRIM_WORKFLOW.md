# GlobalPiligrim - Complete Workflow Documentation

## 📋 Table of Contents
1. [Project Overview](#project-overview)
2. [Architecture](#architecture)
3. [User Roles & Authentication](#user-roles--authentication)
4. [Module Workflows](#module-workflows)
5. [Admin Dashboard](#admin-dashboard)
6. [Technical Stack](#technical-stack)
7. [Database Structure](#database-structure)
8. [API Endpoints](#api-endpoints)

---

## 🎯 Project Overview

**GlobalPiligrim** is a comprehensive multi-module pilgrimage management platform that integrates:
- **Pooja Items Module** - Religious items marketplace
- **Scholar/Astrologer Module** - Consultation booking system
- **Accommodation Module** - Property booking platform
- **Travel/Pilgrimage Package Module** - Travel agency management
- **Temple Module** - Temple services (Darshan, Pooja, Prasadham, Tours, Donations)

### Key Features
- Multi-religion support (Hindu, Christian, Muslim, Jain, Buddhist)
- Unified user management across all modules
- Centralized admin dashboard
- Payment integration (Razorpay)
- Email notifications & OTP verification
- File upload management
- Real-time chat (Scholar consultations)

---

## 🏗️ Architecture

### Technology Stack
- **Framework**: Spring Boot 3.2.0
- **Java Version**: 17
- **View Technologies**: JSP (primary), Thymeleaf (Temple module)
- **Database**: MySQL (via JPA/Hibernate)
- **Security**: Spring Security
- **Build Tool**: Maven
- **Payment Gateway**: Razorpay

### Project Structure
```
GlobalPiligrim/
├── src/main/java/com/pilgrim/
│   ├── config/          # Configuration classes
│   ├── controller/      # MVC Controllers (48+ controllers)
│   ├── entity/          # JPA Entities (59+ entities)
│   ├── enums/           # Enum definitions (34 enums)
│   ├── repository/      # Spring Data JPA Repositories (59+ repos)
│   ├── service/         # Business Logic Layer (48+ services)
│   └── util/            # Utility classes
├── src/main/webapp/
│   └── WEB-INF/views/   # JSP templates
└── src/main/resources/
    └── templates/       # Thymeleaf templates (Temple module)
```

---

## 👥 User Roles & Authentication

### User Roles (UserRole Enum)
1. **CUSTOMER** - General customer for all modules
2. **SCHOLAR** - Religious scholar/astrologer
3. **VENDOR** - Pooja items vendor
4. **ADMIN** - System administrator
5. **PROPERTY_OWNER** - Accommodation property owner
6. **PILGRIM** - Accommodation guest (same as CUSTOMER)
7. **TEMPLE_ADMIN** - Temple administrator
8. **TOUR_GUIDE** - Tour guide

### Authentication Flow

#### 1. User Registration
```
User Registration Flow:
├── User fills registration form
├── OTP sent to email
├── User verifies OTP
├── Account created with role=CUSTOMER
└── Email verification required
```

#### 2. Module-Specific Registration
- **Scholar Registration**: `/scholar/register` → Admin approval required
- **Vendor Registration**: `/pooja/vendor/register` → Admin approval required
- **Property Owner**: `/accommodation/register` → Direct access
- **Travel Agency**: `/pilgrim/travel/register` → Admin approval required
- **Temple Admin**: `/pilgrim/temple-admin/register` → Admin approval required

#### 3. Login Flow
```
Login Process:
├── User enters email/password
├── System validates credentials
├── Check user role and module access
├── Create session with user details
└── Redirect to appropriate dashboard
```

### Session Management
- Uses `HttpSession` for state management
- Session attributes: `userSession`, `userId`, `userName`, `userEmail`
- Module-specific sessions: `scholarId`, `vendorId`, `propertyOwnerId`, etc.

---

## 🔄 Module Workflows

### 1. Pooja Items Module

#### Vendor Workflow
```
1. Vendor Registration
   └── Submit business details → Admin approval → Vendor dashboard access

2. Product Management
   ├── Add Pooja Items (name, category, price, stock, image)
   ├── Update inventory
   └── View orders

3. Order Processing
   ├── Receive customer orders
   ├── Update order status (PENDING → CONFIRMED → SHIPPED → DELIVERED)
   └── Process payments
```

#### Customer Workflow
```
1. Browse Pooja Items
   └── Filter by category, vendor, price

2. Shopping Cart
   ├── Add items to cart
   └── Proceed to checkout

3. Order Placement
   ├── Enter delivery address
   ├── Select payment method
   ├── Place order
   └── Receive order confirmation

4. Order Tracking
   └── View order status and tracking
```

**Key Routes:**
- `/pooja/**` - Public access
- `/pooja/vendor/**` - Vendor dashboard
- `/pooja/admin/**` - Admin management

---

### 2. Scholar/Astrologer Module

#### Scholar Workflow
```
1. Scholar Registration
   └── Submit credentials → Admin approval → Scholar dashboard

2. Profile Management
   ├── Set consultation fees
   ├── Set availability
   └── Update bio and specialties

3. Consultation Management
   ├── Receive booking requests
   ├── Accept/Reject bookings
   ├── Conduct chat consultations
   └── Mark consultations as completed
```

#### Customer Workflow
```
1. Browse Scholars
   └── Search by specialty, rating, language

2. Book Consultation
   ├── Select date/time
   ├── Make payment
   └── Receive confirmation

3. Chat Consultation
   ├── Real-time chat with scholar
   └── Get answers to questions

4. Review & Rating
   └── Rate and review scholar after consultation
```

**Key Routes:**
- `/scholar/**` - Scholar management
- `/scholar/customer/**` - Customer bookings

---

### 3. Accommodation Module

#### Property Owner Workflow
```
1. Property Registration
   └── Add property details, photos, rooms, amenities

2. Property Management
   ├── Update availability
   ├── Set pricing
   └── Manage bookings

3. Booking Management
   ├── View booking requests
   ├── Accept/Reject bookings
   └── Process check-ins/check-outs
```

#### Guest/Pilgrim Workflow
```
1. Search Properties
   └── Filter by location, dates, amenities, price

2. Book Accommodation
   ├── Select property and room
   ├── Enter guest details
   ├── Make payment
   └── Receive booking confirmation

3. Booking Management
   ├── View bookings
   ├── Cancel bookings (if allowed)
   └── Check-in/Check-out
```

**Key Routes:**
- `/accommodation/**` - Public access
- `/accommodation/owner/**` - Property owner dashboard
- `/accommodation/admin/**` - Admin management

---

### 4. Travel/Pilgrimage Package Module

#### Travel Agency Workflow
```
1. Agency Registration
   └── Submit business details → Admin approval → Agency dashboard

2. Package Management
   ├── Create travel packages
   ├── Add packages (ONE_DAY, MULTI_DAY, CITY_TOUR, TEMPLE_ONLY)
   ├── Set pricing and itinerary
   └── Manage availability

3. Guide & Transport Management
   ├── Add tour guides
   ├── Add transport vehicles
   └── Assign to packages

4. Booking Management
   ├── View bookings
   ├── Confirm bookings
   └── Process payments
```

#### Customer Workflow
```
1. Browse Packages
   └── Search by destination, type, price

2. Book Package
   ├── Select package and dates
   ├── Enter traveler details
   ├── Make payment
   └── Receive booking confirmation

3. Booking Management
   ├── View bookings
   ├── Cancel bookings
   └── Rate packages
```

**Key Routes:**
- `/pilgrim/travel/**` - Public access
- `/pilgrim/travel/agency/**` - Agency dashboard

---

### 5. Temple Module

#### Temple Admin Workflow
```
1. Temple Registration
   └── Create temple profile → Admin approval

2. Temple Management
   ├── Update temple information
   ├── Add photos (INTERIOR, EXTERIOR, SCULPTURE)
   ├── Manage rituals
   ├── Add festivals
   └── Add events

3. Service Management
   ├── Darshan Management
   │   ├── Create darshan types
   │   ├── Set pricing and time slots
   │   └── Manage bookings
   ├── Pooja Management
   │   ├── Add temple poojas
   │   ├── Set pricing
   │   └── Manage bookings
   ├── Prasadham Management
   │   ├── Add prasadham items
   │   ├── Set pricing and stock
   │   └── Manage orders
   ├── Tour Guide Management
   │   ├── Add tour guides
   │   ├── Set rates
   │   └── Manage bookings
   └── Donation Management
       └── View and process donations
```

#### Customer Workflow
```
1. Browse Temples
   └── Search by religion, location, name

2. Temple Services
   ├── Book Darshan
   │   ├── Select date and time slot
   │   ├── Enter devotee details
   │   ├── Make payment
   │   └── Receive booking confirmation
   ├── Book Pooja
   │   ├── Select pooja and date
   │   ├── Enter devotee details (gotra, nakshatra, rashi)
   │   ├── Make payment
   │   └── Receive booking confirmation
   ├── Order Prasadham
   │   ├── Select prasadham items
   │   ├── Choose delivery option
   │   ├── Make payment
   │   └── Receive order confirmation
   ├── Book Tour Guide
   │   ├── Select guide and tour type
   │   ├── Select date and time
   │   ├── Make payment
   │   └── Receive booking confirmation
   └── Make Donation
       ├── Select donation type
       ├── Enter amount and purpose
       ├── Make payment
       └── Receive receipt
```

**Key Routes:**
- `/pilgrim/temple/**` - Public temple browsing
- `/pilgrim/temple/admin/**` - Temple admin dashboard
- `/pilgrim/temple/user/**` - User bookings dashboard
- `/pilgrim/temple/booking/**` - Booking pages
- `/pilgrim/temple/payment/**` - Payment processing
- `/pilgrim/temple/donation/**` - Donation pages

---

## 🎛️ Admin Dashboard

### Unified Admin Dashboard (`/admin/dashboard`)

The admin dashboard provides a centralized view of all modules:

#### Statistics Displayed
1. **Scholar Module**
   - Total Scholars
   - Pending Approvals
   - Total Users

2. **Pooja Module**
   - Total Vendors
   - Pending Vendor Approvals
   - Total Pooja Items
   - Total Orders

3. **Accommodation Module**
   - Total Properties
   - Pending Property Approvals
   - Total Users
   - Total Bookings
   - Pending Complaints
   - Pending Refunds
   - Pending Payouts

4. **Travel Module**
   - Total Travel Agencies
   - Pending Agency Approvals
   - Total Packages
   - Total Bookings
   - Total Guides
   - Total Transport

5. **Temple Module**
   - Total Temples
   - Total Darshan Bookings
   - Total Pooja Bookings
   - Total Prasadham Orders
   - Total Tour Bookings
   - Total Donations

#### Quick Actions
- Manage Scholars
- Manage Vendors
- Manage Properties
- Manage Travel Agencies
- Manage Temples
- View All Bookings/Orders
- Support Tickets
- User Management

---

## 💳 Payment Processing

### Payment Flow
```
1. User initiates payment
   └── Selects payment method (Razorpay)

2. Create Payment Order
   ├── Generate order ID
   ├── Set amount and currency
   └── Return payment details to frontend

3. User completes payment
   ├── Razorpay payment gateway
   └── Payment success/failure callback

4. Verify Payment
   ├── Verify payment signature
   ├── Update booking/order status
   └── Send confirmation email
```

### Payment Status Flow
- **PENDING** → Payment not initiated
- **PAID/SUCCESS** → Payment successful, booking confirmed
- **FAILED** → Payment failed, booking remains pending

---

## 📧 Email & Notifications

### Email Services
1. **OTP Verification**
   - Registration OTP
   - Password reset OTP
   - Email verification

2. **Booking Confirmations**
   - Order confirmations
   - Booking confirmations
   - Payment receipts

3. **Notifications**
   - Admin approval notifications
   - Booking status updates
   - Payment confirmations

---

## 🗄️ Database Structure

### Key Entity Relationships

#### User Entity (Central)
- Unified user table for all modules
- Role-based access control
- Supports multiple module participation

#### Module-Specific Entities
- **Pooja**: Vendor, PoojaItem, PoojaOrder, PoojaCart
- **Scholar**: Scholar, ScholarBooking, ScholarChat, ScholarPayment, ScholarReview
- **Accommodation**: Property, Room, AccommodationBooking, AccommodationUser
- **Travel**: TravelAgency, TravelPackage, TravelBooking, Guide, Transport
- **Temple**: Temple, Darshan, DarshanBooking, TemplePooja, PoojaBooking, Prasadham, PrasadhamOrder, TourGuide, TourBooking, TempleDonation

### Common Patterns
- All entities have `createdAt` and `updatedAt` timestamps
- Soft deletes using `isActive` flags
- Status enums for workflow management
- Payment integration fields

---

## 🔐 Security Configuration

### Security Setup
- **Password Encoding**: BCrypt
- **Session Management**: IF_REQUIRED
- **CSRF**: Disabled (can be enabled for production)
- **Public Routes**: All module routes are currently public (can be secured)

### Route Permissions
```java
// Public routes
"/", "/index", "/home" - Landing pages
"/register", "/login" - Authentication
"/pooja/**" - Pooja module
"/accommodation/**" - Accommodation module
"/pilgrim/travel/**" - Travel module
"/pilgrim/temple/**" - Temple module
"/admin/**" - Admin dashboard (currently public)
```

---

## 🚀 Deployment & Configuration

### Application Properties
- Database connection settings
- File upload directory: `C:/pilgrim-uploads/`
- Razorpay keys configuration
- Email SMTP settings

### Build & Run
```bash
# Build project
mvn clean install

# Run application
mvn spring-boot:run

# Or deploy WAR file to Tomcat
```

---

## 📊 Key Features Summary

### Multi-Module Integration
✅ Unified user management
✅ Centralized admin dashboard
✅ Cross-module navigation
✅ Shared payment gateway
✅ Unified email service

### Module-Specific Features
✅ Pooja: Shopping cart, vendor management
✅ Scholar: Real-time chat, consultation booking
✅ Accommodation: Property search, booking management
✅ Travel: Package management, guide assignment
✅ Temple: Multi-service booking, donation management

### Admin Features
✅ Module-wise statistics
✅ Approval workflows
✅ User management
✅ Support ticket system
✅ Audit logging

---

## 🔄 Typical User Journey

### Example: Complete Pilgrimage Planning
```
1. User Registration
   └── Create account as CUSTOMER

2. Book Accommodation
   ├── Search properties near temple
   ├── Book room for pilgrimage dates
   └── Make payment

3. Book Temple Services
   ├── Browse temples
   ├── Book Darshan for specific date
   ├── Book Pooja ceremony
   ├── Order Prasadham for delivery
   └── Book tour guide

4. Book Travel Package
   ├── Browse travel packages
   ├── Book multi-day pilgrimage package
   └── Make payment

5. Consult Scholar
   ├── Browse scholars
   ├── Book consultation
   ├── Chat with scholar
   └── Get guidance

6. Order Pooja Items
   ├── Browse items
   ├── Add to cart
   ├── Place order
   └── Track delivery

7. Make Donation
   └── Donate to temple

8. View All Bookings
   └── Unified dashboard showing all bookings
```

---

## 📝 Notes

### Current Implementation Status
- ✅ All modules integrated
- ✅ Unified admin dashboard
- ✅ Payment integration
- ✅ Email notifications
- ✅ File uploads
- ⚠️ Security: Currently all routes are public (needs role-based security)
- ⚠️ Templates: Temple module uses Thymeleaf, others use JSP

### Future Enhancements
- Role-based security implementation
- API documentation (Swagger)
- Mobile app integration
- Advanced analytics
- Multi-language support
- Real-time notifications

---

## 📞 Support & Maintenance

### Admin Functions
- User management (block/unblock)
- Module approvals
- Support ticket resolution
- Audit log viewing
- System settings management

### Error Handling
- Global exception handler
- User-friendly error messages
- Logging for debugging

---

**Last Updated**: Based on current codebase integration
**Version**: 1.0.0
**Maintained By**: Development Team

