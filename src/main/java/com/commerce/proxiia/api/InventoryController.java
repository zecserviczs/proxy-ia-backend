package com.commerce.proxiia.api;

import com.commerce.proxiia.model.Inventory;
import com.commerce.proxiia.model.Product;
import com.commerce.proxiia.repositories.InventoryRepository;
import com.commerce.proxiia.repositories.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api/inventory")
@CrossOrigin(origins = "*")
public class InventoryController {

    @Autowired
    private InventoryRepository inventoryRepository;

    @Autowired
    private ProductRepository productRepository;

    @GetMapping
    public ResponseEntity<Map<String, Object>> getAllInventory() {
        Map<String, Object> response = new HashMap<>();
        
        try {
            List<Inventory> inventory = inventoryRepository.findAll();
            response.put("inventory", inventory);
            response.put("total", inventory.size());
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("error", "Erreur lors de la récupération de l'inventaire: " + e.getMessage());
            return ResponseEntity.ok(response);
        }
    }

    @GetMapping("/low-stock")
    public ResponseEntity<Map<String, Object>> getLowStockItems() {
        Map<String, Object> response = new HashMap<>();
        
        try {
            List<Inventory> lowStockItems = inventoryRepository.findAll().stream()
                .filter(item -> item.getAvailableQuantity() != null && item.getAvailableQuantity() < 10)
                .toList();
            
            response.put("lowStockItems", lowStockItems);
            response.put("count", lowStockItems.size());
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("error", "Erreur lors de la récupération des articles en stock faible: " + e.getMessage());
            return ResponseEntity.ok(response);
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<Map<String, Object>> getInventoryById(@PathVariable UUID id) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            Inventory inventory = inventoryRepository.findById(id).orElse(null);
            if (inventory != null) {
                response.put("inventory", inventory);
                return ResponseEntity.ok(response);
            } else {
                response.put("error", "Inventaire non trouvé");
                return ResponseEntity.ok(response);
            }
        } catch (Exception e) {
            response.put("error", "Erreur lors de la récupération de l'inventaire: " + e.getMessage());
            return ResponseEntity.ok(response);
        }
    }

    @PutMapping("/{id}/update-stock")
    public ResponseEntity<Map<String, Object>> updateStock(
            @PathVariable UUID id,
            @RequestBody Map<String, Object> request) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            Inventory inventory = inventoryRepository.findById(id).orElse(null);
            if (inventory != null) {
                Integer newQuantity = (Integer) request.get("quantity");
                if (newQuantity != null) {
                    inventory.setAvailableQuantity(newQuantity);
                    inventoryRepository.save(inventory);
                    response.put("message", "Stock mis à jour avec succès");
                    response.put("inventory", inventory);
                } else {
                    response.put("error", "Quantité requise");
                }
            } else {
                response.put("error", "Inventaire non trouvé");
            }
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("error", "Erreur lors de la mise à jour du stock: " + e.getMessage());
            return ResponseEntity.ok(response);
        }
    }

    @GetMapping("/summary")
    public ResponseEntity<Map<String, Object>> getInventorySummary() {
        Map<String, Object> response = new HashMap<>();
        
        try {
            List<Inventory> allInventory = inventoryRepository.findAll();
            
            long totalItems = allInventory.size();
            long lowStockItems = allInventory.stream()
                .filter(item -> item.getAvailableQuantity() != null && item.getAvailableQuantity() < 10)
                .count();
            long outOfStockItems = allInventory.stream()
                .filter(item -> item.getAvailableQuantity() != null && item.getAvailableQuantity() == 0)
                .count();
            
            response.put("totalItems", totalItems);
            response.put("lowStockItems", lowStockItems);
            response.put("outOfStockItems", outOfStockItems);
            response.put("inStockItems", totalItems - outOfStockItems);
            
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("error", "Erreur lors du calcul du résumé de l'inventaire: " + e.getMessage());
            return ResponseEntity.ok(response);
        }
    }
}
