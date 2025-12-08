package com.pilgrim.enums;

public enum DarshanType {
    // Hindu/Jain types
    FREE("Free Darshan", "Free entry for all devotees"),
    SPECIAL("Special Darshan", "Priority entry with minimal waiting time"),
    VIP("VIP Darshan", "Direct darshan with special privileges"),
    VVIP("VVIP Darshan", "Exclusive darshan with personal assistance"),
    SENIOR_CITIZEN("Senior Citizen", "Special queue for elderly devotees"),
    PHYSICALLY_CHALLENGED("Physically Challenged", "Accessible entry for differently abled"),
    
    // Christian types
    REGULAR_SERVICE("Regular Service", "Standard worship service"),
    MASS("Mass", "Eucharistic celebration"),
    CONFESSION("Confession", "Sacrament of reconciliation"),
    BAPTISM("Baptism", "Sacrament of baptism"),
    MARRIAGE("Marriage", "Wedding ceremony"),
    FUNERAL("Funeral", "Funeral service"),
    
    // Muslim types
    FAJR("Fajr Prayer", "Dawn prayer"),
    DHUHR("Dhuhr Prayer", "Midday prayer"),
    ASR("Asr Prayer", "Afternoon prayer"),
    MAGHRIB("Maghrib Prayer", "Sunset prayer"),
    ISHA("Isha Prayer", "Night prayer"),
    JUMAH("Jumah Prayer", "Friday congregational prayer"),
    TARAWEEH("Taraweeh Prayer", "Ramadan night prayer"),
    
    // Buddhism types
    MEDITATION("Meditation Session", "Meditation practice"),
    DHARMA_TALK("Dharma Talk", "Buddhist teaching session"),
    CHANTING("Chanting Session", "Buddhist chanting practice"),
    OFFERING("Offering Ceremony", "Offering ceremony"),
    BODHI_PUJA("Bodhi Puja", "Bodhi tree worship");
    
    private final String displayName;
    private final String description;
    
    DarshanType(String displayName, String description) {
        this.displayName = displayName;
        this.description = description;
    }
    
    public String getDisplayName() {
        return displayName;
    }
    
    public String getDescription() {
        return description;
    }
}

