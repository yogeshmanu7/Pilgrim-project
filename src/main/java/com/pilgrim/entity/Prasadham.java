package com.pilgrim.entity;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "prasadhams")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Prasadham {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne
    @JoinColumn(name = "temple_id", nullable = false)
    private Temple temple;
    
    @Column(nullable = false)
    private String name;
    
    private String nameHindi;
    
    @Column(columnDefinition = "TEXT")
    private String description;
    
    @Column(precision = 10, scale = 2, nullable = false)
    private BigDecimal price;
    
    private String imageUrl;
    
    @Enumerated(EnumType.STRING)
    private PrasadhamType type;
    
    private String weight; // e.g., "250g", "500g"
    
    @Builder.Default
    private boolean isAvailable = true;
    
    @Builder.Default
    private boolean canBeDelivered = true;
    
    @Column(precision = 10, scale = 2)
    private BigDecimal deliveryCharge;
    
    private Integer stockQuantity;
    
    @Column(columnDefinition = "TEXT")
    private String ingredients;
    
    private String shelfLife;
    
    @OneToMany(mappedBy = "prasadham", cascade = CascadeType.ALL)
    private List<PrasadhamOrder> orders;
    
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
    public Prasadham() {
    }
    
    // Static builder method
    public static PrasadhamBuilder builder() {
        return new PrasadhamBuilder();
    }
    
    // Builder class
    public static class PrasadhamBuilder {
        private Long id;
        private Temple temple;
        private String name;
        private String nameHindi;
        private String description;
        private BigDecimal price;
        private String imageUrl;
        private PrasadhamType type;
        private String weight;
        private boolean isAvailable = true;
        private boolean canBeDelivered = true;
        private BigDecimal deliveryCharge;
        private Integer stockQuantity;
        private String ingredients;
        private String shelfLife;
        private List<PrasadhamOrder> orders;
        private LocalDateTime createdAt;
        private LocalDateTime updatedAt;
        
        public PrasadhamBuilder id(Long id) { this.id = id; return this; }
        public PrasadhamBuilder temple(Temple temple) { this.temple = temple; return this; }
        public PrasadhamBuilder name(String name) { this.name = name; return this; }
        public PrasadhamBuilder nameHindi(String nameHindi) { this.nameHindi = nameHindi; return this; }
        public PrasadhamBuilder description(String description) { this.description = description; return this; }
        public PrasadhamBuilder price(BigDecimal price) { this.price = price; return this; }
        public PrasadhamBuilder imageUrl(String imageUrl) { this.imageUrl = imageUrl; return this; }
        public PrasadhamBuilder type(PrasadhamType type) { this.type = type; return this; }
        public PrasadhamBuilder weight(String weight) { this.weight = weight; return this; }
        public PrasadhamBuilder isAvailable(boolean isAvailable) { this.isAvailable = isAvailable; return this; }
        public PrasadhamBuilder canBeDelivered(boolean canBeDelivered) { this.canBeDelivered = canBeDelivered; return this; }
        public PrasadhamBuilder deliveryCharge(BigDecimal deliveryCharge) { this.deliveryCharge = deliveryCharge; return this; }
        public PrasadhamBuilder stockQuantity(Integer stockQuantity) { this.stockQuantity = stockQuantity; return this; }
        public PrasadhamBuilder ingredients(String ingredients) { this.ingredients = ingredients; return this; }
        public PrasadhamBuilder shelfLife(String shelfLife) { this.shelfLife = shelfLife; return this; }
        public PrasadhamBuilder orders(List<PrasadhamOrder> orders) { this.orders = orders; return this; }
        public PrasadhamBuilder createdAt(LocalDateTime createdAt) { this.createdAt = createdAt; return this; }
        public PrasadhamBuilder updatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; return this; }
        
        public Prasadham build() {
            Prasadham prasadham = new Prasadham();
            prasadham.setId(id);
            prasadham.setTemple(temple);
            prasadham.setName(name);
            prasadham.setNameHindi(nameHindi);
            prasadham.setDescription(description);
            prasadham.setPrice(price);
            prasadham.setImageUrl(imageUrl);
            prasadham.setType(type);
            prasadham.setWeight(weight);
            prasadham.setIsAvailable(isAvailable);
            prasadham.setCanBeDelivered(canBeDelivered);
            prasadham.setDeliveryCharge(deliveryCharge);
            prasadham.setStockQuantity(stockQuantity);
            prasadham.setIngredients(ingredients);
            prasadham.setShelfLife(shelfLife);
            prasadham.setOrders(orders);
            prasadham.setCreatedAt(createdAt);
            prasadham.setUpdatedAt(updatedAt);
            return prasadham;
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
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    public PrasadhamType getType() { return type; }
    public void setType(PrasadhamType type) { this.type = type; }
    public String getWeight() { return weight; }
    public void setWeight(String weight) { this.weight = weight; }
    public boolean isAvailable() { return isAvailable; }
    public void setIsAvailable(boolean isAvailable) { this.isAvailable = isAvailable; }
    public boolean isCanBeDelivered() { return canBeDelivered; }
    public void setCanBeDelivered(boolean canBeDelivered) { this.canBeDelivered = canBeDelivered; }
    public BigDecimal getDeliveryCharge() { return deliveryCharge; }
    public void setDeliveryCharge(BigDecimal deliveryCharge) { this.deliveryCharge = deliveryCharge; }
    public Integer getStockQuantity() { return stockQuantity; }
    public void setStockQuantity(Integer stockQuantity) { this.stockQuantity = stockQuantity; }
    public String getIngredients() { return ingredients; }
    public void setIngredients(String ingredients) { this.ingredients = ingredients; }
    public String getShelfLife() { return shelfLife; }
    public void setShelfLife(String shelfLife) { this.shelfLife = shelfLife; }
    public List<PrasadhamOrder> getOrders() { return orders; }
    public void setOrders(List<PrasadhamOrder> orders) { this.orders = orders; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
    
    public enum PrasadhamType {
        // Hindu/Jain types
        LADDU("Laddu"),
        MODAK("Modak"),
        PEDA("Peda"),
        PANCHAMRIT("Panchamrit"),
        CHARNAMRIT("Charnamrit"),
        TULSI("Tulsi"),
        VIBHUTI("Vibhuti"),
        KUMKUM("Kumkum"),
        FLOWER("Flower/Garland"),
        
        // Christian types
        HOLY_BREAD("Holy Bread"),
        BLESSED_WATER("Blessed Water"),
        CONSECRATED_WINE("Consecrated Wine"),
        ROSARY("Rosary"),
        CHRISTIAN_CANDLE("Candle"),
        CROSS("Cross"),
        MEDAL("Religious Medal"),
        HOLY_CARD("Holy Card"),
        
        // Muslim types
        DATES("Dates"),
        ZAMZAM_WATER("Zamzam Water"),
        HALAL_FOOD("Halal Food"),
        MISWAK("Miswak"),
        TASBIH("Tasbih"),
        QURAN("Quran Copy"),
        PRAYER_MAT("Prayer Mat"),
        
        // Buddhism types
        INCENSE("Incense"),
        BUDDHIST_CANDLE("Candle"),
        FLOWERS("Flowers"),
        FRUITS("Fruits"),
        RICE("Rice"),
        BUDDHA_STATUE("Buddha Statue"),
        PRAYER_WHEEL("Prayer Wheel"),
        MALA("Mala"),
        
        OTHER("Other");
        
        private final String displayName;
        
        PrasadhamType(String displayName) {
            this.displayName = displayName;
        }
        
        public String getDisplayName() {
            return displayName;
        }
    }
}

