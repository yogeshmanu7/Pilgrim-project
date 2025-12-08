# Temple Module - Complete Testing Guide

## 🚀 Quick Start

### 1. Start the Application
```bash
cd GlobalPiligrim
mvn spring-boot:run
```

Or if using an IDE, run the `PilgrimTempleApplication.java` main class.

**Application URL**: `http://localhost:8081`

---

## 📋 Testing Flow Overview

The Temple module has **3 main user flows**:
1. **Public User** - Browse temples and book services
2. **Temple Admin** - Manage temple and services
3. **Regular User** - View bookings and manage profile

---

## 🔍 Flow 1: Public User - Browse & Book Services

### Step 1: Browse Temples
```
URL: http://localhost:8081/pilgrim/temple
```
- Should display list of all active temples
- Can filter by religion, location, name

### Step 2: View Temple Details
```
URL: http://localhost:8081/pilgrim/temple/{templeId}
```
Replace `{templeId}` with actual temple ID (e.g., `1`)

**What to check:**
- ✅ Temple information displays
- ✅ Photos gallery visible
- ✅ Darshans listed
- ✅ Poojas listed
- ✅ Prasadhams listed
- ✅ Tour guides listed
- ✅ Festivals and events visible
- ✅ Map location (if available)

### Step 3: View Specific Services
```
# View Darshans
http://localhost:8081/pilgrim/temple/{templeId}/darshans

# View Poojas
http://localhost:8081/pilgrim/temple/{templeId}/poojas

# View Prasadhams
http://localhost:8081/pilgrim/temple/{templeId}/prasadhams

# View Tour Guides
http://localhost:8081/pilgrim/temple/{templeId}/tour-guides

# View Festivals
http://localhost:8081/pilgrim/temple/{templeId}/festivals

# View Events
http://localhost:8081/pilgrim/temple/{templeId}/events

# View Gallery
http://localhost:8081/pilgrim/temple/{templeId}/gallery

# View Map
http://localhost:8081/pilgrim/temple/{templeId}/map
```

### Step 4: Book Darshan
```
URL: http://localhost:8081/pilgrim/temple/booking/darshan/{darshanId}
```

**Booking Process:**
1. Select booking date
2. Select time slot (if required)
3. Enter number of persons
4. Enter devotee details (name, phone)
5. Submit booking
6. Make payment (if required)
7. Receive booking confirmation

**Check API for available seats:**
```
GET http://localhost:8081/pilgrim/temple/booking/api/darshan/{darshanId}/available-seats?date=2024-12-15
```

### Step 5: Book Pooja
```
URL: http://localhost:8081/pilgrim/temple/booking/pooja/{poojaId}
```

**Booking Process:**
1. Select booking date
2. Enter preferred time (optional)
3. Enter devotee name
4. Enter astrological details (gotra, nakshatra, rashi) - optional
5. Enter family member names (optional)
6. Add special requests (optional)
7. Select if prasadham required
8. Enter delivery address (if prasadham required)
9. Submit booking
10. Make payment
11. Receive confirmation

### Step 6: Order Prasadham
```
URL: http://localhost:8081/pilgrim/temple/booking/prasadham/{prasadhamId}
```

**Order Process:**
1. Select quantity
2. Choose delivery option (pickup/delivery)
3. Enter recipient details (if delivery)
4. Enter delivery address
5. Submit order
6. Make payment
7. Receive order confirmation

### Step 7: Book Tour Guide
```
URL: http://localhost:8081/pilgrim/temple/booking/tour-guide/{guideId}
```

**Booking Process:**
1. Select tour date
2. Select start time
3. Select end time (optional)
4. Select tour type (HOURLY, HALF_DAY, FULL_DAY)
5. Enter number of persons
6. Enter contact details
7. Select preferred language (optional)
8. Add special requirements (optional)
9. Submit booking
10. Make payment
11. Receive confirmation

### Step 8: Make Donation
```
URL: http://localhost:8081/pilgrim/temple/donation/{templeId}
```

**Donation Process:**
1. Enter donor details (name, email, phone, address)
2. Enter PAN number (optional, for tax purposes)
3. Select donation type
4. Enter amount
5. Enter purpose (optional)
6. Enter "In memory of" (optional)
7. Select if anonymous
8. Select if receipt required
9. Select if 80G applicable
10. Add notes (optional)
11. Submit donation
12. Make payment
13. Receive receipt

---

## 👨‍💼 Flow 2: Temple Admin - Manage Temple

### Step 1: Access Temple Admin Dashboard
```
URL: http://localhost:8081/pilgrim/temple/admin/dashboard
```

**What to check:**
- ✅ Dashboard loads
- ✅ Statistics displayed
- ✅ Quick action links work

### Step 2: Add New Temple
```
URL: http://localhost:8081/pilgrim/temple/admin/temple/add
```

**Required Information:**
- Temple name (English & Hindi)
- Religion (Hindu, Christian, Muslim, Jain, Buddhist)
- Address, City, State, Pincode
- Contact details (phone, email, website)
- Location (latitude, longitude)
- Timings (morning/evening open/close times)
- Description and history
- Main deity information

**Religion-Specific Fields:**
- **Hindu**: Main deity, special timings, rules
- **Christian**: Pastor name, denomination, mass times, confession times, church type
- **Muslim**: Imam name, prayer times, qibla direction, mosque type
- **Jain**: Tirthankara, jain sect, jain rituals
- **Buddhist**: Buddha statue, buddhist sect, meditation times

### Step 3: Edit Temple
```
URL: http://localhost:8081/pilgrim/temple/admin/temple/{templeId}/edit
```

### Step 4: Add Photos
```
URL: http://localhost:8081/pilgrim/temple/admin/temple/{templeId}/photos
```

**Photo Categories:**
- INTERIOR
- EXTERIOR
- SCULPTURE
- FESTIVAL
- EVENT
- OTHER

### Step 5: Manage Darshans
```
URL: http://localhost:8081/pilgrim/temple/admin/temple/{templeId}/darshans
```

**Add Darshan:**
- Darshan type (FREE, PAID, VIP, SPECIAL)
- Name and name in Hindi
- Price (if paid)
- Start time and end time
- Duration in minutes
- Max bookings per slot
- Booking start date and end date
- Description
- Benefits
- Instructions
- Requires booking flag

**Edit/Delete:**
- Edit: `/pilgrim/temple/admin/temple/{templeId}/darshans/{darshanId}/edit`
- Delete: `POST /pilgrim/temple/admin/temple/{templeId}/darshans/{darshanId}/delete`

### Step 6: Manage Poojas
```
URL: http://localhost:8081/pilgrim/temple/admin/temple/{templeId}/poojas
```

**Add Pooja:**
- Name (English & Hindi)
- Category (DAILY, WEEKLY, MONTHLY, FESTIVAL, SPECIAL)
- Description
- Price
- Duration in minutes
- Default time
- Available days
- Max bookings per day
- Items included
- Benefits
- Requires advance booking
- Advance booking days

### Step 7: Manage Prasadhams
```
URL: http://localhost:8081/pilgrim/temple/admin/temple/{templeId}/prasadhams
```

**Add Prasadham:**
- Name (English & Hindi)
- Description
- Price
- Type (LADDU, MODAK, PEDA, etc.)
- Weight
- Can be delivered
- Delivery charge
- Stock quantity
- Ingredients
- Shelf life

### Step 8: Manage Festivals
```
URL: http://localhost:8081/pilgrim/temple/admin/temple/{templeId}/festivals
```

**Add Festival:**
- Name (English & Hindi)
- Description
- Start date and end date
- Significance
- Rituals performed
- Special timings

### Step 9: Manage Rituals
```
URL: http://localhost:8081/pilgrim/temple/admin/temple/{templeId}/rituals
```

**Add Ritual:**
- Name (English & Hindi)
- Description
- Significance
- Time
- Duration
- Frequency (DAILY, WEEKLY, MONTHLY, YEARLY, SPECIAL)
- Ritual procedure
- Public allowed flag
- Display order

### Step 10: Manage Tour Guides
```
URL: http://localhost:8081/pilgrim/temple/admin/temple/{templeId}/tour-guides
```

**Add Tour Guide:**
- Name
- Phone and email
- Photo URL
- Bio
- Languages (JSON array)
- Experience years
- Hourly rate
- Full day rate
- Certifications

### Step 11: View Bookings & Donations
```
# View all bookings
http://localhost:8081/pilgrim/temple/admin/temple/{templeId}/bookings

# View all donations
http://localhost:8081/pilgrim/temple/admin/temple/{templeId}/donations
```

---

## 👤 Flow 3: Regular User - Manage Bookings

### Step 1: Access User Dashboard
```
URL: http://localhost:8081/pilgrim/temple/user/dashboard
```

**What to check:**
- ✅ All bookings displayed (Darshan, Pooja, Tour)
- ✅ All orders displayed (Prasadham)
- ✅ All donations displayed
- ✅ Quick access to each booking/order

### Step 2: View Profile
```
URL: http://localhost:8081/pilgrim/temple/user/profile
```

**Update Profile:**
- Name
- Phone
- Address
- City
- State
- Pincode

### Step 3: View Bookings
```
# All bookings
http://localhost:8081/pilgrim/temple/user/bookings

# Specific booking
http://localhost:8081/pilgrim/temple/user/bookings/darshan/{id}
http://localhost:8081/pilgrim/temple/user/bookings/pooja/{id}
http://localhost:8081/pilgrim/temple/user/bookings/tour/{id}
```

### Step 4: View Orders
```
# All orders
http://localhost:8081/pilgrim/temple/user/orders

# Specific order
http://localhost:8081/pilgrim/temple/user/orders/prasadham/{id}
```

### Step 5: View Donations
```
URL: http://localhost:8081/pilgrim/temple/user/donations
```

### Step 6: Cancel Bookings/Orders
```
POST http://localhost:8081/pilgrim/temple/user/bookings/darshan/{id}/cancel
POST http://localhost:8081/pilgrim/temple/user/bookings/pooja/{id}/cancel
POST http://localhost:8081/pilgrim/temple/user/bookings/tour/{id}/cancel
POST http://localhost:8081/pilgrim/temple/user/orders/prasadham/{id}/cancel
```

---

## 💳 Payment Flow Testing

### Payment Process
1. **Create Payment Order**
   ```
   POST http://localhost:8081/pilgrim/temple/payment/darshan/{bookingId}/create-order
   POST http://localhost:8081/pilgrim/temple/payment/pooja/{bookingId}/create-order
   POST http://localhost:8081/pilgrim/temple/payment/prasadham/{orderId}/create-order
   POST http://localhost:8081/pilgrim/temple/payment/tour/{bookingId}/create-order
   ```

2. **Verify Payment**
   ```
   POST http://localhost:8081/pilgrim/temple/payment/darshan/{bookingId}/verify
   ```
   Parameters: `razorpay_order_id`, `razorpay_payment_id`, `razorpay_signature`

**What to check:**
- ✅ Payment order created successfully
- ✅ Razorpay gateway opens
- ✅ Payment verification works
- ✅ Booking status updates to PAID
- ✅ Confirmation email sent

---

## 🧪 Complete Testing Checklist

### ✅ Temple Management
- [ ] Add new temple
- [ ] Edit temple details
- [ ] Upload temple photos
- [ ] View temple in public listing

### ✅ Darshan Management
- [ ] Add darshan
- [ ] Edit darshan
- [ ] Delete darshan
- [ ] Book darshan (public)
- [ ] Check available seats API
- [ ] Process payment
- [ ] View booking in user dashboard

### ✅ Pooja Management
- [ ] Add pooja
- [ ] Edit pooja
- [ ] Delete pooja
- [ ] Book pooja (public)
- [ ] Process payment
- [ ] View booking in user dashboard

### ✅ Prasadham Management
- [ ] Add prasadham
- [ ] Edit prasadham
- [ ] Delete prasadham
- [ ] Order prasadham (public)
- [ ] Process payment
- [ ] View order in user dashboard

### ✅ Festival Management
- [ ] Add festival
- [ ] Edit festival
- [ ] Delete festival
- [ ] View festivals on temple page

### ✅ Ritual Management
- [ ] Add ritual
- [ ] Edit ritual
- [ ] Delete ritual
- [ ] View rituals on temple page

### ✅ Tour Guide Management
- [ ] Add tour guide
- [ ] Book tour guide (public)
- [ ] Process payment
- [ ] View booking in user dashboard

### ✅ Donation Management
- [ ] Make donation (public)
- [ ] Process payment
- [ ] View donation in user dashboard
- [ ] View donations in temple admin

### ✅ User Dashboard
- [ ] View all bookings
- [ ] View all orders
- [ ] View all donations
- [ ] Cancel bookings
- [ ] Cancel orders
- [ ] Update profile

### ✅ Payment Integration
- [ ] Create payment order
- [ ] Verify payment
- [ ] Handle payment success
- [ ] Handle payment failure
- [ ] Free bookings (amount = 0)

---

## 🔍 Common Issues & Solutions

### Issue 1: Templates Not Found
**Error**: `Template not found` or `404`
**Solution**: 
- Check if Thymeleaf templates are in `src/main/resources/templates/`
- Verify template names match controller return values

### Issue 2: Entity Not Found
**Error**: `Entity not found` or `NullPointerException`
**Solution**:
- Ensure database has temple data
- Check if temple ID exists
- Verify entity relationships are correct

### Issue 3: Payment Not Working
**Error**: Payment gateway not opening
**Solution**:
- Check Razorpay keys in `application.properties`
- Verify `razorpay.key.id` is set
- Check payment order creation logs

### Issue 4: Builder Errors
**Error**: `builder() method not found`
**Solution**:
- All entities now have explicit builder methods
- If error persists, check entity has `builder()` method

### Issue 5: Missing Getters/Setters
**Error**: `getter/setter not found`
**Solution**:
- All entities have explicit getters/setters
- Check entity file for required methods

---

## 📊 Database Setup

### Required Tables
Ensure these tables exist:
- `temples`
- `temple_photos`
- `darshans`
- `darshan_bookings`
- `temple_poojas`
- `pooja_bookings`
- `prasadhams`
- `prasadham_orders`
- `festivals`
- `rituals`
- `tour_guides`
- `tour_bookings`
- `temple_donations`
- `users`

### Sample Data
You can create sample data via:
1. Temple Admin dashboard - Add temple manually
2. SQL scripts (if available)
3. Database seeding scripts

---

## 🎯 Quick Test Scenarios

### Scenario 1: Complete Booking Flow
```
1. Browse temples → http://localhost:8081/pilgrim/temple
2. View temple → http://localhost:8081/pilgrim/temple/1
3. Book darshan → http://localhost:8081/pilgrim/temple/booking/darshan/1
4. Complete booking
5. Make payment
6. View in dashboard → http://localhost:8081/pilgrim/temple/user/dashboard
```

### Scenario 2: Temple Admin Setup
```
1. Login as temple admin
2. Add temple → http://localhost:8081/pilgrim/temple/admin/temple/add
3. Add darshan → http://localhost:8081/pilgrim/temple/admin/temple/1/darshans
4. Add pooja → http://localhost:8081/pilgrim/temple/admin/temple/1/poojas
5. Add prasadham → http://localhost:8081/pilgrim/temple/admin/temple/1/prasadhams
6. View public temple → http://localhost:8081/pilgrim/temple/1
```

### Scenario 3: Multiple Services Booking
```
1. Book darshan
2. Book pooja
3. Order prasadham
4. Book tour guide
5. Make donation
6. View all in dashboard
```

---

## 🔗 Key URLs Reference

### Public URLs
- Temples List: `http://localhost:8081/pilgrim/temple`
- Temple Details: `http://localhost:8081/pilgrim/temple/{id}`
- Book Darshan: `http://localhost:8081/pilgrim/temple/booking/darshan/{id}`
- Book Pooja: `http://localhost:8081/pilgrim/temple/booking/pooja/{id}`
- Order Prasadham: `http://localhost:8081/pilgrim/temple/booking/prasadham/{id}`
- Book Tour: `http://localhost:8081/pilgrim/temple/booking/tour-guide/{id}`
- Donation: `http://localhost:8081/pilgrim/temple/donation/{id}`

### User URLs
- Dashboard: `http://localhost:8081/pilgrim/temple/user/dashboard`
- Profile: `http://localhost:8081/pilgrim/temple/user/profile`
- Bookings: `http://localhost:8081/pilgrim/temple/user/bookings`
- Orders: `http://localhost:8081/pilgrim/temple/user/orders`
- Donations: `http://localhost:8081/pilgrim/temple/user/donations`

### Admin URLs
- Dashboard: `http://localhost:8081/pilgrim/temple/admin/dashboard`
- Add Temple: `http://localhost:8081/pilgrim/temple/admin/temple/add`
- Manage Services: `http://localhost:8081/pilgrim/temple/admin/temple/{id}/darshans`

---

## 📝 Testing Notes

1. **Authentication**: Currently all routes are public. You may need to login for some features.
2. **Database**: Ensure you have at least one temple in the database to test.
3. **Payment**: Use Razorpay test keys for testing payments.
4. **File Uploads**: Check `application.properties` for upload directory path.
5. **Email**: Configure SMTP settings for email notifications.

---

## 🚨 Important Reminders

- Replace `{id}`, `{templeId}`, `{darshanId}`, etc. with actual IDs from your database
- Check browser console for JavaScript errors
- Check server logs for backend errors
- Verify database connections
- Ensure all dependencies are installed (`mvn clean install`)

---

**Happy Testing! 🎉**

