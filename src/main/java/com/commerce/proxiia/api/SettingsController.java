package com.commerce.proxiia.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/settings")
@CrossOrigin(origins = "*")
public class SettingsController {

    @GetMapping("/general")
    public ResponseEntity<Map<String, Object>> getGeneralSettings() {
        Map<String, Object> response = new HashMap<>();
        
        try {
            response.put("settings", Map.of(
                "companyName", "Commerce Proxi-IA",
                "currency", "EUR",
                "timezone", "Europe/Paris",
                "language", "fr",
                "dateFormat", "dd/MM/yyyy",
                "decimalPlaces", 2,
                "taxRate", 20.0,
                "autoBackup", true,
                "notifications", true
            ));
            
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("error", "Erreur lors de la récupération des paramètres: " + e.getMessage());
            return ResponseEntity.ok(response);
        }
    }

    @GetMapping("/notifications")
    public ResponseEntity<Map<String, Object>> getNotificationSettings() {
        Map<String, Object> response = new HashMap<>();
        
        try {
            response.put("notifications", Map.of(
                "emailNotifications", true,
                "smsNotifications", false,
                "pushNotifications", true,
                "lowStockAlerts", true,
                "orderUpdates", true,
                "priceChanges", false,
                "systemAlerts", true
            ));
            
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("error", "Erreur lors de la récupération des paramètres de notification: " + e.getMessage());
            return ResponseEntity.ok(response);
        }
    }

    @GetMapping("/security")
    public ResponseEntity<Map<String, Object>> getSecuritySettings() {
        Map<String, Object> response = new HashMap<>();
        
        try {
            response.put("security", Map.of(
                "twoFactorAuth", false,
                "sessionTimeout", 30,
                "passwordExpiry", 90,
                "maxLoginAttempts", 5,
                "ipWhitelist", List.of("192.168.1.0/24"),
                "auditLog", true,
                "dataEncryption", true
            ));
            
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("error", "Erreur lors de la récupération des paramètres de sécurité: " + e.getMessage());
            return ResponseEntity.ok(response);
        }
    }

    @PutMapping("/general")
    public ResponseEntity<Map<String, Object>> updateGeneralSettings(@RequestBody Map<String, Object> request) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            // Simulation de la mise à jour des paramètres
            response.put("message", "Paramètres mis à jour avec succès");
            response.put("updatedSettings", request);
            
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("error", "Erreur lors de la mise à jour des paramètres: " + e.getMessage());
            return ResponseEntity.ok(response);
        }
    }

    @GetMapping("/backup")
    public ResponseEntity<Map<String, Object>> getBackupSettings() {
        Map<String, Object> response = new HashMap<>();
        
        try {
            response.put("backup", Map.of(
                "autoBackup", true,
                "backupFrequency", "daily",
                "backupTime", "02:00",
                "retentionDays", 30,
                "lastBackup", "2024-01-15T02:00:00",
                "nextBackup", "2024-01-16T02:00:00",
                "backupLocation", "/backups",
                "compression", true
            ));
            
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("error", "Erreur lors de la récupération des paramètres de sauvegarde: " + e.getMessage());
            return ResponseEntity.ok(response);
        }
    }
}
