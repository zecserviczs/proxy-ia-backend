#!/bin/bash

echo "🧪 Test de l'API Commerce Proxi-IA avec Swagger"
echo "================================================"

# Attendre que le backend démarre
echo "⏳ Attente du démarrage du backend..."
sleep 20

# Test de l'endpoint de santé
echo "🔍 Test de l'endpoint de santé..."
curl -s http://localhost:8080/actuator/health | jq . 2>/dev/null || echo "❌ Backend non accessible"

# Test de Swagger UI
echo ""
echo "📚 Test de Swagger UI..."
curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/swagger-ui.html
if [ $? -eq 0 ]; then
    echo "✅ Swagger UI accessible à http://localhost:8080/swagger-ui.html"
else
    echo "❌ Swagger UI non accessible"
fi

# Test de l'API docs
echo ""
echo "📖 Test de l'API docs..."
curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/api-docs
if [ $? -eq 0 ]; then
    echo "✅ API docs accessible à http://localhost:8080/api-docs"
else
    echo "❌ API docs non accessible"
fi

# Test des nouveaux contrôleurs
echo ""
echo "🚀 Test des nouveaux contrôleurs..."

# Test Dashboard
echo "📊 Test Dashboard..."
curl -s http://localhost:8080/api/dashboard/metrics | jq . 2>/dev/null || echo "❌ Dashboard non accessible"

# Test Analytics
echo ""
echo "📈 Test Analytics..."
curl -s http://localhost:8080/api/analytics/reports | jq . 2>/dev/null || echo "❌ Analytics non accessible"

# Test Assistant
echo ""
echo "🤖 Test Assistant..."
curl -s http://localhost:8080/api/assistant/quick-actions | jq . 2>/dev/null || echo "❌ Assistant non accessible"

# Test Settings
echo ""
echo "⚙️ Test Settings..."
curl -s http://localhost:8080/api/settings/general | jq . 2>/dev/null || echo "❌ Settings non accessible"

# Test Products (contrôleur existant)
echo ""
echo "📦 Test Products..."
curl -s http://localhost:8080/api/products | jq . 2>/dev/null || echo "❌ Products non accessible"

echo ""
echo "🎉 Tests terminés !"
echo ""
echo "📋 URLs importantes :"
echo "   - Swagger UI: http://localhost:8080/swagger-ui.html"
echo "   - API Docs: http://localhost:8080/api-docs"
echo "   - Health: http://localhost:8080/actuator/health"
echo ""
echo "🔗 Endpoints API :"
echo "   - Dashboard: http://localhost:8080/api/dashboard"
echo "   - Analytics: http://localhost:8080/api/analytics"
echo "   - Assistant: http://localhost:8080/api/assistant"
echo "   - Settings: http://localhost:8080/api/settings"
echo "   - Products: http://localhost:8080/api/products"
