# Visual Flow Diagram

## 🔄 Complete System Flow

```
┌─────────────────────────────────────────────────────────────────┐
│                    SCHOLAR SIDE FLOW                            │
└─────────────────────────────────────────────────────────────────┘

1. LOGIN
   /scholar/login
   ↓
   [Validate Scholar Account]
   ↓
   [Session Created]
   ↓

2. DASHBOARD
   /scholar/dashboard
   ↓
   [View Bookings, Messages, Profile]
   ↓

3. SERVICE MANAGEMENT
   /scholar/service/list
   ↓
   ┌─────────────────────────────────────┐
   │  Service List Page                  │
   │  - View all services                │
   │  - Add/Edit/Delete/Toggle           │
   └─────────────────────────────────────┘
   ↓
   
4. ADD SERVICE
   /scholar/service/add (GET) → Form
   ↓
   [Fill Form: Name, Description, Prices]
   ↓
   /scholar/service/add (POST)
   ↓
   [ServiceController.addService()]
   ↓
   [ScholarServiceService.createService()]
   ↓
   [Save to Database]
   ↓
   [Redirect to Service List]

┌─────────────────────────────────────────────────────────────────┐
│                    CUSTOMER SIDE FLOW                           │
└─────────────────────────────────────────────────────────────────┘

1. LOGIN
   /customer/login
   ↓
   [Validate Customer Account]
   ↓
   [Session Created]
   ↓

2. BROWSE SCHOLARS
   /book-scholar.jsp
   ↓
   [View Available Scholars]
   ↓
   [Click "Book Now"]
   ↓

3. BOOKING DETAILS PAGE
   /customer/scholar/booking-details?scholarId={id}
   ↓
   [ScholarCustomerController.showBookingDetails()]
   ↓
   [Fetch Scholar + Active Services]
   ↓
   ┌─────────────────────────────────────────────────────────┐
   │  STEP 1: SELECT PACKAGE                                 │
   │  ┌───────────────────────────────────────────────────┐  │
   │  │ Package Cards Display:                            │  │
   │  │ - Service Name                                    │  │
   │  │ - Description                                     │  │
   │  │ - Price With Items (₹5000)                       │  │
   │  │ - Price Without Items (₹4000) [strikethrough]   │  │
   │  │ [Select Button]                                   │  │
   │  └───────────────────────────────────────────────────┘  │
   │  ↓                                                       │
   │  [JavaScript: selectPackage()]                          │
   │  - Stores: serviceId, serviceName, basePrice            │
   │  ↓                                                       │
   └─────────────────────────────────────────────────────────┘
   ↓
   ┌─────────────────────────────────────────────────────────┐
   │  STEP 2: ADDONS SELECTION                               │
   │  ┌───────────────────────────────────────────────────┐  │
   │  │ Included:                                         │  │
   │  │ ✓ Dakshina                                       │  │
   │  │ ✓ All Puja Samagries                             │  │
   │  │                                                   │  │
   │  │ Optional:                                        │  │
   │  │ ☐ Flowers & Fruits (₹1200) [Add Button]         │  │
   │  │ ☐ Havan (₹1000) [Add Button]                     │  │
   │  │                                                   │  │
   │  │ Order Summary:                                    │  │
   │  │ - Service: ₹5000                                 │  │
   │  │ - Addons: ₹1200                                  │  │
   │  │ - Total: ₹6200                                   │  │
   │  │ [Proceed To Checkout]                            │  │
   │  └───────────────────────────────────────────────────┘  │
   │  ↓                                                       │
   │  [JavaScript: proceedToPayment()]                       │
   └─────────────────────────────────────────────────────────┘
   ↓
   ┌─────────────────────────────────────────────────────────┐
   │  STEP 3: PAYMENT                                         │
   │  ┌───────────────────────────────────────────────────┐  │
   │  │ Payment Summary:                                  │  │
   │  │ - Service: ₹5000                                 │  │
   │  │ - Addons: ₹1200                                  │  │
   │  │ - Total: ₹6200                                   │  │
   │  │                                                   │  │
   │  │ [Pay Now Button]                                 │  │
   │  └───────────────────────────────────────────────────┘  │
   │  ↓                                                       │
   │  [JavaScript: initiatePayment()]                       │
   │  ↓                                                       │
   │  POST /customer/scholar/create-booking                  │
   │  {                                                       │
   │    "scholarId": 123,                                    │
   │    "serviceId": 456,                                    │
   │    "amount": 6200,                                      │
   │    "addons": {"flowers": true, "havan": false}         │
   │  }                                                       │
   └─────────────────────────────────────────────────────────┘
   ↓
   
4. CREATE BOOKING
   [ScholarCustomerController.createBookingFromService()]
   ↓
   [Validate User Session]
   ↓
   [Fetch Scholar & Service]
   ↓
   [Create ScholarBooking Entity]
   ├─ customer: User
   ├─ scholar: Scholar
   ├─ serviceType: ONSITE
   ├─ totalAmount: ₹6200
   ├─ serviceDescription: "Service: Ganpati Puja"
   └─ status: PENDING_CONFIRMATION
   ↓
   [Create ScholarPayment Entity]
   ├─ booking: ScholarBooking
   ├─ amount: ₹6200
   ├─ platformCommission: ₹620 (10%)
   ├─ scholarAmount: ₹5580 (90%)
   └─ status: PENDING
   ↓
   [Return: { "success": true, "bookingId": 789 }]
   ↓
   [JavaScript Redirect]
   ↓

5. PAYMENT PAGE
   /customer/scholar/payment/initiate?bookingId=789
   ↓
   [ScholarPaymentController.showPaymentPage()]
   ↓
   [Validate Booking Ownership]
   ↓
   [Initialize Razorpay Order]
   ├─ Convert ₹6200 → 620000 paise
   ├─ Create Razorpay Order
   └─ Get Order ID
   ↓
   [Display payment.jsp]
   ├─ Razorpay Order ID
   ├─ Amount: 620000 paise
   ├─ Razorpay Key ID
   └─ Booking Details
   ↓
   [Customer Clicks "Pay Now"]
   ↓
   [Razorpay Checkout Opens]
   ↓
   [Customer Enters Payment Details]
   ↓
   [Razorpay Processes Payment]
   ↓

6. PAYMENT SUCCESS
   POST /customer/scholar/payment/success
   ↓
   [ScholarPaymentController.paymentSuccess()]
   ↓
   [Verify Payment with Razorpay]
   ↓
   [Update ScholarPayment]
   ├─ status: PAID
   ├─ razorpayPaymentId: {from response}
   └─ paidAt: {timestamp}
   ↓
   [Update ScholarBooking]
   └─ status: CONFIRMED
   ↓
   [Redirect to Success Page]
   ↓
   ✅ BOOKING CONFIRMED!

┌─────────────────────────────────────────────────────────────────┐
│                    DATABASE FLOW                                │
└─────────────────────────────────────────────────────────────────┘

SCHOLAR TABLE
└─→ SCHOLAR_SERVICES TABLE (One-to-Many)
    ├─ Service 1: Ganpati Puja (₹5000/₹4000)
    ├─ Service 2: Satyanarayan Puja (₹6000/₹5000)
    └─ Service 3: House Warming (₹8000/₹7000)

USER (Customer) TABLE
└─→ SCHOLAR_BOOKINGS TABLE (One-to-Many)
    └─→ SCHOLAR_PAYMENTS TABLE (One-to-One)
        ├─ Amount: ₹6200
        ├─ Commission: ₹620
        └─ Scholar Amount: ₹5580

┌─────────────────────────────────────────────────────────────────┐
│                    API ENDPOINTS                                 │
└─────────────────────────────────────────────────────────────────┘

SCHOLAR ENDPOINTS:
GET  /scholar/service/list          → View all services
GET  /scholar/service/add           → Show add form
POST /scholar/service/add           → Create service
GET  /scholar/service/edit?id={id}  → Show edit form
POST /scholar/service/edit          → Update service
POST /scholar/service/delete        → Delete service
POST /scholar/service/toggle        → Toggle active/inactive

CUSTOMER ENDPOINTS:
GET  /customer/scholar/booking-details?scholarId={id}  → View packages
POST /customer/scholar/create-booking                 → Create booking
GET  /customer/scholar/payment/initiate?bookingId={id} → Payment page
POST /customer/scholar/payment/success                 → Payment success

┌─────────────────────────────────────────────────────────────────┐
│                    JAVASCRIPT FLOW                               │
└─────────────────────────────────────────────────────────────────┘

booking-details.jsp JavaScript:

1. selectPackage(serviceId, name, priceWith, priceWithout)
   ├─ Store: selectedPackage, selectedPackageName, basePrice
   ├─ Update: Order Summary
   └─ Navigate: Step 2

2. toggleAddon(addonName, price, button)
   ├─ Toggle: addons[addonName]
   ├─ Update: Button state (Add/Added)
   ├─ Show/Hide: Addon in summary
   └─ Update: Total amount

3. updateTotal()
   ├─ Calculate: basePrice + addons
   ├─ Update: Summary total
   └─ Update: Payment summary

4. proceedToPayment()
   ├─ Validate: Package selected
   └─ Navigate: Step 3

5. initiatePayment()
   ├─ Validate: Total amount > 0
   ├─ POST: /customer/scholar/create-booking
   ├─ Get: bookingId from response
   └─ Redirect: /customer/scholar/payment/initiate?bookingId={id}

