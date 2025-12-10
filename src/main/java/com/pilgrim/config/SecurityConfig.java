package com.pilgrim.config;

// Note: This requires security classes - will need to be created or commented out temporarily
// import com.pilgrim.security.CustomUserDetailsService;
// import com.pilgrim.security.JwtAuthenticationFilter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
// import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity
public class SecurityConfig {
    
    // Note: Uncomment when security classes are created
    // private final CustomUserDetailsService userDetailsService;
    // private final JwtAuthenticationFilter jwtAuthenticationFilter;
    
    // public SecurityConfig(CustomUserDetailsService userDetailsService,
    //                      JwtAuthenticationFilter jwtAuthenticationFilter) {
    //     this.userDetailsService = userDetailsService;
    //     this.jwtAuthenticationFilter = jwtAuthenticationFilter;
    // }
    
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
    
    // Note: authenticationProvider and authenticationManager are commented out
    // until CustomUserDetailsService is created
    // @Bean
    // public DaoAuthenticationProvider authenticationProvider() {
    //     DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
    //     authProvider.setUserDetailsService(userDetailsService);
    //     authProvider.setPasswordEncoder(passwordEncoder());
    //     return authProvider;
    // }
    
    // @Bean
    // public AuthenticationManager authenticationManager(AuthenticationConfiguration authConfig) throws Exception {
    //     return authConfig.getAuthenticationManager();
    // }
    
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .csrf(csrf -> csrf.disable())
            .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED))
            .authorizeHttpRequests(auth -> auth
                // Public landing pages
                .requestMatchers("/", "/index", "/home", "/aboutus", "/contactus", "/services", "/privacy", "/terms").permitAll()
                
                // Public authentication pages
                .requestMatchers("/register", "/login", "/otp-verify", "/save-user", "/verify-otp", "/login-user", "/logout").permitAll()
                
                // Scholar authentication pages
                .requestMatchers("/scholar/login", "/scholar/register/**", "/scholar/logout").permitAll()
                
                // Pooja Module paths
                .requestMatchers("/pooja/**").permitAll()
                
                // Accommodation Module paths
                .requestMatchers("/accommodation/**").permitAll()
                
                // Travel Module paths
                .requestMatchers("/pilgrim/travel/**").permitAll()
                
                // Temple Module paths
                .requestMatchers("/pilgrim/temple/**").permitAll()
                .requestMatchers("/pilgrim/temple-admin/**").permitAll()
                
                // Auth endpoints
                .requestMatchers("/auth/**").permitAll()
                .requestMatchers("/api/auth/**").permitAll()
                .requestMatchers("/api/public/**").permitAll()
                .requestMatchers("/api/chat/**").permitAll()
                .requestMatchers("/jsp/**").permitAll()
                
                // Admin pages (from existing application)
                .requestMatchers("/admin/**").permitAll()
                .requestMatchers("/user/**").permitAll()
                .requestMatchers("/pilgrim/**").permitAll()
                
                // Static resources
                .requestMatchers("/css/**", "/js/**", "/images/**", "/fonts/**", "/webjars/**", "/views/**").permitAll()
                .requestMatchers("/static/**").permitAll()
                
                // H2 Console (development only)
                .requestMatchers("/h2-console/**").permitAll()
                
                // Uploads
                .requestMatchers("/uploads/**").permitAll()
                
                // Temporarily permit all requests until security classes are created
                // TODO: Uncomment and configure authentication when CustomUserDetailsService is available
                .anyRequest().permitAll()
                // .anyRequest().authenticated()
            )
            .headers(headers -> headers.frameOptions(frame -> frame.sameOrigin()));
            // .authenticationProvider(authenticationProvider());
            // .addFilterBefore(jwtAuthenticationFilter, UsernamePasswordAuthenticationFilter.class);
        
        return http.build();
    }
}

