package com.commerce.proxiia.api;

import com.commerce.proxiia.model.PurchaseOrder;
import com.commerce.proxiia.repositories.PurchaseOrderRepository;
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
@RequestMapping("/api/orders")
@CrossOrigin(origins = "*")
public class OrdersController {

    @Autowired
    private PurchaseOrderRepository purchaseOrderRepository;

    @GetMapping
    public ResponseEntity<Map<String, Object>> getAllOrders() {
        Map<String, Object> response = new HashMap<>();
        
        try {
            List<PurchaseOrder> orders = purchaseOrderRepository.findAll();
            response.put("orders", orders);
            response.put("total", orders.size());
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("error", "Erreur lors de la récupération des commandes: " + e.getMessage());
            return ResponseEntity.ok(response);
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<Map<String, Object>> getOrderById(@PathVariable UUID id) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            PurchaseOrder order = purchaseOrderRepository.findById(id).orElse(null);
            if (order != null) {
                response.put("order", order);
                return ResponseEntity.ok(response);
            } else {
                response.put("error", "Commande non trouvée");
                return ResponseEntity.ok(response);
            }
        } catch (Exception e) {
            response.put("error", "Erreur lors de la récupération de la commande: " + e.getMessage());
            return ResponseEntity.ok(response);
        }
    }

    @PostMapping
    public ResponseEntity<Map<String, Object>> createOrder(@RequestBody Map<String, Object> request) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            PurchaseOrder order = new PurchaseOrder();
            order.setId(UUID.randomUUID());
            order.setSupplierId(UUID.fromString((String) request.get("supplierId")));
            order.setOrderDate(LocalDateTime.now());
            order.setExpectedDeliveryDate(LocalDateTime.now().plusDays(7));
            order.setTotalAmount(new BigDecimal(request.get("totalAmount").toString()));
            order.setStatus("pending");
            order.setNotes((String) request.get("notes"));
            
            PurchaseOrder savedOrder = purchaseOrderRepository.save(order);
            response.put("message", "Commande créée avec succès");
            response.put("order", savedOrder);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("error", "Erreur lors de la création de la commande: " + e.getMessage());
            return ResponseEntity.ok(response);
        }
    }

    @PutMapping("/{id}/status")
    public ResponseEntity<Map<String, Object>> updateOrderStatus(
            @PathVariable UUID id,
            @RequestBody Map<String, Object> request) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            PurchaseOrder order = purchaseOrderRepository.findById(id).orElse(null);
            if (order != null) {
                String newStatus = (String) request.get("status");
                if (newStatus != null) {
                    order.setStatus(newStatus);
                    PurchaseOrder updatedOrder = purchaseOrderRepository.save(order);
                    response.put("message", "Statut de la commande mis à jour");
                    response.put("order", updatedOrder);
                } else {
                    response.put("error", "Statut requis");
                }
            } else {
                response.put("error", "Commande non trouvée");
            }
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("error", "Erreur lors de la mise à jour du statut: " + e.getMessage());
            return ResponseEntity.ok(response);
        }
    }

    @GetMapping("/summary")
    public ResponseEntity<Map<String, Object>> getOrdersSummary() {
        Map<String, Object> response = new HashMap<>();
        
        try {
            List<PurchaseOrder> allOrders = purchaseOrderRepository.findAll();
            
            long totalOrders = allOrders.size();
            long pendingOrders = allOrders.stream().filter(o -> "pending".equals(o.getStatus())).count();
            long completedOrders = allOrders.stream().filter(o -> "completed".equals(o.getStatus())).count();
            long cancelledOrders = allOrders.stream().filter(o -> "cancelled".equals(o.getStatus())).count();
            
            BigDecimal totalValue = allOrders.stream()
                .map(PurchaseOrder::getTotalAmount)
                .filter(amount -> amount != null)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
            
            response.put("totalOrders", totalOrders);
            response.put("pendingOrders", pendingOrders);
            response.put("completedOrders", completedOrders);
            response.put("cancelledOrders", cancelledOrders);
            response.put("totalValue", totalValue);
            
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("error", "Erreur lors du calcul du résumé des commandes: " + e.getMessage());
            return ResponseEntity.ok(response);
        }
    }

    @GetMapping("/recent")
    public ResponseEntity<Map<String, Object>> getRecentOrders() {
        Map<String, Object> response = new HashMap<>();
        
        try {
            List<PurchaseOrder> recentOrders = purchaseOrderRepository.findAll().stream()
                .sorted((o1, o2) -> o2.getOrderDate().compareTo(o1.getOrderDate()))
                .limit(10)
                .toList();
            
            response.put("recentOrders", recentOrders);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("error", "Erreur lors de la récupération des commandes récentes: " + e.getMessage());
            return ResponseEntity.ok(response);
        }
    }
}
