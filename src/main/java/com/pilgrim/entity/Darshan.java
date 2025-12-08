package com.pilgrim.entity;

import com.pilgrim.enums.DarshanType;
import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

@Entity
@Table(name = "darshans")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Darshan {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne
    @JoinColumn(name = "temple_id", nullable = false)
    private Temple temple;
    
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private DarshanType darshanType;
    
    private String name;
    
    private String nameHindi;
    
    @Column(precision = 10, scale = 2)
    private BigDecimal price;
    
    private Integer durationMinutes;
    
    @Column(columnDefinition = "TEXT")
    private String benefits;
    
    @Column(columnDefinition = "TEXT")
    private String instructions;
    
    @Builder.Default
    private boolean requiresBooking = true;
    
    private LocalTime startTime;
    
    private LocalTime endTime;
    
    private Integer maxBookingsPerSlot;
    
    private LocalDate bookingStartDate;
    
    private LocalDate bookingEndDate;
    
    @Column(columnDefinition = "TEXT")
    private String description;
    
    @Builder.Default
    private boolean isActive = true;
    
    @OneToMany(mappedBy = "darshan", cascade = CascadeType.ALL)
    private List<DarshanBooking> bookings;
    
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
    public Darshan() {
    }
    
    public Darshan(Long id, Temple temple, DarshanType darshanType, String name, String nameHindi,
                   BigDecimal price, Integer durationMinutes, String benefits, String instructions,
                   boolean requiresBooking, LocalTime startTime, LocalTime endTime, Integer maxBookingsPerSlot,
                   LocalDate bookingStartDate, LocalDate bookingEndDate, String description,
                   boolean isActive, List<DarshanBooking> bookings, LocalDateTime createdAt, 
                   LocalDateTime updatedAt) {
        this.id = id;
        this.temple = temple;
        this.darshanType = darshanType;
        this.name = name;
        this.nameHindi = nameHindi;
        this.price = price;
        this.durationMinutes = durationMinutes;
        this.benefits = benefits;
        this.instructions = instructions;
        this.requiresBooking = requiresBooking;
        this.startTime = startTime;
        this.endTime = endTime;
        this.maxBookingsPerSlot = maxBookingsPerSlot;
        this.bookingStartDate = bookingStartDate;
        this.bookingEndDate = bookingEndDate;
        this.description = description;
        this.isActive = isActive;
        this.bookings = bookings;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }
    
    // Static builder method
    public static DarshanBuilder builder() {
        return new DarshanBuilder();
    }
    
    // Builder class
    public static class DarshanBuilder {
        private Long id;
        private Temple temple;
        private DarshanType darshanType;
        private String name;
        private String nameHindi;
        private BigDecimal price;
        private Integer durationMinutes;
        private String benefits;
        private String instructions;
        private boolean requiresBooking = true;
        private LocalTime startTime;
        private LocalTime endTime;
        private Integer maxBookingsPerSlot;
        private LocalDate bookingStartDate;
        private LocalDate bookingEndDate;
        private String description;
        private boolean isActive = true;
        private List<DarshanBooking> bookings;
        private LocalDateTime createdAt;
        private LocalDateTime updatedAt;
        
        public DarshanBuilder id(Long id) { this.id = id; return this; }
        public DarshanBuilder temple(Temple temple) { this.temple = temple; return this; }
        public DarshanBuilder darshanType(DarshanType darshanType) { this.darshanType = darshanType; return this; }
        public DarshanBuilder name(String name) { this.name = name; return this; }
        public DarshanBuilder nameHindi(String nameHindi) { this.nameHindi = nameHindi; return this; }
        public DarshanBuilder price(BigDecimal price) { this.price = price; return this; }
        public DarshanBuilder durationMinutes(Integer durationMinutes) { this.durationMinutes = durationMinutes; return this; }
        public DarshanBuilder benefits(String benefits) { this.benefits = benefits; return this; }
        public DarshanBuilder instructions(String instructions) { this.instructions = instructions; return this; }
        public DarshanBuilder requiresBooking(boolean requiresBooking) { this.requiresBooking = requiresBooking; return this; }
        public DarshanBuilder startTime(LocalTime startTime) { this.startTime = startTime; return this; }
        public DarshanBuilder endTime(LocalTime endTime) { this.endTime = endTime; return this; }
        public DarshanBuilder maxBookingsPerSlot(Integer maxBookingsPerSlot) { this.maxBookingsPerSlot = maxBookingsPerSlot; return this; }
        public DarshanBuilder bookingStartDate(LocalDate bookingStartDate) { this.bookingStartDate = bookingStartDate; return this; }
        public DarshanBuilder bookingEndDate(LocalDate bookingEndDate) { this.bookingEndDate = bookingEndDate; return this; }
        public DarshanBuilder description(String description) { this.description = description; return this; }
        public DarshanBuilder isActive(boolean isActive) { this.isActive = isActive; return this; }
        public DarshanBuilder bookings(List<DarshanBooking> bookings) { this.bookings = bookings; return this; }
        public DarshanBuilder createdAt(LocalDateTime createdAt) { this.createdAt = createdAt; return this; }
        public DarshanBuilder updatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; return this; }
        
        public Darshan build() {
            Darshan darshan = new Darshan();
            darshan.setId(id);
            darshan.setTemple(temple);
            darshan.setDarshanType(darshanType);
            darshan.setName(name);
            darshan.setNameHindi(nameHindi);
            darshan.setPrice(price);
            darshan.setDurationMinutes(durationMinutes);
            darshan.setBenefits(benefits);
            darshan.setInstructions(instructions);
            darshan.setRequiresBooking(requiresBooking);
            darshan.setStartTime(startTime);
            darshan.setEndTime(endTime);
            darshan.setMaxBookingsPerSlot(maxBookingsPerSlot);
            darshan.setBookingStartDate(bookingStartDate);
            darshan.setBookingEndDate(bookingEndDate);
            darshan.setDescription(description);
            darshan.setIsActive(isActive);
            darshan.setBookings(bookings);
            darshan.setCreatedAt(createdAt);
            darshan.setUpdatedAt(updatedAt);
            return darshan;
        }
    }
    
    // Explicit getters and setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public Temple getTemple() {
        return temple;
    }
    
    public void setTemple(Temple temple) {
        this.temple = temple;
    }
    
    public DarshanType getDarshanType() {
        return darshanType;
    }
    
    public void setDarshanType(DarshanType darshanType) {
        this.darshanType = darshanType;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getNameHindi() {
        return nameHindi;
    }
    
    public void setNameHindi(String nameHindi) {
        this.nameHindi = nameHindi;
    }
    
    public BigDecimal getPrice() {
        return price;
    }
    
    public Integer getDurationMinutes() {
        return durationMinutes;
    }
    
    public void setDurationMinutes(Integer durationMinutes) {
        this.durationMinutes = durationMinutes;
    }
    
    public String getBenefits() {
        return benefits;
    }
    
    public void setBenefits(String benefits) {
        this.benefits = benefits;
    }
    
    public String getInstructions() {
        return instructions;
    }
    
    public void setInstructions(String instructions) {
        this.instructions = instructions;
    }
    
    public boolean isRequiresBooking() {
        return requiresBooking;
    }
    
    public void setRequiresBooking(boolean requiresBooking) {
        this.requiresBooking = requiresBooking;
    }
    
    public void setPrice(BigDecimal price) {
        this.price = price;
    }
    
    public LocalTime getStartTime() {
        return startTime;
    }
    
    public void setStartTime(LocalTime startTime) {
        this.startTime = startTime;
    }
    
    public LocalTime getEndTime() {
        return endTime;
    }
    
    public void setEndTime(LocalTime endTime) {
        this.endTime = endTime;
    }
    
    public Integer getMaxBookingsPerSlot() {
        return maxBookingsPerSlot;
    }
    
    public void setMaxBookingsPerSlot(Integer maxBookingsPerSlot) {
        this.maxBookingsPerSlot = maxBookingsPerSlot;
    }
    
    public LocalDate getBookingStartDate() {
        return bookingStartDate;
    }
    
    public void setBookingStartDate(LocalDate bookingStartDate) {
        this.bookingStartDate = bookingStartDate;
    }
    
    public LocalDate getBookingEndDate() {
        return bookingEndDate;
    }
    
    public void setBookingEndDate(LocalDate bookingEndDate) {
        this.bookingEndDate = bookingEndDate;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public boolean isActive() {
        return isActive;
    }
    
    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }
    
    public List<DarshanBooking> getBookings() {
        return bookings;
    }
    
    public void setBookings(List<DarshanBooking> bookings) {
        this.bookings = bookings;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
}

