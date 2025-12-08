package com.pilgrim.filter;
import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
@Component
@Order(1)
public class AdminAuthFilter implements Filter {
  
   // URLs that don't require authentication
   private static final List<String> PUBLIC_URLS = Arrays.asList(
       "/admin/login",
       "/admin/register",
       "/admin/verify-otp",
       "/admin/resend-otp",
       "/admin/forgot-password",
       "/admin/reset-password"
   );
  
   // Static resources
   private static final List<String> STATIC_RESOURCES = Arrays.asList(
       "/css/",
       "/js/",
       "/images/",
       "/fonts/",
       "/uploads/",
       "/webjars/"
   );
  
   @Override
   public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
           throws IOException, ServletException {
      
       HttpServletRequest httpRequest = (HttpServletRequest) request;
       HttpServletResponse httpResponse = (HttpServletResponse) response;
      
       String requestURI = httpRequest.getRequestURI();
       String contextPath = httpRequest.getContextPath();
       String path = requestURI.substring(contextPath.length());
      
       // Allow static resources
       for (String staticPath : STATIC_RESOURCES) {
           if (path.contains(staticPath)) {
               chain.doFilter(request, response);
               return;
           }
       }
      
       // Only filter admin URLs
       if (!path.startsWith("/admin")) {
           chain.doFilter(request, response);
           return;
       }
      
       // Allow public URLs
       for (String publicUrl : PUBLIC_URLS) {
           if (path.equals(publicUrl) || path.startsWith(publicUrl + "?") || path.startsWith(publicUrl + "/")) {
               chain.doFilter(request, response);
               return;
           }
       }
      
       // Check session for protected admin URLs
       HttpSession session = httpRequest.getSession(false);
      
       if (session == null || session.getAttribute("adminSession") == null) {
           // No valid session, redirect to login
           httpResponse.sendRedirect(contextPath + "/admin/login");
           return;
       }
      
       // Valid session exists, continue
       chain.doFilter(request, response);
   }
  
   @Override
   public void init(FilterConfig filterConfig) throws ServletException {
       // Initialization logic if needed
   }
  
   @Override
   public void destroy() {
       // Cleanup logic if needed
   }
}
