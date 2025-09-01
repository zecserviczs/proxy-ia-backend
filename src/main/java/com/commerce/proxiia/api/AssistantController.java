package com.commerce.proxiia.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/assistant")
@CrossOrigin(origins = "*")
public class AssistantController {

    @GetMapping("/quick-actions")
    public ResponseEntity<Map<String, Object>> getQuickActions() {
        Map<String, Object> response = new HashMap<>();
        
        try {
            response.put("quickActions", List.of(
                Map.of(
                    "id", "QA001",
                    "title", "Analyser les ventes",
                    "description", "Générer un rapport détaillé des ventes",
                    "icon", "chart-line",
                    "action", "analyze_sales"
                ),
                Map.of(
                    "id", "QA002",
                    "title", "Prévoir les stocks",
                    "description", "Prédire les besoins en stock",
                    "icon", "warehouse",
                    "action", "predict_stock"
                ),
                Map.of(
                    "id", "QA003",
                    "title", "Optimiser les prix",
                    "description", "Suggérer des ajustements de prix",
                    "icon", "tags",
                    "action", "optimize_pricing"
                ),
                Map.of(
                    "id", "QA004",
                    "title", "Analyser la concurrence",
                    "description", "Comparer avec les prix concurrents",
                    "icon", "search",
                    "action", "analyze_competition"
                )
            ));
            
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("error", "Erreur lors de la récupération des actions rapides: " + e.getMessage());
            return ResponseEntity.ok(response);
        }
    }

    @GetMapping("/chat-history")
    public ResponseEntity<Map<String, Object>> getChatHistory() {
        Map<String, Object> response = new HashMap<>();
        
        try {
            response.put("chatHistory", List.of(
                Map.of(
                    "id", "CH001",
                    "message", "Comment optimiser mes stocks ?",
                    "response", "Basé sur vos données, je recommande de réduire le stock des produits à faible rotation et d'augmenter celui des produits populaires.",
                    "timestamp", "2024-01-15T10:30:00",
                    "type", "user"
                ),
                Map.of(
                    "id", "CH002",
                    "message", "Quels sont mes produits les plus rentables ?",
                    "message", "Vos produits les plus rentables sont l'iPhone 15 (marge de 35%), MacBook Pro (marge de 28%) et AirPods Pro (marge de 42%).",
                    "timestamp", "2024-01-15T10:25:00",
                    "type", "assistant"
                )
            ));
            
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("error", "Erreur lors de la récupération de l'historique: " + e.getMessage());
            return ResponseEntity.ok(response);
        }
    }

    @PostMapping("/chat")
    public ResponseEntity<Map<String, Object>> sendMessage(@RequestBody Map<String, Object> request) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            String message = (String) request.get("message");
            
            // Simulation d'une réponse IA
            String aiResponse = "Je comprends votre question sur '" + message + "'. Basé sur l'analyse de vos données, voici mes recommandations...";
            
            response.put("response", aiResponse);
            response.put("timestamp", java.time.LocalDateTime.now().toString());
            response.put("confidence", 0.85);
            
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("error", "Erreur lors du traitement du message: " + e.getMessage());
            return ResponseEntity.ok(response);
        }
    }

    @GetMapping("/stats")
    public ResponseEntity<Map<String, Object>> getAssistantStats() {
        Map<String, Object> response = new HashMap<>();
        
        try {
            response.put("stats", Map.of(
                "totalConversations", 156,
                "averageResponseTime", 2.3,
                "satisfactionRate", 92.5,
                "mostAskedQuestions", List.of(
                    "Comment optimiser mes stocks ?",
                    "Quels sont mes produits les plus vendus ?",
                    "Comment augmenter mes marges ?"
                )
            ));
            
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("error", "Erreur lors de la récupération des statistiques: " + e.getMessage());
            return ResponseEntity.ok(response);
        }
    }
}
