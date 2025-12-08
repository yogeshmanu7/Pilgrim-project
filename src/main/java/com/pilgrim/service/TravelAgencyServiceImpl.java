package com.pilgrim.service;

import com.pilgrim.entity.*;
import com.pilgrim.enums.ApprovalStatus;
import com.pilgrim.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TravelAgencyServiceImpl implements TravelAgencyService {

    @Autowired private TravelAgencyRepository agencyRepository;
    @Autowired private TravelAgencyOtpRepository otpRepository;
    @Autowired private TravelAgencyPersonalRepository personalRepository;
    @Autowired private TravelAgencyBankRepository bankRepository;
    @Autowired private TravelAgencyGSTRepository gstRepository;
    @Autowired private TravelAgencyDocumentsRepository documentsRepository;

    @Override
    public TravelAgencyPersonal savePersonalDetails(TravelAgencyPersonal personal) {
        TravelAgencyPersonal existing = personalRepository.findByAgencyId(personal.getAgencyId());
        if (existing != null) {
            personal.setId(existing.getId());
        }
        return personalRepository.save(personal);
    }

    @Override
    public TravelAgencyBank saveBankDetails(TravelAgencyBank bank) {
        TravelAgencyBank existing = bankRepository.findByAgencyId(bank.getAgencyId());
        if (existing != null) {
            bank.setId(existing.getId());
        }
        return bankRepository.save(bank);
    }

    @Override
    public TravelAgencyGST saveGstDetails(TravelAgencyGST gst) {
        TravelAgencyGST existing = gstRepository.findByAgencyId(gst.getAgencyId());
        if (existing != null) {
            gst.setId(existing.getId());
        }
        return gstRepository.save(gst);
    }

    @Override
    public TravelAgencyDocuments saveDocuments(TravelAgencyDocuments documents) {
        TravelAgencyDocuments existing = documentsRepository.findByAgencyId(documents.getAgencyId());

        if (existing != null) {
            documents.setId(existing.getId());

            if (documents.getCancelledCheque() == null) {
                documents.setCancelledCheque(existing.getCancelledCheque());
            }
            if (documents.getPanCard() == null) {
                documents.setPanCard(existing.getPanCard());
            }
            if (documents.getGstCertificate() == null) {
                documents.setGstCertificate(existing.getGstCertificate());
            }
            if (documents.getMsmeDoc() == null) {
                documents.setMsmeDoc(existing.getMsmeDoc());
            }
            if (documents.getIdProof() == null) {
                documents.setIdProof(existing.getIdProof());
            }
            if (documents.getCoiDoc() == null) {
                documents.setCoiDoc(existing.getCoiDoc());
            }
        }

        return documentsRepository.save(documents);
    }

    @Override
    public TravelAgencyDocuments findDocumentsByAgencyId(Long agencyId) {
        return documentsRepository.findByAgencyId(agencyId);
    }

    @Override
    public TravelAgencyPersonal findPersonalByAgencyId(Long agencyId) {
        return personalRepository.findByAgencyId(agencyId);
    }

    @Override
    public TravelAgencyBank findBankByAgencyId(Long agencyId) {
        return bankRepository.findByAgencyId(agencyId);
    }

    @Override
    public TravelAgencyGST findGstByAgencyId(Long agencyId) {
        return gstRepository.findByAgencyId(agencyId);
    }

    @Override
    public TravelAgencyOtp saveOtp(TravelAgencyOtp otp) {
        TravelAgencyOtp old = otpRepository.findByEmail(otp.getEmail());
        if (old != null) otpRepository.delete(old);
        return otpRepository.save(otp);
    }

    @Override
    public TravelAgencyOtp getOtpByEmail(String email) {
        return otpRepository.findByEmail(email);
    }

    @Override
    public TravelAgency saveAgency(TravelAgency agency) {
        return agencyRepository.save(agency);
    }

    @Override
    public TravelAgency findByEmail(String email) {
        return agencyRepository.findByEmail(email);
    }

    @Override
    public TravelAgency findByMobile(String mobile) {
        return agencyRepository.findByMobile(mobile);
    }

    @Override
    public TravelAgency findById(Long id) {
        return agencyRepository.findById(id).orElse(null);
    }

    @Override
    public List<TravelAgency> getAllAgencies() {
        return agencyRepository.findAll();
    }

    @Override
    public List<TravelAgency> getPendingAgencies() {
        return agencyRepository.findByApprovalStatus(ApprovalStatus.PENDING);
    }

    @Override
    public List<TravelAgency> getApprovedAgencies() {
        return agencyRepository.findByApprovalStatus(ApprovalStatus.APPROVED);
    }

    @Override
    public List<TravelAgency> getRejectedAgencies() {
        return agencyRepository.findByApprovalStatus(ApprovalStatus.REJECTED);
    }

    @Override
    public TravelAgency approveAgency(Long agencyId) {
        TravelAgency agency = findById(agencyId);
        if (agency != null) {
            agency.setApprovalStatus(ApprovalStatus.APPROVED);
            agency.setActive(true);
            return agencyRepository.save(agency);
        }
        return null;
    }

    @Override
    public TravelAgency rejectAgency(Long agencyId) {
        TravelAgency agency = findById(agencyId);
        if (agency != null) {
            agency.setApprovalStatus(ApprovalStatus.REJECTED);
            agency.setActive(false);
            return agencyRepository.save(agency);
        }
        return null;
    }

    @Override
    public void updateDocumentPaths(Long agencyId, TravelAgencyDocuments docs) {
        TravelAgencyDocuments existing = documentsRepository.findByAgencyId(agencyId);
        if (existing != null) {
            docs.setId(existing.getId());
        }
        documentsRepository.save(docs);
    }

    @Override
    public boolean isAgencyApproved(String email) {
        TravelAgency agency = findByEmail(email);
        return agency != null && agency.getApprovalStatus() == ApprovalStatus.APPROVED;
    }

    @Override
    public TravelAgency login(String emailOrMobile, String password) {
        TravelAgency agency = agencyRepository.findByEmailOrMobile(emailOrMobile, emailOrMobile);
        if (agency == null) return null;

        if (!agency.getPassword().equals(password)) return null;

        if (agency.getApprovalStatus() == ApprovalStatus.PENDING) {
            return null;
        }
        return agency;
    }

    @Override
    public boolean resetPassword(String emailOrMobile, String newPassword) {
        TravelAgency agency = agencyRepository.findByEmailOrMobile(emailOrMobile, emailOrMobile);
        if (agency == null) return false;
        agency.setPassword(newPassword);
        agencyRepository.save(agency);
        return true;
    }
}

