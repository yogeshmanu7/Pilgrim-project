package com.pilgrim.controller;

import lombok.RequiredArgsConstructor;
import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVParser;
import org.apache.commons.csv.CSVRecord;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import jakarta.annotation.PostConstruct;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.*;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/pilgrim/temple/api/location")
@RequiredArgsConstructor
public class TempleLocationController {
    
    private static final String CSV_CLASSPATH = "pincode-data.csv";
    private static final String CSV_EXTERNAL_PATH = "uploads/temples/pincode-data.csv";
    
    @Value("${csv.location.path:}")
    private String configuredCsvPath;
    
    private List<LocationRecord> locationRecords = new ArrayList<>();
    private Set<String> statesCache = new HashSet<>();
    private Map<String, Set<String>> stateDistrictsCache = new HashMap<>();
    private Map<String, Set<String>> districtPincodesCache = new HashMap<>();
    
    @PostConstruct
    public void loadCSVData() {
        try {
            System.out.println("Loading location data from CSV file...");
            
            InputStream csvInputStream = null;
            
            try {
                Resource resource = new ClassPathResource(CSV_CLASSPATH);
                if (resource.exists()) {
                    csvInputStream = resource.getInputStream();
                    System.out.println("Reading CSV from classpath: " + CSV_CLASSPATH);
                }
            } catch (Exception e) {
                System.out.println("CSV not found in classpath, trying external path...");
            }
            
            if (csvInputStream == null) {
                String userDir = System.getProperty("user.dir");
                System.out.println("Current working directory: " + userDir);
                
                List<String> pathsToTry = new ArrayList<>();
                
                if (configuredCsvPath != null && !configuredCsvPath.trim().isEmpty()) {
                    pathsToTry.add(configuredCsvPath.trim());
                    System.out.println("Using configured CSV path from application.properties: " + configuredCsvPath);
                }
                
                pathsToTry.add(CSV_EXTERNAL_PATH);
                pathsToTry.add(userDir + File.separator + CSV_EXTERNAL_PATH);
                pathsToTry.add(userDir + "/" + CSV_EXTERNAL_PATH.replace("\\", "/"));
                pathsToTry.add(userDir + File.separator + "uploads" + File.separator + "temples" + File.separator + "pincode-data.csv");
                pathsToTry.add(userDir + "/uploads/temples/pincode-data.csv");
                
                File currentDir = new File(userDir);
                while (currentDir != null && currentDir.exists()) {
                    File uploadsDir = new File(currentDir, "uploads/temples/pincode-data.csv");
                    if (uploadsDir.exists()) {
                        pathsToTry.add(uploadsDir.getAbsolutePath());
                        break;
                    }
                    currentDir = currentDir.getParentFile();
                }
                
                File csvFile = null;
                for (String path : pathsToTry) {
                    File testFile = new File(path);
                    String absPath = testFile.getAbsolutePath();
                    boolean exists = testFile.exists() && testFile.isFile();
                    System.out.println("Trying path: " + absPath + " - exists: " + exists);
                    if (exists) {
                        csvFile = testFile;
                        System.out.println("✅ Found CSV file at: " + csvFile.getAbsolutePath());
                        break;
                    }
                }
                
                if (csvFile != null && csvFile.exists() && csvFile.isFile()) {
                    try {
                        csvInputStream = Files.newInputStream(Paths.get(csvFile.getAbsolutePath()));
                        System.out.println("✅ Successfully opened CSV file: " + csvFile.getAbsolutePath());
                        System.out.println("✅ File size: " + csvFile.length() + " bytes");
                    } catch (IOException e) {
                        System.err.println("❌ Error opening CSV file: " + e.getMessage());
                        e.printStackTrace();
                    }
                } else {
                    System.err.println("❌ CSV file not found in any of the tried paths!");
                    System.err.println("Total paths tried: " + pathsToTry.size());
                }
            }
            
            if (csvInputStream == null) {
                System.err.println("ERROR: CSV file not found in classpath or external locations!");
                System.err.println("Tried classpath: " + CSV_CLASSPATH);
                System.err.println("Tried external: " + CSV_EXTERNAL_PATH);
                System.err.println("Current working directory: " + System.getProperty("user.dir"));
                System.err.println("Please ensure the CSV file exists at: uploads/temples/pincode-data.csv");
                return;
            }
            
            try (BufferedReader reader = new BufferedReader(new InputStreamReader(csvInputStream, StandardCharsets.UTF_8));
                 CSVParser csvParser = new CSVParser(reader, CSVFormat.DEFAULT.withFirstRecordAsHeader().withIgnoreHeaderCase().withTrim())) {
                
                Set<String> headerNames = csvParser.getHeaderMap().keySet();
                System.out.println("CSV Headers found: " + headerNames);
                
                int recordCount = 0;
                int skippedCount = 0;
                for (CSVRecord record : csvParser) {
                    try {
                        String pincode = record.get("pincode");
                        String district = record.get("district");
                        String statename = record.get("statename");
                        
                        if (pincode != null && !pincode.trim().isEmpty() &&
                            district != null && !district.trim().isEmpty() &&
                            statename != null && !statename.trim().isEmpty()) {
                            
                            LocationRecord locRecord = new LocationRecord(
                                pincode.trim(),
                                district.trim(),
                                statename.trim()
                            );
                            locationRecords.add(locRecord);
                            
                            statesCache.add(statename.trim());
                            
                            stateDistrictsCache
                                .computeIfAbsent(statename.trim(), k -> new HashSet<>())
                                .add(district.trim());
                            
                            districtPincodesCache
                                .computeIfAbsent(district.trim(), k -> new HashSet<>())
                                .add(pincode.trim());
                            
                            recordCount++;
                            
                            if (recordCount <= 3) {
                                System.out.println("Sample record " + recordCount + ": State=" + statename.trim() + ", District=" + district.trim() + ", Pincode=" + pincode.trim());
                            }
                        } else {
                            skippedCount++;
                            if (skippedCount <= 3) {
                                System.out.println("Skipped record (missing data): pincode=" + pincode + ", district=" + district + ", statename=" + statename);
                            }
                        }
                    } catch (Exception e) {
                        skippedCount++;
                        if (skippedCount <= 3) {
                            System.err.println("Error parsing record " + (recordCount + skippedCount) + ": " + e.getMessage());
                        }
                    }
                }
                
                System.out.println("Skipped " + skippedCount + " invalid or incomplete records");
                
                System.out.println("========================================");
                System.out.println("✅ Successfully loaded " + recordCount + " location records");
                System.out.println("✅ States: " + statesCache.size());
                System.out.println("✅ Total districts: " + stateDistrictsCache.values().stream().mapToInt(Set::size).sum());
                System.out.println("✅ Total pincodes: " + districtPincodesCache.values().stream().mapToInt(Set::size).sum());
                System.out.println("========================================");
                
                if (statesCache.isEmpty()) {
                    System.err.println("⚠️  WARNING: No states loaded! Check CSV file format and column names.");
                }
            }
        } catch (Exception e) {
            System.err.println("Error loading CSV file: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    @GetMapping("/health")
    public ResponseEntity<Map<String, Object>> health() {
        Map<String, Object> health = new HashMap<>();
        health.put("csvLoaded", !locationRecords.isEmpty());
        health.put("totalRecords", locationRecords.size());
        health.put("statesCount", statesCache.size());
        health.put("districtsCount", stateDistrictsCache.values().stream().mapToInt(Set::size).sum());
        health.put("pincodesCount", districtPincodesCache.values().stream().mapToInt(Set::size).sum());
        health.put("sampleStates", statesCache.stream().sorted().limit(5).collect(Collectors.toList()));
        return ResponseEntity.ok(health);
    }
    
    @GetMapping("/countries")
    public ResponseEntity<List<String>> getCountries() {
        System.out.println("GET /pilgrim/temple/api/location/countries - Returning countries");
        return ResponseEntity.ok(Collections.singletonList("India"));
    }
    
    @GetMapping("/states")
    public ResponseEntity<List<String>> getStates(@RequestParam(required = false) String country) {
        System.out.println("GET /pilgrim/temple/api/location/states?country=" + country);
        System.out.println("States cache size: " + statesCache.size());
        
        if (statesCache.isEmpty()) {
            System.err.println("WARNING: States cache is empty! CSV file may not have loaded correctly.");
            System.err.println("Total location records loaded: " + locationRecords.size());
        }
        
        List<String> states = new ArrayList<>(statesCache);
        Collections.sort(states);
        System.out.println("Returning " + states.size() + " states");
        return ResponseEntity.ok(states);
    }
    
    @GetMapping("/districts")
    public ResponseEntity<List<String>> getDistricts(@RequestParam String state) {
        System.out.println("GET /pilgrim/temple/api/location/districts?state=" + state);
        System.out.println("State districts cache size: " + stateDistrictsCache.size());
        System.out.println("Available states in cache: " + stateDistrictsCache.keySet());
        
        Set<String> districts = stateDistrictsCache.getOrDefault(state, Collections.emptySet());
        
        if (districts.isEmpty()) {
            for (String key : stateDistrictsCache.keySet()) {
                if (key.equalsIgnoreCase(state)) {
                    districts = stateDistrictsCache.get(key);
                    System.out.println("Found state (case-insensitive): " + key + " for input: " + state);
                    break;
                }
            }
        }
        
        List<String> districtList = new ArrayList<>(districts);
        Collections.sort(districtList);
        System.out.println("Returning " + districtList.size() + " districts for state: " + state);
        return ResponseEntity.ok(districtList);
    }
    
    @GetMapping("/pincodes")
    public ResponseEntity<List<String>> getPincodes(@RequestParam String district) {
        Set<String> pincodes = districtPincodesCache.get(district);
        
        if (pincodes == null || pincodes.isEmpty()) {
            for (String key : districtPincodesCache.keySet()) {
                if (key.equalsIgnoreCase(district)) {
                    pincodes = districtPincodesCache.get(key);
                    System.out.println("Found district (case-insensitive): " + key + " for input: " + district);
                    break;
                }
            }
        }
        
        if (pincodes == null || pincodes.isEmpty()) {
            System.out.println("No pincodes found for district: " + district);
            return ResponseEntity.ok(Collections.emptyList());
        }
        
        List<String> pincodeList = new ArrayList<>(pincodes);
        Collections.sort(pincodeList);
        System.out.println("Returning " + pincodeList.size() + " pincodes for district: " + district);
        return ResponseEntity.ok(pincodeList);
    }
    
    private static class LocationRecord {
        String pincode; 
        String district;
        String statename;
        
        LocationRecord(String pincode, String district, String statename) {
            this.pincode = pincode;
            this.district = district;
            this.statename = statename;
        }
    }
}

