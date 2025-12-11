# Project Architecture Understanding & Refactoring Plan

## 📋 What I Understood

### 1. **Main Landing Page (index.jsp)**
- **Location**: `src/main/webapp/WEB-INF/views/index.jsp`
- **Should Display**:
  - Random temples (featured/random selection)
  - Project aim/mission statement
  - Overview of all services
  - When user clicks on a temple → Show temple details with history

### 2. **Temple Admin Functionality**
- **One Temple Per Admin**: Each temple admin can manage ONLY ONE temple
- **Temple Admin Capabilities**:
  - ✅ Edit temple information
  - ✅ Upload images
  - ✅ Add/Edit/Delete Darshana
  - ✅ Add/Edit/Delete Pooja
  - ✅ Add/Edit/Delete Prasadham
  - ✅ Add/Edit/Delete Donation options
  - ✅ Add/Edit/Delete Rituals
  - ✅ Add/Edit/Delete Events
- **Religion-Based Content**: All sub-modules should adapt based on the temple's religion
- **Edit/Delete Buttons**: Temple admin should have edit/delete for every sub-module

### 3. **Temple Recommendations**
- Each temple should recommend related services:
  - Travel Packages
  - Travel Agencies
  - Pooja items
  - Tour Guides
  - Pandiths/Astrologers
  - Accommodations (nearby)
  - Other related services

### 4. **Unified User System**
- **Single Registration/Login**: Only ONE user registration and login system
- **User Flow**:
  - User registers once → Gets access to ALL services
  - User logs in → Lands on `index.jsp`
  - From index.jsp → User can access all services

### 5. **Services Page**
- **Purpose**: Allow users to access services separately (without going through temple)
- **Should Display**:
  - Pooja items
  - Pandiths/Astrologers
  - Vendors
  - Travel packages
  - Travel agencies
  - Accommodations
  - Tour guides
  - Other services
- **Functionality**: User can book/purchase services directly from this page

### 6. **Code Organization - CRITICAL**
- **Current Problem**: Too many controllers (40+ controllers)
- **Required Solution**:
  - **Temple Module**: Consolidate all temple-related controllers into 1-2 controllers max
    - Current: `TempleController`, `TempleAdminController`, `TempleUserController`, `TempleBookingController`, `TemplePaymentController`, `TempleDonationController`, `TempleLocationController`
    - Target: 1-2 controllers (e.g., `TempleController` for public, `TempleAdminController` for admin)
  - **Same pattern for other modules**:
    - Pooja Module: Consolidate
    - Travel Module: Consolidate
    - Accommodation Module: Consolidate
    - Scholar Module: Consolidate
  - **Entities & Services**: Also need consolidation (not just controllers)

---

## 🎯 Current Issues Identified

### Controller Count (40+ controllers):
```
Temple Module (7 controllers):
- TempleController
- TempleAdminController
- TempleUserController
- TempleBookingController
- TemplePaymentController
- TempleDonationController
- TempleLocationController

Pooja Module (3 controllers):
- PoojaAdminController
- PoojaCustomerController
- PoojaVendorController

Scholar Module (5 controllers):
- ScholarController
- ScholarAdminController
- ScholarCustomerController
- ScholarLoginController
- ScholarRegisterController

Travel Module (5 controllers):
- TravelAgencyController
- TravelPackageController
- TravelBookingController
- TravelRatingController
- UserTravelController

Accommodation Module (5 controllers):
- AccommodationHomeController
- AccommodationAuthController
- AccommodationPropertyController
- AccommodationUserController
- AccommodationAdminController

+ Many more...
```

### Authentication Issues:
- Multiple login systems:
  - `AuthController` (general)
  - `AccommodationAuthController`
  - `ScholarLoginController`
  - `CustomerLoginController`
  - `AdminLoginController`
  - `UserAuthController`
- Multiple registration systems

---

## ✅ Refactoring Plan

### Phase 1: Unified Authentication
1. **Single AuthController**:
   - Merge all login/registration into one controller
   - Support role-based redirects after login
   - Single session management

### Phase 2: Controller Consolidation

#### Temple Module:
- **TempleController** (Public):
  - List temples
  - View temple details
  - View temple history
  - Book services (darshan, pooja, prasadham, etc.)
  - View recommendations
  
- **TempleAdminController** (Admin only):
  - Dashboard
  - Edit temple info
  - Manage all sub-modules (CRUD for darshan, pooja, prasadham, donation, rituals, events)
  - Upload images
  - View bookings

#### Other Modules: Similar consolidation pattern

### Phase 3: Index.jsp Enhancement
1. Display random temples
2. Show project aim
3. Show services overview
4. Click temple → Show temple details with recommendations

### Phase 4: Services Page
1. Create unified services page
2. Display all services (pooja, pandiths, travels, etc.)
3. Allow direct booking/purchase

### Phase 5: Entity & Service Consolidation
1. Review and consolidate duplicate entities
2. Consolidate services where possible
3. Reduce code duplication

---

## 📝 Next Steps

1. **Confirm Understanding**: Review this document
2. **Prioritize**: Which phase to start first?
3. **Begin Refactoring**: Start with Phase 1 (Unified Auth) or Phase 2 (Controller Consolidation)?

---

## ❓ Questions for Clarification

1. Should temple admin be able to switch between multiple temples, or strictly one temple per admin?
2. For services page - should it show ALL services from ALL vendors, or filtered by location/religion?
3. Should recommendations be automatic (based on temple religion/location) or manually curated by temple admin?
4. For controller consolidation - should we maintain separate admin controllers, or merge admin functions into main controllers with role checks?

