package com.pilgrim;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.thymeleaf.ThymeleafAutoConfiguration;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class PilgrimTempleApplication extends SpringBootServletInitializer {

    public static void main(String[] args) {
        SpringApplication.run(PilgrimTempleApplication.class, args);
        System.out.println("Namma Piligrim");
    }
}

