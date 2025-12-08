package com.pilgrim.service;

import com.pilgrim.entity.PoojaCart;
import com.pilgrim.entity.PoojaCustomer;
import com.pilgrim.entity.PoojaItem;
import com.pilgrim.repository.PoojaCartRepository;
import com.pilgrim.repository.PoojaCustomerRepository;
import com.pilgrim.repository.PoojaItemRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class PoojaCartService {

    @Autowired
    private PoojaCartRepository cartRepository;

    @Autowired
    private PoojaCustomerRepository customerRepository;

    @Autowired
    private PoojaItemRepository poojaItemRepository;

    @Autowired
    private PoojaItemService poojaItemService;

    @Transactional
    public PoojaCart addToCart(Long customerId, Long itemId, Integer quantity) {
        PoojaCustomer customer = customerRepository.findById(customerId)
                .orElseThrow(() -> new RuntimeException("Customer not found"));
        PoojaItem item = poojaItemRepository.findById(itemId)
                .orElseThrow(() -> new RuntimeException("Item not found"));

        if (item.getStock() < quantity) {
            throw new RuntimeException("Insufficient stock");
        }

        Optional<PoojaCart> existingCart = cartRepository.findByCustomerAndItemAndStatus(
                customer, item, PoojaCart.CartStatus.ACTIVE);

        if (existingCart.isPresent()) {
            PoojaCart cart = existingCart.get();
            int newQuantity = cart.getQuantity() + quantity;
            
            poojaItemService.releaseStock(itemId, cart.getQuantity());
            poojaItemService.reserveStock(itemId, newQuantity);
            
            cart.setQuantity(newQuantity);
            cart.setUpdatedAt(LocalDateTime.now());
            cart.setExpiresAt(LocalDateTime.now().plusMinutes(30));
            return cartRepository.save(cart);
        } else {
            poojaItemService.reserveStock(itemId, quantity);
            
            PoojaCart cart = new PoojaCart(customer, item, quantity);
            cart.setExpiresAt(LocalDateTime.now().plusMinutes(30));
            return cartRepository.save(cart);
        }
    }

    public List<PoojaCart> getCustomerCart(Long customerId) {
        PoojaCustomer customer = customerRepository.findById(customerId)
                .orElseThrow(() -> new RuntimeException("Customer not found"));
        return cartRepository.findByCustomerAndStatus(customer, PoojaCart.CartStatus.ACTIVE);
    }

    @Transactional
    public PoojaCart updateCartQuantity(Long cartId, Integer newQuantity) {
        PoojaCart cart = cartRepository.findById(cartId)
                .orElseThrow(() -> new RuntimeException("Cart item not found"));
        
        PoojaItem item = cart.getItem();
        int quantityDiff = newQuantity - cart.getQuantity();
        
        if (quantityDiff > 0) {
            if (item.getStock() < quantityDiff) {
                throw new RuntimeException("Insufficient stock");
            }
            poojaItemService.reserveStock(item.getId(), quantityDiff);
        } else if (quantityDiff < 0) {
            poojaItemService.releaseStock(item.getId(), Math.abs(quantityDiff));
        }
        
        cart.setQuantity(newQuantity);
        cart.setUpdatedAt(LocalDateTime.now());
        cart.setExpiresAt(LocalDateTime.now().plusMinutes(30));
        return cartRepository.save(cart);
    }

    @Transactional
    public void removeFromCart(Long cartId) {
        PoojaCart cart = cartRepository.findById(cartId)
                .orElseThrow(() -> new RuntimeException("Cart item not found"));
        
        poojaItemService.releaseStock(cart.getItem().getId(), cart.getQuantity());
        
        cart.setStatus(PoojaCart.CartStatus.REMOVED);
        cart.setUpdatedAt(LocalDateTime.now());
        cartRepository.save(cart);
    }

    @Transactional
    @Scheduled(fixedRate = 600000)
    public void restoreExpiredCarts() {
        List<PoojaCart> expiredCarts = cartRepository.findExpiredCarts(LocalDateTime.now());
        for (PoojaCart cart : expiredCarts) {
            if (cart.getStatus() == PoojaCart.CartStatus.ACTIVE) {
                poojaItemService.releaseStock(cart.getItem().getId(), cart.getQuantity());
                cart.setStatus(PoojaCart.CartStatus.EXPIRED);
                cartRepository.save(cart);
            }
        }
    }

    @Transactional
    public void checkoutCart(Long customerId) {
        List<PoojaCart> cartItems = getCustomerCart(customerId);
        for (PoojaCart cart : cartItems) {
            poojaItemService.convertReservedToSold(cart.getItem().getId(), cart.getQuantity());
            cart.setStatus(PoojaCart.CartStatus.CHECKED_OUT);
            cart.setUpdatedAt(LocalDateTime.now());
            cartRepository.save(cart);
        }
    }

    @Transactional
    public void clearCart(Long customerId) {
        PoojaCustomer customer = customerRepository.findById(customerId)
                .orElseThrow(() -> new RuntimeException("Customer not found"));
        List<PoojaCart> cartItems = cartRepository.findByCustomerAndStatus(customer, PoojaCart.CartStatus.ACTIVE);
        for (PoojaCart cart : cartItems) {
            poojaItemService.releaseStock(cart.getItem().getId(), cart.getQuantity());
            cart.setStatus(PoojaCart.CartStatus.REMOVED);
            cart.setUpdatedAt(LocalDateTime.now());
            cartRepository.save(cart);
        }
    }
}

