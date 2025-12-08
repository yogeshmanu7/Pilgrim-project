package com.pilgrim.service;

import com.pilgrim.entity.*;
import com.pilgrim.enums.PaymentStatus;
import com.pilgrim.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
public class PrasadhamService {
    
    private final PrasadhamRepository prasadhamRepository;
    private final PrasadhamOrderRepository orderRepository;
    
    // Explicit constructor to ensure dependencies are injected
    public PrasadhamService(PrasadhamRepository prasadhamRepository, PrasadhamOrderRepository orderRepository) {
        this.prasadhamRepository = prasadhamRepository;
        this.orderRepository = orderRepository;
    }
    
    // Prasadham CRUD
    public Prasadham createPrasadham(Prasadham prasadham) {
        return prasadhamRepository.save(prasadham);
    }
    
    public Optional<Prasadham> findById(Long id) {
        return prasadhamRepository.findById(id);
    }
    
    public List<Prasadham> findAll() {
        return prasadhamRepository.findAll();
    }
    
    public List<Prasadham> findByTemple(Temple temple) {
        return prasadhamRepository.findByTempleAndIsAvailableTrue(temple);
    }
    
    public List<Prasadham> findDeliverablePrasadhams() {
        return prasadhamRepository.findByCanBeDeliveredTrueAndIsAvailableTrue();
    }
    
    public Prasadham updatePrasadham(Prasadham prasadham) {
        return prasadhamRepository.save(prasadham);
    }
    
    public void deletePrasadham(Long id) {
        Prasadham prasadham = prasadhamRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Prasadham not found"));
        
        // Check if there are any orders for this prasadham
        List<PrasadhamOrder> orders = orderRepository.findByPrasadham(prasadham);
        if (!orders.isEmpty()) {
            // Use soft delete instead - set isAvailable to false
            prasadham.setIsAvailable(false);
            prasadhamRepository.save(prasadham);
        } else {
            // No orders exist, safe to hard delete
            prasadhamRepository.deleteById(id);
        }
    }
    
    public boolean hasOrders(Long id) {
        Prasadham prasadham = prasadhamRepository.findById(id).orElse(null);
        if (prasadham == null) {
            return false;
        }
        List<PrasadhamOrder> orders = orderRepository.findByPrasadham(prasadham);
        return !orders.isEmpty();
    }
    
    // Order Management
    public PrasadhamOrder createOrder(PrasadhamOrder order) {
        Prasadham prasadham = order.getPrasadham();
        order.setUnitPrice(prasadham.getPrice());
        
        BigDecimal itemTotal = prasadham.getPrice().multiply(BigDecimal.valueOf(order.getQuantity()));
        BigDecimal deliveryCharge = order.isForDelivery() && prasadham.getDeliveryCharge() != null 
                ? prasadham.getDeliveryCharge() : BigDecimal.ZERO;
        order.setDeliveryCharge(deliveryCharge);
        order.setTotalAmount(itemTotal.add(deliveryCharge));
        
        // Update stock
        if (prasadham.getStockQuantity() != null) {
            prasadham.setStockQuantity(prasadham.getStockQuantity() - order.getQuantity());
            prasadhamRepository.save(prasadham);
        }
        
        return orderRepository.save(order);
    }
    
    public Optional<PrasadhamOrder> findOrderById(Long id) {
        return orderRepository.findById(id);
    }
    
    public Optional<PrasadhamOrder> findOrderByNumber(String orderNumber) {
        return orderRepository.findByOrderNumber(orderNumber);
    }
    
    public List<PrasadhamOrder> findOrdersByUser(User user) {
        return orderRepository.findByUserOrderByCreatedAtDesc(user);
    }
    
    public List<PrasadhamOrder> findOrdersByTemple(Long templeId) {
        return orderRepository.findByTempleId(templeId);
    }
    
    public List<PrasadhamOrder> findOrdersByStatus(PrasadhamOrder.OrderStatus status) {
        return orderRepository.findByStatus(status);
    }
    
    public PrasadhamOrder updateOrderStatus(Long orderId, PrasadhamOrder.OrderStatus status) {
        PrasadhamOrder order = orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Order not found"));
        order.setStatus(status);
        return orderRepository.save(order);
    }
    
    public PrasadhamOrder updatePaymentStatus(Long orderId, PaymentStatus status, String transactionId) {
        PrasadhamOrder order = orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Order not found"));
        order.setPaymentStatus(status);
        order.setPaymentTransactionId(transactionId);
        if (status == PaymentStatus.PAID || status == PaymentStatus.SUCCESS) {
            order.setStatus(PrasadhamOrder.OrderStatus.CONFIRMED);
        }
        return orderRepository.save(order);
    }
    
    public void cancelOrder(Long orderId) {
        PrasadhamOrder order = orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Order not found"));
        order.setStatus(PrasadhamOrder.OrderStatus.CANCELLED);
        
        // Restore stock
        Prasadham prasadham = order.getPrasadham();
        if (prasadham.getStockQuantity() != null) {
            prasadham.setStockQuantity(prasadham.getStockQuantity() + order.getQuantity());
            prasadhamRepository.save(prasadham);
        }
        
        orderRepository.save(order);
    }
}

