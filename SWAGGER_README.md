# Documentation API avec Swagger/OpenAPI

## 🚀 Vue d'ensemble

Ce projet utilise **Swagger/OpenAPI** pour documenter automatiquement l'API REST. Swagger fournit une interface interactive pour explorer et tester tous les endpoints de l'API.

## 📋 URLs d'accès

### Interface Swagger UI
```
http://localhost:8080/swagger-ui.html
```

### Documentation JSON
```
http://localhost:8080/api-docs
```

### Documentation YAML
```
http://localhost:8080/api-docs.yaml
```

## 🔧 Configuration

### Dépendances Maven
```xml
<dependency>
    <groupId>org.springdoc</groupId>
    <artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
    <version>2.2.0</version>
</dependency>
```

### Configuration dans `application.yml`
```yaml
springdoc:
  api-docs:
    path: /api-docs
  swagger-ui:
    path: /swagger-ui.html
    operationsSorter: method
    tagsSorter: alpha
    docExpansion: none
  packages-to-scan: com.commerce.proxiia.api
```

### Configuration Java
```java
@Configuration
public class OpenApiConfig {
    @Bean
    public OpenAPI customOpenAPI() {
        return new OpenAPI()
                .info(new Info()
                        .title("Commerce Proxi-IA API")
                        .description("API REST pour la plateforme de commerce intelligent avec IA")
                        .version("1.0.0"));
    }
}
```

## 📚 Endpoints disponibles

### 🏠 Dashboard
- `GET /api/dashboard/metrics` - Métriques du tableau de bord
- `GET /api/dashboard/recent-activity` - Activité récente
- `GET /api/dashboard/sales-chart` - Données de graphiques

### 📦 Produits
- `GET /api/products` - Liste tous les produits
- `GET /api/products/{id}` - Récupère un produit par ID
- `GET /api/products/sku/{sku}` - Récupère un produit par SKU
- `POST /api/products` - Crée un nouveau produit
- `PUT /api/products/{id}` - Met à jour un produit
- `PATCH /api/products/{id}/price` - Met à jour le prix
- `PATCH /api/products/{id}/status` - Met à jour le statut

### 📊 Inventaire
- `GET /api/inventory` - Liste tout l'inventaire
- `GET /api/inventory/low-stock` - Articles en stock faible
- `GET /api/inventory/{id}` - Récupère un item d'inventaire
- `PUT /api/inventory/{id}/update-stock` - Met à jour le stock

### 💰 Ventes
- `GET /api/sales` - Liste toutes les ventes
- `GET /api/sales/{id}` - Récupère une vente par ID
- `POST /api/sales` - Crée une nouvelle vente
- `GET /api/sales/summary` - Résumé des ventes
- `GET /api/sales/recent` - Ventes récentes

### 📋 Commandes
- `GET /api/orders` - Liste toutes les commandes
- `GET /api/orders/{id}` - Récupère une commande par ID
- `POST /api/orders` - Crée une nouvelle commande
- `PUT /api/orders/{id}/status` - Met à jour le statut
- `GET /api/orders/summary` - Résumé des commandes

### 📈 Analytics
- `GET /api/analytics/reports` - Rapports analytiques
- `GET /api/analytics/metrics` - Métriques analytiques
- `GET /api/analytics/charts` - Données de graphiques
- `GET /api/analytics/insights` - Insights et recommandations

### 🤖 Assistant IA
- `GET /api/assistant/quick-actions` - Actions rapides
- `GET /api/assistant/chat-history` - Historique des conversations
- `POST /api/assistant/chat` - Envoie un message à l'assistant
- `GET /api/assistant/stats` - Statistiques de l'assistant

### ⚙️ Paramètres
- `GET /api/settings/general` - Paramètres généraux
- `GET /api/settings/notifications` - Paramètres de notification
- `GET /api/settings/security` - Paramètres de sécurité
- `PUT /api/settings/general` - Met à jour les paramètres
- `GET /api/settings/backup` - Paramètres de sauvegarde

## 🧪 Test de l'API

### Script de test automatique
```bash
./test-swagger.sh
```

### Test manuel avec curl
```bash
# Test de santé
curl http://localhost:8080/actuator/health

# Test des produits
curl http://localhost:8080/api/products

# Test du dashboard
curl http://localhost:8080/api/dashboard/metrics
```

## 🎯 Fonctionnalités Swagger

### Interface interactive
- ✅ Test direct des endpoints
- ✅ Visualisation des modèles de données
- ✅ Documentation automatique
- ✅ Authentification intégrée
- ✅ Export de la documentation

### Annotations disponibles
```java
@Tag(name = "Nom du groupe", description = "Description")
@Operation(summary = "Résumé", description = "Description détaillée")
@ApiResponses(value = {
    @ApiResponse(responseCode = "200", description = "Succès"),
    @ApiResponse(responseCode = "404", description = "Non trouvé")
})
@Parameter(name = "param", description = "Description du paramètre")
@Schema(description = "Description du modèle")
```

## 🔒 Sécurité

### CORS configuré
```java
@CrossOrigin(origins = "*")
```

### Headers de sécurité recommandés
```yaml
# À ajouter en production
springdoc:
  swagger-ui:
    csrf:
      enabled: true
```

## 🚀 Déploiement

### Production
```yaml
springdoc:
  swagger-ui:
    enabled: false  # Désactiver en production
  api-docs:
    enabled: false  # Désactiver en production
```

### Développement
```yaml
springdoc:
  swagger-ui:
    enabled: true
  api-docs:
    enabled: true
```

## 📖 Ressources supplémentaires

- [Documentation SpringDoc](https://springdoc.org/)
- [Spécification OpenAPI](https://swagger.io/specification/)
- [Swagger UI](https://swagger.io/tools/swagger-ui/)
- [Annotations OpenAPI](https://github.com/swagger-api/swagger-core/wiki/Annotations)
