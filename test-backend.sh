#!/bin/bash

# Script de test pour le backend Proxi-IA Commerce
# Ce script teste les différents endpoints de l'API

echo "🧪 Test du backend Proxi-IA Commerce..."
echo "========================================"

# Variables
BASE_URL="http://localhost:8080"
API_BASE="$BASE_URL/api"

# Couleurs pour l'affichage
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Fonction pour afficher les résultats
print_result() {
    local endpoint=$1
    local status=$2
    local response=$3
    
    if [ "$status" = "200" ] || [ "$status" = "201" ]; then
        echo -e "${GREEN}✅ $endpoint - Status: $status${NC}"
    else
        echo -e "${RED}❌ $endpoint - Status: $status${NC}"
        echo -e "${YELLOW}Response: $response${NC}"
    fi
}

# Fonction pour tester un endpoint
test_endpoint() {
    local method=$1
    local endpoint=$2
    local data=$3
    
    local response
    if [ "$method" = "GET" ]; then
        response=$(curl -s -w "%{http_code}" "$API_BASE$endpoint" -o /tmp/response_body)
    elif [ "$method" = "POST" ]; then
        response=$(curl -s -w "%{http_code}" -X POST -H "Content-Type: application/json" -d "$data" "$API_BASE$endpoint" -o /tmp/response_body)
    fi
    
    local status_code=${response: -3}
    local response_body=$(cat /tmp/response_body)
    
    print_result "$method $endpoint" "$status_code" "$response_body"
}

# Attendre que le backend soit prêt
echo -e "${BLUE}⏳ Attente du démarrage du backend...${NC}"
for i in {1..30}; do
    if curl -s "$BASE_URL/actuator/health" > /dev/null 2>&1; then
        echo -e "${GREEN}✅ Backend prêt !${NC}"
        break
    fi
    echo -n "."
    sleep 2
done

if [ $i -eq 30 ]; then
    echo -e "${RED}❌ Backend non accessible après 60 secondes${NC}"
    exit 1
fi

echo ""
echo -e "${BLUE}🚀 Début des tests...${NC}"
echo ""

# Test 1: Vérification de la santé de l'application
echo -e "${YELLOW}1. Test de santé de l'application${NC}"
test_endpoint "GET" "/actuator/health"

# Test 2: Produits
echo -e "${YELLOW}2. Test des produits${NC}"
test_endpoint "GET" "/products"
test_endpoint "GET" "/products/1"

# Test 3: Inventaire
echo -e "${YELLOW}3. Test de l'inventaire${NC}"
test_endpoint "GET" "/inventory"
test_endpoint "GET" "/inventory/low-stock"
test_endpoint "GET" "/inventory/stats"

# Test 4: Ventes
echo -e "${YELLOW}4. Test des ventes${NC}"
test_endpoint "GET" "/sales"
test_endpoint "GET" "/sales/stats"

# Test 5: Commandes
echo -e "${YELLOW}5. Test des commandes${NC}"
test_endpoint "GET" "/orders"
test_endpoint "GET" "/orders/stats"

# Test 6: Fournisseurs
echo -e "${YELLOW}6. Test des fournisseurs${NC}"
test_endpoint "GET" "/suppliers"
test_endpoint "GET" "/suppliers/top-rated"

# Test 7: Tableau de bord
echo -e "${YELLOW}7. Test du tableau de bord${NC}"
test_endpoint "GET" "/dashboard/overview"
test_endpoint "GET" "/dashboard/metrics"
test_endpoint "GET" "/dashboard/sales-chart"

# Test 8: Assistant IA
echo -e "${YELLOW}8. Test de l'assistant IA${NC}"
test_endpoint "GET" "/assistant/quick-actions"
test_endpoint "GET" "/assistant/stats"
test_endpoint "GET" "/assistant/insights"

# Test 9: Analytiques
echo -e "${YELLOW}9. Test des analytiques${NC}"
test_endpoint "GET" "/analytics/reports"
test_endpoint "GET" "/analytics/sales/trend"

# Test 10: Paramètres
echo -e "${YELLOW}10. Test des paramètres${NC}"
test_endpoint "GET" "/settings/general"
test_endpoint "GET" "/settings/notifications"

# Test 11: Prix
echo -e "${YELLOW}11. Test des prix${NC}"
test_endpoint "GET" "/pricing"
test_endpoint "GET" "/pricing/stats"

# Test 12: Commandes d'achat
echo -e "${YELLOW}12. Test des commandes d'achat${NC}"
test_endpoint "GET" "/purchase-orders"
test_endpoint "GET" "/purchase-orders/stats"

echo ""
echo -e "${BLUE}📊 Résumé des tests${NC}"
echo "=================="

# Compter les succès et échecs
success_count=$(grep -c "✅" /tmp/test_results 2>/dev/null || echo "0")
error_count=$(grep -c "❌" /tmp/test_results 2>/dev/null || echo "0")

echo -e "${GREEN}Tests réussis: $success_count${NC}"
echo -e "${RED}Tests échoués: $error_count${NC}"

if [ "$error_count" -eq 0 ]; then
    echo -e "${GREEN}🎉 Tous les tests sont passés avec succès !${NC}"
else
    echo -e "${YELLOW}⚠️  Certains tests ont échoué. Vérifiez les logs du backend.${NC}"
fi

echo ""
echo -e "${BLUE}🔗 Liens utiles${NC}"
echo "================"
echo -e "🌐 Application: ${GREEN}$BASE_URL${NC}"
echo -e "📊 Swagger UI: ${GREEN}$BASE_URL/swagger-ui.html${NC}"
echo -e "📚 API Docs: ${GREEN}$BASE_URL/v3/api-docs${NC}"
echo -e "💚 Health Check: ${GREEN}$BASE_URL/actuator/health${NC}"
echo -e "🗄️  pgAdmin: ${GREEN}http://localhost:5050${NC}"
echo "   Email: admin@proxi-ia.com"
echo "   Mot de passe: admin123"

# Nettoyage
rm -f /tmp/response_body /tmp/test_results

echo ""
echo -e "${BLUE}✨ Tests terminés !${NC}"
