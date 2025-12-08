package com.pilgrim.service;

import com.pilgrim.entity.PoojaCart;
import com.pilgrim.entity.PoojaCustomer;
import com.pilgrim.entity.PoojaOrder;
import com.pilgrim.entity.Vendor;
import com.pilgrim.repository.PoojaCartRepository;
import com.pilgrim.repository.PoojaCustomerRepository;
import com.pilgrim.repository.PoojaOrderRepository;
import com.pilgrim.repository.VendorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Service
public class PoojaOrderService {

    @Autowired
    private PoojaOrderRepository orderRepository;

    @Autowired
    private PoojaCartRepository cartRepository;

    @Autowired
    private PoojaCustomerRepository customerRepository;

    @Autowired
    private VendorRepository vendorRepository;

    @Autowired
    private PoojaCartService cartService;

    @Transactional
    public PoojaOrder createOrder(Long customerId, String shippingAddress, PoojaOrder.PaymentMethod paymentMethod) {
        PoojaCustomer customer = customerRepository.findById(customerId)
                .orElseThrow(() -> new RuntimeException("Customer not found"));

        List<PoojaCart> cartItems = cartRepository.findByCustomerAndStatus(
                customer, PoojaCart.CartStatus.ACTIVE);

        if (cartItems.isEmpty()) {
            throw new RuntimeException("Cart is empty");
        }

        PoojaOrder lastOrder = null;

        for (PoojaCart cart : cartItems) {
            String orderNumber = "ORD-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
            BigDecimal totalAmount = cart.getItem().getPrice()
                    .multiply(BigDecimal.valueOf(cart.getQuantity()));

            PoojaOrder order = new PoojaOrder();
            order.setOrderNumber(orderNumber);
            order.setCustomer(customer);
            order.setVendor(cart.getItem().getVendor());
            order.setItem(cart.getItem());
            order.setQuantity(cart.getQuantity());
            order.setTotalAmount(totalAmount);
            order.setShippingAddress(shippingAddress);
            order.setStatus(PoojaOrder.OrderStatus.PENDING);
            order.setPaymentMethod(paymentMethod);

            lastOrder = orderRepository.save(order);
        }

        cartService.checkoutCart(customerId);

        return lastOrder;
    }

    public List<PoojaOrder> getCustomerOrders(Long customerId) {
        PoojaCustomer customer = customerRepository.findById(customerId)
                .orElseThrow(() -> new RuntimeException("Customer not found"));
        return orderRepository.findByCustomer(customer);
    }

    public List<PoojaOrder> getVendorOrders(Long vendorId) {
        Vendor vendor = vendorRepository.findById(vendorId)
                .orElseThrow(() -> new RuntimeException("Vendor not found"));
        return orderRepository.findByVendor(vendor);
    }

    public List<PoojaOrder> getAllOrders() {
        return orderRepository.findAll();
    }

    public PoojaOrder updateOrderStatus(Long orderId, PoojaOrder.OrderStatus status) {
        PoojaOrder order = orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Order not found"));
        order.setStatus(status);
        order.setUpdatedAt(LocalDateTime.now());
        return orderRepository.save(order);
    }

    public PoojaOrder getOrderByOrderNumber(String orderNumber) {
        return orderRepository.findByOrderNumber(orderNumber)
                .orElseThrow(() -> new RuntimeException("Order not found"));
    }

    public PoojaOrder updateOrder(PoojaOrder order) {
        order.setUpdatedAt(LocalDateTime.now());
        return orderRepository.save(order);
    }
}

