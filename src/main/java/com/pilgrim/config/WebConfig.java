package com.pilgrim.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

@Configuration(proxyBeanMethods = false)
public class WebConfig implements WebMvcConfigurer {
    
    @Value("${file.upload.directory:C:/pilgrim-uploads/}")
    private String uploadDirectory;
    
    /**
     * Configure JSP View Resolver with highest priority (order 0)
     * This ensures JSP views are resolved before Thymeleaf
     * Spring Boot's auto-configured ThymeleafViewResolver will have lower priority
     */
    @Bean
    public ViewResolver jspViewResolver() {
        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
        resolver.setPrefix("/WEB-INF/views/");
        resolver.setSuffix(".jsp");
        resolver.setViewClass(JstlView.class);
        resolver.setOrder(0); // Highest priority - checked first (lower number = higher priority)
        return resolver;
    }
    
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // Serve uploaded files
        registry.addResourceHandler("/uploads/**")
                .addResourceLocations("file:" + uploadDirectory);
        
        // Static resources
        registry.addResourceHandler("/css/**")
                .addResourceLocations("classpath:/static/css/");
        registry.addResourceHandler("/js/**")
                .addResourceLocations("classpath:/static/js/");
        registry.addResourceHandler("/images/**")
                .addResourceLocations("classpath:/static/images/");
        registry.addResourceHandler("/static/**")
                .addResourceLocations("classpath:/static/");
        
        // JSP images in views folder
        registry.addResourceHandler("/views/images/**")
                .addResourceLocations("/WEB-INF/views/images/");
    }
    
    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        // Removed default redirect to allow HomeController to handle "/"
        registry.addRedirectViewController("/admin", "/admin/dashboard");
    }
}

