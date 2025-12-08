package com.pilgrim.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "travel_agency_documents")
public class TravelAgencyDocuments {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Long agencyId;

    private String cancelledCheque;
    private String panCard;
    private String gstCertificate;
    private String msmeDoc;
    private String idProof;
    private String coiDoc;

    private boolean declaration;

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Long getAgencyId() { return agencyId; }
    public void setAgencyId(Long agencyId) { this.agencyId = agencyId; }

    public String getCancelledCheque() { return cancelledCheque; }
    public void setCancelledCheque(String cancelledCheque) { this.cancelledCheque = cancelledCheque; }

    public String getPanCard() { return panCard; }
    public void setPanCard(String panCard) { this.panCard = panCard; }

    public String getGstCertificate() { return gstCertificate; }
    public void setGstCertificate(String gstCertificate) { this.gstCertificate = gstCertificate; }

    public String getMsmeDoc() { return msmeDoc; }
    public void setMsmeDoc(String msmeDoc) { this.msmeDoc = msmeDoc; }

    public String getIdProof() { return idProof; }
    public void setIdProof(String idProof) { this.idProof = idProof; }

    public String getCoiDoc() { return coiDoc; }
    public void setCoiDoc(String coiDoc) { this.coiDoc = coiDoc; }

    public boolean isDeclaration() { return declaration; }
    public void setDeclaration(boolean declaration) { this.declaration = declaration; }
}

