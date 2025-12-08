package com.pilgrim.entity;

import com.pilgrim.enums.PaymentStatus;
import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "prasadham_orders")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PrasadhamOrder {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(unique = true, nullable = false)
    private String orderNumber;
    
    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;
    
    @ManyToOne
    @JoinColumn(name = "prasadham_id", nullable = false)
    private Prasadham prasadham;
    
    @Column(nullable = false)
    private Integer quantity;
    
    @Column(precision = 10, scale = 2)
    private BigDecimal unitPrice;
    
    @Column(precision = 10, scale = 2)
    private BigDecimal deliveryCharge;
    
    @Column(precision = 10, scale = 2)
    private BigDecimal totalAmount;
    
    // Delivery Details
    @Builder.Default
    private boolean forDelivery = false;
    
    private String recipientName;
    
    private String recipientPhone;
    
    @Column(columnDefinition = "TEXT")
    private String deliveryAddress;
    
    private String city;
    
    private String state;
    
    private String pincode;
    
    @Builder.Default
    @Enumerated(EnumType.STRING)
    private OrderStatus status = OrderStatus.PENDING;
    
    @Builder.Default
    @Enumerated(EnumType.STRING)
    private PaymentStatus paymentStatus = PaymentStatus.PENDING;
    
    private String paymentTransactionId;
    
    private String trackingNumber;
    
    @Column(columnDefinition = "TEXT")
    private String notes;
    
    @Column(updatable = false)
    private LocalDateTime createdAt;
    
    private LocalDateTime updatedAt;
    
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (orderNumber == null) {
            orderNumber = "PRS" + System.currentTimeMillis();
        }
    }
    
    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
    
    // Explicit constructors
    public PrasadhamOrder() {
    }
    
    // Static builder method
    public static PrasadhamOrderBuilder builder() {
        return new PrasadhamOrderBuilder();
    }
    
    // Builder class
    public static class PrasadhamOrderBuilder {
        private Long id;
        private String orderNumber;
        private User user;
        private Prasadham prasadham;
        private Integer quantity;
        private BigDecimal unitPrice;
        private BigDecimal deliveryCharge;
        private BigDecimal totalAmount;
        private boolean forDelivery = false;
        private String recipientName;
        private String recipientPhone;
        private String deliveryAddress;
        private String city;
        private String state;
        private String pincode;
        private OrderStatus status = OrderStatus.PENDING;
        private PaymentStatus paymentStatus = PaymentStatus.PENDING;
        private String paymentTransactionId;
        private String trackingNumber;
        private String notes;
        private LocalDateTime createdAt;
        private LocalDateTime updatedAt;
        
        public PrasadhamOrderBuilder id(Long id) { this.id = id; return this; }
        public PrasadhamOrderBuilder orderNumber(String orderNumber) { this.orderNumber = orderNumber; return this; }
        public PrasadhamOrderBuilder user(User user) { this.user = user; return this; }
        public PrasadhamOrderBuilder prasadham(Prasadham prasadham) { this.prasadham = prasadham; return this; }
        public PrasadhamOrderBuilder quantity(Integer quantity) { this.quantity = quantity; return this; }
        public PrasadhamOrderBuilder unitPrice(BigDecimal unitPrice) { this.unitPrice = unitPrice; return this; }
        public PrasadhamOrderBuilder deliveryCharge(BigDecimal deliveryCharge) { this.deliveryCharge = deliveryCharge; return this; }
        public PrasadhamOrderBuilder totalAmount(BigDecimal totalAmount) { this.totalAmount = totalAmount; return this; }
        public PrasadhamOrderBuilder forDelivery(boolean forDelivery) { this.forDelivery = forDelivery; return this; }
        public PrasadhamOrderBuilder recipientName(String recipientName) { this.recipientName = recipientName; return this; }
        public PrasadhamOrderBuilder recipientPhone(String recipientPhone) { this.recipientPhone = recipientPhone; return this; }
        public PrasadhamOrderBuilder deliveryAddress(String deliveryAddress) { this.deliveryAddress = deliveryAddress; return this; }
        public PrasadhamOrderBuilder city(String city) { this.city = city; return this; }
        public PrasadhamOrderBuilder state(String state) { this.state = state; return this; }
        public PrasadhamOrderBuilder pincode(String pincode) { this.pincode = pincode; return this; }
        public PrasadhamOrderBuilder status(OrderStatus status) { this.status = status; return this; }
        public PrasadhamOrderBuilder paymentStatus(PaymentStatus paymentStatus) { this.paymentStatus = paymentStatus; return this; }
        public PrasadhamOrderBuilder paymentTransactionId(String paymentTransactionId) { this.paymentTransactionId = paymentTransactionId; return this; }
        public PrasadhamOrderBuilder trackingNumber(String trackingNumber) { this.trackingNumber = trackingNumber; return this; }
        public PrasadhamOrderBuilder notes(String notes) { this.notes = notes; return this; }
        public PrasadhamOrderBuilder createdAt(LocalDateTime createdAt) { this.createdAt = createdAt; return this; }
        public PrasadhamOrderBuilder updatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; return this; }
        
        public PrasadhamOrder build() {
            PrasadhamOrder order = new PrasadhamOrder();
            order.setId(id);
            order.setOrderNumber(orderNumber);
            order.setUser(user);
            order.setPrasadham(prasadham);
            order.setQuantity(quantity);
            order.setUnitPrice(unitPrice);
            order.setDeliveryCharge(deliveryCharge);
            order.setTotalAmount(totalAmount);
            order.setForDelivery(forDelivery);
            order.setRecipientName(recipientName);
            order.setRecipientPhone(recipientPhone);
            order.setDeliveryAddress(deliveryAddress);
            order.setCity(city);
            order.setState(state);
            order.setPincode(pincode);
            order.setStatus(status);
            order.setPaymentStatus(paymentStatus);
            order.setPaymentTransactionId(paymentTransactionId);
            order.setTrackingNumber(trackingNumber);
            order.setNotes(notes);
            order.setCreatedAt(createdAt);
            order.setUpdatedAt(updatedAt);
            return order;
        }
    }
    
    // Explicit getters and setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getOrderNumber() { return orderNumber; }
    public void setOrderNumber(String orderNumber) { this.orderNumber = orderNumber; }
    public Prasadham getPrasadham() { return prasadham; }
    public void setPrasadham(Prasadham prasadham) { this.prasadham = prasadham; }
    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { this.quantity = quantity; }
    public BigDecimal getUnitPrice() { return unitPrice; }
    public void setUnitPrice(BigDecimal unitPrice) { this.unitPrice = unitPrice; }
    public BigDecimal getDeliveryCharge() { return deliveryCharge; }
    public void setDeliveryCharge(BigDecimal deliveryCharge) { this.deliveryCharge = deliveryCharge; }
    public BigDecimal getTotalAmount() { return totalAmount; }
    public void setTotalAmount(BigDecimal totalAmount) { this.totalAmount = totalAmount; }
    public boolean isForDelivery() { return forDelivery; }
    public void setForDelivery(boolean forDelivery) { this.forDelivery = forDelivery; }
    public String getRecipientName() { return recipientName; }
    public void setRecipientName(String recipientName) { this.recipientName = recipientName; }
    public String getRecipientPhone() { return recipientPhone; }
    public void setRecipientPhone(String recipientPhone) { this.recipientPhone = recipientPhone; }
    public String getDeliveryAddress() { return deliveryAddress; }
    public void setDeliveryAddress(String deliveryAddress) { this.deliveryAddress = deliveryAddress; }
    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }
    public String getState() { return state; }
    public void setState(String state) { this.state = state; }
    public String getPincode() { return pincode; }
    public void setPincode(String pincode) { this.pincode = pincode; }
    public OrderStatus getStatus() { return status; }
    public void setStatus(OrderStatus status) { this.status = status; }
    public PaymentStatus getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(PaymentStatus paymentStatus) { this.paymentStatus = paymentStatus; }
    public String getPaymentTransactionId() { return paymentTransactionId; }
    public void setPaymentTransactionId(String paymentTransactionId) { this.paymentTransactionId = paymentTransactionId; }
    public String getTrackingNumber() { return trackingNumber; }
    public void setTrackingNumber(String trackingNumber) { this.trackingNumber = trackingNumber; }
    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
    
    public enum OrderStatus {
        PENDING,
        CONFIRMED,
        PREPARING,
        READY,
        DISPATCHED,
        DELIVERED,
        CANCELLED
    }
}

