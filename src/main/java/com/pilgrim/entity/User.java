package com.pilgrim.entity;

import com.pilgrim.enums.UserRole;
import com.pilgrim.enums.Religion;
import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "users")
public class User {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(nullable = false)
    private String name;
    
    // For accommodation module compatibility
    @Column(name = "full_name")
    private String fullName;
    
    @Column(unique = true)
    private String username;
    
    @Column(nullable = false, unique = true)
    private String email;
    
    private String phone;
    
    // For accommodation module compatibility
    @Column(name = "phone_number")
    private String phoneNumber;
    
    private String password;
    
    @Column(name = "profile_image")
    private String profileImage;
    
    @Column(columnDefinition = "TEXT")
    private String address;
    
    private String city;
    
    private String state;
    
    @Column(name = "pin_code")
    private String pinCode;
    
    @Column(name = "date_of_birth")
    private String dateOfBirth;
    
    // For accommodation module - LocalDate version
    @Column(name = "dob")
    private LocalDate dob;
    
    private String gender;
    
    // User Role - unified for all modules
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private UserRole role = UserRole.CUSTOMER;
    
    // Religion field - required for TEMPLE_ADMIN, optional for others
    @Enumerated(EnumType.STRING)
    @Column(name = "religion")
    private Religion religion;
    
    @Column(name = "is_verified")
    private boolean isVerified = false;
    
    // For accommodation module compatibility
    @Column(name = "email_verified")
    private Boolean emailVerified = false;
    
    @Column(name = "is_active")
    private boolean isActive = true;
    
    @Column(name = "is_blocked")
    private boolean isBlocked = false;
    
    @Column(name = "blocked_reason")
    private String blockedReason;
    
    @Column(name = "auth_provider")
    private String authProvider;
    
    @Column(name = "provider_id")
    private String providerId;
    
    @Column(name = "fcm_token")
    private String fcmToken;
    
    // Additional fields from AccommodationUser
    @Column(name = "first_name")
    private String firstName;
    
    @Column(name = "last_name")
    private String lastName;
    
    private String nationality;
    
    @Column(name = "residence_country")
    private String residenceCountry;
    
    @Column(name = "residence_state")
    private String residenceState;
    
    @Column(name = "residence_city")
    private String residenceCity;
    
    @Column(name = "preferred_language")
    private String preferredLanguage;
    
    @Column(name = "country_code")
    private String countryCode;
    
    @Column(name = "contact_phone_number")
    private String contactPhoneNumber;
    
    @Column(name = "contact_email")
    private String contactEmail;
    
    // Vendor specific fields
    @Column(name = "business_name")
    private String businessName;
    
    @Column(name = "owner_name")
    private String ownerName;
    
    @Column(name = "business_type")
    private String businessType;
    
    @Column(name = "gst_number")
    private String gstNumber;
    
    @Column(name = "pan_number")
    private String panNumber;
    
    @Column(name = "bank_name")
    private String bankName;
    
    @Column(name = "account_number")
    private String accountNumber;
    
    @Column(name = "ifsc_code")
    private String ifscCode;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    @Column(name = "last_login")
    private LocalDateTime lastLogin;
    
    public User() {}
    
    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    
    public String getProfileImage() { return profileImage; }
    public void setProfileImage(String profileImage) { this.profileImage = profileImage; }
    
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    
    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }
    
    public String getState() { return state; }
    public void setState(String state) { this.state = state; }
    
    public String getPinCode() { return pinCode; }
    public void setPinCode(String pinCode) { this.pinCode = pinCode; }
    public String getPincode() { return pinCode; }
    public void setPincode(String pincode) { this.pinCode = pincode; }
    
    public String getDateOfBirth() { return dateOfBirth; }
    public void setDateOfBirth(String dateOfBirth) { this.dateOfBirth = dateOfBirth; }
    
    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }
    
    public boolean isVerified() { return isVerified; }
    public void setVerified(boolean isVerified) { this.isVerified = isVerified; }
    
    public boolean isActive() { return isActive; }
    public void setActive(boolean isActive) { this.isActive = isActive; }
    
    public boolean isBlocked() { return isBlocked; }
    public void setBlocked(boolean isBlocked) { this.isBlocked = isBlocked; }
    
    public String getBlockedReason() { return blockedReason; }
    public void setBlockedReason(String blockedReason) { this.blockedReason = blockedReason; }
    
    public String getAuthProvider() { return authProvider; }
    public void setAuthProvider(String authProvider) { this.authProvider = authProvider; }
    
    public String getProviderId() { return providerId; }
    public void setProviderId(String providerId) { this.providerId = providerId; }
    
    public String getFcmToken() { return fcmToken; }
    public void setFcmToken(String fcmToken) { this.fcmToken = fcmToken; }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
    
    public LocalDateTime getLastLogin() { return lastLogin; }
    public void setLastLogin(LocalDateTime lastLogin) { this.lastLogin = lastLogin; }
    
    // Role getter and setter
    public UserRole getRole() { return role; }
    public void setRole(UserRole role) { this.role = role; }
    
    // Religion getter and setter
    public Religion getReligion() { return religion; }
    public void setReligion(Religion religion) { this.religion = religion; }
    
    // AccommodationUser compatibility methods
    public String getFullName() { 
        return fullName != null ? fullName : name; 
    }
    public void setFullName(String fullName) { 
        this.fullName = fullName;
        if (name == null) this.name = fullName;
    }
    
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    
    public String getPhoneNumber() { 
        return phoneNumber != null ? phoneNumber : phone; 
    }
    public void setPhoneNumber(String phoneNumber) { 
        this.phoneNumber = phoneNumber;
        if (phone == null) this.phone = phoneNumber;
    }
    
    public Boolean getEmailVerified() { 
        return emailVerified != null ? emailVerified : isVerified; 
    }
    public void setEmailVerified(Boolean emailVerified) { 
        this.emailVerified = emailVerified;
        this.isVerified = emailVerified != null ? emailVerified : false;
    }
    
    // Additional getters and setters
    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }
    
    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }
    
    public String getNationality() { return nationality; }
    public void setNationality(String nationality) { this.nationality = nationality; }
    
    public LocalDate getDob() { return dob; }
    public void setDob(LocalDate dob) { this.dob = dob; }
    
    public String getResidenceCountry() { return residenceCountry; }
    public void setResidenceCountry(String residenceCountry) { this.residenceCountry = residenceCountry; }
    
    public String getResidenceState() { return residenceState; }
    public void setResidenceState(String residenceState) { this.residenceState = residenceState; }
    
    public String getResidenceCity() { return residenceCity; }
    public void setResidenceCity(String residenceCity) { this.residenceCity = residenceCity; }
    
    public String getPreferredLanguage() { return preferredLanguage; }
    public void setPreferredLanguage(String preferredLanguage) { this.preferredLanguage = preferredLanguage; }
    
    public String getCountryCode() { return countryCode; }
    public void setCountryCode(String countryCode) { this.countryCode = countryCode; }
    
    public String getContactPhoneNumber() { return contactPhoneNumber; }
    public void setContactPhoneNumber(String contactPhoneNumber) { this.contactPhoneNumber = contactPhoneNumber; }
    
    public String getContactEmail() { return contactEmail; }
    public void setContactEmail(String contactEmail) { this.contactEmail = contactEmail; }
    
    // Vendor fields
    public String getBusinessName() { return businessName; }
    public void setBusinessName(String businessName) { this.businessName = businessName; }
    
    public String getOwnerName() { return ownerName; }
    public void setOwnerName(String ownerName) { this.ownerName = ownerName; }
    
    public String getBusinessType() { return businessType; }
    public void setBusinessType(String businessType) { this.businessType = businessType; }
    
    public String getGstNumber() { return gstNumber; }
    public void setGstNumber(String gstNumber) { this.gstNumber = gstNumber; }
    
    public String getPanNumber() { return panNumber; }
    public void setPanNumber(String panNumber) { this.panNumber = panNumber; }
    
    public String getBankName() { return bankName; }
    public void setBankName(String bankName) { this.bankName = bankName; }
    
    public String getAccountNumber() { return accountNumber; }
    public void setAccountNumber(String accountNumber) { this.accountNumber = accountNumber; }
    
    public String getIfscCode() { return ifscCode; }
    public void setIfscCode(String ifscCode) { this.ifscCode = ifscCode; }
    
    @PrePersist
    protected void onCreate() {
        if (createdAt == null) createdAt = LocalDateTime.now();
        if (updatedAt == null) updatedAt = LocalDateTime.now();
        // Set fullName from name if not set
        if (fullName == null && name != null) fullName = name;
        // Set name from fullName if not set
        if (name == null && fullName != null) name = fullName;
        // Set phone from phoneNumber if not set
        if (phone == null && phoneNumber != null) phone = phoneNumber;
        // Set phoneNumber from phone if not set
        if (phoneNumber == null && phone != null) phoneNumber = phone;
        // Set emailVerified from isVerified if not set
        if (emailVerified == null) emailVerified = isVerified;
    }
    
    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
}
