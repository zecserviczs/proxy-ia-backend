# Dockerfile pour le backend Proxi-IA Commerce
FROM openjdk:17-jdk-slim

# Métadonnées
LABEL maintainer="Proxi-IA Team <dev@proxi-ia.com>"
LABEL version="1.0.0"
LABEL description="Backend Spring Boot pour Proxi-IA Commerce"

# Variables d'environnement
ENV APP_NAME=proxi-ia-backend
ENV APP_VERSION=1.0.0
ENV JAVA_OPTS="-Xmx512m -Xms256m"

# Créer le répertoire de travail
WORKDIR /app

# Installer les dépendances système
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copier le fichier pom.xml et télécharger les dépendances
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copier le code source
COPY src ./src

# Compiler l'application
RUN mvn clean package -DskipTests

# Créer un utilisateur non-root
RUN groupadd -r appuser && useradd -r -g appuser appuser

# Changer les permissions
RUN chown -R appuser:appuser /app
USER appuser

# Exposer le port
EXPOSE 8080

# Point d'entrée
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar target/${APP_NAME}-${APP_VERSION}.jar"]

# Commande par défaut
CMD ["--spring.profiles.active=docker"]
