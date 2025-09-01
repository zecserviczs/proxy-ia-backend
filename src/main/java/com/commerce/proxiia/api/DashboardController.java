package com.commerce.proxiia.api;

import com.commerce.proxiia.model.Product;
import com.commerce.proxiia.model.Sale;
import com.commerce.proxiia.model.PurchaseOrder;
import com.commerce.proxiia.repositories.ProductRepository;
import com.commerce.proxiia.repositories.SaleRepository;
import com.commerce.proxiia.repositories.PurchaseOrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/dashboard")
@CrossOrigin(origins = "*")
public class DashboardController {

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private SaleRepository saleRepository;

    @Autowired
    private PurchaseOrderRepository purchaseOrderRepository;

    @GetMapping("/metrics")
    public ResponseEntity<Map<String, Object>> getDashboardMetrics() {
        Map<String, Object> metrics = new HashMap<>();
        
        try {
            // Statistiques des produits
            List<Product> allProducts = productRepository.findAll();
            long totalProducts = allProducts.size();
            long activeProducts = allProducts.stream().filter(p -> p.isActive()).count();
            long lowStockProducts = allProducts.stream().filter(p -> p.getPrice() != null && p.getPrice().compareTo(BigDecimal.valueOf(10)) < 0).count();
            
            // Statistiques des ventes (simulées car pas de vraies ventes)
            BigDecimal totalRevenue = BigDecimal.valueOf(125000.00);
            BigDecimal monthlyRevenue = BigDecimal.valueOf(15000.00);
            long totalOrders = 45;
            
            // Statistiques des commandes
            List<PurchaseOrder> allOrders = purchaseOrderRepository.findAll();
            long pendingOrders = allOrders.stream().filter(o -> "pending".equals(o.getStatus())).count();
            long completedOrders = allOrders.stream().filter(o -> "completed".equals(o.getStatus())).count();
            
            metrics.put("totalProducts", totalProducts);
            metrics.put("activeProducts", activeProducts);
            metrics.put("lowStockProducts", lowStockProducts);
            metrics.put("totalRevenue", totalRevenue);
            metrics.put("monthlyRevenue", monthlyRevenue);
            metrics.put("totalOrders", totalOrders);
            metrics.put("pendingOrders", pendingOrders);
            metrics.put("completedOrders", completedOrders);
            
            return ResponseEntity.ok(metrics);
        } catch (Exception e) {
            metrics.put("error", "Erreur lors du calcul des métriques: " + e.getMessage());
            return ResponseEntity.ok(metrics);
        }
    }

    @GetMapping("/recent-activity")
    public ResponseEntity<Map<String, Object>> getRecentActivity() {
        Map<String, Object> activity = new HashMap<>();
        
        try {
            // Activité récente simulée
            activity.put("recentSales", List.of(
                Map.of("id", "S001", "product", "iPhone 15", "amount", 999.99, "date", "2024-01-15"),
                Map.of("id", "S002", "product", "MacBook Pro", "amount", 2499.99, "date", "2024-01-14"),
                Map.of("id", "S003", "product", "AirPods Pro", "amount", 249.99, "date", "2024-01-13")
            ));
            
            activity.put("recentOrders", List.of(
                Map.of("id", "PO001", "supplier", "Apple Inc.", "status", "pending", "date", "2024-01-15"),
                Map.of("id", "PO002", "supplier", "Samsung", "status", "completed", "date", "2024-01-14"),
                Map.of("id", "PO003", "supplier", "Sony", "status", "processing", "date", "2024-01-13")
            ));
            
            return ResponseEntity.ok(activity);
        } catch (Exception e) {
            activity.put("error", "Erreur lors de la récupération de l'activité récente: " + e.getMessage());
            return ResponseEntity.ok(activity);
        }
    }

    @GetMapping("/sales-chart")
    public ResponseEntity<Map<String, Object>> getSalesChart() {
        Map<String, Object> chartData = new HashMap<>();
        
        try {
            // Données de graphique simulées
            chartData.put("labels", List.of("Jan", "Fév", "Mar", "Avr", "Mai", "Jun"));
            chartData.put("sales", List.of(12000, 15000, 18000, 14000, 22000, 25000));
            chartData.put("orders", List.of(45, 52, 68, 48, 78, 85));
            
            return ResponseEntity.ok(chartData);
        } catch (Exception e) {
            chartData.put("error", "Erreur lors de la récupération des données de graphique: " + e.getMessage());
            return ResponseEntity.ok(chartData);
        }
    }
}
