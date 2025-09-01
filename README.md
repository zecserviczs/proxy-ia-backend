# 🚀 Backend Proxi-IA Commerce

Backend Spring Boot complet pour la plateforme e-commerce Proxi-IA avec fonctionnalités d'intelligence artificielle.

## 📋 Table des matières

- [Fonctionnalités](#-fonctionnalités)
- [Technologies utilisées](#-technologies-utilisées)
- [Architecture](#-architecture)
- [Installation](#-installation)
- [Configuration](#-configuration)
- [Démarrage](#-démarrage)
- [API Endpoints](#-api-endpoints)
- [Base de données](#-base-de-données)
- [Tests](#-tests)
- [Déploiement](#-déploiement)

## ✨ Fonctionnalités

### 🛍️ Gestion des Produits
- CRUD complet des produits
- Gestion des catégories et marques
- Système de SKU unique
- Images et descriptions détaillées

### 📦 Gestion de l'Inventaire
- Suivi des stocks en temps réel
- Alertes de stock faible
- Gestion des emplacements
- Historique des mouvements

### 💰 Gestion des Ventes
- Enregistrement des transactions
- Suivi des clients
- Statistiques de vente
- Rapports de performance

### 🚚 Gestion des Commandes
- Commandes d'achat fournisseurs
- Suivi des statuts
- Gestion des délais de livraison
- Historique des commandes

### 👥 Gestion des Fournisseurs
- Base de données fournisseurs
- Évaluation et notation
- Gestion des contacts
- Historique des relations

### 🤖 Intelligence Artificielle
- Assistant IA intégré
- Analyse prédictive des ventes
- Optimisation des prix
- Recommandations produits

### 📊 Tableau de Bord
- Métriques en temps réel
- Graphiques interactifs
- Alertes et notifications
- Rapports personnalisables

### ⚙️ Paramètres et Configuration
- Configuration système
- Gestion des utilisateurs
- Intégrations tierces
- Sauvegarde et sécurité

## 🛠️ Technologies utilisées

- **Java 17+** - Langage principal
- **Spring Boot 3.x** - Framework principal
- **Spring Data JPA** - Persistance des données
- **PostgreSQL** - Base de données
- **Flyway** - Migration de base de données
- **Maven** - Gestion des dépendances
- **Docker** - Conteneurisation
- **Swagger/OpenAPI** - Documentation API

## 🏗️ Architecture

```
src/main/java/com/commerce/proxiia/
├── api/                    # Contrôleurs REST
│   ├── ProductController.java
│   ├── InventoryController.java
│   ├── SalesController.java
│   ├── OrdersController.java
│   ├── PricingController.java
│   ├── AnalyticsController.java
│   ├── AssistantController.java
│   ├── SupplierController.java
│   ├── PurchaseOrdersController.java
│   ├── SettingsController.java
│   └── DashboardController.java
├── model/                  # Entités JPA
│   ├── Product.java
│   ├── Inventory.java
│   ├── Sale.java
│   ├── PurchaseOrder.java
│   └── Supplier.java
├── repositories/           # Interfaces Repository
│   ├── ProductRepository.java
│   ├── InventoryRepository.java
│   ├── SaleRepository.java
│   ├── PurchaseOrderRepository.java
│   └── SupplierRepository.java
├── config/                 # Configuration
│   └── SecurityConfiguration.java
└── ProxiIaApplication.java # Classe principale
```

## 📦 Installation

### Prérequis

- Java 17 ou supérieur
- Maven 3.6+
- Docker et Docker Compose
- PostgreSQL 15+ (optionnel, Docker recommandé)

### Étapes d'installation

1. **Cloner le projet**
   ```bash
   git clone <repository-url>
   cd backend
   ```

2. **Vérifier Java et Maven**
   ```bash
   java -version
   mvn -version
   ```

3. **Démarrer PostgreSQL (via Docker)**
   ```bash
   docker run -d \
     --name proxi-ia-postgres \
     -e POSTGRES_DB=proxi_ia_db \
     -e POSTGRES_USER=proxi_ia_user \
     -e POSTGRES_PASSWORD=proxi_ia_password \
     -p 5432:5432 \
     postgres:15
   ```

## ⚙️ Configuration

### Variables d'environnement

Créez un fichier `.env` à la racine du projet :

```env
# Base de données
DB_HOST=localhost
DB_PORT=5432
DB_NAME=proxi_ia_db
DB_USER=proxi_ia_user
DB_PASSWORD=proxi_ia_password

# Application
APP_PORT=8080
APP_ENV=development
APP_DEBUG=true

# Sécurité
JWT_SECRET=your-secret-key
JWT_EXPIRATION=86400000
```

### Configuration application.yml

Le fichier `src/main/resources/application.yml` contient la configuration par défaut :

```yaml
spring:
  datasource:
    url: jdbc:postgresql://localhost:5432/proxi_ia_db
    username: proxi_ia_user
    password: proxi_ia_password
  jpa:
    hibernate:
      ddl-auto: validate
    show-sql: true
  flyway:
    enabled: true
    locations: classpath:db/migration
```

## 🚀 Démarrage

### Méthode 1: Script automatique (recommandé)

```bash
./start-backend.sh
```

### Méthode 2: Maven

```bash
mvn spring-boot:run
```

### Méthode 3: JAR exécutable

```bash
mvn clean package
java -jar target/proxi-ia-backend-1.0.0.jar
```

## 🔌 API Endpoints

### Produits
- `GET /api/products` - Liste des produits
- `GET /api/products/{id}` - Détails d'un produit
- `POST /api/products` - Créer un produit
- `PUT /api/products/{id}` - Modifier un produit
- `DELETE /api/products/{id}` - Supprimer un produit

### Inventaire
- `GET /api/inventory` - État des stocks
- `GET /api/inventory/low-stock` - Produits en stock faible
- `PATCH /api/inventory/{id}/quantity` - Mettre à jour la quantité

### Ventes
- `GET /api/sales` - Historique des ventes
- `GET /api/sales/stats` - Statistiques de vente
- `POST /api/sales` - Enregistrer une vente

### Tableau de Bord
- `GET /api/dashboard/overview` - Vue d'ensemble
- `GET /api/dashboard/metrics` - Métriques clés
- `GET /api/dashboard/sales-chart` - Graphique des ventes

### Assistant IA
- `GET /api/assistant/quick-actions` - Actions rapides
- `POST /api/assistant/chat` - Chat avec l'IA
- `GET /api/assistant/insights` - Insights business

## 🗄️ Base de données

### Structure des tables

- **products** - Catalogue des produits
- **inventory** - Gestion des stocks
- **sales** - Historique des ventes
- **purchase_orders** - Commandes fournisseurs
- **suppliers** - Base fournisseurs

### Migration automatique

Flyway gère automatiquement les migrations de base de données :

```bash
# Vérifier le statut des migrations
mvn flyway:info

# Appliquer les migrations
mvn flyway:migrate

# Réinitialiser la base
mvn flyway:clean
```

### Données de test

Un script de chargement est disponible :

```bash
# Exécuter le script SQL
psql -h localhost -U proxi_ia_user -d proxi_ia_db -f src/main/resources/db/data.sql
```

## 🧪 Tests

### Tests unitaires

```bash
mvn test
```

### Tests d'intégration

```bash
mvn verify
```

### Tests avec couverture

```bash
mvn jacoco:report
```

## 🚀 Déploiement

### Docker

```bash
# Construire l'image
docker build -t proxi-ia-backend .

# Lancer le conteneur
docker run -p 8080:8080 proxi-ia-backend
```

### Docker Compose

```yaml
version: '3.8'
services:
  backend:
    build: .
    ports:
      - "8080:8080"
    environment:
      - SPRING_PROFILES_ACTIVE=production
    depends_on:
      - postgres
  
  postgres:
    image: postgres:15
    environment:
      POSTGRES_DB: proxi_ia_db
      POSTGRES_USER: proxi_ia_user
      POSTGRES_PASSWORD: proxi_ia_password
    volumes:
      - postgres_data:/var/lib/postgresql/data

volumes:
  postgres_data:
```

### Production

1. **Configuration de production**
   ```yaml
   spring:
     profiles:
       active: production
     datasource:
       url: ${DATABASE_URL}
       username: ${DATABASE_USER}
       password: ${DATABASE_PASSWORD}
   ```

2. **Variables d'environnement**
   ```bash
   export DATABASE_URL=jdbc:postgresql://prod-db:5432/proxi_ia_db
   export DATABASE_USER=prod_user
   export DATABASE_PASSWORD=prod_password
   ```

## 📚 Documentation

- **Swagger UI**: http://localhost:8080/swagger-ui.html
- **API Docs**: http://localhost:8080/v3/api-docs
- **Actuator**: http://localhost:8080/actuator

## 🤝 Contribution

1. Fork le projet
2. Créer une branche feature (`git checkout -b feature/AmazingFeature`)
3. Commit les changements (`git commit -m 'Add some AmazingFeature'`)
4. Push vers la branche (`git push origin feature/AmazingFeature`)
5. Ouvrir une Pull Request

## 📄 Licence

Ce projet est sous licence MIT. Voir le fichier `LICENSE` pour plus de détails.

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/your-repo/issues)
- **Documentation**: [Wiki](https://github.com/your-repo/wiki)
- **Email**: support@proxi-ia.com

---

**Proxi-IA Commerce** - L'avenir du e-commerce intelligent 🚀
