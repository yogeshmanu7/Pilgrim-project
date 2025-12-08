package com.pilgrim.enums;

public enum UserRole {
    CUSTOMER,           // General customer for all modules
    SCHOLAR,            // Religious scholar/astrologer
    VENDOR,             // Pooja items vendor
    ADMIN,              // System administrator
    PROPERTY_OWNER,     // Accommodation property owner
    PILGRIM,            // Accommodation guest/pilgrim (same as CUSTOMER but specific to accommodation)
    TEMPLE_ADMIN,       // Temple administrator (from Temple module)
    TOUR_GUIDE          // Tour guide (from Temple module)
}

