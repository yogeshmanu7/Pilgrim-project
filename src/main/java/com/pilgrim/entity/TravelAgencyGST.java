package com.pilgrim.entity;

import com.pilgrim.enums.YesNo;
import jakarta.persistence.*;

@Entity
@Table(name = "travel_agency_gst")
public class TravelAgencyGST {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Long agencyId;

    @Enumerated(EnumType.STRING)
    @Column(length = 10)
    private YesNo hasGstin;

    @Enumerated(EnumType.STRING)
    @Column(length = 10)
    private YesNo turnoverExceeded20L;

    private String stateName;
    private String stateCode;
    private String gstin;
    private boolean headOffice;

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Long getAgencyId() { return agencyId; }
    public void setAgencyId(Long agencyId) { this.agencyId = agencyId; }

    public YesNo getHasGstin() { return hasGstin; }
    public void setHasGstin(YesNo hasGstin) { this.hasGstin = hasGstin; }

    public YesNo getTurnoverExceeded20L() { return turnoverExceeded20L; }
    public void setTurnoverExceeded20L(YesNo turnoverExceeded20L) { this.turnoverExceeded20L = turnoverExceeded20L; }

    public String getStateName() { return stateName; }
    public void setStateName(String stateName) { this.stateName = stateName; }

    public String getStateCode() { return stateCode; }
    public void setStateCode(String stateCode) { this.stateCode = stateCode; }

    public String getGstin() { return gstin; }
    public void setGstin(String gstin) { this.gstin = gstin; }

    public boolean isHeadOffice() { return headOffice; }
    public void setHeadOffice(boolean headOffice) { this.headOffice = headOffice; }
}

