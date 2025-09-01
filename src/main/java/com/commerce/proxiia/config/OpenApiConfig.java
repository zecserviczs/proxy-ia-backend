package com.commerce.proxiia.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.info.License;
import io.swagger.v3.oas.models.servers.Server;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.List;

@Configuration
public class OpenApiConfig {

    @Bean
    public OpenAPI customOpenAPI() {
        return new OpenAPI()
                .info(new Info()
                        .title("Commerce Proxi-IA API")
                        .description("API REST pour la plateforme de commerce intelligent avec IA")
                        .version("1.0.0")
                        .contact(new Contact()
                                .name("Équipe Proxi-IA")
                                .email("contact@proxi-ia.com")
                                .url("https://proxi-ia.com"))
                        .license(new License()
                                .name("MIT License")
                                .url("https://opensource.org/licenses/MIT")))
                .servers(List.of(
                        new Server()
                                .url("http://localhost:8080")
                                .description("Serveur de développement"),
                        new Server()
                                .url("https://api.proxi-ia.com")
                                .description("Serveur de production")
                ));
    }
}
