package com.commerce.proxiia.api;

import com.commerce.proxiia.model.Sale;
import com.commerce.proxiia.repositories.SaleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api/sales")
@CrossOrigin(origins = "*")
public class SalesController {

    @Autowired
    private SaleRepository saleRepository;

    @GetMapping
    public ResponseEntity<Map<String, Object>> getAllSales() {
        Map<String, Object> response = new HashMap<>();
        
        try {
            List<Sale> sales = saleRepository.findAll();
            response.put("sales", sales);
            response.put("total", sales.size());
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("error", "Erreur lors de la récupération des ventes: " + e.getMessage());
            return ResponseEntity.ok(response);
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<Map<String, Object>> getSaleById(@PathVariable UUID id) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            Sale sale = saleRepository.findById(id).orElse(null);
            if (sale != null) {
                response.put("sale", sale);
                return ResponseEntity.ok(response);
            } else {
                response.put("error", "Vente non trouvée");
                return ResponseEntity.ok(response);
            }
        } catch (Exception e) {
            response.put("error", "Erreur lors de la récupération de la vente: " + e.getMessage());
            return ResponseEntity.ok(response);
        }
    }

    @PostMapping
    public ResponseEntity<Map<String, Object>> createSale(@RequestBody Map<String, Object> request) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            Sale sale = new Sale();
            sale.setId(UUID.randomUUID());
            sale.setSku((String) request.get("sku"));
            sale.setQuantity((Integer) request.get("quantity"));
            sale.setUnitPrice(new BigDecimal(request.get("unitPrice").toString()));
            sale.setTotalAmount(new BigDecimal(request.get("totalAmount").toString()));
            sale.setSaleDate(LocalDateTime.now());
            sale.setCustomerId((String) request.get("customerId"));
            sale.setPaymentMethod((String) request.get("paymentMethod"));
            
            Sale savedSale = saleRepository.save(sale);
            response.put("message", "Vente créée avec succès");
            response.put("sale", savedSale);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("error", "Erreur lors de la création de la vente: " + e.getMessage());
            return ResponseEntity.ok(response);
        }
    }

    @GetMapping("/summary")
    public ResponseEntity<Map<String, Object>> getSalesSummary() {
        Map<String, Object> response = new HashMap<>();
        
        try {
            List<Sale> allSales = saleRepository.findAll();
            
            long totalSales = allSales.size();
            BigDecimal totalRevenue = allSales.stream()
                .map(Sale::getTotalAmount)
                .filter(amount -> amount != null)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
            
            BigDecimal averageSale = totalSales > 0 ? 
                totalRevenue.divide(BigDecimal.valueOf(totalSales), 2, BigDecimal.ROUND_HALF_UP) : 
                BigDecimal.ZERO;
            
            response.put("totalSales", totalSales);
            response.put("totalRevenue", totalRevenue);
            response.put("averageSale", averageSale);
            
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("error", "Erreur lors du calcul du résumé des ventes: " + e.getMessage());
            return ResponseEntity.ok(response);
        }
    }

    @GetMapping("/recent")
    public ResponseEntity<Map<String, Object>> getRecentSales() {
        Map<String, Object> response = new HashMap<>();
        
        try {
            List<Sale> recentSales = saleRepository.findAll().stream()
                .sorted((s1, s2) -> s2.getSaleDate().compareTo(s1.getSaleDate()))
                .limit(10)
                .toList();
            
            response.put("recentSales", recentSales);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("error", "Erreur lors de la récupération des ventes récentes: " + e.getMessage());
            return ResponseEntity.ok(response);
        }
    }
}
