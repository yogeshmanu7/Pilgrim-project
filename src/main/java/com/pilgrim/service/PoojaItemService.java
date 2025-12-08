package com.pilgrim.service;

import com.pilgrim.entity.PoojaItem;
import com.pilgrim.entity.Vendor;
import com.pilgrim.repository.PoojaItemRepository;
import com.pilgrim.repository.VendorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;

@Service
public class PoojaItemService {

    @Autowired
    private PoojaItemRepository poojaItemRepository;

    @Autowired
    private VendorRepository vendorRepository;

    public PoojaItem addItem(Long vendorId, PoojaItem item) {
        Vendor vendor = vendorRepository.findById(vendorId)
                .orElseThrow(() -> new RuntimeException("Vendor not found"));
        item.setVendor(vendor);
        item.setStatus(PoojaItem.ItemStatus.ACTIVE);
        return poojaItemRepository.save(item);
    }

    public List<PoojaItem> getVendorItems(Long vendorId) {
        Vendor vendor = vendorRepository.findById(vendorId)
                .orElseThrow(() -> new RuntimeException("Vendor not found"));
        return poojaItemRepository.findByVendorAndStatus(vendor, PoojaItem.ItemStatus.ACTIVE);
    }

    public List<PoojaItem> getAllActiveItems() {
        return poojaItemRepository.findByStatusAndStockGreaterThan(PoojaItem.ItemStatus.ACTIVE, 0);
    }

    public List<PoojaItem> getAllItems() {
        return poojaItemRepository.findAll();
    }

    public Optional<PoojaItem> getItemById(Long id) {
        return poojaItemRepository.findById(id);
    }

    public PoojaItem updateItem(Long id, PoojaItem itemDetails) {
        PoojaItem item = poojaItemRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Item not found"));
        item.setName(itemDetails.getName());
        item.setCategory(itemDetails.getCategory());
        item.setPrice(itemDetails.getPrice());
        item.setStock(itemDetails.getStock());
        item.setDescription(itemDetails.getDescription());
        if (itemDetails.getImagePath() != null && !itemDetails.getImagePath().isEmpty()) {
            item.setImagePath(itemDetails.getImagePath());
        }
        item.setUpdatedAt(LocalDateTime.now());
        return poojaItemRepository.save(item);
    }

    @Transactional
    public void deleteItem(Long id) {
        PoojaItem item = poojaItemRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Item not found"));
        item.setStatus(PoojaItem.ItemStatus.DELETED);
        poojaItemRepository.save(item);
    }

    @Transactional
    public void reserveStock(Long itemId, Integer quantity) {
        PoojaItem item = poojaItemRepository.findById(itemId)
                .orElseThrow(() -> new RuntimeException("Item not found"));
        if (item.getStock() < quantity) {
            throw new RuntimeException("Insufficient stock");
        }
        item.setStock(item.getStock() - quantity);
        item.setReservedStock(item.getReservedStock() + quantity);
        poojaItemRepository.save(item);
    }

    @Transactional
    public void releaseStock(Long itemId, Integer quantity) {
        PoojaItem item = poojaItemRepository.findById(itemId)
                .orElseThrow(() -> new RuntimeException("Item not found"));
        item.setStock(item.getStock() + quantity);
        item.setReservedStock(item.getReservedStock() - quantity);
        poojaItemRepository.save(item);
    }

    @Transactional
    public void convertReservedToSold(Long itemId, Integer quantity) {
        PoojaItem item = poojaItemRepository.findById(itemId)
                .orElseThrow(() -> new RuntimeException("Item not found"));
        item.setReservedStock(item.getReservedStock() - quantity);
        item.setSoldStock(item.getSoldStock() + quantity);
        poojaItemRepository.save(item);
    }

    public List<PoojaItem> advancedSearch(String search, String category, String sort) {
        List<PoojaItem> items = poojaItemRepository.filterItems(search, category);

        if (sort != null) {
            switch (sort) {
                case "low" -> items.sort(Comparator.comparing(PoojaItem::getPrice));
                case "high" -> items.sort(Comparator.comparing(PoojaItem::getPrice).reversed());
                case "new" -> {
                    try {
                        items.sort(Comparator.comparing(PoojaItem::getCreatedAt).reversed());
                    } catch (Exception e) {
                        items.sort(Comparator.comparing(PoojaItem::getId).reversed());
                    }
                }
            }
        }

        return items;
    }

    public List<String> getAllCategories() {
        return poojaItemRepository.findAllCategories();
    }
}

