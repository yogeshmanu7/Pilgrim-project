package com.pilgrim.enums;

public enum Religion {
    HINDU("Hindu"),
    CHRISTIAN("Christian"),
    MUSLIM("Muslim"),
    JAIN("Jain"),
    BUDDHISM("Buddhism"),
    SIKH("Sikh"),
    OTHER("Other");
    
    private final String displayName;
    
    Religion(String displayName) {
        this.displayName = displayName;
    }
    
    public String getDisplayName() {
        return displayName;
    }
}

