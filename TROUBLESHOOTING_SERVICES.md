# Troubleshooting Guide: Services Not Showing

## 🔍 Problem
- Scholar dashboard doesn't show option to add services
- Customer booking page shows "No Packages Available"

## ✅ Solutions Applied

### 1. Added "Manage Services" Button to Dashboard
- **Location**: Both `ScholarDashboard.jsp` and `AstrologerDashboard.jsp`
- **Button**: "Manage Services" in Quick Actions section
- **URL**: `/scholar/service/list`

### 2. Fixed Taglib Imports
- Updated `booking-details.jsp` to use Jakarta EE taglibs
- Changed from `http://java.sun.com/jsp/jstl/core` to `jakarta.tags.core`

## 📝 Step-by-Step Verification

### For Scholars:

1. **Login as Scholar**
   ```
   URL: /scholar/login
   ```

2. **Check Dashboard**
   - You should see a "📦 Services" card in Quick Actions
   - Click "Manage Services" button
   - OR navigate to: `/scholar/service/list`

3. **Add Your First Service**
   - Click "Add New Service" button
   - Fill in the form:
     - Service Name: e.g., "Ganpati Puja"
     - Description: Describe your service
     - Price With Items: e.g., 5000
     - Price Without Items: e.g., 4000
   - Click "Add Service"
   - Service should appear in the list

4. **Verify Service is Active**
   - In service list, check status badge
   - Should show "Active" (green badge)
   - If "Inactive", click the eye icon to activate

### For Customers:

1. **Login as Customer**
   ```
   URL: /customer/login
   ```

2. **Browse Scholars**
   ```
   URL: /book-scholar.jsp
   ```

3. **Click "Book Now" on a Scholar**
   - Should redirect to: `/customer/scholar/booking-details?scholarId={id}`

4. **Check for Packages**
   - If scholar has added services, you'll see package cards
   - If no services, you'll see: "No Packages Available" message

## 🐛 Common Issues & Fixes

### Issue 1: "Manage Services" Button Not Visible
**Solution**: 
- Clear browser cache
- Logout and login again
- Check you're logged in as a scholar (not customer)

### Issue 2: Services Not Showing in Booking Page
**Possible Causes**:
1. **No services created yet**
   - Scholar needs to add services first
   - Go to `/scholar/service/list` and add services

2. **Services are inactive**
   - Check service status in `/scholar/service/list`
   - Click the eye icon to activate inactive services

3. **Wrong scholar selected**
   - Verify the `scholarId` in URL matches the scholar who created services

4. **Database issue**
   - Check if `scholar_services` table exists
   - Verify services are saved in database

### Issue 3: Cannot Access Service Management
**Check**:
- Are you logged in? (`/scholar/login`)
- Is your scholar account approved? (Check status in dashboard)
- Try direct URL: `/scholar/service/list`

## 🔧 Database Verification

### Check if Services Exist:
```sql
SELECT * FROM scholar_services WHERE scholar_id = {your_scholar_id};
```

### Check Service Status:
```sql
SELECT id, name, is_active FROM scholar_services WHERE scholar_id = {your_scholar_id};
```

### Verify Scholar-Service Relationship:
```sql
SELECT s.id, s.name, ss.id as service_id, ss.name as service_name, ss.is_active
FROM scholars s
LEFT JOIN scholar_services ss ON s.id = ss.scholar_id
WHERE s.id = {your_scholar_id};
```

## 📋 Quick Checklist

- [ ] Scholar is logged in
- [ ] Scholar account is APPROVED
- [ ] "Manage Services" button visible in dashboard
- [ ] Can access `/scholar/service/list`
- [ ] At least one service created
- [ ] Service status is "Active"
- [ ] Customer is logged in
- [ ] Customer clicks "Book Now" on correct scholar
- [ ] Booking details page loads correctly
- [ ] Services appear in package selection

## 🚀 Testing Flow

1. **Scholar Side**:
   ```
   Login → Dashboard → Manage Services → Add Service → Verify Active
   ```

2. **Customer Side**:
   ```
   Login → Browse Scholars → Book Now → See Packages → Select Package
   ```

## 💡 Debug Tips

### Enable Debug Logging:
Add to `application.properties`:
```properties
logging.level.com.pilgrim.service.ScholarServiceService=DEBUG
logging.level.com.pilgrim.controller.ServiceController=DEBUG
logging.level.com.pilgrim.controller.ScholarCustomerController=DEBUG
```

### Check Console Logs:
- Look for errors when accessing `/scholar/service/list`
- Check for errors when accessing `/customer/scholar/booking-details`
- Verify SQL queries are executing

### Test Direct Access:
- Try: `http://localhost:8080/scholar/service/list` (replace with your server)
- Try: `http://localhost:8080/customer/scholar/booking-details?scholarId=1` (replace ID)

## 📞 If Still Not Working

1. **Check Application Logs** for errors
2. **Verify Database Connection**
3. **Check Entity Relationships** are correct
4. **Verify Repository Methods** are working
5. **Test with Direct Database Query**

---

**Last Updated**: After fixes applied
**Version**: 1.1

