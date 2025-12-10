# Service Management & Booking Flow Guide

## 📋 Overview
This guide explains how the Service Management and Booking system works in GlobalPiligrim, from scholars creating services to customers booking and paying for them.

---

## 🔄 Complete System Flow

### **PART 1: Scholar Side - Managing Services**

#### **Step 1: Scholar Login**
1. **URL**: `/scholar/login`
2. Scholar logs in with email and password
3. System validates:
   - User exists and is registered as a scholar
   - Scholar account is approved by admin
4. On success, redirects to `/scholar/dashboard`

#### **Step 2: Access Service Management**
From the Scholar Dashboard, navigate to:
- **URL**: `/scholar/service/list`
- This shows all services created by the scholar

#### **Step 3: Add New Service**
1. **URL**: `/scholar/service/add` (GET) - Shows form
2. Fill in the form:
   - **Service Name**: e.g., "Ganpati Puja", "Satyanarayan Puja"
   - **Description**: Detailed description of the service
   - **Price With Items**: Price including all puja samagri (₹)
   - **Price Without Items**: Base price without puja samagri (₹)
3. **Submit**: POST to `/scholar/service/add`
4. System creates `ScholarService` entity and saves to database
5. Redirects to service list with success message

#### **Step 4: Edit Service**
1. **URL**: `/scholar/service/edit?id={serviceId}` (GET)
2. Form pre-filled with existing service data
3. Modify fields as needed
4. **Submit**: POST to `/scholar/service/edit`
5. Updates service in database
6. Redirects to service list

#### **Step 5: Manage Service Status**
- **Toggle Active/Inactive**: POST to `/scholar/service/toggle?id={serviceId}`
- **Delete Service**: POST to `/scholar/service/delete?id={serviceId}`

---

### **PART 2: Customer Side - Booking Services**

#### **Step 1: Customer Login**
1. **URL**: `/customer/login`
2. Customer logs in with email and password
3. Redirects to `/customer/scholar/dashboard`

#### **Step 2: Browse Scholars**
1. **URL**: `/book-scholar.jsp` or `/book-astrologer.jsp`
2. Displays list of available scholars
3. Shows:
   - Scholar name
   - Experience years
   - Base price
   - Rating
   - Reviews count
4. Click **"Book Now"** button

#### **Step 3: View Service Packages (Booking Details Page)**
1. **URL**: `/customer/scholar/booking-details?scholarId={id}`
2. **Controller**: `ScholarCustomerController.showBookingDetails()`
3. **Flow**:
   - Validates user session
   - Fetches scholar by ID
   - Fetches all active services for that scholar
   - Displays booking-details.jsp

#### **Step 4: 3-Step Booking Process**

##### **STEP 1: Select Package**
- Displays all available service packages
- Each package shows:
  - Service name
  - Description
  - Price with items (main price)
  - Price without items (strikethrough)
- Customer clicks **"Select"** on desired package
- JavaScript stores selected package info
- Automatically moves to Step 2

##### **STEP 2: Addons Selection**
- **Included Addons** (already in package):
  - Dakshina
  - All Puja Samagries
- **Optional Addons**:
  - Flowers & Fruits (₹1200)
  - Havan (₹1000)
- Customer can add optional addons
- **Order Summary** shows:
  - Selected service name
  - Service price
  - Selected addons
  - **Total Amount**
- Click **"Proceed To Checkout"** → Step 3

##### **STEP 3: Payment**
- Displays final payment summary
- Shows total amount
- Click **"Pay Now"** button

#### **Step 5: Create Booking & Payment**
1. **JavaScript Function**: `initiatePayment()`
2. **API Call**: POST to `/customer/scholar/create-booking`
   ```json
   {
     "scholarId": 123,
     "serviceId": 456,
     "amount": 5000,
     "addons": {
       "flowers": true,
       "havan": false
     }
   }
   ```
3. **Controller**: `ScholarCustomerController.createBookingFromService()`
4. **Backend Process**:
   - Validates user session
   - Fetches scholar and service
   - Creates `ScholarBooking` entity:
     - Links customer, scholar, service
     - Sets total amount
     - Sets booking date
     - Sets status to `PENDING_CONFIRMATION`
   - Creates `ScholarPayment` entity:
     - Links to booking
     - Sets amount
     - Calculates 10% platform commission
     - Sets scholar amount (90%)
     - Sets status to `PENDING`
5. **Response**: Returns `{ "success": true, "bookingId": 789 }`
6. **Redirect**: JavaScript redirects to `/customer/scholar/payment/initiate?bookingId=789`

#### **Step 6: Payment Processing**
1. **URL**: `/customer/scholar/payment/initiate?bookingId={id}`
2. **Controller**: `ScholarPaymentController.showPaymentPage()`
3. **Process**:
   - Validates booking belongs to logged-in user
   - Checks if payment already exists
   - Initializes Razorpay order:
     - Converts amount to paise (×100)
     - Creates order with Razorpay API
     - Gets order ID
   - Displays payment.jsp with:
     - Razorpay order ID
     - Amount
     - Razorpay key ID
     - Booking details
4. **Customer completes payment** via Razorpay checkout
5. **Payment Success**: POST to `/customer/scholar/payment/success`
6. **Controller**: `ScholarPaymentController.paymentSuccess()`
   - Verifies payment with Razorpay
   - Updates payment status to `PAID`
   - Updates booking status to `CONFIRMED`
   - Redirects to success page

---

## 🗄️ Database Flow

### **Entities Involved:**

1. **Scholar** (already exists)
   - One scholar can have many services

2. **ScholarService** (NEW)
   ```java
   - id
   - scholar (ManyToOne → Scholar)
   - name
   - description
   - priceWithItems
   - priceWithoutItems
   - isActive
   - createdAt
   - updatedAt
   ```

3. **ScholarBooking** (already exists)
   - Links customer, scholar, and booking details
   - Now can be created from a service

4. **ScholarPayment** (already exists)
   - Links to booking
   - Handles payment processing

### **Relationships:**
```
Scholar (1) ──→ (Many) ScholarService
Scholar (1) ──→ (Many) ScholarBooking
ScholarBooking (1) ──→ (1) ScholarPayment
User (Customer) (1) ──→ (Many) ScholarBooking
```

---

## 🔧 Technical Implementation Details

### **Controllers:**

1. **ServiceController** (`/scholar/service/*`)
   - Manages CRUD operations for services
   - Only accessible to logged-in scholars
   - Validates scholar owns the service

2. **ScholarCustomerController** (`/customer/scholar/*`)
   - `booking-details`: Shows service packages
   - `create-booking`: Creates booking from service selection

3. **ScholarPaymentController** (`/customer/scholar/payment/*`)
   - Handles payment initiation and processing
   - Integrates with Razorpay

### **Services:**

1. **ScholarServiceService**
   - `createService()`: Creates new service
   - `updateService()`: Updates existing service
   - `findByScholar()`: Gets all services for a scholar
   - `findActiveByScholar()`: Gets only active services

2. **ScholarBookingService**
   - `createBooking()`: Creates booking (existing, now used with services)

3. **ScholarPaymentService**
   - `createPayment()`: Creates payment record
   - `processPayment()`: Processes payment after Razorpay verification

---

## 📱 User Interface Flow

### **Scholar Dashboard → Service Management:**
```
Scholar Dashboard
    ↓
Click "Manage Services" or navigate to /scholar/service/list
    ↓
Service List Page
    ├─→ Add New Service → service_add.jsp
    ├─→ Edit Service → service_edit.jsp
    ├─→ Toggle Active/Inactive
    └─→ Delete Service
```

### **Customer Booking Flow:**
```
Home / Browse Scholars
    ↓
Click "Book Now" on a scholar
    ↓
Booking Details Page (booking-details.jsp)
    ├─→ Step 1: Select Package
    ├─→ Step 2: Select Addons
    └─→ Step 3: Payment
        ↓
    Payment Page (payment.jsp)
        ↓
    Razorpay Checkout
        ↓
    Payment Success / Failure
```

---

## 🔐 Security & Validation

1. **Session Validation**: All endpoints check for valid user session
2. **Scholar Ownership**: Scholars can only manage their own services
3. **Service Access**: Only active services are shown to customers
4. **Booking Ownership**: Customers can only view their own bookings
5. **Payment Security**: Razorpay handles secure payment processing

---

## 🎯 Key Features

✅ **Service Management**: Scholars can add, edit, delete services
✅ **Service Status**: Toggle active/inactive to control visibility
✅ **Package Selection**: Customers choose from available service packages
✅ **Addons**: Optional addons (Flowers, Havan) can be added
✅ **Payment Integration**: Seamless Razorpay integration
✅ **Booking Tracking**: Complete booking lifecycle management
✅ **Commission Calculation**: Automatic 10% platform commission

---

## 📝 Example Usage Scenario

### **Scholar Side:**
1. Scholar "Pandit Ram" logs in
2. Navigates to Service Management
3. Adds service:
   - Name: "Ganpati Puja"
   - Price With Items: ₹5000
   - Price Without Items: ₹4000
4. Service is now visible to customers

### **Customer Side:**
1. Customer "John" logs in
2. Browses scholars, finds "Pandit Ram"
3. Clicks "Book Now"
4. Sees "Ganpati Puja" package
5. Selects package (₹5000)
6. Adds "Flowers & Fruits" addon (₹1200)
7. Total: ₹6200
8. Proceeds to payment
9. Completes Razorpay payment
10. Booking confirmed!

---

## 🚀 Getting Started

### **For Scholars:**
1. Login at `/scholar/login`
2. Go to `/scholar/service/list`
3. Click "Add New Service"
4. Fill form and submit

### **For Customers:**
1. Login at `/customer/login`
2. Browse scholars at `/book-scholar.jsp`
3. Click "Book Now" on desired scholar
4. Follow 3-step booking process
5. Complete payment

---

## 📞 Support

If you encounter any issues:
- Check that scholar account is approved
- Verify services are marked as active
- Ensure payment gateway is configured
- Check session is valid

---

**Last Updated**: Based on current implementation
**Version**: 1.0

