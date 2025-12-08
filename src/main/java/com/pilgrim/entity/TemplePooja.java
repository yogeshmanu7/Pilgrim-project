package com.pilgrim.entity;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

@Entity
@Table(name = "temple_poojas")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TemplePooja {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne
    @JoinColumn(name = "temple_id", nullable = false)
    private Temple temple;
    
    @Column(nullable = false)
    private String name;
    
    private String nameHindi;
    
    private String nameTamil;
    
    @Enumerated(EnumType.STRING)
    private PoojaCategory category;
    
    @Column(columnDefinition = "TEXT")
    private String description;
    
    @Column(columnDefinition = "TEXT")
    private String descriptionHindi;
    
    @Column(columnDefinition = "TEXT")
    private String significance;
    
    @Column(name = "pooja_procedure", columnDefinition = "TEXT")
    private String poojaProcedure;
    
    @Column(precision = 10, scale = 2, nullable = false)
    private BigDecimal price;
    
    private Integer durationMinutes;
    
    private LocalTime defaultTime;
    
    @Column(columnDefinition = "TEXT")
    private String availableDays; // JSON array of days like ["MONDAY", "TUESDAY"]
    
    private Integer maxBookingsPerDay;
    
    @Column(columnDefinition = "TEXT")
    private String itemsIncluded;
    
    @Column(columnDefinition = "TEXT")
    private String benefits;
    
    private String imageUrl;
    
    @Builder.Default
    private boolean isActive = true;
    
    @Builder.Default
    private boolean requiresAdvanceBooking = true;
    
    @Builder.Default
    private Integer advanceBookingDays = 7;
    
    @OneToMany(mappedBy = "pooja", cascade = CascadeType.ALL)
    private List<PoojaBooking> bookings;
    
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
    
    // Explicit constructors
    public TemplePooja() {
    }
    
    // Static builder method
    public static TemplePoojaBuilder builder() {
        return new TemplePoojaBuilder();
    }
    
    // Builder class
    public static class TemplePoojaBuilder {
        private Long id;
        private Temple temple;
        private String name;
        private String nameHindi;
        private String nameTamil;
        private PoojaCategory category;
        private String description;
        private String descriptionHindi;
        private String significance;
        private String poojaProcedure;
        private BigDecimal price;
        private Integer durationMinutes;
        private LocalTime defaultTime;
        private String availableDays;
        private Integer maxBookingsPerDay;
        private String itemsIncluded;
        private String benefits;
        private String imageUrl;
        private boolean isActive = true;
        private boolean requiresAdvanceBooking = true;
        private Integer advanceBookingDays = 7;
        private List<PoojaBooking> bookings;
        private LocalDateTime createdAt;
        private LocalDateTime updatedAt;
        
        public TemplePoojaBuilder id(Long id) { this.id = id; return this; }
        public TemplePoojaBuilder temple(Temple temple) { this.temple = temple; return this; }
        public TemplePoojaBuilder name(String name) { this.name = name; return this; }
        public TemplePoojaBuilder nameHindi(String nameHindi) { this.nameHindi = nameHindi; return this; }
        public TemplePoojaBuilder nameTamil(String nameTamil) { this.nameTamil = nameTamil; return this; }
        public TemplePoojaBuilder category(PoojaCategory category) { this.category = category; return this; }
        public TemplePoojaBuilder description(String description) { this.description = description; return this; }
        public TemplePoojaBuilder descriptionHindi(String descriptionHindi) { this.descriptionHindi = descriptionHindi; return this; }
        public TemplePoojaBuilder significance(String significance) { this.significance = significance; return this; }
        public TemplePoojaBuilder poojaProcedure(String poojaProcedure) { this.poojaProcedure = poojaProcedure; return this; }
        public TemplePoojaBuilder price(BigDecimal price) { this.price = price; return this; }
        public TemplePoojaBuilder durationMinutes(Integer durationMinutes) { this.durationMinutes = durationMinutes; return this; }
        public TemplePoojaBuilder defaultTime(LocalTime defaultTime) { this.defaultTime = defaultTime; return this; }
        public TemplePoojaBuilder availableDays(String availableDays) { this.availableDays = availableDays; return this; }
        public TemplePoojaBuilder maxBookingsPerDay(Integer maxBookingsPerDay) { this.maxBookingsPerDay = maxBookingsPerDay; return this; }
        public TemplePoojaBuilder itemsIncluded(String itemsIncluded) { this.itemsIncluded = itemsIncluded; return this; }
        public TemplePoojaBuilder benefits(String benefits) { this.benefits = benefits; return this; }
        public TemplePoojaBuilder imageUrl(String imageUrl) { this.imageUrl = imageUrl; return this; }
        public TemplePoojaBuilder isActive(boolean isActive) { this.isActive = isActive; return this; }
        public TemplePoojaBuilder requiresAdvanceBooking(boolean requiresAdvanceBooking) { this.requiresAdvanceBooking = requiresAdvanceBooking; return this; }
        public TemplePoojaBuilder advanceBookingDays(Integer advanceBookingDays) { this.advanceBookingDays = advanceBookingDays; return this; }
        public TemplePoojaBuilder bookings(List<PoojaBooking> bookings) { this.bookings = bookings; return this; }
        public TemplePoojaBuilder createdAt(LocalDateTime createdAt) { this.createdAt = createdAt; return this; }
        public TemplePoojaBuilder updatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; return this; }
        
        public TemplePooja build() {
            TemplePooja pooja = new TemplePooja();
            pooja.setId(id);
            pooja.setTemple(temple);
            pooja.setName(name);
            pooja.setNameHindi(nameHindi);
            pooja.setNameTamil(nameTamil);
            pooja.setCategory(category);
            pooja.setDescription(description);
            pooja.setDescriptionHindi(descriptionHindi);
            pooja.setSignificance(significance);
            pooja.setPoojaProcedure(poojaProcedure);
            pooja.setPrice(price);
            pooja.setDurationMinutes(durationMinutes);
            pooja.setDefaultTime(defaultTime);
            pooja.setAvailableDays(availableDays);
            pooja.setMaxBookingsPerDay(maxBookingsPerDay);
            pooja.setItemsIncluded(itemsIncluded);
            pooja.setBenefits(benefits);
            pooja.setImageUrl(imageUrl);
            pooja.setIsActive(isActive);
            pooja.setRequiresAdvanceBooking(requiresAdvanceBooking);
            pooja.setAdvanceBookingDays(advanceBookingDays);
            pooja.setBookings(bookings);
            pooja.setCreatedAt(createdAt);
            pooja.setUpdatedAt(updatedAt);
            return pooja;
        }
    }
    
    // Explicit getters and setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Temple getTemple() { return temple; }
    public void setTemple(Temple temple) { this.temple = temple; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getNameHindi() { return nameHindi; }
    public void setNameHindi(String nameHindi) { this.nameHindi = nameHindi; }
    public String getNameTamil() { return nameTamil; }
    public void setNameTamil(String nameTamil) { this.nameTamil = nameTamil; }
    public PoojaCategory getCategory() { return category; }
    public void setCategory(PoojaCategory category) { this.category = category; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getDescriptionHindi() { return descriptionHindi; }
    public void setDescriptionHindi(String descriptionHindi) { this.descriptionHindi = descriptionHindi; }
    public String getSignificance() { return significance; }
    public void setSignificance(String significance) { this.significance = significance; }
    public String getPoojaProcedure() { return poojaProcedure; }
    public void setPoojaProcedure(String poojaProcedure) { this.poojaProcedure = poojaProcedure; }
    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }
    public Integer getDurationMinutes() { return durationMinutes; }
    public void setDurationMinutes(Integer durationMinutes) { this.durationMinutes = durationMinutes; }
    public LocalTime getDefaultTime() { return defaultTime; }
    public void setDefaultTime(LocalTime defaultTime) { this.defaultTime = defaultTime; }
    public String getAvailableDays() { return availableDays; }
    public void setAvailableDays(String availableDays) { this.availableDays = availableDays; }
    public Integer getMaxBookingsPerDay() { return maxBookingsPerDay; }
    public void setMaxBookingsPerDay(Integer maxBookingsPerDay) { this.maxBookingsPerDay = maxBookingsPerDay; }
    public String getItemsIncluded() { return itemsIncluded; }
    public void setItemsIncluded(String itemsIncluded) { this.itemsIncluded = itemsIncluded; }
    public String getBenefits() { return benefits; }
    public void setBenefits(String benefits) { this.benefits = benefits; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    public boolean isActive() { return isActive; }
    public void setIsActive(boolean isActive) { this.isActive = isActive; }
    public boolean isRequiresAdvanceBooking() { return requiresAdvanceBooking; }
    public void setRequiresAdvanceBooking(boolean requiresAdvanceBooking) { this.requiresAdvanceBooking = requiresAdvanceBooking; }
    public Integer getAdvanceBookingDays() { return advanceBookingDays; }
    public void setAdvanceBookingDays(Integer advanceBookingDays) { this.advanceBookingDays = advanceBookingDays; }
    public List<PoojaBooking> getBookings() { return bookings; }
    public void setBookings(List<PoojaBooking> bookings) { this.bookings = bookings; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
    
    public enum PoojaCategory {
        // Hindu types
        DAILY("Daily Pooja"),
        WEEKLY("Weekly Pooja"),
        MONTHLY("Monthly Pooja"),
        SPECIAL("Special Pooja"),
        FESTIVAL("Festival Pooja"),
        ARCHANA("Archana"),
        ABHISHEKAM("Abhishekam"),
        HOMAM("Homam/Havan"),
        SEVA("Seva"),
        
        // Christian types
        SUNDAY_MASS("Sunday Mass"),
        WEEKDAY_MASS("Weekday Mass"),
        HOLY_MASS("Holy Mass"),
        ROSARY("Rosary"),
        NOVENA("Novena"),
        ADORATION("Adoration"),
        BAPTISM_SERVICE("Baptism Service"),
        CONFIRMATION("Confirmation"),
        MARRIAGE_SERVICE("Marriage Service"),
        
        // Muslim types
        DAILY_PRAYER("Daily Prayer"),
        FRIDAY_PRAYER("Friday Prayer"),
        EID_PRAYER("Eid Prayer"),
        TARAWEEH("Taraweeh"),
        TAHJJUD("Tahajjud"),
        DUHA("Duha Prayer"),
        ISTIKHARA("Istikhara Prayer"),
        
        // Jain types
        DAILY_RITUAL("Daily Ritual"),
        WEEKLY_RITUAL("Weekly Ritual"),
        MONTHLY_RITUAL("Monthly Ritual"),
        FESTIVAL_RITUAL("Festival Ritual"),
        
        // Buddhism types
        DAILY_CEREMONY("Daily Ceremony"),
        WEEKLY_CEREMONY("Weekly Ceremony"),
        MONTHLY_CEREMONY("Monthly Ceremony"),
        FESTIVAL_CEREMONY("Festival Ceremony"),
        MEDITATION("Meditation"),
        CHANTING("Chanting"),
        OFFERING_CEREMONY("Offering Ceremony");
        
        private final String displayName;
        
        PoojaCategory(String displayName) {
            this.displayName = displayName;
        }
        
        public String getDisplayName() {
            return displayName;
        }
    }
}

