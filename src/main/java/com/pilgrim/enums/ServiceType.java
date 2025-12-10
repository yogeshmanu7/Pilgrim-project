package com.pilgrim.enums;

public enum ServiceType {
    // Puja & Hawan Services
    GANAPATHI_HOMA("Ganapathi Homa"),
    SATYANARAYANA_POOJA("Satyanarayana Pooja"),
    RUDRABHISHEKA("Rudrabhisheka"),
    CHANDI_HAWAN("Chandi Hawan"),
    EKACHANDI_HAWAN("Ekachandi Hawan"),
    NAVCHANDI_HAWAN("Navchandi Hawan"),
    MAHALAXMI_POOJA("Mahalaxmi Pooja"),
    DURGA_POOJA("Durga Pooja"),
    SHIV_POOJA("Shiv Pooja"),
    VISHNU_POOJA("Vishnu Pooja"),
    HANUMAN_POOJA("Hanuman Pooja"),
    LAXMI_NARAYAN_POOJA("Laxmi Narayan Pooja"),
    GAYATRI_HAWAN("Gayatri Hawan"),
    SUDARSHAN_HAWAN("Sudarshan Hawan"),
    SHANTI_HAWAN("Shanti Hawan"),
    GRAH_SHANTI_POOJA("Grah Shanti Pooja"),
    NAVGRAH_POOJA("Navgrah Pooja"),
    SANTAN_GOPAL_POOJA("Santan Gopal Pooja"),
    AYUSH_HOMAM("Ayush Homam"),
    
    // Griha Pravesh & Vastu
    GRIHAPRAVESHA("Grihapravesha"),
    VASTU_POOJA("Vastu Pooja"),
    VASTU_CONSULTATION("Vastu Consultation"),
    BHOOMI_POOJA("Bhoomi Pooja"),
    
    // Marriage & Relationship Services
    VIVAH_POOJA("Vivah Pooja"),
    MARRIAGE_MATCHING("Marriage Matching"),
    MANGAL_DOSHA_REMEDY("Mangal Dosha Remedy"),
    KUNDALI_MATCHING("Kundali Matching"),
    ENGAGEMENT_POOJA("Engagement Pooja"),
    
    // Astrology Services
    KUNDALI_READING("Kundali Reading"),
    HOROSCOPE_PREDICTION("Horoscope Prediction"),
    BIRTH_CHART_ANALYSIS("Birth Chart Analysis"),
    DASHA_PREDICTION("Dasha Prediction"),
    REMEDIAL_ASTROLOGY("Remedial Astrology"),
    PLANETARY_REMEDIES("Planetary Remedies"),
    
    // Special Occasions & Festivals
    BIRTHDAY_POOJA("Birthday Pooja"),
    ANNIVERSARY_POOJA("Anniversary Pooja"),
    NEW_YEAR_POOJA("New Year Pooja"),
    FESTIVAL_POOJA("Festival Pooja"),
    KATHA_PAATH("Katha Paath"),
    RAMAYAN_PAATH("Ramayan Paath"),
    BHAGAVAT_PAATH("Bhagavat Paath"),
    SUNDARKAND_PAATH("Sundarkand Paath"),
    
    // Business & Prosperity
    BUSINESS_POOJA("Business Pooja"),
    VEHICLE_POOJA("Vehicle Pooja"),
    DHANTERAS_POOJA("Dhanteras Pooja"),
    LAXMI_POOJA("Laxmi Pooja"),
    KUBER_POOJA("Kuber Pooja"),
    
    // Health & Wellbeing
    RUDRA_ABHISHEK("Rudra Abhishek"),
    MAHA_MRITYUNJAYA_JAAP("Maha Mrityunjaya Jaap"),
    HEALTH_POOJA("Health Pooja"),
    
    // Education & Knowledge
    SARASWATI_POOJA("Saraswati Pooja"),
    VIDYA_POOJA("Vidya Pooja"),
    EXAM_SUCCESS_POOJA("Exam Success Pooja");
      
    private final String label;

    ServiceType(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }
}

