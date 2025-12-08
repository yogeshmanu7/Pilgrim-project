# GlobalPiligrim - Complete URL List

**Base URL**: `http://localhost:8081`

---

## 🏠 Landing Pages & Public Routes

### Home & General
- `GET /` - Home/Index page
- `GET /home` - Home page
- `GET /aboutus` - About Us page
- `GET /contactus` - Contact Us page
- `GET /services` - Services page
- `GET /privacy` - Privacy Policy
- `GET /terms` - Terms & Conditions

---

## 🔐 Authentication Routes

### General Authentication
- `GET /register` - User registration page
- `POST /register` - Submit registration
- `GET /login` - Login page
- `POST /login` - Submit login
- `GET /login-user` - User login page
- `POST /login-user` - User login submit
- `GET /otp-verify` - OTP verification page
- `POST /verify-otp` - Verify OTP
- `POST /save-user` - Save user after OTP verification
- `GET /logout` - Logout

### Auth API
- `POST /auth/**` - Authentication API endpoints
- `POST /api/auth/**` - Authentication API
- `GET /api/public/**` - Public API endpoints

---

## 📿 Pooja Items Module

### Public/Customer Routes
- `GET /pooja` - Pooja items index
- `GET /pooja/**` - All pooja public routes

### Customer Routes
- `GET /pooja/customer/**` - Customer dashboard and shopping

### Vendor Routes
- `GET /pooja/vendor/**` - Vendor dashboard
- `POST /pooja/vendor/**` - Vendor actions

### Admin Routes
- `GET /admin/pooja/vendors` - View all vendors
- `GET /admin/pooja/vendors/pending` - Pending vendor approvals
- `POST /admin/pooja/vendors/approve/{id}` - Approve vendor
- `POST /admin/pooja/vendors/reject/{id}` - Reject vendor
- `GET /admin/pooja/items` - View all pooja items
- `POST /admin/pooja/items/block/{id}` - Block item
- `POST /admin/pooja/items/unblock/{id}` - Unblock item
- `GET /admin/pooja/orders` - View all orders

---

## 🎓 Scholar/Astrologer Module

### Public Routes
- `GET /scholar/**` - Scholar browsing and search

### Scholar Routes
- `GET /scholar/register` - Scholar registration
- `POST /scholar/register` - Submit scholar registration
- `GET /scholar/login` - Scholar login
- `POST /scholar/login` - Scholar login submit
- `GET /scholar/logout` - Scholar logout
- `GET /scholar/dashboard` - Scholar dashboard

### Customer Routes
- `GET /scholar/customer/**` - Customer booking and consultation

### Admin Routes
- `GET /admin/scholar/**` - Scholar management

---

## 🏨 Accommodation Module

### Public Routes
- `GET /accommodation/**` - All accommodation public routes

### Home & Search
- `GET /accommodation` - Accommodation home
- `GET /accommodation/search` - Search properties
- `GET /accommodation/property/{id}` - View property details

### Authentication
- `GET /accommodation/register` - Register (owner/guest)
- `POST /accommodation/register` - Submit registration
- `GET /accommodation/login` - Login
- `POST /accommodation/login` - Submit login

### Property Owner Routes
- `GET /accommodation/owner/**` - Owner dashboard
- `POST /accommodation/owner/**` - Owner actions

### Guest/Pilgrim Routes
- `GET /accommodation/guest/**` - Guest dashboard
- `POST /accommodation/guest/**` - Guest booking actions

### Admin Routes
- `GET /admin/accommodation/properties` - View all properties
- `GET /admin/accommodation/property/{id}` - View property details
- `POST /admin/accommodation/property/{id}/approve` - Approve property
- `POST /admin/accommodation/property/{id}/reject` - Reject property
- `POST /admin/accommodation/property/{id}/hold` - Hold property
- `POST /admin/accommodation/property/{id}/activate` - Activate property
- `POST /admin/accommodation/property/{id}/deactivate` - Deactivate property
- `GET /admin/accommodation/users` - View all users
- `POST /admin/accommodation/user/{id}/ban` - Ban user
- `POST /admin/accommodation/user/{id}/unban` - Unban user
- `GET /admin/accommodation/bookings` - View all bookings
- `POST /admin/accommodation/booking/{id}/approve` - Approve booking
- `POST /admin/accommodation/booking/{id}/reject` - Reject booking
- `GET /admin/accommodation/complaints` - View complaints
- `POST /admin/accommodation/complaint/{id}/resolve` - Resolve complaint
- `GET /admin/accommodation/refunds` - View refunds
- `POST /admin/accommodation/refund/{id}/approve` - Approve refund
- `GET /admin/accommodation/payouts` - View payouts
- `POST /admin/accommodation/payout/{id}/approve` - Approve payout

---

## ✈️ Travel/Pilgrimage Package Module

### Public Routes
- `GET /pilgrim/travel/**` - All travel public routes

### User/Customer Routes
- `GET /pilgrim/travel/packages` - Browse travel packages
- `GET /pilgrim/travel/view/{id}` - View package details
- `GET /pilgrim/travel/type/{type}` - Filter by type
- `GET /pilgrim/travel/search` - Search packages
- `GET /pilgrim/travel/price` - Filter by price

### Booking Routes
- `GET /pilgrim/travel/booking/user/create` - Create booking
- `GET /pilgrim/travel/booking/user/transport/create` - Book transport
- `GET /pilgrim/travel/booking/user/guide/create` - Book guide
- `POST /pilgrim/travel/booking/user/details` - Submit booking details
- `POST /pilgrim/travel/booking/user/payment` - Process payment
- `POST /pilgrim/travel/booking/user/confirm` - Confirm booking
- `GET /pilgrim/travel/booking/user/success` - Booking success page
- `GET /pilgrim/travel/booking/status/{id}` - Check booking status
- `GET /pilgrim/travel/booking/status` - View all bookings
- `GET /pilgrim/travel/booking/user/receipt/{id}` - View receipt
- `GET /pilgrim/travel/booking/user/payment/status` - Payment status

### Travel Agency Routes
- `GET /pilgrim/travel/agency/register` - Agency registration
- `POST /pilgrim/travel/agency/register` - Submit registration
- `POST /pilgrim/travel/agency/verify-otp` - Verify OTP
- `GET /pilgrim/travel/agency/personal-details` - Personal details form
- `POST /pilgrim/travel/agency/personal-details` - Submit personal details
- `GET /pilgrim/travel/agency/gst-details` - GST details form
- `POST /pilgrim/travel/agency/gst-details` - Submit GST details
- `GET /pilgrim/travel/agency/bank-details` - Bank details form
- `POST /pilgrim/travel/agency/bank-details` - Submit bank details
- `GET /pilgrim/travel/agency/documents` - Documents upload
- `POST /pilgrim/travel/agency/documents` - Submit documents
- `GET /pilgrim/travel/agency/dashboard` - Agency dashboard
- `GET /pilgrim/travel/agency/profile` - Agency profile
- `POST /pilgrim/travel/agency/profile` - Update profile

### Package Management (Agency)
- `GET /pilgrim/travel/agency/package/list` - List packages
- `GET /pilgrim/travel/agency/package/details/{id}` - Package details
- `GET /pilgrim/travel/agency/package/add` - Add package form
- `POST /pilgrim/travel/agency/package/add` - Submit new package
- `GET /pilgrim/travel/agency/package/edit/{id}` - Edit package form
- `POST /pilgrim/travel/agency/package/edit/{id}` - Update package
- `GET /pilgrim/travel/agency/package/delete/{id}` - Delete package

### Guide Management (Agency)
- `GET /pilgrim/travel/agency/guides/list` - List guides
- `GET /pilgrim/travel/agency/guides/add` - Add guide form
- `POST /pilgrim/travel/agency/guides/add` - Submit new guide
- `GET /pilgrim/travel/agency/guides/edit/{id}` - Edit guide form
- `POST /pilgrim/travel/agency/guides/edit/{id}` - Update guide
- `GET /pilgrim/travel/agency/guides/details/{id}` - Guide details
- `GET /pilgrim/travel/agency/guides/delete/{id}` - Delete guide
- `POST /pilgrim/travel/agency/guides/book/{id}` - Book guide
- `POST /pilgrim/travel/agency/guides/release/{id}` - Release guide

### Transport Management (Agency)
- `GET /pilgrim/travel/agency/transport/list` - List transport
- `GET /pilgrim/travel/agency/transport/add` - Add transport form
- `POST /pilgrim/travel/agency/transport/add` - Submit new transport
- `GET /pilgrim/travel/agency/transport/edit/{id}` - Edit transport form
- `POST /pilgrim/travel/agency/transport/edit/{id}` - Update transport
- `GET /pilgrim/travel/agency/transport/delete/{id}` - Delete transport
- `GET /pilgrim/travel/agency/transport/details/{id}` - Transport details
- `POST /pilgrim/travel/agency/transport/book/{id}` - Book transport
- `POST /pilgrim/travel/agency/transport/release/{id}` - Release transport

### Booking Management (Agency)
- `GET /pilgrim/travel/booking/agency/list` - List bookings
- `GET /pilgrim/travel/booking/agency/details/{id}` - Booking details
- `POST /pilgrim/travel/booking/agency/update/{id}` - Update booking

### Rating Routes
- `POST /pilgrim/travel/rating/{type}/{id}` - Submit rating
- `GET /pilgrim/travel/rating/{type}/{id}/list` - View ratings

### Admin Routes
- `GET /admin/travel/agencies/pending` - Pending agency approvals
- `GET /admin/travel/agencies/view/{id}` - View agency details
- `POST /admin/travel/agencies/approve/{id}` - Approve agency
- `POST /admin/travel/agencies/reject/{id}` - Reject agency
- `GET /admin/travel/agencies/approval` - Approval list
- `GET /admin/travel/packages` - View all packages
- `GET /admin/travel/bookings` - View all bookings
- `GET /admin/travel/guides` - View all guides
- `GET /admin/travel/transport` - View all transport

---

## 🛕 Temple Module

### Public Routes
- `GET /pilgrim/temple` - List all temples
- `GET /pilgrim/temple/{id}` - View temple details
- `GET /pilgrim/temple/{id}/darshans` - View darshans
- `GET /pilgrim/temple/{id}/poojas` - View poojas
- `GET /pilgrim/temple/{id}/prasadhams` - View prasadhams
- `GET /pilgrim/temple/{id}/tour-guides` - View tour guides
- `GET /pilgrim/temple/{id}/festivals` - View festivals
- `GET /pilgrim/temple/{id}/events` - View events
- `GET /pilgrim/temple/{id}/gallery` - View gallery
- `GET /pilgrim/temple/{id}/map` - View map

### Booking Routes
- `GET /pilgrim/temple/booking/darshan/{darshanId}` - Book darshan page
- `GET /pilgrim/temple/booking/api/darshan/{darshanId}/available-seats` - Check available seats (API)
- `POST /pilgrim/temple/booking/darshan/{darshanId}` - Submit darshan booking
- `GET /pilgrim/temple/booking/pooja/{poojaId}` - Book pooja page
- `POST /pilgrim/temple/booking/pooja/{poojaId}` - Submit pooja booking
- `GET /pilgrim/temple/booking/prasadham/{prasadhamId}` - Order prasadham page
- `POST /pilgrim/temple/booking/prasadham/{prasadhamId}` - Submit prasadham order
- `GET /pilgrim/temple/booking/tour-guide/{guideId}` - Book tour guide page
- `POST /pilgrim/temple/booking/tour-guide/{guideId}` - Submit tour booking

### Payment Routes
- `POST /pilgrim/temple/payment/darshan/{bookingId}/create-order` - Create darshan payment order
- `POST /pilgrim/temple/payment/darshan/{bookingId}/verify` - Verify darshan payment
- `POST /pilgrim/temple/payment/pooja/{bookingId}/create-order` - Create pooja payment order
- `POST /pilgrim/temple/payment/pooja/{bookingId}/verify` - Verify pooja payment
- `POST /pilgrim/temple/payment/prasadham/{orderId}/create-order` - Create prasadham payment order
- `POST /pilgrim/temple/payment/prasadham/{orderId}/verify` - Verify prasadham payment
- `POST /pilgrim/temple/payment/tour/{bookingId}/create-order` - Create tour payment order
- `POST /pilgrim/temple/payment/tour/{bookingId}/verify` - Verify tour payment

### Donation Routes
- `GET /pilgrim/temple/donation/{templeId}` - Donation page
- `POST /pilgrim/temple/donation/{templeId}` - Submit donation
- `GET /pilgrim/temple/donation/success/{donationId}` - Donation success page

### User Dashboard Routes
- `GET /pilgrim/temple/user/dashboard` - User dashboard
- `GET /pilgrim/temple/user/profile` - User profile
- `POST /pilgrim/temple/user/profile` - Update profile
- `GET /pilgrim/temple/user/bookings` - View all bookings
- `GET /pilgrim/temple/user/bookings/darshan/{id}` - View darshan booking
- `GET /pilgrim/temple/user/bookings/pooja/{id}` - View pooja booking
- `GET /pilgrim/temple/user/bookings/tour/{id}` - View tour booking
- `POST /pilgrim/temple/user/bookings/darshan/{id}/cancel` - Cancel darshan booking
- `POST /pilgrim/temple/user/bookings/pooja/{id}/cancel` - Cancel pooja booking
- `GET /pilgrim/temple/user/orders` - View all orders
- `GET /pilgrim/temple/user/orders/prasadham/{id}` - View prasadham order
- `POST /pilgrim/temple/user/orders/prasadham/{id}/cancel` - Cancel prasadham order
- `GET /pilgrim/temple/user/donations` - View all donations

### Temple Admin Routes
- `GET /pilgrim/temple/admin/dashboard` - Temple admin dashboard
- `GET /pilgrim/temple/admin/temple/add` - Add temple form
- `POST /pilgrim/temple/admin/temple/add` - Submit new temple
- `GET /pilgrim/temple/admin/temple/{templeId}/edit` - Edit temple form
- `POST /pilgrim/temple/admin/temple/{templeId}/edit` - Update temple

#### Photo Management
- `GET /pilgrim/temple/admin/temple/{templeId}/photos` - View photos
- `POST /pilgrim/temple/admin/temple/{templeId}/photos/add` - Add photo

#### Darshan Management
- `GET /pilgrim/temple/admin/temple/{templeId}/darshans` - View darshans
- `POST /pilgrim/temple/admin/temple/{templeId}/darshans/add` - Add darshan
- `GET /pilgrim/temple/admin/temple/{templeId}/darshans/{darshanId}/edit` - Edit darshan
- `POST /pilgrim/temple/admin/temple/{templeId}/darshans/{darshanId}/edit` - Update darshan
- `POST /pilgrim/temple/admin/temple/{templeId}/darshans/{darshanId}/delete` - Delete darshan

#### Pooja Management
- `GET /pilgrim/temple/admin/temple/{templeId}/poojas` - View poojas
- `POST /pilgrim/temple/admin/temple/{templeId}/poojas/add` - Add pooja
- `GET /pilgrim/temple/admin/temple/{templeId}/poojas/{poojaId}/edit` - Edit pooja
- `POST /pilgrim/temple/admin/temple/{templeId}/poojas/{poojaId}/edit` - Update pooja
- `POST /pilgrim/temple/admin/temple/{templeId}/poojas/{poojaId}/delete` - Delete pooja

#### Prasadham Management
- `GET /pilgrim/temple/admin/temple/{templeId}/prasadhams` - View prasadhams
- `POST /pilgrim/temple/admin/temple/{templeId}/prasadhams/add` - Add prasadham
- `GET /pilgrim/temple/admin/temple/{templeId}/prasadhams/{prasadhamId}/edit` - Edit prasadham
- `POST /pilgrim/temple/admin/temple/{templeId}/prasadhams/{prasadhamId}/edit` - Update prasadham
- `POST /pilgrim/temple/admin/temple/{templeId}/prasadhams/{prasadhamId}/delete` - Delete prasadham

#### Festival Management
- `GET /pilgrim/temple/admin/temple/{templeId}/festivals` - View festivals
- `POST /pilgrim/temple/admin/temple/{templeId}/festivals/add` - Add festival
- `GET /pilgrim/temple/admin/temple/{templeId}/festivals/{festivalId}/edit` - Edit festival
- `POST /pilgrim/temple/admin/temple/{templeId}/festivals/{festivalId}/edit` - Update festival
- `POST /pilgrim/temple/admin/temple/{templeId}/festivals/{festivalId}/delete` - Delete festival

#### Ritual Management
- `GET /pilgrim/temple/admin/temple/{templeId}/rituals` - View rituals
- `POST /pilgrim/temple/admin/temple/{templeId}/rituals/add` - Add ritual
- `GET /pilgrim/temple/admin/temple/{templeId}/rituals/{ritualId}/edit` - Edit ritual
- `POST /pilgrim/temple/admin/temple/{templeId}/rituals/{ritualId}/edit` - Update ritual
- `POST /pilgrim/temple/admin/temple/{templeId}/rituals/{ritualId}/delete` - Delete ritual

#### Tour Guide Management
- `GET /pilgrim/temple/admin/temple/{templeId}/tour-guides` - View tour guides
- `POST /pilgrim/temple/admin/temple/{templeId}/tour-guides/add` - Add tour guide

#### Booking & Donation Management
- `GET /pilgrim/temple/admin/temple/{templeId}/bookings` - View all bookings
- `GET /pilgrim/temple/admin/temple/{templeId}/donations` - View all donations

### Location API Routes
- `GET /pilgrim/temple/api/location/health` - Health check
- `GET /pilgrim/temple/api/location/countries` - Get countries
- `GET /pilgrim/temple/api/location/states` - Get states
- `GET /pilgrim/temple/api/location/districts` - Get districts
- `GET /pilgrim/temple/api/location/pincodes` - Get pincodes

---

## 👨‍💼 Admin Dashboard Routes

### Main Dashboard
- `GET /admin/dashboard` - Main admin dashboard
- `GET /admin/profile` - Admin profile
- `POST /admin/profile/update` - Update profile
- `POST /admin/profile/change-password` - Change password
- `POST /admin/profile/upload-image` - Upload profile image

### User Management
- `GET /admin/users` - View all users
- `GET /admin/user/{id}` - View user details
- `POST /admin/user/{id}/block` - Block user
- `POST /admin/user/{id}/unblock` - Unblock user

### Support & Tickets
- `GET /admin/support/tickets` - View support tickets
- `POST /admin/support/ticket/{id}/resolve` - Resolve ticket

### Audit Logs
- `GET /admin/audit-logs` - View audit logs

### Settings
- `GET /admin/settings` - System settings
- `POST /admin/settings/update` - Update settings

---

## 💬 Chat & Communication

### Chat API
- `POST /api/chat/**` - Chat endpoints
- `GET /api/chat/**` - Chat endpoints

### Scholar Chat
- `GET /scholar/chat/**` - Scholar chat interface
- `POST /scholar/chat/**` - Send chat messages

---

## 📱 API Endpoints

### Public API
- `GET /api/public/**` - Public API endpoints
- `POST /api/public/**` - Public API endpoints

### Authentication API
- `POST /api/auth/**` - Authentication API
- `GET /api/auth/**` - Authentication API

---

## 📁 Static Resources

### Static Files
- `GET /css/**` - CSS files
- `GET /js/**` - JavaScript files
- `GET /images/**` - Image files
- `GET /fonts/**` - Font files
- `GET /webjars/**` - WebJars resources
- `GET /views/**` - View files
- `GET /static/**` - Static resources
- `GET /uploads/**` - Uploaded files

---

## 🔧 Development Routes

### H2 Console (Development)
- `GET /h2-console/**` - H2 Database Console

---

## 📝 Notes

### URL Patterns
- All routes starting with `/pilgrim/**` are part of the Travel and Temple modules
- Routes starting with `/admin/**` are admin-only (currently public, needs security)
- Routes starting with `/pooja/**` are Pooja module routes
- Routes starting with `/accommodation/**` are Accommodation module routes
- Routes starting with `/scholar/**` are Scholar module routes

### HTTP Methods
- `GET` - Retrieve data/pages
- `POST` - Submit forms/data
- `PUT` - Update resources (if implemented)
- `DELETE` - Delete resources (if implemented)

### Path Variables
- `{id}` - Entity ID (Long)
- `{templeId}` - Temple ID
- `{bookingId}` - Booking ID
- `{orderId}` - Order ID
- `{darshanId}` - Darshan ID
- `{poojaId}` - Pooja ID
- `{prasadhamId}` - Prasadham ID
- `{guideId}` - Guide ID
- `{type}` - Enum type (e.g., TravelType, DarshanType)

---

## 🚀 Quick Access URLs

### Most Common Entry Points
1. **Home**: `http://localhost:8081/`
2. **Admin Dashboard**: `http://localhost:8081/admin/dashboard`
3. **Temples**: `http://localhost:8081/pilgrim/temple`
4. **Travel Packages**: `http://localhost:8081/pilgrim/travel/packages`
5. **Pooja Items**: `http://localhost:8081/pooja`
6. **Accommodation**: `http://localhost:8081/accommodation`
7. **Scholars**: `http://localhost:8081/scholar`

---

**Last Updated**: Based on current codebase
**Total Routes**: 200+ endpoints
**Base URL**: `http://localhost:8081`

