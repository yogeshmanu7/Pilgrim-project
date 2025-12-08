package com.pilgrim.entity;

import com.pilgrim.enums.Religion;
import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "temples")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Temple {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(nullable = false)
    private String name;
    
    private String nameHindi;
    
    private String nameTamil;
    
    private String nameTelugu;
    
    @Column(columnDefinition = "TEXT")
    private String description;
    
    @Column(columnDefinition = "TEXT")
    private String descriptionHindi;
    
    @Column(columnDefinition = "TEXT")
    private String history;
    
    @Column(columnDefinition = "TEXT")
    private String historyHindi;
    
    private String mainDeity;
    
    // Religion of the temple
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    @Builder.Default
    private Religion religion = Religion.HINDU;
    
    // ========== HINDU SPECIFIC FIELDS ==========
    
    // ========== CHRISTIAN SPECIFIC FIELDS ==========
    private String pastorName; // Pastor/Priest name
    private String denomination; // e.g., Catholic, Protestant, Orthodox
    @Column(columnDefinition = "TEXT")
    private String massTimes; // Mass/Service timings
    @Column(columnDefinition = "TEXT")
    private String confessionTimes; // Confession timings
    private String churchType; // e.g., Cathedral, Church, Chapel
    
    // ========== MUSLIM SPECIFIC FIELDS ==========
    private String imamName; // Imam name
    private String prayerTimes; // Prayer timings (Fajr, Dhuhr, Asr, Maghrib, Isha)
    private String qiblaDirection; // Qibla direction
    private String mosqueType; // e.g., Masjid, Jama Masjid, Dargah
    
    // ========== JAIN SPECIFIC FIELDS ==========
    private String tirthankara; // Main Tirthankara
    private String jainSect; // e.g., Digambara, Shwetambara
    @Column(columnDefinition = "TEXT")
    private String jainRituals; // Jain specific rituals
    
    // ========== BUDDHISM SPECIFIC FIELDS ==========
    private String buddhaStatue; // Main Buddha statue type
    private String buddhistSect; // e.g., Theravada, Mahayana, Vajrayana
    @Column(columnDefinition = "TEXT")
    private String meditationTimes; // Meditation timings
    
    private String address;
    
    private String city;
    
    private String state;
    
    private String pincode;
    
    private String phone;
    
    private String email;
    
    private String website;
    
    // Map coordinates
    private Double latitude;
    
    private Double longitude;
    
    @Column(columnDefinition = "TEXT")
    private String mapEmbedUrl;
    
    // Timings
    private String morningOpenTime;
    
    private String morningCloseTime;
    
    private String eveningOpenTime;
    
    private String eveningCloseTime;
    
    @Column(columnDefinition = "TEXT")
    private String specialTimings;
    
    // Rules
    @Column(columnDefinition = "TEXT")
    private String rules;
    
    @Column(columnDefinition = "TEXT")
    private String rulesHindi;
    
    private boolean isActive = true;
    
    @ManyToOne
    @JoinColumn(name = "admin_id")
    private User admin;
    
    @OneToMany(mappedBy = "temple", cascade = CascadeType.ALL)
    private List<TemplePhoto> photos;
    
    @OneToMany(mappedBy = "temple", cascade = CascadeType.ALL)
    private List<Darshan> darshans;
    
    @OneToMany(mappedBy = "temple", cascade = CascadeType.ALL)
    private List<TemplePooja> templePoojas;
    
    @OneToMany(mappedBy = "temple", cascade = CascadeType.ALL)
    private List<Prasadham> prasadhams;
    
    @OneToMany(mappedBy = "temple", cascade = CascadeType.ALL)
    private List<Festival> festivals;
    
    @OneToMany(mappedBy = "temple", cascade = CascadeType.ALL)
    private List<TempleEvent> events;
    
    @OneToMany(mappedBy = "temple", cascade = CascadeType.ALL)
    private List<Ritual> rituals;
    
    @OneToMany(mappedBy = "temple", cascade = CascadeType.ALL)
    private List<TourGuide> tourGuides;
    
    @Column(updatable = false)
    private LocalDateTime createdAt;
    
    private LocalDateTime updatedAt;
    
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }
    
    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
    
    // Explicit getters and setters for all fields
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getNameHindi() { return nameHindi; }
    public void setNameHindi(String nameHindi) { this.nameHindi = nameHindi; }
    public String getNameTamil() { return nameTamil; }
    public void setNameTamil(String nameTamil) { this.nameTamil = nameTamil; }
    public String getNameTelugu() { return nameTelugu; }
    public void setNameTelugu(String nameTelugu) { this.nameTelugu = nameTelugu; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getDescriptionHindi() { return descriptionHindi; }
    public void setDescriptionHindi(String descriptionHindi) { this.descriptionHindi = descriptionHindi; }
    public String getHistory() { return history; }
    public void setHistory(String history) { this.history = history; }
    public String getHistoryHindi() { return historyHindi; }
    public void setHistoryHindi(String historyHindi) { this.historyHindi = historyHindi; }
    public String getMainDeity() { return mainDeity; }
    public void setMainDeity(String mainDeity) { this.mainDeity = mainDeity; }
    public Religion getReligion() { return religion; }
    public void setReligion(Religion religion) { this.religion = religion; }
    public String getPastorName() { return pastorName; }
    public void setPastorName(String pastorName) { this.pastorName = pastorName; }
    public String getDenomination() { return denomination; }
    public void setDenomination(String denomination) { this.denomination = denomination; }
    public String getMassTimes() { return massTimes; }
    public void setMassTimes(String massTimes) { this.massTimes = massTimes; }
    public String getConfessionTimes() { return confessionTimes; }
    public void setConfessionTimes(String confessionTimes) { this.confessionTimes = confessionTimes; }
    public String getChurchType() { return churchType; }
    public void setChurchType(String churchType) { this.churchType = churchType; }
    public String getImamName() { return imamName; }
    public void setImamName(String imamName) { this.imamName = imamName; }
    public String getPrayerTimes() { return prayerTimes; }
    public void setPrayerTimes(String prayerTimes) { this.prayerTimes = prayerTimes; }
    public String getQiblaDirection() { return qiblaDirection; }
    public void setQiblaDirection(String qiblaDirection) { this.qiblaDirection = qiblaDirection; }
    public String getMosqueType() { return mosqueType; }
    public void setMosqueType(String mosqueType) { this.mosqueType = mosqueType; }
    public String getTirthankara() { return tirthankara; }
    public void setTirthankara(String tirthankara) { this.tirthankara = tirthankara; }
    public String getJainSect() { return jainSect; }
    public void setJainSect(String jainSect) { this.jainSect = jainSect; }
    public String getJainRituals() { return jainRituals; }
    public void setJainRituals(String jainRituals) { this.jainRituals = jainRituals; }
    public String getBuddhaStatue() { return buddhaStatue; }
    public void setBuddhaStatue(String buddhaStatue) { this.buddhaStatue = buddhaStatue; }
    public String getBuddhistSect() { return buddhistSect; }
    public void setBuddhistSect(String buddhistSect) { this.buddhistSect = buddhistSect; }
    public String getMeditationTimes() { return meditationTimes; }
    public void setMeditationTimes(String meditationTimes) { this.meditationTimes = meditationTimes; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }
    public String getState() { return state; }
    public void setState(String state) { this.state = state; }
    public String getPincode() { return pincode; }
    public void setPincode(String pincode) { this.pincode = pincode; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getWebsite() { return website; }
    public void setWebsite(String website) { this.website = website; }
    public Double getLatitude() { return latitude; }
    public void setLatitude(Double latitude) { this.latitude = latitude; }
    public Double getLongitude() { return longitude; }
    public void setLongitude(Double longitude) { this.longitude = longitude; }
    public String getMapEmbedUrl() { return mapEmbedUrl; }
    public void setMapEmbedUrl(String mapEmbedUrl) { this.mapEmbedUrl = mapEmbedUrl; }
    public String getMorningOpenTime() { return morningOpenTime; }
    public void setMorningOpenTime(String morningOpenTime) { this.morningOpenTime = morningOpenTime; }
    public String getMorningCloseTime() { return morningCloseTime; }
    public void setMorningCloseTime(String morningCloseTime) { this.morningCloseTime = morningCloseTime; }
    public String getEveningOpenTime() { return eveningOpenTime; }
    public void setEveningOpenTime(String eveningOpenTime) { this.eveningOpenTime = eveningOpenTime; }
    public String getEveningCloseTime() { return eveningCloseTime; }
    public void setEveningCloseTime(String eveningCloseTime) { this.eveningCloseTime = eveningCloseTime; }
    public String getSpecialTimings() { return specialTimings; }
    public void setSpecialTimings(String specialTimings) { this.specialTimings = specialTimings; }
    public String getRules() { return rules; }
    public void setRules(String rules) { this.rules = rules; }
    public String getRulesHindi() { return rulesHindi; }
    public void setRulesHindi(String rulesHindi) { this.rulesHindi = rulesHindi; }
    public boolean isActive() { return isActive; }
    public void setIsActive(boolean isActive) { this.isActive = isActive; }
    public User getAdmin() { return admin; }
    public void setAdmin(User admin) { this.admin = admin; }
    public List<TemplePhoto> getPhotos() { return photos; }
    public void setPhotos(List<TemplePhoto> photos) { this.photos = photos; }
    public List<Darshan> getDarshans() { return darshans; }
    public void setDarshans(List<Darshan> darshans) { this.darshans = darshans; }
    public List<TemplePooja> getTemplePoojas() { return templePoojas; }
    public void setTemplePoojas(List<TemplePooja> templePoojas) { this.templePoojas = templePoojas; }
    public List<Prasadham> getPrasadhams() { return prasadhams; }
    public void setPrasadhams(List<Prasadham> prasadhams) { this.prasadhams = prasadhams; }
    public List<Festival> getFestivals() { return festivals; }
    public void setFestivals(List<Festival> festivals) { this.festivals = festivals; }
    public List<TempleEvent> getEvents() { return events; }
    public void setEvents(List<TempleEvent> events) { this.events = events; }
    public List<Ritual> getRituals() { return rituals; }
    public void setRituals(List<Ritual> rituals) { this.rituals = rituals; }
    public List<TourGuide> getTourGuides() { return tourGuides; }
    public void setTourGuides(List<TourGuide> tourGuides) { this.tourGuides = tourGuides; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
    
    // Static builder method for compatibility
    public static TempleBuilder builder() {
        return new TempleBuilder();
    }
    
    // Builder class
    public static class TempleBuilder {
        private Long id;
        private String name;
        private String nameHindi;
        private String nameTamil;
        private String nameTelugu;
        private String description;
        private String descriptionHindi;
        private String history;
        private String historyHindi;
        private String mainDeity;
        private Religion religion = Religion.HINDU;
        private String pastorName;
        private String denomination;
        private String massTimes;
        private String confessionTimes;
        private String churchType;
        private String imamName;
        private String prayerTimes;
        private String qiblaDirection;
        private String mosqueType;
        private String tirthankara;
        private String jainSect;
        private String jainRituals;
        private String buddhaStatue;
        private String buddhistSect;
        private String meditationTimes;
        private String address;
        private String city;
        private String state;
        private String pincode;
        private String phone;
        private String email;
        private String website;
        private Double latitude;
        private Double longitude;
        private String mapEmbedUrl;
        private String morningOpenTime;
        private String morningCloseTime;
        private String eveningOpenTime;
        private String eveningCloseTime;
        private String specialTimings;
        private String rules;
        private String rulesHindi;
        private boolean isActive = true;
        private User admin;
        private List<TemplePhoto> photos;
        private List<Darshan> darshans;
        private List<TemplePooja> templePoojas;
        private List<Prasadham> prasadhams;
        private List<Festival> festivals;
        private List<TempleEvent> events;
        private List<Ritual> rituals;
        private List<TourGuide> tourGuides;
        private LocalDateTime createdAt;
        private LocalDateTime updatedAt;
        
        public TempleBuilder id(Long id) { this.id = id; return this; }
        public TempleBuilder name(String name) { this.name = name; return this; }
        public TempleBuilder nameHindi(String nameHindi) { this.nameHindi = nameHindi; return this; }
        public TempleBuilder nameTamil(String nameTamil) { this.nameTamil = nameTamil; return this; }
        public TempleBuilder nameTelugu(String nameTelugu) { this.nameTelugu = nameTelugu; return this; }
        public TempleBuilder description(String description) { this.description = description; return this; }
        public TempleBuilder descriptionHindi(String descriptionHindi) { this.descriptionHindi = descriptionHindi; return this; }
        public TempleBuilder history(String history) { this.history = history; return this; }
        public TempleBuilder historyHindi(String historyHindi) { this.historyHindi = historyHindi; return this; }
        public TempleBuilder mainDeity(String mainDeity) { this.mainDeity = mainDeity; return this; }
        public TempleBuilder religion(Religion religion) { this.religion = religion; return this; }
        public TempleBuilder pastorName(String pastorName) { this.pastorName = pastorName; return this; }
        public TempleBuilder denomination(String denomination) { this.denomination = denomination; return this; }
        public TempleBuilder massTimes(String massTimes) { this.massTimes = massTimes; return this; }
        public TempleBuilder confessionTimes(String confessionTimes) { this.confessionTimes = confessionTimes; return this; }
        public TempleBuilder churchType(String churchType) { this.churchType = churchType; return this; }
        public TempleBuilder imamName(String imamName) { this.imamName = imamName; return this; }
        public TempleBuilder prayerTimes(String prayerTimes) { this.prayerTimes = prayerTimes; return this; }
        public TempleBuilder qiblaDirection(String qiblaDirection) { this.qiblaDirection = qiblaDirection; return this; }
        public TempleBuilder mosqueType(String mosqueType) { this.mosqueType = mosqueType; return this; }
        public TempleBuilder tirthankara(String tirthankara) { this.tirthankara = tirthankara; return this; }
        public TempleBuilder jainSect(String jainSect) { this.jainSect = jainSect; return this; }
        public TempleBuilder jainRituals(String jainRituals) { this.jainRituals = jainRituals; return this; }
        public TempleBuilder buddhaStatue(String buddhaStatue) { this.buddhaStatue = buddhaStatue; return this; }
        public TempleBuilder buddhistSect(String buddhistSect) { this.buddhistSect = buddhistSect; return this; }
        public TempleBuilder meditationTimes(String meditationTimes) { this.meditationTimes = meditationTimes; return this; }
        public TempleBuilder address(String address) { this.address = address; return this; }
        public TempleBuilder city(String city) { this.city = city; return this; }
        public TempleBuilder state(String state) { this.state = state; return this; }
        public TempleBuilder pincode(String pincode) { this.pincode = pincode; return this; }
        public TempleBuilder phone(String phone) { this.phone = phone; return this; }
        public TempleBuilder email(String email) { this.email = email; return this; }
        public TempleBuilder website(String website) { this.website = website; return this; }
        public TempleBuilder latitude(Double latitude) { this.latitude = latitude; return this; }
        public TempleBuilder longitude(Double longitude) { this.longitude = longitude; return this; }
        public TempleBuilder mapEmbedUrl(String mapEmbedUrl) { this.mapEmbedUrl = mapEmbedUrl; return this; }
        public TempleBuilder morningOpenTime(String morningOpenTime) { this.morningOpenTime = morningOpenTime; return this; }
        public TempleBuilder morningCloseTime(String morningCloseTime) { this.morningCloseTime = morningCloseTime; return this; }
        public TempleBuilder eveningOpenTime(String eveningOpenTime) { this.eveningOpenTime = eveningOpenTime; return this; }
        public TempleBuilder eveningCloseTime(String eveningCloseTime) { this.eveningCloseTime = eveningCloseTime; return this; }
        public TempleBuilder specialTimings(String specialTimings) { this.specialTimings = specialTimings; return this; }
        public TempleBuilder rules(String rules) { this.rules = rules; return this; }
        public TempleBuilder rulesHindi(String rulesHindi) { this.rulesHindi = rulesHindi; return this; }
        public TempleBuilder isActive(boolean isActive) { this.isActive = isActive; return this; }
        public TempleBuilder admin(User admin) { this.admin = admin; return this; }
        public TempleBuilder photos(List<TemplePhoto> photos) { this.photos = photos; return this; }
        public TempleBuilder darshans(List<Darshan> darshans) { this.darshans = darshans; return this; }
        public TempleBuilder templePoojas(List<TemplePooja> templePoojas) { this.templePoojas = templePoojas; return this; }
        public TempleBuilder prasadhams(List<Prasadham> prasadhams) { this.prasadhams = prasadhams; return this; }
        public TempleBuilder festivals(List<Festival> festivals) { this.festivals = festivals; return this; }
        public TempleBuilder events(List<TempleEvent> events) { this.events = events; return this; }
        public TempleBuilder rituals(List<Ritual> rituals) { this.rituals = rituals; return this; }
        public TempleBuilder tourGuides(List<TourGuide> tourGuides) { this.tourGuides = tourGuides; return this; }
        public TempleBuilder createdAt(LocalDateTime createdAt) { this.createdAt = createdAt; return this; }
        public TempleBuilder updatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; return this; }
        
        public Temple build() {
            Temple temple = new Temple();
            temple.setId(id);
            temple.setName(name);
            temple.setNameHindi(nameHindi);
            temple.setNameTamil(nameTamil);
            temple.setNameTelugu(nameTelugu);
            temple.setDescription(description);
            temple.setDescriptionHindi(descriptionHindi);
            temple.setHistory(history);
            temple.setHistoryHindi(historyHindi);
            temple.setMainDeity(mainDeity);
            temple.setReligion(religion);
            temple.setPastorName(pastorName);
            temple.setDenomination(denomination);
            temple.setMassTimes(massTimes);
            temple.setConfessionTimes(confessionTimes);
            temple.setChurchType(churchType);
            temple.setImamName(imamName);
            temple.setPrayerTimes(prayerTimes);
            temple.setQiblaDirection(qiblaDirection);
            temple.setMosqueType(mosqueType);
            temple.setTirthankara(tirthankara);
            temple.setJainSect(jainSect);
            temple.setJainRituals(jainRituals);
            temple.setBuddhaStatue(buddhaStatue);
            temple.setBuddhistSect(buddhistSect);
            temple.setMeditationTimes(meditationTimes);
            temple.setAddress(address);
            temple.setCity(city);
            temple.setState(state);
            temple.setPincode(pincode);
            temple.setPhone(phone);
            temple.setEmail(email);
            temple.setWebsite(website);
            temple.setLatitude(latitude);
            temple.setLongitude(longitude);
            temple.setMapEmbedUrl(mapEmbedUrl);
            temple.setMorningOpenTime(morningOpenTime);
            temple.setMorningCloseTime(morningCloseTime);
            temple.setEveningOpenTime(eveningOpenTime);
            temple.setEveningCloseTime(eveningCloseTime);
            temple.setSpecialTimings(specialTimings);
            temple.setRules(rules);
            temple.setRulesHindi(rulesHindi);
            temple.setIsActive(isActive);
            temple.setAdmin(admin);
            temple.setPhotos(photos);
            temple.setDarshans(darshans);
            temple.setTemplePoojas(templePoojas);
            temple.setPrasadhams(prasadhams);
            temple.setFestivals(festivals);
            temple.setEvents(events);
            temple.setRituals(rituals);
            temple.setTourGuides(tourGuides);
            temple.setCreatedAt(createdAt);
            temple.setUpdatedAt(updatedAt);
            return temple;
        }
    }
}

