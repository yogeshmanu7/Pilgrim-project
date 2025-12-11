package com.pilgrim.service;

import com.pilgrim.entity.PoojaCustomer;
import com.pilgrim.repository.PoojaCustomerRepository;
import com.pilgrim.util.PasswordUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class PoojaCustomerService {

    @Autowired
    private PoojaCustomerRepository customerRepository;

    public PoojaCustomer registerCustomer(PoojaCustomer customer) {
        if (customerRepository.existsByEmail(customer.getEmail())) {
            throw new RuntimeException("Email already exists");
        }
        customer.setPassword(PasswordUtil.encode(customer.getPassword()));
        return customerRepository.save(customer);
    }

    public Optional<PoojaCustomer> login(String email, String password) {
        Optional<PoojaCustomer> customerOpt = customerRepository.findByEmail(email);
        if (customerOpt.isPresent()) {
            PoojaCustomer customer = customerOpt.get();
            if (PasswordUtil.matches(password, customer.getPassword())) {
                return Optional.of(customer);
            }
        }
        return Optional.empty();
    }

    public List<PoojaCustomer> getAllCustomers() {
        return customerRepository.findAll();
    }

    public Optional<PoojaCustomer> getCustomerById(Long id) {
        return customerRepository.findById(id);
    }

    public PoojaCustomer updateCustomer(Long id, PoojaCustomer customerDetails) {
        PoojaCustomer customer = customerRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Customer not found"));
        customer.setName(customerDetails.getName());
        customer.setPhone(customerDetails.getPhone());
        customer.setAddress(customerDetails.getAddress());
        return customerRepository.save(customer);
    }

    public PoojaCustomer changePassword(Long id, String oldPassword, String newPassword) {
        PoojaCustomer customer = customerRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Customer not found"));
        if (!PasswordUtil.matches(oldPassword, customer.getPassword())) {
            throw new RuntimeException("Old password is incorrect");
        }
        customer.setPassword(PasswordUtil.encode(newPassword));
        return customerRepository.save(customer);
    }
    
    public Optional<PoojaCustomer> getCustomerByEmail(String email) {
        return customerRepository.findByEmail(email);
    }
    
    public PoojaCustomer saveCustomer(PoojaCustomer customer) {
        return customerRepository.save(customer);
    }
}

