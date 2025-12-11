package com.pilgrim.controller;

import com.pilgrim.entity.PoojaCart;
import com.pilgrim.entity.PoojaCustomer;
import com.pilgrim.entity.PoojaOrder;
import com.pilgrim.entity.PoojaItem;
import com.pilgrim.entity.User;
import com.pilgrim.service.PoojaCartService;
import com.pilgrim.service.PoojaCustomerService;
import com.pilgrim.service.PoojaOrderService;
import com.pilgrim.service.PoojaItemService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/pooja/customer")
public class PoojaCustomerController {

    @Autowired
    private PoojaCustomerService customerService;

    @Autowired
    private PoojaItemService poojaItemService;

    @Autowired
    private PoojaCartService cartService;

    @Autowired
    private PoojaOrderService orderService;
    
    // Helper method to get or create PoojaCustomer from User session
    private PoojaCustomer getOrCreatePoojaCustomer(User user) {
        if (user == null) {
            return null;
        }
        Optional<PoojaCustomer> existingCustomer = customerService.getCustomerByEmail(user.getEmail());
        if (existingCustomer.isPresent()) {
            return existingCustomer.get();
        }
        // Create a new PoojaCustomer from User data
        PoojaCustomer poojaCustomer = new PoojaCustomer();
        poojaCustomer.setName(user.getName());
        poojaCustomer.setEmail(user.getEmail());
        poojaCustomer.setPhone(user.getPhone() != null ? user.getPhone() : "");
        poojaCustomer.setAddress(user.getAddress() != null ? user.getAddress() : "");
        poojaCustomer.setPassword(""); // Not needed as we use User authentication
        return customerService.saveCustomer(poojaCustomer);
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        User user = (User) session.getAttribute("userSession");
        if (user == null) {
            return "redirect:/login";
        }
        PoojaCustomer customer = getOrCreatePoojaCustomer(user);
        List<PoojaItem> items = poojaItemService.getAllActiveItems();
        model.addAttribute("items", items);
        model.addAttribute("customer", customer);
        return "pooja/customer/dashboard";
    }

    @GetMapping("/items")
    public String browseItems(HttpSession session, 
                              @RequestParam(required = false) String search,
                              @RequestParam(required = false) String category,
                              @RequestParam(required = false) String sort,
                              Model model) {

        User user = (User) session.getAttribute("userSession");
        if (user == null) {
            return "redirect:/login";
        }
        PoojaCustomer customer = getOrCreatePoojaCustomer(user);

        List<PoojaItem> items = poojaItemService.advancedSearch(search, category, sort);
        List<String> categories = poojaItemService.getAllCategories();

        model.addAttribute("items", items);
        model.addAttribute("categories", categories);
        model.addAttribute("search", search);
        model.addAttribute("category", category);
        model.addAttribute("sort", sort);

        return "pooja/customer/items";
    }

    @GetMapping("/items/{id}")
    public String viewItem(@PathVariable Long id, HttpSession session, Model model) {
        User user = (User) session.getAttribute("userSession");
        if (user == null) {
            return "redirect:/login";
        }
        PoojaCustomer customer = getOrCreatePoojaCustomer(user);
        var itemOpt = poojaItemService.getItemById(id);
        if (itemOpt.isPresent()) {
            model.addAttribute("item", itemOpt.get());
            return "pooja/customer/item-details";
        }
        return "redirect:/pooja/customer/items";
    }

    @PostMapping("/cart/add")
    public String addToCart(@RequestParam Long itemId, @RequestParam Integer quantity,
                           HttpSession session, Model model) {
        User user = (User) session.getAttribute("userSession");
        if (user == null) {
            return "redirect:/login";
        }
        PoojaCustomer customer = getOrCreatePoojaCustomer(user);
        try {
            cartService.addToCart(customer.getId(), itemId, quantity);
            return "redirect:/pooja/customer/cart";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "redirect:/pooja/customer/items";
        }
    }

    @GetMapping("/cart")
    public String viewCart(HttpSession session, Model model) {
        User user = (User) session.getAttribute("userSession");
        if (user == null) {
            return "redirect:/login";
        }
        PoojaCustomer customer = getOrCreatePoojaCustomer(user);
        List<PoojaCart> cartItems = cartService.getCustomerCart(customer.getId());
        model.addAttribute("cartItems", cartItems);
        return "pooja/customer/cart";
    }

    @PostMapping("/cart/update/{id}")
    public String updateCartQuantity(@PathVariable Long id, @RequestParam Integer quantity,
                                     HttpSession session) {
        User user = (User) session.getAttribute("userSession");
        if (user == null) {
            return "redirect:/login";
        }
        PoojaCustomer customer = getOrCreatePoojaCustomer(user);
        try {
            cartService.updateCartQuantity(id, quantity);
        } catch (Exception e) {
            // Handle error
        }
        return "redirect:/pooja/customer/cart";
    }

    @PostMapping("/cart/remove/{id}")
    public String removeFromCart(@PathVariable Long id, HttpSession session) {
        User user = (User) session.getAttribute("userSession");
        if (user == null) {
            return "redirect:/login";
        }
        PoojaCustomer customer = getOrCreatePoojaCustomer(user);
        cartService.removeFromCart(id);
        return "redirect:/pooja/customer/cart";
    }

    @GetMapping("/checkout")
    public String showCheckout(HttpSession session, Model model) {
        User user = (User) session.getAttribute("userSession");
        if (user == null) {
            return "redirect:/login";
        }
        PoojaCustomer customer = getOrCreatePoojaCustomer(user);

        List<PoojaCart> cartItems = cartService.getCustomerCart(customer.getId());
        if (cartItems.isEmpty()) {
            return "redirect:/pooja/customer/cart";
        }

        BigDecimal totalAmount = BigDecimal.ZERO;
        for (PoojaCart cartItem : cartItems) {
            BigDecimal subtotal = cartItem.getItem().getPrice().multiply(new BigDecimal(cartItem.getQuantity()));
            totalAmount = totalAmount.add(subtotal);
        }

        model.addAttribute("cartItems", cartItems);
        model.addAttribute("totalAmount", totalAmount);
        model.addAttribute("customer", customer);

        return "pooja/customer/checkout";
    }

    @PostMapping("/checkout")
    public String placeOrder(@RequestParam String address,
                             @RequestParam String city,
                             @RequestParam String state,
                             @RequestParam String paymentMethod,
                             HttpSession session, Model model) {

        User user = (User) session.getAttribute("userSession");
        if (user == null) {
            return "redirect:/login";
        }
        PoojaCustomer customer = getOrCreatePoojaCustomer(user);

        List<PoojaCart> cartItems = cartService.getCustomerCart(customer.getId());

        if (cartItems.isEmpty()) {
            model.addAttribute("errorMsg", "Your cart is empty.");
            return "pooja/customer/checkout";
        }

        boolean allItemsAvailable = true;
        StringBuilder unavailableItems = new StringBuilder();
        java.time.LocalDate localExpectedDate = java.time.LocalDate.now();

        for (PoojaCart cart : cartItems) {
            PoojaItem item = cart.getItem();
            String allowedLocations = item.getDeliveryStates();
            if (allowedLocations == null || allowedLocations.isEmpty()) {
                allowedLocations = "Karnataka,Bangalore";
            }

            String[] allowed = allowedLocations.split(",");
            boolean available = false;
            for (String loc : allowed) {
                if (loc.equalsIgnoreCase(city) || loc.equalsIgnoreCase(state)) {
                    available = true;
                    break;
                }
            }

            if (!available) {
                allItemsAvailable = false;
                unavailableItems.append(item.getName()).append(", ");
            }

            java.time.LocalDate itemExpectedDate;
            if (city.equalsIgnoreCase("Bangalore")) {
                itemExpectedDate = java.time.LocalDate.now().plusDays(2);
            } else if (state.equalsIgnoreCase("Karnataka")) {
                itemExpectedDate = java.time.LocalDate.now().plusDays(5);
            } else {
                itemExpectedDate = java.time.LocalDate.now().plusDays(7);
            }

            if (itemExpectedDate.isAfter(localExpectedDate)) {
                localExpectedDate = itemExpectedDate;
            }
        }

        java.util.Date expectedDate = java.util.Date.from(
                localExpectedDate.atStartOfDay(java.time.ZoneId.systemDefault()).toInstant()
        );

        if (!allItemsAvailable) {
            model.addAttribute("errorMsg", "Item(s) not available for this location: " +
                    unavailableItems.toString() + "Allowed locations: Bangalore/Karnataka");
            model.addAttribute("expectedDate", expectedDate);
            model.addAttribute("cartItems", cartItems);
            return "pooja/customer/checkout";
        }

        String fullAddress = address + ", " + city + ", " + state;
        session.setAttribute("shippingAddress", fullAddress);

        if (paymentMethod.equalsIgnoreCase("ONLINE")) {
            session.setAttribute("expectedDate", expectedDate);
            PoojaOrder order = orderService.createOrder(customer.getId(), fullAddress, PoojaOrder.PaymentMethod.ONLINE);
            return "redirect:/pooja/customer/payment?orderId=" + order.getOrderNumber();
        }

        PoojaOrder order = orderService.createOrder(customer.getId(), fullAddress, PoojaOrder.PaymentMethod.COD);
        cartService.clearCart(customer.getId());

        session.setAttribute("expectedDate", expectedDate);

        return "redirect:/pooja/customer/order-success?order=" + order.getOrderNumber();
    }

    @GetMapping("/payment")
    public String paymentPage(@RequestParam String orderId, Model model) {
        PoojaOrder order = orderService.getOrderByOrderNumber(orderId);
        model.addAttribute("order", order);
        return "pooja/payment/onlinePayment";
    }

    @PostMapping("/payment/submit")
    public String processPayment(@RequestParam String orderId,
                                 @RequestParam String status) {

        PoojaOrder order = orderService.getOrderByOrderNumber(orderId);

        if (status.equalsIgnoreCase("SUCCESS")) {
            order.setStatus(PoojaOrder.OrderStatus.CONFIRMED);
            order.setPaymentStatus(PoojaOrder.PaymentStatus.PAID);
            order.setTransactionId("TXN-" + orderId);
        } else {
            order.setStatus(PoojaOrder.OrderStatus.PENDING);
            order.setPaymentStatus(PoojaOrder.PaymentStatus.FAILED);
            order.setTransactionId("FAILED-" + orderId);
        }

        orderService.updateOrder(order);
        return "redirect:/pooja/customer/order-success?order=" + orderId;
    }

    @GetMapping("/orders")
    public String viewOrders(HttpSession session, Model model) {
        User user = (User) session.getAttribute("userSession");
        if (user == null) {
            return "redirect:/login";
        }
        PoojaCustomer customer = getOrCreatePoojaCustomer(user);
        List<PoojaOrder> orders = orderService.getCustomerOrders(customer.getId());
        model.addAttribute("orders", orders);
        return "pooja/customer/orders";
    }

    @GetMapping("/order-success")
    public String orderSuccess(@RequestParam("order") String orderNumber,
                               Model model,
                               HttpSession session) {

        PoojaOrder orderDetails = orderService.getOrderByOrderNumber(orderNumber);

        if (orderDetails == null) {
            model.addAttribute("msg", "Invalid Order Number!");
            return "errorPage"; 
        }

        model.addAttribute("order", orderDetails);

        Object expected = session.getAttribute("expectedDate");
        if (expected != null) {
            model.addAttribute("expectedDate", expected);
            session.removeAttribute("expectedDate");
        }

        return "pooja/customer/order-success";
    }

    @PostMapping("/orders/cancel/{orderNumber}")
    public String cancelOrder(@PathVariable String orderNumber,
                              @RequestParam("reason") String reason,
                              HttpSession session) {

        User user = (User) session.getAttribute("userSession");
        if (user == null) {
            return "redirect:/login";
        }
        PoojaCustomer customer = getOrCreatePoojaCustomer(user);

        PoojaOrder order = orderService.getOrderByOrderNumber(orderNumber);

        if (order != null && order.getCustomer().getId().equals(customer.getId())
                && (order.getStatus() == PoojaOrder.OrderStatus.PENDING
                || order.getStatus() == PoojaOrder.OrderStatus.CONFIRMED)) {

            order.setStatus(PoojaOrder.OrderStatus.CANCELLED);
            order.setCancelReason(reason);
            orderService.updateOrder(order);
        }

        return "redirect:/pooja/customer/orders";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}

