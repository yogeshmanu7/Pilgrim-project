package com.pilgrim.service;

import com.pilgrim.entity.AppSettings;
import com.pilgrim.entity.Admin;
import com.pilgrim.repository.AppSettingsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jakarta.annotation.PostConstruct;
import java.util.List;
import java.util.Optional;

@Service
public class AppSettingsService {
    
    @Autowired
    private AppSettingsRepository settingsRepository;
    
    @Autowired
    private AuditLogService auditLogService;
    
    @PostConstruct
    public void initializeDefaultSettings() {
        createSettingIfNotExists("tax_percent", "18", "NUMBER", "FINANCE", "Tax percentage for orders");
        createSettingIfNotExists("service_fee", "10", "NUMBER", "FINANCE", "Service fee amount");
        createSettingIfNotExists("min_order_amount", "100", "NUMBER", "ORDERS", "Minimum order amount");
        createSettingIfNotExists("max_booking_days", "30", "NUMBER", "BOOKING", "Maximum days in advance for booking");
        createSettingIfNotExists("cancellation_hours", "24", "NUMBER", "BOOKING", "Hours before which cancellation is free");
        createSettingIfNotExists("upload_directory", "C:/pilgrim-uploads/", "STRING", "SYSTEM", "File upload directory");
        createSettingIfNotExists("app_name", "Pilgrim Temple", "STRING", "GENERAL", "Application name");
        createSettingIfNotExists("support_email", "support@pilgrim.com", "STRING", "GENERAL", "Support email address");
        createSettingIfNotExists("support_phone", "+91-9999999999", "STRING", "GENERAL", "Support phone number");
    }
    
    private void createSettingIfNotExists(String key, String value, String type, String group, String description) {
        if (settingsRepository.findBySettingKey(key).isEmpty()) {
            AppSettings setting = AppSettings.builder()
                    .settingKey(key)
                    .settingValue(value)
                    .settingType(type)
                    .settingGroup(group)
                    .description(description)
                    .isEditable(true)
                    .build();
            settingsRepository.save(setting);
        }
    }
    
    public List<AppSettings> getAllSettings() {
        return settingsRepository.findAll();
    }
    
    public List<AppSettings> getSettingsByGroup(String group) {
        return settingsRepository.findBySettingGroup(group);
    }
    
    public Optional<AppSettings> getSettingByKey(String key) {
        return settingsRepository.findBySettingKey(key);
    }
    
    public String getSettingValue(String key, String defaultValue) {
        return settingsRepository.findBySettingKey(key)
                .map(AppSettings::getSettingValue)
                .orElse(defaultValue);
    }
    
    public Double getNumericSetting(String key, Double defaultValue) {
        return settingsRepository.findBySettingKey(key)
                .map(s -> Double.parseDouble(s.getSettingValue()))
                .orElse(defaultValue);
    }
    
    @Transactional
    public AppSettings updateSetting(String key, String value, Admin admin) {
        AppSettings setting = settingsRepository.findBySettingKey(key)
                .orElseThrow(() -> new RuntimeException("Setting not found"));
        
        if (!setting.isEditable()) {
            throw new RuntimeException("This setting cannot be modified");
        }
        
        String oldValue = setting.getSettingValue();
        setting.setSettingValue(value);
        setting.setUpdatedBy(admin.getId());
        setting = settingsRepository.save(setting);
        
        auditLogService.logAction(admin.getId(), admin.getName(), admin.getEmail(),
                "UPDATE", "AppSettings", setting.getId(), key,
                "Setting updated", oldValue, value, null, null);
        
        return setting;
    }
    
    @Transactional
    public AppSettings createSetting(AppSettings setting, Admin admin) {
        setting = settingsRepository.save(setting);
        
        auditLogService.logAction(admin.getId(), admin.getName(), admin.getEmail(),
                "CREATE", "AppSettings", setting.getId(), setting.getSettingKey(),
                "Setting created", null, null, null, null);
        
        return setting;
    }
}

