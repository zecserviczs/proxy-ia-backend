#!/bin/bash

# Script de démarrage du backend Proxi-IA Commerce
# Ce script lance le backend Spring Boot avec la base de données PostgreSQL

echo "🚀 Démarrage du backend Proxi-IA Commerce..."

# Vérification de Java
if ! command -v java &> /dev/null; then
    echo "❌ Java n'est pas installé. Veuillez installer Java 17 ou supérieur."
    exit 1
fi

# Vérification de Maven
if ! command -v mvn &> /dev/null; then
    echo "❌ Maven n'est pas installé. Veuillez installer Maven."
    exit 1
fi

# Vérification de la version Java
JAVA_VERSION=$(java -version 2>&1 | head -n 1 | cut -d'"' -f2 | cut -d'.' -f1)
if [ "$JAVA_VERSION" -lt 17 ]; then
    echo "❌ Java 17 ou supérieur est requis. Version actuelle: $JAVA_VERSION"
    exit 1
fi

echo "✅ Java $JAVA_VERSION détecté"
echo "✅ Maven détecté"

# Vérification de la base de données PostgreSQL
echo "🔍 Vérification de la base de données PostgreSQL..."

# Vérification si Docker est en cours d'exécution
if ! docker info &> /dev/null; then
    echo "⚠️  Docker n'est pas en cours d'exécution. Démarrage de Docker..."
    if command -v open &> /dev/null; then
        open -a Docker
        echo "⏳ Attente du démarrage de Docker..."
        sleep 10
    else
        echo "❌ Impossible de démarrer Docker automatiquement. Veuillez le démarrer manuellement."
        exit 1
    fi
fi

# Vérification et démarrage de PostgreSQL
if ! docker ps | grep -q "postgres"; then
    echo "🐘 Démarrage de PostgreSQL via Docker..."
    docker run -d \
        --name proxi-ia-postgres \
        -e POSTGRES_DB=proxi_ia_db \
        -e POSTGRES_USER=proxi_ia_user \
        -e POSTGRES_PASSWORD=proxi_ia_password \
        -p 5432:5432 \
        postgres:15
    
    echo "⏳ Attente du démarrage de PostgreSQL..."
    sleep 15
else
    echo "✅ PostgreSQL est déjà en cours d'exécution"
fi

# Vérification de la connexion à la base de données
echo "🔌 Test de connexion à la base de données..."
if ! docker exec proxi-ia-postgres pg_isready -U proxi_ia_user -d proxi_ia_db &> /dev/null; then
    echo "❌ Impossible de se connecter à PostgreSQL"
    exit 1
fi

echo "✅ Connexion à PostgreSQL réussie"

# Nettoyage et compilation
echo "🧹 Nettoyage et compilation du projet..."
mvn clean compile

if [ $? -ne 0 ]; then
    echo "❌ Erreur lors de la compilation"
    exit 1
fi

echo "✅ Compilation réussie"

# Démarrage de l'application
echo "🌟 Démarrage de l'application Spring Boot..."
echo "📱 L'API sera disponible sur: http://localhost:8080"
echo "📊 Swagger UI sera disponible sur: http://localhost:8080/swagger-ui.html"
echo "🔄 Appuyez sur Ctrl+C pour arrêter l'application"

# Lancement de l'application
mvn spring-boot:run

echo "👋 Backend arrêté"
