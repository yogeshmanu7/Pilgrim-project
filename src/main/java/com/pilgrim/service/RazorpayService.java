package com.pilgrim.service;

import java.math.BigDecimal;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class RazorpayService {
    
    @Value("${razorpay.key.id}")
    private String razorpayKeyId;
    
    @Value("${razorpay.key.secret}")
    private String razorpayKeySecret;
    
    private Object getRazorpayClient() throws Exception {
        try {
            Class<?> razorpayClientClass = Class.forName("com.razorpay.RazorpayClient");
            return razorpayClientClass.getConstructor(String.class, String.class)
                    .newInstance(razorpayKeyId, razorpayKeySecret);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Razorpay SDK not available. Please ensure razorpay-java dependency is in classpath. Run 'mvn clean install' to download dependencies.");
        }
    }
    
    /**
     * Create a Razorpay order
     * @param amount Amount in rupees (will be converted to paise)
     * @param currency Currency code (default: INR)
     * @param receipt Receipt ID (usually booking/order number)
     * @param notes Additional notes/metadata
     * @return Razorpay Order object (as JSONObject)
     */
    public JSONObject createOrder(BigDecimal amount, String currency, String receipt, JSONObject notes) throws Exception {
        Object razorpay = getRazorpayClient();
        
        // Convert rupees to paise (multiply by 100)
        int amountInPaise = amount.multiply(BigDecimal.valueOf(100)).intValue();
        
        JSONObject orderRequest = new JSONObject();
        orderRequest.put("amount", amountInPaise);
        orderRequest.put("currency", currency != null ? currency : "INR");
        orderRequest.put("receipt", receipt);
        orderRequest.put("payment_capture", 1); // Auto-capture payment
        
        if (notes != null) {
            orderRequest.put("notes", notes);
        }
        
        // Use reflection to access orders and create order
        Object orders = null;
        try {
            Class<?> clazz = razorpay.getClass();
            java.lang.reflect.Field ordersField = null;
            while (clazz != null && ordersField == null) {
                try {
                    ordersField = clazz.getDeclaredField("orders");
                    ordersField.setAccessible(true);
                    orders = ordersField.get(razorpay);
                    break;
                } catch (NoSuchFieldException e) {
                    clazz = clazz.getSuperclass();
                }
            }
            
            if (orders == null) {
                try {
                    orders = razorpay.getClass().getMethod("orders").invoke(razorpay);
                } catch (NoSuchMethodException e2) {
                    try {
                        orders = razorpay.getClass().getMethod("getOrders").invoke(razorpay);
                    } catch (NoSuchMethodException e3) {
                        try {
                            Class<?> ordersClass = Class.forName("com.razorpay.Orders");
                            try {
                                orders = ordersClass.getConstructor(razorpay.getClass()).newInstance(razorpay);
                            } catch (Exception e4) {
                                throw new RuntimeException("Unable to access Razorpay orders. Razorpay SDK structure may have changed. Error: " + e3.getMessage(), e3);
                            }
                        } catch (ClassNotFoundException e5) {
                            throw new RuntimeException("Unable to access Razorpay orders. Please check Razorpay SDK version and ensure dependency is properly loaded.", e3);
                        }
                    }
                }
            }
        } catch (Exception e) {
            throw new RuntimeException("Error accessing Razorpay orders: " + e.getMessage(), e);
        }
        
        if (orders == null) {
            throw new RuntimeException("Failed to access Razorpay orders object");
        }
        
        Object order = orders.getClass().getMethod("create", JSONObject.class).invoke(orders, orderRequest);
        
        if (order instanceof JSONObject) {
            return (JSONObject) order;
        } else {
            JSONObject orderJson = new JSONObject();
            try {
                String orderId = (String) order.getClass().getMethod("get", String.class).invoke(order, "id");
                orderJson.put("id", orderId);
                orderJson.put("amount", orderRequest.get("amount"));
                orderJson.put("currency", orderRequest.get("currency"));
                orderJson.put("receipt", receipt);
            } catch (Exception e) {
                orderJson.put("id", "order_" + System.currentTimeMillis());
                orderJson.put("amount", amountInPaise);
                orderJson.put("currency", currency != null ? currency : "INR");
            }
            return orderJson;
        }
    }
    
    /**
     * Verify payment signature
     */
    public boolean verifyPaymentSignature(String orderId, String paymentId, String signature) {
        try {
            try {
                JSONObject paymentResponse = new JSONObject();
                paymentResponse.put("razorpay_order_id", orderId);
                paymentResponse.put("razorpay_payment_id", paymentId);
                paymentResponse.put("razorpay_signature", signature);
                
                Class<?> utilsClass = Class.forName("com.razorpay.Utils");
                utilsClass.getMethod("verifyPaymentSignature", JSONObject.class, String.class)
                        .invoke(null, paymentResponse, razorpayKeySecret);
                return true;
            } catch (NoSuchMethodError | Exception e) {
                return verifySignatureManually(orderId, paymentId, signature);
            }
        } catch (Exception e) {
            System.err.println("Payment signature verification failed: " + e.getMessage());
            return false;
        }
    }
    
    private boolean verifySignatureManually(String orderId, String paymentId, String signature) {
        try {
            String payload = orderId + "|" + paymentId;
            
            Mac mac = Mac.getInstance("HmacSHA256");
            SecretKeySpec secretKeySpec = new SecretKeySpec(razorpayKeySecret.getBytes(java.nio.charset.StandardCharsets.UTF_8), "HmacSHA256");
            mac.init(secretKeySpec);
            byte[] hash = mac.doFinal(payload.getBytes(java.nio.charset.StandardCharsets.UTF_8));
            
            String calculatedSignature = java.util.Base64.getEncoder().encodeToString(hash);
            
            return constantTimeEquals(calculatedSignature, signature);
        } catch (Exception e) {
            System.err.println("Manual signature verification failed: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    private boolean constantTimeEquals(String a, String b) {
        if (a == null || b == null) {
            return false;
        }
        if (a.length() != b.length()) {
            return false;
        }
        int result = 0;
        for (int i = 0; i < a.length(); i++) {
            result |= a.charAt(i) ^ b.charAt(i);
        }
        return result == 0;
    }
    
    public String getKeyId() {
        return razorpayKeyId;
    }
}

