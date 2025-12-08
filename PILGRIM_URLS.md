# GlobalPiligrim - /pilgrim Routes Complete List

**Base URL**: `http://localhost:8081/pilgrim`

---

## 🚀 Quick Access

All routes below are prefixed with: `http://localhost:8081/pilgrim`

---

## ✈️ Travel Module Routes (`/pilgrim/travel`)

### Public Package Browsing
- `GET /travel/packages` - Browse all travel packages
- `GET /travel/view/{id}` - View package details
- `GET /travel/type/{type}` - Filter packages by type (ONE_DAY, MULTI_DAY, CITY_TOUR, TEMPLE_ONLY)
- `GET /travel/search` - Search packages
- `GET /travel/price` - Filter by price range

### Booking Routes (`/pilgrim/travel/booking`)
- `GET /travel/booking/user/create` - Create new booking
- `GET /travel/booking/user/transport/create` - Book transport separately
- `GET /travel/booking/user/guide/create` - Book guide separately
- `POST /travel/booking/user/details` - Submit booking details
- `POST /travel/booking/user/payment` - Process payment
- `POST /travel/booking/user/confirm` - Confirm booking
- `GET /travel/booking/user/success` - Booking success page
- `GET /travel/booking/status/{id}` - Check specific booking status
- `GET /travel/booking/status` - View all user bookings
- `GET /travel/booking/user/receipt/{id}` - View booking receipt
- `GET /travel/booking/user/payment/status` - Check payment status

### Travel Agency Routes (`/pilgrim/travel/agency`)
- `GET /travel/agency/register` - Agency registration page
- `POST /travel/agency/register` - Submit agency registration
- `POST /travel/agency/verify-otp` - Verify OTP for registration
- `GET /travel/agency/personal-details` - Personal details form
- `POST /travel/agency/personal-details` - Submit personal details
- `GET /travel/agency/gst-details` - GST details form
- `POST /travel/agency/gst-details` - Submit GST details
- `GET /travel/agency/bank-details` - Bank details form
- `POST /travel/agency/bank-details` - Submit bank details
- `GET /travel/agency/documents` - Documents upload page
- `POST /travel/agency/documents` - Submit documents
- `GET /travel/agency/dashboard` - Agency dashboard
- `GET /travel/agency/profile` - Agency profile page
- `POST /travel/agency/profile` - Update agency profile

### Package Management (`/pilgrim/travel/agency/package`)
- `GET /travel/agency/package/list` - List all packages
- `GET /travel/agency/package/details/{id}` - Package details
- `GET /travel/agency/package/add` - Add new package form
- `POST /travel/agency/package/add` - Submit new package
- `GET /travel/agency/package/edit/{id}` - Edit package form
- `POST /travel/agency/package/edit/{id}` - Update package
- `GET /travel/agency/package/delete/{id}` - Delete package

### Guide Management (`/pilgrim/travel/agency/guides`)
- `GET /travel/agency/guides/list` - List all guides
- `GET /travel/agency/guides/add` - Add guide form
- `POST /travel/agency/guides/add` - Submit new guide
- `GET /travel/agency/guides/edit/{id}` - Edit guide form
- `POST /travel/agency/guides/edit/{id}` - Update guide
- `GET /travel/agency/guides/details/{id}` - View guide details
- `GET /travel/agency/guides/delete/{id}` - Delete guide
- `POST /travel/agency/guides/book/{id}` - Book guide
- `POST /travel/agency/guides/release/{id}` - Release guide

### Transport Management (`/pilgrim/travel/agency/transport`)
- `GET /travel/agency/transport/list` - List all transport vehicles
- `GET /travel/agency/transport/add` - Add transport form
- `POST /travel/agency/transport/add` - Submit new transport
- `GET /travel/agency/transport/edit/{id}` - Edit transport form
- `POST /travel/agency/transport/edit/{id}` - Update transport
- `GET /travel/agency/transport/delete/{id}` - Delete transport
- `GET /travel/agency/transport/details/{id}` - View transport details
- `POST /travel/agency/transport/book/{id}` - Book transport
- `POST /travel/agency/transport/release/{id}` - Release transport

### Agency Booking Management
- `GET /travel/booking/agency/list` - List all agency bookings
- `GET /travel/booking/agency/details/{id}` - View booking details
- `POST /travel/booking/agency/update/{id}` - Update booking status

### Rating Routes (`/pilgrim/travel/rating`)
- `POST /travel/rating/{type}/{id}` - Submit rating (type: package, guide, transport)
- `GET /travel/rating/{type}/{id}/list` - View all ratings

---

## 🛕 Temple Module Routes (`/pilgrim/temple`)

### Public Temple Browsing
- `GET /temple` - List all temples
- `GET /temple/{id}` - View temple details
- `GET /temple/{id}/darshans` - View temple darshans
- `GET /temple/{id}/poojas` - View temple poojas
- `GET /temple/{id}/prasadhams` - View prasadham items
- `GET /temple/{id}/tour-guides` - View tour guides
- `GET /temple/{id}/festivals` - View festivals
- `GET /temple/{id}/events` - View events
- `GET /temple/{id}/gallery` - View photo gallery
- `GET /temple/{id}/map` - View temple map

### Booking Routes (`/pilgrim/temple/booking`)
- `GET /temple/booking/darshan/{darshanId}` - Book darshan page
- `GET /temple/booking/api/darshan/{darshanId}/available-seats` - Check available seats (API, requires date param)
- `POST /temple/booking/darshan/{darshanId}` - Submit darshan booking
- `GET /temple/booking/pooja/{poojaId}` - Book pooja page
- `POST /temple/booking/pooja/{poojaId}` - Submit pooja booking
- `GET /temple/booking/prasadham/{prasadhamId}` - Order prasadham page
- `POST /temple/booking/prasadham/{prasadhamId}` - Submit prasadham order
- `GET /temple/booking/tour-guide/{guideId}` - Book tour guide page
- `POST /temple/booking/tour-guide/{guideId}` - Submit tour booking

### Payment Routes (`/pilgrim/temple/payment`)
- `POST /temple/payment/darshan/{bookingId}/create-order` - Create Razorpay order for darshan
- `POST /temple/payment/darshan/{bookingId}/verify` - Verify darshan payment
- `POST /temple/payment/pooja/{bookingId}/create-order` - Create Razorpay order for pooja
- `POST /temple/payment/pooja/{bookingId}/verify` - Verify pooja payment
- `POST /temple/payment/prasadham/{orderId}/create-order` - Create Razorpay order for prasadham
- `POST /temple/payment/prasadham/{orderId}/verify` - Verify prasadham payment
- `POST /temple/payment/tour/{bookingId}/create-order` - Create Razorpay order for tour
- `POST /temple/payment/tour/{bookingId}/verify` - Verify tour payment

### Donation Routes (`/pilgrim/temple/donation`)
- `GET /temple/donation/{templeId}` - Donation form page
- `POST /temple/donation/{templeId}` - Submit donation
- `GET /temple/donation/success/{donationId}` - Donation success page

### User Dashboard Routes (`/pilgrim/temple/user`)
- `GET /temple/user/dashboard` - User dashboard (all bookings/orders)
- `GET /temple/user/profile` - User profile page
- `POST /temple/user/profile` - Update user profile
- `GET /temple/user/bookings` - View all bookings
- `GET /temple/user/bookings/darshan/{id}` - View darshan booking details
- `GET /temple/user/bookings/pooja/{id}` - View pooja booking details
- `GET /temple/user/bookings/tour/{id}` - View tour booking details
- `POST /temple/user/bookings/darshan/{id}/cancel` - Cancel darshan booking
- `POST /temple/user/bookings/pooja/{id}/cancel` - Cancel pooja booking
- `POST /temple/user/bookings/tour/{id}/cancel` - Cancel tour booking
- `GET /temple/user/orders` - View all prasadham orders
- `GET /temple/user/orders/prasadham/{id}` - View prasadham order details
- `POST /temple/user/orders/prasadham/{id}/cancel` - Cancel prasadham order
- `GET /temple/user/donations` - View all donations

### Temple Admin Routes (`/pilgrim/temple/admin`)
- `GET /temple/admin/dashboard` - Temple admin dashboard

#### Temple Management
- `GET /temple/admin/temple/add` - Add new temple form
- `POST /temple/admin/temple/add` - Submit new temple
- `GET /temple/admin/temple/{templeId}/edit` - Edit temple form
- `POST /temple/admin/temple/{templeId}/edit` - Update temple

#### Photo Management
- `GET /temple/admin/temple/{templeId}/photos` - View all photos
- `POST /temple/admin/temple/{templeId}/photos/add` - Upload new photo

#### Darshan Management
- `GET /temple/admin/temple/{templeId}/darshans` - View all darshans
- `POST /temple/admin/temple/{templeId}/darshans/add` - Add new darshan
- `GET /temple/admin/temple/{templeId}/darshans/{darshanId}/edit` - Edit darshan form
- `POST /temple/admin/temple/{templeId}/darshans/{darshanId}/edit` - Update darshan
- `POST /temple/admin/temple/{templeId}/darshans/{darshanId}/delete` - Delete darshan

#### Pooja Management
- `GET /temple/admin/temple/{templeId}/poojas` - View all poojas
- `POST /temple/admin/temple/{templeId}/poojas/add` - Add new pooja
- `GET /temple/admin/temple/{templeId}/poojas/{poojaId}/edit` - Edit pooja form
- `POST /temple/admin/temple/{templeId}/poojas/{poojaId}/edit` - Update pooja
- `POST /temple/admin/temple/{templeId}/poojas/{poojaId}/delete` - Delete pooja

#### Prasadham Management
- `GET /temple/admin/temple/{templeId}/prasadhams` - View all prasadhams
- `POST /temple/admin/temple/{templeId}/prasadhams/add` - Add new prasadham
- `GET /temple/admin/temple/{templeId}/prasadhams/{prasadhamId}/edit` - Edit prasadham form
- `POST /temple/admin/temple/{templeId}/prasadhams/{prasadhamId}/edit` - Update prasadham
- `POST /temple/admin/temple/{templeId}/prasadhams/{prasadhamId}/delete` - Delete prasadham

#### Festival Management
- `GET /temple/admin/temple/{templeId}/festivals` - View all festivals
- `POST /temple/admin/temple/{templeId}/festivals/add` - Add new festival
- `GET /temple/admin/temple/{templeId}/festivals/{festivalId}/edit` - Edit festival form
- `POST /temple/admin/temple/{templeId}/festivals/{festivalId}/edit` - Update festival
- `POST /temple/admin/temple/{templeId}/festivals/{festivalId}/delete` - Delete festival

#### Ritual Management
- `GET /temple/admin/temple/{templeId}/rituals` - View all rituals
- `POST /temple/admin/temple/{templeId}/rituals/add` - Add new ritual
- `GET /temple/admin/temple/{templeId}/rituals/{ritualId}/edit` - Edit ritual form
- `POST /temple/admin/temple/{templeId}/rituals/{ritualId}/edit` - Update ritual
- `POST /temple/admin/temple/{templeId}/rituals/{ritualId}/delete` - Delete ritual

#### Tour Guide Management
- `GET /temple/admin/temple/{templeId}/tour-guides` - View all tour guides
- `POST /temple/admin/temple/{templeId}/tour-guides/add` - Add new tour guide

#### Booking & Donation Management
- `GET /temple/admin/temple/{templeId}/bookings` - View all bookings for temple
- `GET /temple/admin/temple/{templeId}/donations` - View all donations for temple

### Location API Routes (`/pilgrim/temple/api/location`)
- `GET /temple/api/location/health` - Health check endpoint
- `GET /temple/api/location/countries` - Get all countries
- `GET /temple/api/location/states` - Get states (requires country param)
- `GET /temple/api/location/districts` - Get districts (requires state param)
- `GET /temple/api/location/pincodes` - Get pincodes (requires district param)

---

## 📊 Summary

### Total Routes under `/pilgrim`:
- **Travel Module**: ~40 routes
- **Temple Module**: ~70 routes
- **Total**: ~110 routes

### Route Categories:
1. **Public Browsing** - View packages, temples, services
2. **Booking** - Create bookings and orders
3. **Payment** - Payment processing via Razorpay
4. **User Dashboard** - Manage bookings, orders, profile
5. **Admin/Management** - Manage content (agencies, temples, services)
6. **API Endpoints** - JSON responses for AJAX calls

---

## 🔗 Full URL Examples

### Travel Module Examples:
```
http://localhost:8081/pilgrim/travel/packages
http://localhost:8081/pilgrim/travel/view/1
http://localhost:8081/pilgrim/travel/agency/register
http://localhost:8081/pilgrim/travel/agency/dashboard
http://localhost:8081/pilgrim/travel/booking/user/create
```

### Temple Module Examples:
```
http://localhost:8081/pilgrim/temple
http://localhost:8081/pilgrim/temple/1
http://localhost:8081/pilgrim/temple/booking/darshan/1
http://localhost:8081/pilgrim/temple/admin/dashboard
http://localhost:8081/pilgrim/temple/user/dashboard
http://localhost:8081/pilgrim/temple/donation/1
```

---

**Note**: All routes are currently public (no authentication required). Security can be added later based on requirements.

