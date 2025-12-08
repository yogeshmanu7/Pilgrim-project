package com.pilgrim.entity;

import com.pilgrim.enums.BusinessBackground;
import com.pilgrim.enums.YesNo;
import jakarta.persistence.*;

@Entity
@Table(name = "travel_agency_personal")
public class TravelAgencyPersonal {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Long agencyId;

    private String travelsName;
    private String ownerName;

    @Enumerated(EnumType.STRING)
    @Column(length = 50)
    private BusinessBackground businessBackground;

    private String businessBackgroundOther;
    private String pincode;
    private String country;
    private String state;
    private String district;
    private String city;
    private String address;
    private String mobile;
    private String phone;
    private String email;
    private String alternateEmail;
    private String pan;

    @Enumerated(EnumType.STRING)
    @Column(length = 10)
    private YesNo msme;

    private String msmeNumber;
    private String cin;

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Long getAgencyId() { return agencyId; }
    public void setAgencyId(Long agencyId) { this.agencyId = agencyId; }

    public String getTravelsName() { return travelsName; }
    public void setTravelsName(String travelsName) { this.travelsName = travelsName; }

    public String getOwnerName() { return ownerName; }
    public void setOwnerName(String ownerName) { this.ownerName = ownerName; }

    public BusinessBackground getBusinessBackground() { return businessBackground; }
    public void setBusinessBackground(BusinessBackground businessBackground) { this.businessBackground = businessBackground; }

    public String getBusinessBackgroundOther() { return businessBackgroundOther; }
    public void setBusinessBackgroundOther(String businessBackgroundOther) { this.businessBackgroundOther = businessBackgroundOther; }

    public String getPincode() { return pincode; }
    public void setPincode(String pincode) { this.pincode = pincode; }

    public String getCountry() { return country; }
    public void setCountry(String country) { this.country = country; }

    public String getState() { return state; }
    public void setState(String state) { this.state = state; }

    public String getDistrict() { return district; }
    public void setDistrict(String district) { this.district = district; }

    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getMobile() { return mobile; }
    public void setMobile(String mobile) { this.mobile = mobile; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getAlternateEmail() { return alternateEmail; }
    public void setAlternateEmail(String alternateEmail) { this.alternateEmail = alternateEmail; }

    public String getPan() { return pan; }
    public void setPan(String pan) { this.pan = pan; }

    public YesNo getMsme() { return msme; }
    public void setMsme(YesNo msme) { this.msme = msme; }

    public String getMsmeNumber() { return msmeNumber; }
    public void setMsmeNumber(String msmeNumber) { this.msmeNumber = msmeNumber; }

    public String getCin() { return cin; }
    public void setCin(String cin) { this.cin = cin; }
}

