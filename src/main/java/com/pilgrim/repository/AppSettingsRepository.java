package com.pilgrim.repository;

import com.pilgrim.entity.AppSettings;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface AppSettingsRepository extends JpaRepository<AppSettings, Long> {
    
    Optional<AppSettings> findBySettingKey(String settingKey);
    
    List<AppSettings> findBySettingGroup(String settingGroup);
    
    List<AppSettings> findByIsEditableTrue();
}

