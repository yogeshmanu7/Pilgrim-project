package com.pilgrim.service;

import com.pilgrim.entity.*;
import java.util.List;

public interface TravelAgencyService {

    // --------------------------------------------------
    // REGISTRATION FLOW (Personal, Bank, GST, Documents)
    // --------------------------------------------------
    TravelAgencyPersonal savePersonalDetails(TravelAgencyPersonal personal);
    TravelAgencyBank saveBankDetails(TravelAgencyBank bank);
    TravelAgencyGST saveGstDetails(TravelAgencyGST gst);
    TravelAgencyDocuments saveDocuments(TravelAgencyDocuments documents);

    // --------------------------------------------------
    // OTP — EMAIL ONLY
    // --------------------------------------------------
    TravelAgencyOtp saveOtp(TravelAgencyOtp otp);
    TravelAgencyOtp getOtpByEmail(String email);

    // --------------------------------------------------
    // AGENCY CRUD
    // --------------------------------------------------
    TravelAgency saveAgency(TravelAgency agency);
    TravelAgency findByEmail(String email);
    TravelAgency findByMobile(String mobile);
    TravelAgency findById(Long id);

    List<TravelAgency> getAllAgencies();
    List<TravelAgency> getPendingAgencies();
    List<TravelAgency> getApprovedAgencies();
    List<TravelAgency> getRejectedAgencies();

    // --------------------------------------------------
    // ADMIN APPROVAL + VIEW DETAILS
    // --------------------------------------------------
    TravelAgency approveAgency(Long id);
    TravelAgency rejectAgency(Long id);

    TravelAgencyPersonal findPersonalByAgencyId(Long agencyId);
    TravelAgencyBank findBankByAgencyId(Long agencyId);
    TravelAgencyGST findGstByAgencyId(Long agencyId);
    TravelAgencyDocuments findDocumentsByAgencyId(Long agencyId);

    // --------------------------------------------------
    // DOCUMENT PATH UPDATE
    // --------------------------------------------------
    void updateDocumentPaths(Long agencyId, TravelAgencyDocuments docs);

    // --------------------------------------------------
    // APPROVAL CHECK
    // --------------------------------------------------
    boolean isAgencyApproved(String email);

    // --------------------------------------------------
    // LOGIN + PASSWORD MANAGEMENT
    // --------------------------------------------------
    TravelAgency login(String emailOrMobile, String password);
    boolean resetPassword(String emailOrMobile, String newPassword);
}

